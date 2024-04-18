@isTest
public class AddPermissionSets_Test {
    @isTest
    public static void PermissionCoverage()
    {
        Set<id> userSet =new Set<id>();
        
        Id profileId = [Select Id From Profile Where Name ='Borrower'].Id;
        
        String AccountRecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'Borrowing Entity' AND sObjectType = 'Account'].Id;
        Account acc = new Account();
        acc.RecordTypeId = AccountRecordTypeId;
        acc.Name = 'Test Account';
        insert acc;
        
        
        Contact con = new Contact();
        con.AccountId = acc.Id;
        con.FirstName = 'Test';
        con.LastName = 'Demo';
        insert con;
        
        
        String orgId = UserInfo.getOrganizationId();  
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');  
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));  
        String uniqueName = orgId + dateString + randomInt; 
        User tempUser = new User();  
        tempUser.FirstName = 'tester';  
        tempUser.LastName = 'User';
        tempUser.ContactId = con.Id;
        tempUser.email = uniqueName + '@sfdc' + orgId + '.org';
        tempUser.Username = uniqueName + '@sfdc' + orgId + '.org';  
        tempUser.EmailEncodingKey = 'ISO-8859-1';
        tempUser.Alias = uniqueName.substring(18, 23);  
        tempUser.TimeZoneSidKey = 'America/Los_Angeles';  
        tempUser.LocaleSidKey = 'en_US';
        tempUser.LanguageLocaleKey = 'en_US'; 
        tempUser.ProfileId = profileId;
        insert tempUser; 
        userSet.add(tempUser.id);
        System.debug('USer '+tempUser);
        
        AddPermissionSets.AssignPermissionSetToUsers(userSet);
    }
}