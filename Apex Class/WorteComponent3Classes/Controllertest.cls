@istest
public class Controllertest {
    
    @istest static string GetProfileIDtest(){
        
        String worteprofilevalue='';
        Contact con=new Contact();
        con.FirstName='TEST';
        con.LastName='test2';
        con.Email='testing@abc.com';
        con.X100worte_profile_id__c='8c70a3e6-0c89-4b63-a651-46be06b8gb54';
        insert con;
        
        
        Lead l=new Lead();
        l.FirstName='TEST1';
        l.LastName='test3';
        l.Email='testing@ab.com';
        l.company='testlead';
        l.X100worte_profile_id__c='8c70a3f6-0c89-4b63-f651-46be06b8gb54';
        insert l;
        controller.getTags(con.id);
        controller.getTags(l.id);
        controller.GetProfileID(con.id);
        controller.GetProfileID(l.id);
		controller.AnalysisResult(con.id);
        controller.AnalysisResult(l.id);
       
        
        //test.stopTest();
        return worteprofilevalue;
             
    }
   
    
  @istest static String RelationshipQualitytest(){
       Map<String,Object> qualityfactor=new  Map<String,Object>();
      qualityfactor.put('qualityfactor', 32.22);
      qualityfactor.put('trend', 'upward');
        String result='';
        Contact con=new Contact();
        con.FirstName='TEST';
        con.LastName='test2';
        con.Email='testing@abc.com';
        con.X100worte_profile_id__c='8c70a3e6-0c89-4b63-a651-46be06b8gb54';
        con.Relationship_Tendency__c='upward';
        con.Relationship_Quality__c=10;
        insert con;   
        controller.RelationshipQuality(con.id);
          
        Lead l=new Lead();
        l.FirstName='TEST1';
        l.LastName='test3';
        l.Email='testing@ab.com';
        l.company='testlead';
        l.Relationship_Quality__c=10;
        l.Relationship_Tendency__c='upward';
        l.X100worte_profile_id__c='8c70a3f6-0c89-4b63-f651-46be06b8gb54';
        insert l;
        controller.RelationshipQuality(l.id);
       
        return result;
        //return qualityfactor ;
    }
    
}