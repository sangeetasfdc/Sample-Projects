@isTest
public class actionPlanValidationTest {
    @isTest
    public static void actionPlanValidationMethod1(){
        list<Account> aList = new list<Account>();
        Account acc = new account();
        acc.Name='Test001';
        acc.Entity_Status__c='Ineligible';
        aList.add(acc);
        insert acc;
        
        update acc;
        
        Contact con = new Contact();
        con.LastName='Test002';
        insert con;
        
        Task t = new Task();
        t.Subject='Pull Credit';
        t.Priority='Low';
        t.Status='Not Started';
        t.WhatId=acc.Id;
        insert t;
        
                
        DocumentChecklistItem d = new DocumentChecklistItem();
        d.Name='Background Check';
        d.Status='New';
        d.ParentRecordId=acc.Id;
        d.WhoId=con.Id;
        insert d;
            
        actionPlanValidationClass.checkTaskDocuments(aList);
        
         t.Subject='Order Background Check';
        update t;
        
        actionPlanValidationClass.checkTaskDocuments(aList);
        
        t.Subject='Validate Track Record Experience';
        update t;
        
        actionPlanValidationClass.checkTaskDocuments(aList); 
    }
    
     public static void actionPlanValidationMethod2(){
        list<Account> aList = new list<Account>();
        Account acc = new account();
        acc.Name='Test001';
        acc.Entity_Status__c='Ineligible';
        aList.add(acc);
        insert aList;
        
        Contact con = new Contact();
        con.LastName='Test002';
        insert con;
        
        Task t = new Task();
        t.Subject='Order Background Check';
        t.Priority='Low';
        t.Status='Not Started';
        t.WhatId=acc.Id;
        insert t;
        
                
        DocumentChecklistItem d = new DocumentChecklistItem();
        d.Name='Background Check';
        d.Status='New';
        d.ParentRecordId=acc.Id;
        d.WhoId=con.Id;
        insert d;
            
        actionPlanValidationClass.checkTaskDocuments(aList);    
}}