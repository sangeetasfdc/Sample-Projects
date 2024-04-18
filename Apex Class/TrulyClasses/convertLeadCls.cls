public class convertLeadCls {
    
    
    public static string convertLeadMethod(list<lead> leadList){
    
    
        /********************************************  CONVERT LEAD START  **********************************************/
    
        List<Database.LeadConvert> leads = new List<Database.LeadConvert>();
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        
        for(lead ld : leadList){
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setConvertedStatus(convertStatus.MasterLabel);
            lc.setDoNotCreateOpportunity(true);
            lc.setLeadId(ld.id);
            leads.add(lc);
        }
        
        Map<id,id> convertMap = new Map<id,id>();
        Map<id,id> LeadContactMap = new Map<id,id>();
        List<Database.LeadConvertResult> lcr = Database.convertLead(leads, true);
        set<id> LoanAppId = new set<id>();
        
        for(Database.LeadConvertResult result : lcr){
            if(result.isSuccess()){
                convertMap.put(result.getLeadId(),result.getAccountId());
                LeadContactMap.put(result.getLeadId(),result.getContactId());
            }else{
                system.debug('Convert error : '+result.getErrors());
            }                
        }
        /********************************************  CONVERT LEAD END  **********************************************/
    
    
    
       
        /********************************************  CREATE LOAN APPLICATION START  **********************************************/
        
        Map<id,ResidentialLoanApplication> applicationMap = new Map<id,ResidentialLoanApplication>();
        
        for(Lead ld : [select id, FirstName , ownerid, LastName from lead where id in : convertMap.keySet()]){
            ResidentialLoanApplication ll = new ResidentialLoanApplication();
            ll.name = ld.FirstName+ ' ' +ld.LastName;
            ll.AccountId = convertMap.get(ld.id);
            ll.ownerid = ld.ownerid;
            applicationMap.put(ld.id,ll);
        }
        
        if(!applicationMap.isEmpty()){
            
            Database.SaveResult[] saveResultListApp = Database.insert(applicationMap.values(), false);
            
            for(Database.SaveResult sr : saveResultListApp){
                if(sr.isSuccess()) {
                    System.debug('Successfully inserted LOAN Application: '+ sr.getId());
                    LoanAppId.add(sr.getId());
                }else{
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    }
                }
            }
            
            
            List<Loan_Pass_Option__c> lpList = new List<Loan_Pass_Option__c>();
            List<LoanPass_Approved_product__c> lpAList = new List<LoanPass_Approved_product__c>();
            
            for(Lead ld : [select id, (select id from Loan_Pass_Options__r), (select id from LoanPass_Approved_products__r) from Lead where id in : applicationMap.keySet()]){
                
                for(Loan_Pass_Option__c lp : ld.Loan_Pass_Options__r){
                    lp.borrower__c = applicationMap.get(ld.id).accountId;
                    lpList.add(lp);
                }
                
                for(LoanPass_Approved_product__c lap : ld.LoanPass_Approved_products__r){
                    lap.Borrower__c = applicationMap.get(ld.id).accountId;
                    lpAList.add(lap);
                }
                
            }
            
            if(!lpList.isEmpty()){
                Update lpList;
            }
            
            if(!lpAList.isEmpty()){
                Update lpAList;
            }
            
        }
        /********************************************  CREATE LOAN APPLICATION END  **********************************************/
    
    
    
    
        /********************************************  CREATE COMMUNITY USER START  **********************************************/
    
        List<Profile> Profile = [SELECT Id FROM Profile WHERE Name = 'Borrower'];
        Map<id,user> usrMap = new Map<id,user>();
        Map<id,string> usrMap2 = new Map<id,string>();
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
            
        if(uniqueName.length()>51){
            uniqueName=uniqueName.substring(0,51);
        }
            
        for(Lead ld : [select id, firstname, lastname, email, ownerid from lead where id in :applicationMap.keySet()]){ 
    
            string nick = ld.email!=null?ld.email.substring(0, ld.email.indexOf('@')):''; nick += Datetime.now().getTime();       
            User newUser = new User(
                alias = uniqueName.substring(18, 23),
                email = ld.email,
                contactId = LeadContactMap.get(ld.id),
                emailencodingkey = 'UTF-8',
                firstname = ld.firstName,
                lastname = ld.lastname,
                languagelocalekey = 'en_US',
                localesidkey = 'en_US',
                timezonesidkey = 'America/Los_Angeles',
                username = ld.email,
                CommunityNickname = nick,
                ProfileId = Profile[0].Id,
                
                IsActive = true);
                
            usrMap.put(applicationMap.get(ld.id).id,newUser); 
            usrMap2.put(applicationMap.get(ld.id).id, ld.ownerId); 
            
        }  
            
        if(!usrMap.isEmpty()){
            
            Map<id,user> uesrsInserted = new Map<id,user>();
            
            Database.SaveResult[] saveResultList = Database.insert(usrMap.values(), false);
            
            for(Database.SaveResult sr : saveResultList){
                if(sr.isSuccess()) {
                    System.debug('Successfully inserted User. User ID: ' + sr.getId());
    
                    /******************* ASSIGN PERMISSION SETS **********************/
                    AddPermissionSets.AssignPermissionSetToUsers(sr.getId());
    
                }else{
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('User fields that affected this error: ' + err.getFields());
                    }
                }
            }
    
            for(String ids : usrMap.keySet()){
                if(usrMap.get(ids).Id == Null){
                    usrMap.remove(ids);
                }
            }
    
            system.debug('usrMap: '+usrMap);
        }
        /********************************************  CREATE COMMUNITY USER END  **********************************************/
    
    
    
    
    
        /********************************************  CREATE SHARING RULES START  ******************************************************/
    
        List<ResidentialLoanApplicationShare> ShareList = new List<ResidentialLoanApplicationShare>();
       
        for(ResidentialLoanApplication RLA : [select id, ownerid from ResidentialLoanApplication where id in : usrMap.keySet()]){
            
            ResidentialLoanApplicationShare resShare = new ResidentialLoanApplicationShare();
            resShare.parentId = RLA.Id;
            resShare.userOrGroupId = RLA.ownerid;
            resShare.AccessLevel = 'Edit';
            ShareList.add(resShare);
            
        }
        
        if(!ShareList.isEmpty()){
            //Insert ShareList;
        }
        /********************************************  CREATE SHARING RULES END  ******************************************************/
        
    
    
    
    
        /********************************************  CHANGE LOAN APPLICATION OWNER START  *****************************************/
        
        List<ResidentialLoanApplication> RLAsToUpdate = new List<ResidentialLoanApplication>();
        for(Id RLAId : usrMap.keySet()){
            ResidentialLoanApplication RLA = new ResidentialLoanApplication(id = RLAId, ownerId = usrMap2.get(RLAId));
            RLAsToUpdate.add(RLA);
        }
    
        if(!RLAsToUpdate.isEmpty()){
            Update RLAsToUpdate;
        }
        /********************************************  CHANGE LOAN APPLICATION OWNER END  ******************************************/
    
        if(!convertMap.values().isEmpty()){
            return convertMap.values()[0];
        }else{
            return null;
        }

    }
    
}