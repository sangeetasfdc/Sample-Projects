@istest
public class LeadQualified_Test {

    @istest
    public static void testM(){
        Lead ld = new lead();
        ld.Company = 'test';
        ld.email = 'test@gmail.com';
        ld.phone = '4554454554';
        ld.LastName = 'test';
        ld.Quote_sent__c = false;
        Insert ld;
        
        ld.Quote_sent__c = true;
        Update ld;
    }
}