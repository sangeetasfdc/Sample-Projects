@isTest
public class LoanApplicationTrigger_Test {
   static testMethod void myUnitTest() {
       Account acc= new Account();
       acc.Name = 'test41 acc';
       insert acc;
       
        

       
       ResidentialLoanApplication la = new ResidentialLoanApplication();
       la.name = 'test41';
        la.stage__c = 'Application In Process';
        la.AccountId = acc.id;
      
       insert la;
      
       Opportunity op = new Opportunity();
       op.Name = 'test41 op';
       op.StageName = 'Converted to Loan';
      op.CreatedDate__c = system.today();
       op.LastModifiedDate__c =  system.today();
       op.Name__c =  'ne4 n';
       op.CloseDate =  system.today();
       op.AccountId = acc.id;
       op.AccountId__c=acc.id;
       insert op;
       
        Loan_Applicant_Entity__c le = new Loan_Applicant_Entity__c();
       le.Name= 'Na4me1';
       le.Loan_Application__c = la.id;
      
       insert le;
       
        LoanApplicant LAT = new LoanApplicant();
       LAT.Name=le.Name;
       LAT.LoanApplicationId = la.id;
       insert LAT;
       
       la.name = 'tes4t212';
       la.stage__c = 'Converted to Loan';
      
       update la;
      
       
   }
    
     
   
   
}