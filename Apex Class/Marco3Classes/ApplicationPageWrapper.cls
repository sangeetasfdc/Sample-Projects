public class ApplicationPageWrapper {
    @AuraEnabled
    public string General_Business_Question_Timestamp{get;set;}
    @AuraEnabled
    public string List_document_submition_timestamp{get;set;}
    @AuraEnabled
    public string AR_ageing_submition_timestamp{get;set;}
    
    @AuraEnabled
    public string currentQuestion{get;set;}
    @AuraEnabled 
    public boolean applicationSubmitted{get;set;}
    @AuraEnabled
    public Id recordId{get;set;}
    @AuraEnabled
    public Id opportunityId{get;set;}
    @AuraEnabled
    public Id accountId{get;set;}
    @AuraEnabled
    public String Industry{get;set;}
    @AuraEnabled
    public String Sub_industry{get;set;}
    @AuraEnabled
    public String Sector{get;set;}
    @AuraEnabled
    public String Product{get;set;}
    @AuraEnabled
    public String Name_of_Insurance_Provider{get;set;}
    @AuraEnabled
    public String Seasonality_To_The_Business{get;set;}
    @AuraEnabled
    public String Company_practice_Progress_Billings{get;set;}
    @AuraEnabled
    public String Company_operate_w_trade_insur_policy{get;set;} 
    @AuraEnabled
    public String Debt_Factor_PO_provider_in_place{get;set;}
    @AuraEnabled
    public String Quality_Checks_in_Place {get;set;}
    @AuraEnabled
    public String Sales_Last_12_Months_USD{get;set;}
    @AuraEnabled
    public String Purchase_Order_PO_Cancellable{get;set;}
    @AuraEnabled
    public String Allow_Us_To_Plug_Into_Acctng_platform{get;set;}
    @AuraEnabled
    public String Company_practice_Installments_Billings{get;set;} 
    @AuraEnabled
    public String Is_There_Debt_Pro{get;set;} 
    @AuraEnabled
    public String Country_of_Incorporation{get;set;} 
    
    @AuraEnabled
    public static ApplicationPageWrapper parse(String accWrapper) {
        return (ApplicationPageWrapper) System.JSON.deserialize(accWrapper, ApplicationPageWrapper.class);
    }
}