@istest
public class NonGuarantorController_Test {
    static testMethod void myUnitTest() {
        list<LoanApplicant> lalist=new list<LoanApplicant>();
        
        Account acc= new Account();
        acc.Name = 'test1 acc';
        insert acc;

        ResidentialLoanApplication la = new ResidentialLoanApplication();
        la.Name = 'testLa';
        la.AccountId= acc.id;
        insert la;
        
        LoanApplicant Loan = new LoanApplicant();
        Loan.Name = 'test' ;
        Loan.LoanApplicationId = la.Id;
        lalist.add(Loan);
        insert lalist;
        
        
        NonGuarantorController.saveLoanApplicantList(lalist ,la.Id);
    }
    
}