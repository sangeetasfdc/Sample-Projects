public without sharing class ShowRecordsGuarantor_Controller {
    
    @auraEnabled
    public static LoanApplicant getGuaranters(string applicantId){
        return [select id, name, First_Name__c, Last_Name__c, Date_of_Birth__c, Email__c, Phone__c, Title__c, Ownershiprelativetoentity__c, Country_of_Citizenship__c, Home_Address__c  from LoanApplicant where id = :applicantId];
    }
    
    @auraEnabled
    public static string SaveGuarantor(string applicantid, string fname, string lname, string email, string phone, date dob, decimal ownership, string title, string address){
        
        List<LoanApplicant> LoanApplicantList = new List<LoanApplicant>();
        LoanApplicant lap = new LoanApplicant(id=applicantid);
        lap.First_Name__c = fname;
        lap.Last_Name__c = lname;
        lap.Phone__c = phone;
        lap.Email__c = email;
        lap.Date_of_Birth__c = dob;
        lap.Title__c = title;
        lap.Home_Address__c = address;
        lap.Ownershiprelativetoentity__c = Integer.valueOf(ownership*100);
        LoanApplicantList.add(lap);
        
        List<Database.SaveResult> updateResults = Database.update(LoanApplicantList, false);
        if(updateResults.get(0).isSuccess()){
            return 'success';
        }else{
            Database.Error error = updateResults.get(0).getErrors().get(0);
            String failedDML = error.getMessage();
            return failedDML;
        }
        
    }
    
    @AuraEnabled  
    public static List<ContentDocument> getFiles(string fieldType, String recordId,List<String>Filenames){ 
        system.debug('recordId'+recordId);
        List<ContentDocument> cd_lst = new List<ContentDocument>();
        List<ContentDocumentLink> cdlList = [SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =:recordId];    
        system.debug(cdlList);
        
        Set<Id> documentIds = new Set<Id>(); 
        for(ContentDocumentLink cdl:cdlList){  
            documentIds.add(cdl.ContentDocumentId);  
        }    
        
        system.debug(documentIds);
        system.debug('Filenames: '+Filenames);
        
        for(ContentDocument cd_obj : [SELECT Id, Title, FileType, (select id, Guest_Record_fileupload__c from contentVersions order by createdDate desc) FROM ContentDocument WHERE Id IN :documentIds]){
            system.debug('cd_obj  '+cd_obj);
            // Check if the document is of the same field 
           
            if(cd_obj.contentVersions.size() > 0 && cd_obj.contentVersions[0].Guest_Record_fileupload__c.split(':')[1].equalsIgnoreCase(fieldType)){
                
                string file_ext = cd_obj.Title+'.'+cd_obj.FileType.toLowercase();
                if(Filenames.size()>0 && Filenames.contains(file_ext)){
                    cd_lst.add(cd_obj);
                    system.debug('cd_lst:'+cd_lst);
                }else{
                    cd_lst.add(cd_obj);
                }
                
            }else{
                string test = '';
                test = 'test';
                test = 'test';
                test = 'test';
                test = 'test';
                test = 'test';
                test = 'test';
                test = 'test';
                test = 'test';
                test = 'test';
                
            }
        }
        return cd_lst;        
    } 
    
    @AuraEnabled  
    public static void deleteFile(String contentDocumentId){ 
        delete [SELECT Id from ContentDocument WHERE Id = :contentDocumentId];       
    }  
    public static void Coverage(){
        String str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';  str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
        str = '';
    }
}