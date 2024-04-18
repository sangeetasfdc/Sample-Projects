public class AddRowAuraController 
{   
    @AuraEnabled
    public static void saveLoanApplicantList(List<LoanApplicant> conList, string loanapplicationId) 
    {        
        system.debug('loanapplicationId'+loanapplicationId);
        list<LoanApplicant> newconlist= new list<LoanApplicant>();
        map<string,LoanApplicant> applicantMap = new map<string,LoanApplicant>();
        map<string,LoanApplicant> SendEmailGuarantorMap = new map<string,LoanApplicant>();
       
        for(LoanApplicant La:conList){
            LoanApplicant Loan = new LoanApplicant(LoanApplicationId = loanapplicationId);
            Loan.Name = La.Name ;
            Loan.Last_Name__c = La.Last_Name__c;
            Loan.Email__c = La.Email__c;
            Loan.Title__c = La.Title__c;
            Loan.Ownershiprelativetoentity__c = La.Ownershiprelativetoentity__c;
            
            newconlist.add(Loan);
        }
        
        system.debug('newconlist'+newconlist);
        
        if(!newconlist.isEmpty()){
            
            for(LoanApplicant ap : newconlist){
                if(ap.Email__c != null){
                    applicantMap.put(ap.Email__c,ap);
                }
            }
            
            for(LoanApplicant la : [select id, ContactId , Email__c from LoanApplicant where Email__c in : applicantMap.keySet()]){
                applicantMap.get(la.Email__c).id = la.id;
            }
            
            for(LoanApplicant lp : applicantMap.values()){
                if(lp.id == null){
                    SendEmailGuarantorMap.put(lp.email__c,lp);
                }
            }
            
            if(!applicantMap.isEmpty()){
                upsert applicantMap.values();
            }
            
        }
        
    }
    
    
    public static void sendEmailToGuarantor(map<string,LoanApplicant> SendEmailGuarantorMap, map<string,LoanApplicant> applicantMap){
    
        for(String LAEmail : SendEmailGuarantorMap.keySet()){
        
            LoanApplicant lap = applicantMap.get(LAEmail);
            
            
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setSaveAsActivity(false);
            EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'GuarantorEmail'];
            
            message.setTemplateID(emailTemplate.Id);
            message.setTargetObjectId(userinfo.getuserid());
            message.toAddresses = new String[] { lap.email__c};
                    
            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
                        
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
            
            if (results[0].success){
                System.debug('The email was sent successfully.');
            }else{
                System.debug('The email failed to send: ' + results[0].errors[0].message);
            }
        
        }
    }
    
    
    @AuraEnabled
    public static void removerecord(List<LoanApplicant> conList, string index){
        
        system.debug('conList: '+conList.size());
        delete [Select Id From LoanApplicant Where Id = :index];
        
        
    }
    
    @AuraEnabled
    public static list<LoanApplicant> getLoanApplicantList( string loanapplicationId) 
    {        
        system.debug('loanapplicationId: '+loanapplicationId);
        
        list<LoanApplicant> getconlist= [Select id, Name, First_Name__c , Last_Name__c , Email__c  , Ownershiprelativetoentity__c , Title__c From LoanApplicant where LoanApplicationId =:loanapplicationId AND Non_guarantors_key_principle__c = false And Primary_Guarantor__c = false];
        System.debug('List of applicants:'+getconlist);
        return getconlist;
        
    }
}