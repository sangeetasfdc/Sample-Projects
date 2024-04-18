//This controller  is for the ThankVfcmpPage//

public class ThankYouController {
    public String thankyouPageUrl {get;set;}
    public ThankYouController(){
        Id siteId = [SELECT ID,Name FROM Site where Name = 'marconifinancial'].Id;
        List<SiteDetail> siteDetail = [SELECT Id, SecureUrl, DurableId FROM SiteDetail where DurableId =: siteId];
        thankyouPageUrl = siteDetail[0].SecureUrl+'/ThankPage?id=';
        
    }
}