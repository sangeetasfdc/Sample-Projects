public class NonGuarantorController {
    @AuraEnabled
    public static void saveLoanApplicantList(List<LoanApplicant> conList, string loanapplicationId) 
    {        
        system.debug('loanapplicationId'+loanapplicationId);
        list<LoanApplicant> newconlist= new list<LoanApplicant>();
        for(LoanApplicant La:conList){
            LoanApplicant Loan = new LoanApplicant(LoanApplicationId = loanapplicationId);
            Loan.Name = La.Name ;
            if(la.id != null){
                loan.id = la.id;
            }
            Loan.Last_Name__c = La.Last_Name__c;
            Loan.Email__c = La.Email__c;
            Loan.Phone__c = La.Phone__c;
            Loan.Title__c = La.Title__c;
            Loan.Ownershiprelativetoentity__c = La.Ownershiprelativetoentity__c;
            Loan.CitizenshipStatus = La.CitizenshipStatus;
            Loan.Country_of_Citizenship__c = La.Country_of_Citizenship__c;
            Loan.Non_guarantors_key_principle__c = true;
            system.debug('applican rec: '+loan);
            newconlist.add(Loan);
        }
        
        upsert newconlist;
        /*
        map<string,LoanApplicant> applicantMap = new map<string,LoanApplicant>();
        system.debug('newconlist'+newconlist);
        
        if(!newconlist.isEmpty()){
        
            for(LoanApplicant ap : newconlist){
                if(ap.Email__c != null){
                    applicantMap.put(ap.Email__c,ap);
                }
            }
            
            system.debug('applicantMap: '+applicantMap);

            for(LoanApplicant la : [select id, Email__c from LoanApplicant where Email__c in : applicantMap.keySet()]){
                applicantMap.get(la.Email__c).id = la.id;
                system.debug('loan applicant to update: '+applicantMap.get(la.Email__c));
            }

            if(!applicantMap.isEmpty()){
                upsert applicantMap.values();
            }
        }*/
        
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
        
        list<LoanApplicant> getconlist= [Select id, Name, First_Name__c , Last_Name__c , Email__c, Phone__c, Ownershiprelativetoentity__c , Title__c, CitizenshipStatus, Country_of_Citizenship__c, Non_guarantors_key_principle__c From LoanApplicant where LoanApplicationId =:loanapplicationId AND Non_guarantors_key_principle__c = true];
         System.debug('List of applicants:'+getconlist);
         
        return getconlist;
        
    }

}