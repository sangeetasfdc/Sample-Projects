//This contoller is for ThankPage//

public without sharing class ThankController 
{
    public List<Lead> leads {get;set;}
    public ThankController(){
        Id leadId = ApexPages.currentPage().getParameters().get('id');
        System.debug('----leadId--'+leadId);
        leads= [SELECT Id,Has_Email_Verifed__c FROM Lead WHERE Id =: leadId];
        
    }
    
    public void updateLead(){
        try{
            if(!leads.isEmpty()){
                leads[0].Has_Email_Verifed__c = true;
                leads[0].emailsentfirst__c = true;
                UPDATE leads;
            }
        }
        Catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, e.getMessage()));
           
        }
    }
}