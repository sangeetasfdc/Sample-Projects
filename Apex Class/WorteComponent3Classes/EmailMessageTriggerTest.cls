@istest
public class EmailMessageTriggerTest {
    @istest static void afterinserttest(){
        Test.startTest();
        
        Lead l = new Lead();
        l.FirstName = 'testing';
        l.LastName = 'record';
        l.X100worte_profile_id__c = '8c70a3e6-0c89-4b63-a651-46be06b8gb54';
        l.City = 'xyz';
        l.Company = 'testcompany'; 
        insert l;
        
        //Insert emailmessage for Lead
        EmailMessage email1 = new EmailMessage();
        email1.FromAddress = 'mohit@makedian.com';
        email1.Incoming = True;
        //email1.ActivityId = t.id;
        email1.ToAddress= 'mohit@makedian.com';
        email1.Subject = 'Test email';
        email1.TextBody = 'test12345';
        Insert email1;
        
        EmailMessageRelation emr = new EmailMessageRelation();
        emr.emailMessageId = email1.Id;
        emr.relationId =l.Id; //Lead Id, .....
        emr.relationType = 'ToAddress'; // OtherAddress, FromAddress,....
        //insert emr;
      
        contact con = new contact();
        con.FirstName = 'testcon';
        con.LastName = 'testing';
        con.X100worte_profile_id__c = '34f76480-9044-404e-bb6f-461f5a96660a';
        con.Description = 'testdescription';
        insert con;
        
        Test.stopTest();
        
    }  
}