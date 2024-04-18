@istest
public class AddRowAuraComponentTest {

    @istest
    public static void testsaveLoanApplicantList(){
        test.startTest();
        Account account1= new Account(Name='acc1');
        insert account1;
        Account account2= new Account(Name='acc2');
        insert account2;
        Datetime myDate = Datetime.newInstance(2008, 12, 1, 12, 30, 2);
        Opportunity loan1= new Opportunity(Name='loa1',StageName='Application In Process',Name__c='systemname1',CloseDate=system.today(),AccountId=account1.id,CreatedDate__c=myDate,LastModifiedDate__c=myDate);
        insert loan1;
        Opportunity loan2= new Opportunity(Name='loa2',StageName='Application In Process',Name__c='systemname2',CloseDate=system.today(),AccountId=account2.id,CreatedDate__c=myDate,LastModifiedDate__c=myDate);
        insert loan2;
        ResidentialLoanApplication LoanApplication1= new ResidentialLoanApplication(Name='Acme',OpportunityId=loan1.id);
        insert LoanApplication1;
        ResidentialLoanApplication LoanApplication2= new ResidentialLoanApplication(Name='dcme',OpportunityId=loan2.id);
        insert LoanApplication2;
        List<LoanApplicant> loanapplicantList = new List<LoanApplicant>();
        LoanApplicant la1 = new LoanApplicant(First_Name__c='la',Last_name__c='da',name='ladaa',LoanApplicationId=LoanApplication1.id);
        LoanApplicant pa1 = new LoanApplicant(First_Name__c='pa',Last_name__c='da',name='padaa',LoanApplicationId=LoanApplication2.Id);
        loanapplicantList.add(la1);
        loanapplicantList.add(pa1);
        
        if(!loanapplicantList.isEmpty()){
            AddRowAuraController.saveLoanApplicantList(loanapplicantList);
        }
        
        test.stopTest();
    }
}