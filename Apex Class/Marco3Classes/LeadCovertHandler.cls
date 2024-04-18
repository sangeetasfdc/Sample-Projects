public without sharing class LeadCovertHandler {
    
    @future
    public static void sendVerifyEmail(List<Id> leadId){
        List<Lead> leadRecords = [SELECT ID,Email from Lead where Id IN : leadId];
        list<Messaging.SingleEmailMessage> multipleSingleEmail = new List<Messaging.SingleEmailMessage>();
        List<EmailTemplate> welcomeEmailTemplates = [SELECT Id, Name,body, DeveloperName FROM EmailTemplate WHERE DeveloperName = 'Marco_Email_Verify' limit 1];
        for(Lead leads : leadRecords){
            // String HtmlValue = welcomeEmailTemplates[0].
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            System.debug(leads.Id);
            mail.setTargetObjectId(leads.Id);
            mail.setTemplateId(welcomeEmailTemplates[0].Id);
            mail.setWhatId(leads.Id);
            mail.setUseSignature(false);
            mail.setSaveAsActivity(false);
            multipleSingleEmail.add(mail);
            
        }
        
        if(!multipleSingleEmail.isEmpty()){
            Messaging.SendEmail(multipleSingleEmail); 
        }
    }
    
    @future
    public static void sendWelcomeEmail(List<id> contactIds){
        List<contact> contactRecords = [SELECT ID,Email from Contact where Id IN : contactIds];
        list<Messaging.SingleEmailMessage> multipleSingleEmail = new List<Messaging.SingleEmailMessage>();
        List<EmailTemplate> welcomeEmailTemplates = [SELECT Id, Name,body, DeveloperName FROM EmailTemplate WHERE DeveloperName = 'Marco_Welcome' limit 1];
        for(contact contact : contactRecords){
            // String HtmlValue = welcomeEmailTemplates[0].
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(contact.Id);
            mail.setTemplateId(welcomeEmailTemplates[0].Id);
            mail.setWhatId(contact.Id);
            mail.setUseSignature(false);
            mail.setSaveAsActivity(false);
            multipleSingleEmail.add(mail);
            
        }
        
        if(!multipleSingleEmail.isEmpty()){
            Messaging.SendEmail(multipleSingleEmail); 
        }
    }
    
    
    //another method
    
    /*@future
    public static void leadConvert(List<Id> leadId){
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        List<Database.LeadConvert> leads = new List<Database.LeadConvert>();
        for( Id reqId : leadId){
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setConvertedStatus(convertStatus.MasterLabel);
            lc.setLeadId(reqId);
            leads.add(lc); 
            
        }
        
        List<Database.LeadConvertResult> lcr = Database.convertLead(leads, true);
        List<Application__c> applicationList = new List<Application__c>();
        for(Database.LeadConvertResult result : lcr){
            if(result.isSuccess()){
                Application__c app = new Application__c();
                app.Name = 'test app';
                app.Account__c = result.getAccountId();
                app.Contact__c = result.getContactId();
                app.Industry__c = 'Value1';
                applicationList.add(app);
                
            }                
        }
        if(!applicationList.isEmpty()){
            INSERT applicationList;
        }
        
    }*/
}