@isTest(SeeAllData=true)
Public class AddRowAuraControllerTest{
    static testMethod void myUnitTest(){
        map<string,LoanApplicant> applicantMap = new map<string,LoanApplicant>();
        map<string,LoanApplicant> SendEmailGuarantorMap = new map<string,LoanApplicant>();
        
        List<LoanApplicant>l_lst = new List<LoanApplicant>();
        
        Account acc = new Account();
        acc.name = 'test012';
        acc.Entity_Status__c='Ineligible';
        insert acc;
        
        task t = new task();
        t.Subject = 'Pull Credit';
        t.Priority = 'Normal';
        t.Status='Open';
        t.WhatId=acc.Id;
        insert t;
        
        ResidentialLoanApplication la = new ResidentialLoanApplication();
        la.AccountId=acc.Id;
        la.Name='Test 2';
        insert la;
        
              
        LoanApplicant Loan1 = new LoanApplicant();
        Loan1.Name = 'Test Name1' ;
        Loan1.LoanApplicationId=la.Id;
        Loan1.Last_Name__c = 'test Last Name1';
        Loan1.Email__c = 'test1@gmail.com';
        Loan1.Title__c = 'Test1 title';
        Loan1.Ownershiprelativetoentity__c = 20;
        l_lst.add(Loan1);
        
        applicantMap.put(Loan1.Email__c,Loan1);
        SendEmailGuarantorMap.put(Loan1.Email__c,Loan1);
        
        EmailTemplate emailTemplate = [Select Id,Subject,Description,  HtmlValue,DeveloperName,Body from EmailTemplate where name = 'GuarantorEmail'];
        
        Test.startTest();       
        AddRowAuraController.sendEmailToGuarantor( applicantMap ,  SendEmailGuarantorMap);
        AddRowAuraController.saveLoanApplicantList(l_lst,la.Id);
        AddRowAuraController.getLoanApplicantList(la.id);
        Test.stopTest();
        

    }
}