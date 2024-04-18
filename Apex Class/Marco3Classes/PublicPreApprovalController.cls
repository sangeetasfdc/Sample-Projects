public without sharing class PublicPreApprovalController {
    
    public class picklistWrapper{
        @AuraEnabled 
        public string label;
        @AuraEnabled 
        public string value;
    }
    
    @AuraEnabled
    public static boolean checkExistingUser(string UserEmail) {
        List<user> userlist = new List<user>();
        userlist = [select id from user where Username = :UserEmail];
        if(userlist.size() > 0){
            return true;
        }
        return false;
    }
    
    @AuraEnabled
    public static List<picklistWrapper> getCountries() {
        Schema.DescribeFieldResult fieldResult = Lead.Country_of_Incorporation__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        list<picklistWrapper> returnValue = new list<picklistWrapper>();
        for (Schema.PicklistEntry a: ple) {
            picklistWrapper aa = new picklistWrapper();
            aa.label = a.getLabel();
            aa.value = a.getValue();
            returnValue.add(aa);
        }
        return returnValue;
    }
    
    @AuraEnabled
    public static List<picklistWrapper> getCurrency() {
        Schema.DescribeFieldResult fieldResult = Lead.Transaction_Currency__c.getDescribe();
        List<Schema.PicklistEntry> plecur = fieldResult.getPicklistValues();
        list<picklistWrapper> returnValue = new list<picklistWrapper>();
        for (Schema.PicklistEntry a: plecur) {
            picklistWrapper aa = new picklistWrapper();
            aa.label = a.getLabel();
            aa.value = a.getValue();
            returnValue.add(aa);
        }
        return returnValue;
    }
    
    @AuraEnabled
    public static List<picklistWrapper> getRegions() {        
        Schema.DescribeFieldResult fieldResult = Lead.Exporting_to_Region_s__c.getDescribe();
        List<Schema.PicklistEntry> plereg = fieldResult.getPicklistValues();
        list<picklistWrapper> returnValue = new list<picklistWrapper>();
        for (Schema.PicklistEntry a: plereg) {
            picklistWrapper aa = new picklistWrapper();
            aa.label = a.getLabel();
            aa.value = a.getValue();
            returnValue.add(aa);
        }
        return returnValue;
    }
    
    @AuraEnabled
    public static List<picklistWrapper> getSources() {
        Schema.DescribeFieldResult fieldResult = Lead.How_did_you_hear_about_Marco__c.getDescribe();
        List<Schema.PicklistEntry> plesrc = fieldResult.getPicklistValues();
        list<picklistWrapper> returnValue = new list<picklistWrapper>();
        for (Schema.PicklistEntry a: plesrc) {
            picklistWrapper aa = new picklistWrapper();
            aa.label = a.getLabel();
            aa.value = a.getValue();
            returnValue.add(aa);
        }
        return returnValue;
    }
    
    @AuraEnabled
    public static List<picklistWrapper> getSectors() {
        Schema.DescribeFieldResult fieldResult = Lead.Industry.getDescribe();
        List<Schema.PicklistEntry> plesect = fieldResult.getPicklistValues();
        list<picklistWrapper> returnValue = new list<picklistWrapper>();
        for (Schema.PicklistEntry a: plesect) {
            picklistWrapper aa = new picklistWrapper();
            aa.label = a.getLabel();
            aa.value = a.getValue();
            returnValue.add(aa);
        }
        return returnValue;
    }
    
    @AuraEnabled
    public static List<picklistWrapper> getDependentPicklistValues(String selectedvalue){
        Schema.DescribeFieldResult depend = Lead.Sub_industry__c.getDescribe();
        Schema.sObjectField controlToken = depend.getController();
        if (controlToken == null) {
            return null;
        }
        
        Schema.DescribeFieldResult control = controlToken.getDescribe();
        List<Schema.PicklistEntry> controlEntries;
        if(control.getType() != Schema.DisplayType.Boolean) {
            controlEntries = control.getPicklistValues();
        }
        
        String base64map = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
        Map<String,List<SelectOption>> dependentPicklistValues = new Map<String,List<SelectOption>>();
        for (Schema.PicklistEntry entry : depend.getPicklistValues()) {
            if (entry.isActive() && String.isNotEmpty(String.valueOf(((Map<String,Object>) JSON.deserializeUntyped(JSON.serialize(entry))).get('validFor')))) {
                List<String> base64chars =
                    String.valueOf(((Map<String,Object>) JSON.deserializeUntyped(JSON.serialize(entry))).get('validFor')).split('');
                for (Integer index = 0; index < (controlEntries != null ? controlEntries.size() : 2); index++) {
                    Object controlValue =
                        (controlEntries == null
                         ?   (Object) (index == 1)
                         :   (Object) (controlEntries[index].isActive() ? controlEntries[index].getLabel() : null)
                        );
                    Integer bitIndex = index / 6;
                    if (bitIndex > base64chars.size() - 1) {
                        break;
                    }
                    Integer bitShift = 5 - Math.mod(index, 6);
                    if  (controlValue == null || (base64map.indexOf( base64chars[ bitIndex ] ) & (1 << bitShift)) == 0)
                        continue;
                    if (!dependentPicklistValues.containsKey((String) controlValue)) {
                        dependentPicklistValues.put((String) controlValue, new List<SelectOption>());
                    }
                    dependentPicklistValues.get((String) controlValue).add(new SelectOption(entry.getLabel(),entry.getValue()));
                }
            }
        }
        list<SelectOption> depvalues = new list<SelectOption>();
        for(String val :dependentPicklistValues.keySet()){
            if(val.equalsIgnoreCase(selectedvalue)){
                depvalues.addAll(dependentPicklistValues.get(val));
            }
        }
        list<picklistWrapper> returnValue = new list<picklistWrapper>();
        for (SelectOption a: depvalues) {
            picklistWrapper aa = new picklistWrapper();
            aa.label = a.getLabel();
            aa.value = a.getValue();
            returnValue.add(aa);
        }
        return returnValue;
    }
    
    @AuraEnabled
    public static List<picklistWrapper> getProducts() {
        Schema.DescribeFieldResult fieldResult = Lead.Product__c.getDescribe();
        List<Schema.PicklistEntry> pleprod = fieldResult.getPicklistValues();
        list<picklistWrapper> returnValue = new list<picklistWrapper>();
        for (Schema.PicklistEntry a: pleprod) {
            picklistWrapper aa = new picklistWrapper();
            aa.label = a.getLabel();
            aa.value = a.getValue();
            returnValue.add(aa);
        }
        return returnValue;
    }
    
    @AuraEnabled
    public static List<picklistWrapper> getAmount() {
        Schema.DescribeFieldResult fieldResult = Lead.Expected_Total_Facility_Size__c.getDescribe();
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
    public static string ApprovalCriteria(String country, list<string> curr,list<string> Region,String source, String sector, String Industry,String Product,String amount,String Email, String OrganisationName,String Contactname,string sourceNameVal){
        try{
            Set<String> setOfCountries = new Set<String>{'Argentina','Australia','Austria','Bahamas','Belgium','Belize','Bermuda','Bolivia',
                'Brazil','Bulgaria','Canada','Cayman Islands','Chile','China','Colombia','Costa Rica','Croatia','Cyprus','Czech Republic',
                'Denmark','Dominican Republic','Ecuador','El Salvador','Estonia','European Union','Fiji','Finland','France','Germany','Greece',
                'Grenada','Guatemala','Honduras','Hong Kong','Hungary','Iceland','India','Indonesia','Ireland','Isle of Man','Israel','Italy',
                'Ivory Coast','Jamaica','Japan','Jordan','Latvia','Liechtenstein','Lithuania','Luxembourg','Malaysia','Maldives','Malta','Mauritius',
                'Mexico','Montenegro','Montserrat','Morocco','Netherlands','New Zealand','Nicaragua','Norway','Panama','Paraguay','Peru','Philippines',
                'Poland','Portugal','Puerto Rico','Qatar','Seychelles','Singapore','Slovakia','Slovenia','Solomon Islands','South Africa','Spain',
                'Sri Lanka','St Vincent and the Grenadines','Suriname','Sweden','Switzerland','Taiwan','Thailand','Trinidad and Tobago','Tunisia',
                'Turkey','United Arab Emirates','United Kingdom','United States','Uruguay','Vietnam'};
                    Set<String> setOfCurrencies = new Set<String>{'USD','EUR','MXN','GBP','AUD','CAD'};
                        Set<String> setOfRegions = new Set<String>{'North America','Latin America & the Caribbean','Western Europe','Australia & New Zealand','Japan'};
                            
                            
                            String cur = String.join( curr, ';' ); 
            String reg = String.join( Region, ';' );
            //String prod = String.join( Product, ';' );
            system.debug('country'+country+'curr'+curr);
            
            lead lead_obj = new lead();     
            lead_obj.Country_of_Incorporation__c =country;
            lead_obj.Transaction_Currency__c=cur;
            lead_obj.Exporting_to_Region_s__c=reg;
            lead_obj.leadsource =source;
            lead_obj.How_did_you_hear_about_Marco__c = source;
            lead_obj.Industry =sector;
            lead_obj.Sub_industry__c =Industry;
            lead_obj.Product__c =Product;
            lead_obj.Expected_Total_Facility_Size__c =amount;
            lead_obj.email=Email;
            lead_obj.company =OrganisationName;
            
            if(String.isNotBlank(sourceNameVal)){
                lead_obj.Please_Fill_if_Other_or_Referral__c = sourceNameVal;
            }
            
            List<String> leadname = Contactname.split(' ', 2);
            if(leadname.size()==1){
                lead_obj.lastname=leadname[0];
                
            }else{ 
                lead_obj.firstname=leadname[0];
                lead_obj.lastname=leadname[1];  
            }
            
            
            
            boolean chechcurr = false;
            for(string str : setOfCurrencies){
                for(string str2 : curr){
                    if(str.equalsIgnoreCase(str2)){
                        chechcurr = true;
                    }                    
                }
            }
            
            boolean chechreg = false;
            for(string str : setOfRegions){
                for(string str2 : Region){
                    if(str.equalsIgnoreCase(str2)){
                        chechreg = true;
                    }                    
                }
            }
            
            String status  = '';
            
            if((setOfCountries.contains(country)) && chechcurr && chechreg){
                status = 'Pre-Approved';
            }
            else{
                status = 'Disqualified';
            }
            
            lead_obj.Application_Status__c = status;
            insert lead_obj;
            
            return status;
            
        }catch(exception e){
            return 'error: '+e.getMessage() + ' line: '+e.getLineNumber();
        }
    }
    
}