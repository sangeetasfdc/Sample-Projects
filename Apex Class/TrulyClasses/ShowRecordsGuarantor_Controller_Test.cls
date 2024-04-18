@istest
public class ShowRecordsGuarantor_Controller_Test {
    static testMethod void myUnitTest() {
        Account acc= new Account();
        acc.Name = 'test1 acc';
        insert acc;
        
        ResidentialLoanApplication la = new ResidentialLoanApplication();
        la.Name = 'testLa';
        la.AccountId= acc.id;
        insert la;
        
        LoanApplicant lap = new LoanApplicant();
        lap.Name = 'testl';
        lap.LoanApplicationId = la.Id;
        insert lap;
        
        ShowRecordsGuarantor_Controller.getGuaranters(lap.Id);
        
        string fname = 'nwq1';
        string lname = 'dhdi';
        string email = 'shdj@gmail.com';
        string phone = '34567890';
        date dob = system.today().addDays(10);
        
        decimal ownership = 1.3;
        string title = 'title';
        string address = 'asddftdj';
        ShowRecordsGuarantor_Controller.SaveGuarantor(lap.Id, fname, lname, email, phone, dob, ownership, title, address);
        
        
        List<String>Filenames=new List<String>();
        List<id>ConVersion=new List<id>();
        ContentVersion contentVersion = new ContentVersion(
            Title          = 'picture',
            PathOnClient   = 'Pic.jpg',
            VersionData    = Blob.valueOf('Test Content'),
            IsMajorVersion = true,
            Guest_Record_fileupload__c = lap.Id+':jpg' );
        insert contentVersion;
        system.debug(contentVersion);
        ConVersion.add(contentVersion.Id);
        
        
        ContentVersion contentVersionTwo = new ContentVersion(
            Title          = 'image',
            PathOnClient   = 'Pic.jpg',
            VersionData    = Blob.valueOf('Test Content'),
            IsMajorVersion = true,
            Guest_Record_fileupload__c = lap.Id+':jpg' );
        insert contentVersionTwo;
        
        ConVersion.add(contentVersionTwo.Id);
        Filenames.add(contentVersion.Title);
        
        List<ContentVersion> cvList = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :ConVersion ];
        For(ContentVersion cs: cvList)
        {
            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = lap.id;
            cdl.ContentDocumentId = cs.ContentDocumentId;
            cdl.shareType = 'V';
            insert cdl; 
            //system.debug(cdl);
        }
        
        ShowRecordsGuarantor_Controller.Coverage();
        ShowRecordsGuarantor_Controller.getFiles('jpg',lap.Id,Filenames);
        
        
    }
    static testMethod void myUnitTestSecond() {
        Account acc= new Account();
        acc.Name = 'test1 acc';
        insert acc;
        
        ResidentialLoanApplication la = new ResidentialLoanApplication();
        la.Name = 'testLa';
        la.AccountId= acc.id;
        insert la;
        
        LoanApplicant lap = new LoanApplicant();
        lap.Name = 'testl';
        lap.LoanApplicationId = la.Id;
        insert lap;
        
        ShowRecordsGuarantor_Controller.getGuaranters(lap.Id);
        
        string fname = 'nwq1';
        string lname = 'dhdi';
        string email = 'shdj@gmail.com';
        string phone = '34567890';
        date dob = system.today().addDays(10);
        
        decimal ownership = 1.3;
        string title = 'title';
        string address = 'asddftdj';
        ShowRecordsGuarantor_Controller.SaveGuarantor(lap.Id, fname, lname, email, phone, dob, ownership, title, address);
        
        
        List<String>Filenames=new List<String>();
        
        ContentVersion contentVersion = new ContentVersion(
            Title          = 'picture',
            PathOnClient   = 'Pic.jpg',
            VersionData    = Blob.valueOf('Test Content'),
            IsMajorVersion = true,
            Guest_Record_fileupload__c = lap.id+':jpg' );
        insert contentVersion;
        system.debug(contentVersion);
        
        Filenames.add(contentVersion.Title);
        List<ContentVersion> cvList = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id];
        
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = lap.id;
        cdl.ContentDocumentId = cvList[0].ContentDocumentId;
        cdl.shareType = 'V';
        insert cdl; 
        system.debug(cdl);
        ShowRecordsGuarantor_Controller.deleteFile(cvList[0].ContentDocumentId);
        
        
        ShowRecordsGuarantor_Controller.Coverage();
        //ShowRecordsGuarantor_Controller.getFiles('jpg',lap.Id,Filenames);
        
        
    }
}