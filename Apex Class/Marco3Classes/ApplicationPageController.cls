public without sharing class ApplicationPageController {
    
    public class picklistWrapper{
        @AuraEnabled 
        public string label;
        @AuraEnabled 
        public string value;
    }
    
    public class ManualAr{
        @AuraEnabled 
        public string customer;
        @AuraEnabled 
        public string Total_Ar;
        @AuraEnabled 
        public string Ar0_30;
        @AuraEnabled 
        public string Ar30_60;
        @AuraEnabled 
        public string Ar60_90;
        @AuraEnabled 
        public string Ar90_120;
        @AuraEnabled 
        public string Ar120_Plus;
    }
    
    public class invoiceWrapper{
        @AuraEnabled 
        public List<String> issue_date {get;set;} // in json: date
        @AuraEnabled 
        public List<String> invoice_currency {get;set;}
        @AuraEnabled 
        public List<String> invoice_number {get;set;} 
        @AuraEnabled 
        public List<String> invoice_total {get;set;} 
        @AuraEnabled 
        public List<String> issuer {get;set;} 
        
        @AuraEnabled 
        public List<String> pymt_terms {get;set;} 
        @AuraEnabled 
        public List<String> debtor_add {get;set;} 
        @AuraEnabled 
        public List<String> debtor_name {get;set;} 
        @AuraEnabled 
        public List<String> inco_terms {get;set;} 
        @AuraEnabled 
        public List<String> client_add {get;set;} 
        @AuraEnabled 
        public String documentId {get;set;} 
        
        
    }
    
    @AuraEnabled 
    public static string submitApplication(String appid){
        Application__c app = new Application__c();
        app.Id = appid;
        app.application_submitted__c = true;
        app.Application_submitted_timestamp__c = system.now();
        update app;
        return 'success';
    }
    
    @AuraEnabled 
    public static list<invoice__c> sendDataToAws(list<string> documentId, id appId){
        
        list<invoice__c> invoiceList = new list<invoice__c>();
        
        // get blob data of the uploaded files
        List<ContentVersion> ContentVersionList = new List<ContentVersion>();
        for(string docid : documentId){
            ContentVersion cv = [SELECT VersionData FROM ContentVersion WHERE ContentDocumentId = :documentId AND IsLatest = true limit 1];
            ContentDistribution cd = [Select Id,ContentDocumentId,ContentDownloadUrl,DistributionPublicUrl from ContentDistribution where ContentDocumentId = :documentId];
            system.debug('blob data: '+cv.VersionData);
            
            // Send data to aws
            http connection = new http();
            httpRequest request = new httpRequest();
            request.setMethod('PUT');
            request.setEndpoint('https://l1xzk1emp7.execute-api.us-east-1.amazonaws.com/test/extractedkvp');
            request.setHeader('file-name', 'customerName.pdf');
            request.setHeader('Content-type', 'application/pdf');
            request.setTimeout(120000);
            String stringBody = EncodingUtil.base64Encode(cv.VersionData);
            request.setBodyAsBlob(cv.VersionData);
            httpResponse response = new httpResponse();
            response = connection.send(request);
            system.debug('responseBody: '+response.getBody()); 
            
            invoiceWrapper invoiceObj = new invoiceWrapper();
            
            if(response.getStatusCode() == 200){
                invoiceObj = (invoiceWrapper) System.JSON.deserialize(response.getBody(), invoiceWrapper.class);
                if(String.isNotBlank(invoiceObj.invoice_number[0])){
                    
                    Invoice__c inv = new Invoice__c();
                    inv.application__c = appId;
                    inv.Name = invoiceObj.invoice_number[0];
                    
                    if(String.isNotBlank(invoiceObj.issuer [0])){
                        inv.issuer__c  = invoiceObj.issuer[0];
                    }
                    if(String.isNotBlank(invoiceObj.invoice_currency [0])){
                        inv.invoice_currency__c = invoiceObj.invoice_currency[0];
                    }
                    if(String.isNotBlank(invoiceObj.invoice_total [0])){
                        inv.invoice_total__c = decimal.valueOf(invoiceObj.invoice_total[0]);
                    }
                    if(String.isNotBlank(invoiceObj.issue_date [0])){
                        string month = invoiceObj.issue_date[0].split('-')[0];
                        string day = invoiceObj.issue_date[0].split('-')[1];
                        string year = invoiceObj.issue_date[0].split('-')[2];
                        system.debug('month: '+month);
                        system.debug('day: '+day);
                        system.debug('year: '+year);
                        inv.issue_date__c = date.valueOf(year+'-'+month+'-'+day);
                    }
                    
                    if(invoiceObj.pymt_terms != null && String.isNotBlank(invoiceObj.pymt_terms [0])){
                        inv.pymt_terms__c  = invoiceObj.pymt_terms[0];
                    }
                    if(invoiceObj.debtor_add != null && String.isNotBlank(invoiceObj.debtor_add [0])){
                        inv.debtor_add__c = invoiceObj.debtor_add[0];
                    }
                    if(invoiceObj.debtor_name != null && String.isNotBlank(invoiceObj.debtor_name [0])){
                        inv.debtor_name__c = invoiceObj.debtor_name[0];
                    }
                    if(invoiceObj.inco_terms != null && String.isNotBlank(invoiceObj.inco_terms [0])){
                        inv.inco_terms__c = invoiceObj.inco_terms[0];
                    }
                    if(invoiceObj.client_add != null && String.isNotBlank(invoiceObj.client_add [0])){
                        inv.client_add__c = invoiceObj.client_add[0];
                    }
                    inv.documentId__c = cd.DistributionPublicUrl;
                    invoiceList.add(inv);
                    
                    system.debug('document id: '+inv.documentId__c);
                    system.debug('issue_date: '+invoiceObj.issue_date[0]);
                    system.debug('invoice_currency: '+invoiceObj.invoice_currency[0]);
                    system.debug('invoice_number: '+invoiceObj.invoice_number[0]);
                    system.debug('invoice_total: '+invoiceObj.invoice_total[0]);
                }
            }else{
                return null;
            }
        }
        Insert invoiceList;
        
        return [select id, name, application__c, issuer__c, documentId__c, invoice_currency__c, invoice_total__c, issue_date__c from invoice__c where application__c = :appId order by createdDate desc];
        
    }
    
    @AuraEnabled 
    public static string updateTimestamp(id appid){
        application__c app = new application__c();
        app.id = appid;
        app.AR_ageing_submition_timestamp__c = system.now();
        update app;
        return 'success';
    }
    
    
    @AuraEnabled 
    public static string UploadFileToAppl(String manualList, String applicationId){
        ContentVersion conVer = new ContentVersion();
        conVer.ContentLocation = 'S'; 
        conVer.PathOnClient = 'testing.csv'; 
        conVer.Title = 'Testing Files'; 
        conVer.VersionData = Blob.valueOf(manualList);
        //conVer.NetworkId='0DB050000008OlRGAU';
        insert conVer;    
        
        //get the Content Document Id from ContentVersion Object
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
        
        //create ContentDocumentLink  record 
        ContentDocumentLink conDocLink = New ContentDocumentLink();
        conDocLink.LinkedEntityId = applicationId; 
        conDocLink.ContentDocumentId = conDoc; 
        conDocLink.shareType = 'V';
        insert conDocLink;
        
        if([select id, AR_ageing_submition_timestamp__c from application__c where id =:applicationId].AR_ageing_submition_timestamp__c == null){
            application__c app = new application__c(id=applicationId, AR_ageing_submition_timestamp__c = system.now());
            update app;
        }
        
        return 'success';
    }
    
    @AuraEnabled 
    public static string UploadFileToApplAndUpdateInvoice(String manualList, String applicationId, list<invoice__c> invoiceList){
        
        system.debug('invoiceList: '+invoiceList);
        
        update invoiceList;
        
        ContentVersion conVer = new ContentVersion();
        conVer.ContentLocation = 'S'; 
        conVer.PathOnClient = 'testing.csv'; 
        conVer.Title = 'Testing Files'; 
        conVer.VersionData = Blob.valueOf(manualList); 
        insert conVer;    
        
        //get the Content Document Id from ContentVersion Object
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
        
        //create ContentDocumentLink  record 
        ContentDocumentLink conDocLink = New ContentDocumentLink();
        conDocLink.LinkedEntityId = applicationId; 
        conDocLink.ContentDocumentId = conDoc; 
        conDocLink.shareType = 'V';
        insert conDocLink;
        
        if([select id, AR_ageing_submition_timestamp__c from application__c where id =:applicationId].AR_ageing_submition_timestamp__c == null){
            application__c app = new application__c(id=applicationId, AR_ageing_submition_timestamp__c = system.now());
            //update app;
        }
        
        return 'success';
        
    }
    
    
    @AuraEnabled 
    public static List<ManualAr> getManualArList(){
        List<ManualAr> manualArList = new List<ManualAr>();
        return manualArList;
    }
    
    @AuraEnabled 
    public static ManualAr getManualAr(){
        ManualAr manualAr = new ManualAr();
        return manualAr;
    }
    
    @AuraEnabled 
    public static Invoice__c getManualArInvoice(){
        Invoice__c manualAr = new Invoice__c();
        return manualAr;
    }
    
    @AuraEnabled 
    Public static void updateApplication(Application__c objacc){
        try{
            update objacc; 
        }catch(Exception e){
            throw new AuraHandledException('Error: ' + e.getMessage() + ' at line number: ' + e.getLineNumber());
        }
        finally {
        }
    }
    
    /*debt factor provider in place*/
    @AuraEnabled
    public static Map<String, String> getDebtPicklist(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Application__c.Debt_Factor_PO_provider_in_place__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    /*company operate trade insurance policy*/
    @AuraEnabled 
    public static Map<String, String> getCompanyPolicy(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Application__c.Company_operate_w_trade_insur_policy__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    /*Seasonality to the business*/
    @AuraEnabled 
    public static Map<String, String> getSeasonalityToBusiness(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Application__c.Seasonality_To_The_Business__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    /*company practice progress*/
    @AuraEnabled 
    public static Map<String, String> getCompanyPracticeProgress(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Application__c.Company_practice_Progress_Billings__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    /*company practice installment billings*/
    @AuraEnabled 
    public static Map<String, String> getCompanyInstallmentProgress(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Application__c.Company_practice_Installments_Billings__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    /**paca*/
    @AuraEnabled 
    public static Map<String, String> getDebtPro(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Application__c.Is_There_Debt_Pro__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    /*purchase order*/
    @AuraEnabled 
    public static Map<String, String> getPurchaseOrder(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Application__c.Purchase_Order_PO_Cancellable__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    /*Allow us to plugin*/
    @AuraEnabled 
    public static Map<String, String> getAllowUsToPlug(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Application__c.Allow_Us_To_Plug_Into_Acctng_platform__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    /*Quality Check*/
    @AuraEnabled
    public static List<picklistWrapper> getRegions() {        
        Schema.DescribeFieldResult fieldResult = Application__c.Quality_Checks_in_Place__c.getDescribe();
        List<Schema.PicklistEntry> plereg = fieldResult.getPicklistValues();
        list<picklistWrapper> returnValue = new list<picklistWrapper>();
        for (Schema.PicklistEntry a: plereg) {
            picklistWrapper aa = new picklistWrapper();
            aa.label = a.getLabel();
            aa.value = a.getValue();
            returnValue.add(aa);
        }
        System.debug('getregions' +returnValue);
        return returnValue;
    }
    
    /*sales last 12 months USD*/
    @AuraEnabled
    public static List<picklistWrapper> getAmount() {
        Schema.DescribeFieldResult fieldResult = Application__c.Sales_Last_12_Months_USD__c.getDescribe();
        List<Schema.PicklistEntry> pleamt = fieldResult.getPicklistValues();
        list<picklistWrapper> returnValue = new list<picklistWrapper>();
        for (Schema.PicklistEntry a: pleamt) {
            picklistWrapper aa = new picklistWrapper();
            aa.label = a.getLabel();
            aa.value = a.getValue();
            returnValue.add(aa);
        }
        return returnValue;
    }
    
    
    @AuraEnabled
    public static Application__c applicationdata(String recordId){
        Application__c app=new Application__c();
        app=[Select Id,Application_ID_18_Digit__c,Account__r.Industry,Account__r.Sub_industry__c,Sector__c,Name_of_Insurance_Provider__c,Seasonality_To_The_Business__c,Company_practice_Progress_Billings__c,Company_operate_w_trade_insur_policy__c,Debt_Factor_PO_provider_in_place__c,Is_There_Debt_Pro__c,Quality_Checks_in_Place__c,Sales_Last_12_Months_USD__c,Purchase_Order_PO_Cancellable__c,Allow_Us_To_Plug_Into_Acctng_platform__c,Company_practice_Installments_Billings__c from Application__C where Id=:recordid];
        System.debug('app' +app);
        return app;
        
    }
    
    
    @AuraEnabled
    public static ApplicationPageWrapper getwrapperdata(String recordId){
        ApplicationPageWrapper accWrapper = new ApplicationPageWrapper();
        Application__c  appval = [Select Id,General_Business_Question_Timestamp__c,AR_ageing_submition_timestamp__c,List_document_submition_timestamp__c,Application_ID_18_Digit__c,currentQuestion__c,application_submitted__c,Opportunity__c, Opportunity__r.Product__c, Account__c, Account__r.Industry,Account__r.Country_of_Incorporation__c,Account__r.Sub_industry__c,Sector__c,Name_of_Insurance_Provider__c,Seasonality_To_The_Business__c,Company_practice_Progress_Billings__c,Company_operate_w_trade_insur_policy__c,Debt_Factor_PO_provider_in_place__c,Is_There_Debt_Pro__c,Quality_Checks_in_Place__c,Sales_Last_12_Months_USD__c,Purchase_Order_PO_Cancellable__c,Allow_Us_To_Plug_Into_Acctng_platform__c,Company_practice_Installments_Billings__c from Application__C where Id=:recordid];
        System.debug('app' +appval); 
        accWrapper.applicationSubmitted = appval.application_submitted__c;
        accWrapper.recordId=recordId;
        accWrapper.accountId = appval.Account__c;
        accWrapper.opportunityId = appval.Opportunity__c;
        
        accWrapper.Name_of_Insurance_Provider = appval.Name_of_Insurance_Provider__c ;
        accWrapper.Allow_Us_To_Plug_Into_Acctng_platform = appval.Allow_Us_To_Plug_Into_Acctng_platform__c;
        accWrapper.Company_operate_w_trade_insur_policy = appval.Company_operate_w_trade_insur_policy__c;
        accWrapper.Company_practice_Installments_Billings = appval.Company_practice_Installments_Billings__c;
        accWrapper.Company_practice_Progress_Billings = appval.Company_practice_Progress_Billings__c;
        
        accWrapper.Debt_Factor_PO_provider_in_place = appval.Debt_Factor_PO_provider_in_place__c;
        accWrapper.Industry = appval.Account__r.Industry;
        accWrapper.Purchase_Order_PO_Cancellable = appval.Purchase_Order_PO_Cancellable__c;
        accWrapper.Quality_Checks_in_Place = appval.Quality_Checks_in_Place__c;
        accWrapper.Sales_Last_12_Months_USD = appval.Sales_Last_12_Months_USD__c;
        accWrapper.Seasonality_To_The_Business = appval.Seasonality_To_The_Business__c;
        accWrapper.Sector = appval.Account__r.Industry;
        accWrapper.Sub_industry = appval.Account__r.Sub_industry__c;
        accWrapper.Is_There_Debt_Pro = appval.Is_There_Debt_Pro__c;
        accWrapper.Product = appval.Opportunity__r.Product__c;
        accWrapper.Country_of_Incorporation = appval.Account__r.Country_of_Incorporation__c;
        accWrapper.currentQuestion = appval.currentQuestion__c;
        System.debug('accwrapper' +accWrapper);
        
        return accWrapper;
    }
    
    @AuraEnabled
    public static Application__c updatewrapper (String wrapperobj, string savedata){
        system.debug('wrapperobj: '+wrapperobj);
        
        try{
            System.debug('applicationWrapperObj' +wrapperobj);
            ApplicationPageWrapper obj = (ApplicationPageWrapper)JSON.deserialize(wrapperobj, ApplicationPageWrapper.class);
            
            //Map Application fileds
            Application__c a = new Application__c();
            a.Id=obj.recordId;
            a.Allow_Us_To_Plug_Into_Acctng_platform__c = obj.Allow_Us_To_Plug_Into_Acctng_platform;
            a.Company_operate_w_trade_insur_policy__c = obj.Company_operate_w_trade_insur_policy;
            if(a.Company_operate_w_trade_insur_policy__c == 'Yes'){
                a.Name_of_Insurance_Provider__c = obj.Name_of_Insurance_Provider ; 
            }else{
                a.Name_of_Insurance_Provider__c = null;
            }
            a.Company_practice_Installments_Billings__c = obj.Company_practice_Installments_Billings;
            a.Company_practice_Progress_Billings__c = obj.Company_practice_Progress_Billings;
            a.Debt_Factor_PO_provider_in_place__c = obj.Debt_Factor_PO_provider_in_place;
            a.Purchase_Order_PO_Cancellable__c = obj.Purchase_Order_PO_Cancellable;
            a.Quality_Checks_in_Place__c = obj.Quality_Checks_in_Place;
            a.Sales_Last_12_Months_USD__c = obj.Sales_Last_12_Months_USD;
            a.Seasonality_To_The_Business__c = obj.Seasonality_To_The_Business;
            a.currentQuestion__c = obj.currentQuestion;
            a.currentQuestion__c = savedata;
            a.Sector__c = obj.Sector;
            a.Is_There_Debt_Pro__c = obj.Is_There_Debt_Pro;   
            
            if(savedata.equalsIgnoreCase('debtprovider') && obj.General_Business_Question_Timestamp == null){
                a.General_Business_Question_Timestamp__c = system.now();
            }else if(savedata.equalsIgnoreCase('listofcustomers') && obj.List_document_submition_timestamp == null){
                a.List_document_submition_timestamp__c  = system.now();
            }else if(savedata.equalsIgnoreCase('ageingreport') && obj.AR_ageing_submition_timestamp == null){
                a.AR_ageing_submition_timestamp__c  = system.now();
            }
            
            Update a;
            return a;
        }catch(exception e){
            return null;
        }
        
    }
    
}