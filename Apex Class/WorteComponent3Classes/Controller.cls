public class Controller{
    //Get Profile Id and create contact at 100worte
    @AuraEnabled
    public static String GetProfileID(String recordId){
        
        // Variable for storing Profile Id
        String worteprofilevalue;
        if(String.valueOf(recordid).startsWith('003')){
            Contact c=[Select Name, Email, X100worte_profile_id__c From Contact WHERE Id=:recordId];
            //Checking if the ProfileId in the salesforce record is blank or null
            //If the ProfileId is blank or null then pass the email to the callout
            
            if(c.X100worte_profile_id__c == null||String.isNotBlank(c.X100worte_profile_id__c)){
                String email=c.Email;
                system.debug('email'+email);
                //if this email exist on 100worte platform then this callout will return Profile Id
                if(string.isNotBlank(email)){
                    worteprofilevalue=WorteAPICallouts.getAllProfiles(email);
                    System.debug(worteprofilevalue);
                    
                    //If email doesn't exist then create an account on the 100worte platform
                    
                    if(worteprofilevalue=='not found'){
                        WorteAPICallouts.createContact(recordId);
                    }
                    else{
                        
                        //update Profile Id in salesforce record
                        c.X100worte_profile_id__c = worteprofilevalue;
                        update c;
                    }
                }
                else{
                    worteprofilevalue='Please enter Email';
                }
            }
            
        }
        
        // Check if the recordId is from Leads
        else  if(String.valueOf(recordid).startsWith('00Q')){
            Lead l = [Select Name, Email, X100worte_profile_id__c From Lead WHERE Id=:recordId];
            //Checking if the ProfileId in the salesforce record is blank or null
            //If the ProfileId is blank or null then pass the email to the callout
            
            if(l.X100worte_profile_id__c == null||String.isNotBlank(l.X100worte_profile_id__c)){
                String email=l.Email;
                
                //if this email exist on 100worte platform then this callout will return Profile Id
                if(string.isNotBlank(email)){
                    worteprofilevalue=WorteAPICallouts.getAllProfiles(email);
                    System.debug(worteprofilevalue);
                    
                    //If email doesn't exist then create an account on the 100worte platform
                    
                    if(worteprofilevalue=='not found'){
                        WorteAPICallouts.createContact(recordId);
                    }
                    else{
                        
                        //update Profile Id in salesforce record
                        l.X100worte_profile_id__c = worteprofilevalue;
                        update l;
                    }
                }
                else{
                    worteprofilevalue='Please enter Email';
                }
            }
        }
        return worteprofilevalue;
    }
    
    //Get component into salesforce
    @AuraEnabled
    public static DetailedAnalysisResultWrapper AnalysisResult(String recordId){
        DetailedAnalysisResultWrapper result;
        if(String.valueOf(recordid).startsWith('003')){
            Contact c = [Select FirstName,LastName, X100worte_profile_id__c From Contact WHERE Id=:recordId];
            if(c.X100worte_profile_id__c != null || String.isNotBlank(c.X100worte_profile_id__c)){
                result = WorteAPICallouts.analysisResultForProfile(c.X100worte_profile_id__c);
            }
            //system.debug('result:'+result.firstname);
        }
        
        else  if(String.valueOf(recordid).startsWith('00Q')){
            Lead l = [Select Name, X100worte_profile_id__c From Lead WHERE Id=:recordId];
            result = WorteAPICallouts.analysisResultForProfile(l.X100worte_profile_id__c);
            
        }
        system.debug('result:'+result);
        return result;
    }
    
    //Get Relationship Quality
    @AuraEnabled
    public static Map<String,Object> RelationshipQuality(String recordId){
        //String qualityfactor;
        Map<String,Object> qualityfactor=new  Map<String,Object>();
        if(String.valueOf(recordid).startsWith('003')){
            Contact c = [Select Name, X100worte_profile_id__c,Relationship_Quality__c,Relationship_Tendency__c From Contact WHERE Id=:recordId];
            qualityfactor=WorteAPICallouts.getRelationshipQuality(c.X100worte_profile_id__c);
            System.debug('values in map '+qualityfactor);
            if(qualityfactor!=null){
                if((decimal)qualityfactor.get('qualityFactor')!=null)
                {
                    c.Relationship_Quality__c=(decimal)qualityfactor.get('qualityFactor');
                }
               
                    if((string)qualityfactor.get('trend')!=null)
                    {
                        c.Relationship_Tendency__c=(string)qualityfactor.get('trend');      
                    }
                    update c;
                    System.debug('qualityfactor '+qualityfactor);
                
            }
        }
        else if(String.valueOf(recordid).startsWith('00Q')){
            Lead l = [Select Name, X100worte_profile_id__c,Relationship_Quality__c,Relationship_Tendency__c From Lead WHERE Id=:recordId];
            qualityfactor=WorteAPICallouts.getRelationshipQuality(l.X100worte_profile_id__c);
            if(qualityfactor!=null){
                if((decimal)qualityfactor.get('qualityFactor')!=null){
               l.Relationship_Quality__c=(decimal)qualityfactor.get('qualityFactor');  
            } 
                if((string)qualityfactor.get('trend')!=null){
                    l.Relationship_Tendency__c=(string)qualityfactor.get('trend');
                }
                update l;
                
            }
            
            }
            
            System.debug(qualityfactor);
          return qualityfactor;
        }
      /* else{
            Lead l = new Lead();
            l.FirstName = 'testing';
            l.LastName = 'record';
            l.X100worte_profile_id__c = '8c70a3e6-0c89-4b63-a651-46be06b8gb54';
            l.City = 'xyz';
            l.Company = 'testcompany'; 
            
            Lead l2 = new Lead();
            l2.FirstName = 'testing';
            l2.LastName = 'record';
            l2.X100worte_profile_id__c = '8c70a3e6-0c89-4b63-a651-46be06b8gb54';
            l2.City = 'xyz';
            l2.Company = 'testcompany'; 
            
            Lead l22 = new Lead();
            l22.FirstName = 'testing';
            l22.LastName = 'record';
            l22.X100worte_profile_id__c = '8c70a3e6-0c89-4b63-a651-46be06b8gb54';
            l22.City = 'xyz';
            l22.Company = 'testcompany'; 
            
            Lead l23 = new Lead();
            l23.FirstName = 'testing';
            l23.LastName = 'record';
            l23.X100worte_profile_id__c = '8c70a3e6-0c89-4b63-a651-46be06b8gb54';
            l23.City = 'xyz';
            l23.Company = 'testcompany'; 
            
            Lead l24 = new Lead();
            l24.FirstName = 'testing';
            l24.LastName = 'record';
            l24.X100worte_profile_id__c = '8c70a3e6-0c89-4b63-a651-46be06b8gb54';
            l24.City = 'xyz';
            l24.Company = 'testcompany'; 
            
            Lead l241 = new Lead();
            l241.FirstName = 'testing';
            l241.LastName = 'record';
            l241.X100worte_profile_id__c = '8c70a3e6-0c89-4b63-a651-46be06b8gb54';
            l241.City = 'xyz';
            l241.Company = 'testcompany'; 
            
            Lead l242 = new Lead();
            l242.FirstName = 'testing';
            l242.LastName = 'record';
            l242.X100worte_profile_id__c = '8c70a3e6-0c89-4b63-a651-46be06b8gb54';
            l242.City = 'xyz';
            l242.Company = 'testcompany'; 
            l242.FirstName = 'testing';
            l242.LastName = 'record';
            l242.X100worte_profile_id__c = '8c70a3e6-0c89-4b63-a651-46be06b8gb54';
            l242.City = 'xyz';
            l242.Company = 'testcompany'; 
            System.debug('no data');   
            
        }  */   
        
    
    
    //Get tags
    @AuraEnabled
    public static  Map<String,GetListOfAllTagsWrapper.Tags> getTags(String recordId){
        Map<String,GetListOfAllTagsWrapper.Tags> tag;
        if(String.valueOf(recordid).startsWith('003')){
            Contact c = [Select Account.name,Title, Department From Contact WHERE Id=:recordId];
            tag=WorteAPICallouts.getListOfAllTags(recordId);
        }
        else  if(String.valueOf(recordid).startsWith('00Q')){
            Lead l = [Select Company,Title From Lead WHERE Id=:recordId];
            tag=WorteAPICallouts.getListOfAllTags(recordId);
        }
        System.debug(tag);
        return tag;
    }
}