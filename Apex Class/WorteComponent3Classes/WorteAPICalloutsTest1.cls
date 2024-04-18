@isTest
private class WorteAPICalloutsTest1 {
    
    @isTest static void createContact() {
        Contact con=new Contact();
        con.FirstName='test';
        con.lastname='record';
        con.Email='test@abc.com';
        con.title='ceo';
        con.department='it';
        con.X100worte_profile_id__c='';
        insert con;
        
        test.startTest();
        WorteAPICallouts.createContact(con.Id);
        test.stopTest();        
    }
    
    @isTest static void createLead() {
        
        Lead l=new Lead();
        l.FirstName='leadtest';
        l.lastname='leadlastname';
        l.Email='lead@test.com';
        l.X100worte_profile_id__c='';
        l.Company='test';
        l.title='ceo';
        insert l;   
        
        test.startTest();
        WorteAPICallouts.createContact(l.Id);
        test.stopTest();
        
    }
    
    @isTest static void getListOfAllTags() {
        
        Lead l=new Lead();
        l.FirstName='leadtest';
        l.lastname='leadlastname';
        l.Email='lead@test.com';
        l.X100worte_profile_id__c='';
        l.Company='test';
        l.title='ceo';
        insert l;   
        
        Contact con=new Contact();
        con.FirstName='test';
        con.lastname='record';
        con.Email='test@abc.com';
        con.title='ceo';
        con.department='it';
        con.X100worte_profile_id__c='';
        insert con;
        
        test.startTest();
        WorteAPICallouts.getListOfAllTags(con.Id);
        test.stopTest();
        
    }
    
    @isTest static void getListOfAllTags2() {
        
        Lead l=new Lead();
        l.FirstName='leadtest';
        l.lastname='leadlastname';
        l.Email='lead@test.com';
        l.X100worte_profile_id__c='';
        l.Company='test';
        l.title='ceo';
        insert l;   
        
        test.startTest();
        WorteAPICallouts.getListOfAllTags(l.Id);
        test.stopTest();
    }
    
    @isTest static void addNewtag() {
        WorteAPICallouts.addNewtag('test');
        WorteAPICallouts.analysisResultForProfile('test123');
        WorteAPICallouts.analyseSentContactText('test','test123');
        WorteAPICallouts.analyseSentText('test','test123');
        WorteAPICallouts.getRelationshipQuality('test');
    }
    
    @isTest static void getAllProfiles() {
        WorteAPICallouts.getAllProfiles('contact@gmail.com');
    }
    
    @isTest static void contacttags() {
        WorteAPICallouts.contacttags('test','test','test');
    }
    
}