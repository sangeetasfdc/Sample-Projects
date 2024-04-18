@istest
public class ContentVersion_Trigger_Test {
    static testMethod void myUnitTest() {
        string before = 'Testing base 64 encode';
         Blob beforeblob = Blob.valueOf(before);
         //Insert contentdocument data
         ContentVersion cv = new ContentVersion();
         cv.title = 'test content trigger';
         cv.PathOnClient ='test';
         cv.VersionData =beforeblob;
         insert cv;
    }
}