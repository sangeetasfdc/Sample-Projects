@isTest
public class ViewPDFTest {

@isTest
static void testMethod1() 
{
test.startTest();
lead testlead = new lead();
    testlead.Lastname='Leadtd' ;
    testlead.Phone='9899665588' ;
    testlead.Email='Testlead@gmail.com';
    testlead.Quote_sent__c=true;
    testlead.status='LVM 2';
insert testlead;

//Create Account
        Account acct = new Account(Name='TEST_ACCT');
        insert acct;
        
        //Create contentVersion
        ContentVersion cv = new ContentVersion();
        cv.Title = 'Test Document';
        cv.PathOnClient = 'TestDocument.pdf';
        cv.VersionData = Blob.valueOf('Test Content');
        cv.IsMajorVersion = true;
        Insert cv;
        
        
        //Get Content Version
        List<ContentVersion> cvList = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id];
        System.assertEquals(cvList.size(), 1);
        system.debug('ContentVersionID : ' + cvList[0].Id);
        
        //create ContentDocumentLink  record 
        ContentDocumentLink cdl = New ContentDocumentLink();
        cdl.LinkedEntityId = testlead.id;
        cdl.ContentDocumentId = cvList[0].ContentDocumentId;
        cdl.shareType = 'V';
        insert cdl;  




PageReference pRef = Page.LeadPDF;
pRef.getParameters().put('id', testlead.Id);
Test.setCurrentPage(pRef);


    ApexPages.StandardController sc = new ApexPages.StandardController(testlead);
    ViewPdf obj = new ViewPdf(sc);
    

    PageReference  sendpdf= obj.SendPDF();


    

Test.StopTest();
} 
}