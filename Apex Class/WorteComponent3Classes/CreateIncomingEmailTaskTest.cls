@isTest
private class CreateIncomingEmailTaskTest
{
    static testMethod void incomingEmailtask() 
    {
       Messaging.InboundEmail email = new Messaging.InboundEmail() ;
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       email.fromAddress = 'test@test.com';
       email.subject = 'Test lead Email';
       email.plainTextBody = 'Test lead Email';
        Contact contact=new Contact(firstName='test',LastName='data',Email='test1@test.com');
        insert contact;
        Lead lead = new Lead(firstName='aditi', lastName='dwivedi',Company='test',Email='test@test.com',X100worte_profile_id__c='c1a511a7-65ac-4df1-9497-2c9f278aa545');
        insert lead ;
        Task task=new Task(Description = email.plainTextBody, subject = email.subject, Priority = 'Medium', ActivityDate = System.today(), ReminderDateTime = System.now(), WhoId = lead.id);
        insert task; 
        /*if(String.isNotBlank(lead.X100worte_profile_id__c)){
            String TextBody = 'Test lead Email';
            WorteAPICallouts.analyseSentContactText(TextBody,lead.X100worte_profile_id__c);
        }*/
        
       CreateIncomingEmailTask obj= new CreateIncomingEmailTask();
       obj.handleInboundEmail(email, envelope );
    }
}