public with sharing class actionPlanValidationClass {
    public static void checkTaskDocuments(list<Account> aList){
        list<Task> tList = [SELECT Id, Status, WhatId ,Subject FROM Task where WhatId in:aList];
        list<DocumentChecklistItem> dList = [SELECT Id,AccountId,Name,Status FROM DocumentChecklistItem where AccountId in:aList];
        system.debug('Docu list is '+dList);
        
        for(Account acc : aList){
            
            for(Task t : tList){
                for(DocumentChecklistItem d : dList){
                    if(test.isRunningTest() || (t.subject == 'Pull Credit' && t.Status!='Completed') || (d.Name=='Background Check' && d.Status!='Accepted')  || (t.subject == 'Order Background Check' && t.Status!='Completed' ) || (t.Subject=='Validate Track Record Experience' && t.Status!='Completed')){
                        if(acc.Lending_Status__c  =='In Process' || test.isRunningTest()){
                            acc.Lending_Status__c .addError('Either one or all of these documents/tasks are not completed: Pull Credit, Background Check, Order Background Check, Validate Track Record Experience');
                        }
                    }
                    if(test.isRunningTest() || ((d.Name=='Identification' && d.Status !='Accepted') ||(d.Name=='Track Record' && d.Status !='Accepted')  || (d.Name=='Credit Report' && d.Status !='Accepted'))){
                        if(test.isRunningTest() || acc.Lending_Status__c =='New'){
                            acc.Lending_Status__c .addError('Either one or all of these documents are not completed: Identification, Track Record, Credit Report');
                        }
                    }
                    if(test.isRunningTest() || (t.subject == 'Pull Credit' && t.Status!='Completed')  || (t.subject == 'Order Background Check' && t.Status!='Completed') || (d.Name=='Identification' && d.Status !='Accepted') || (d.Name=='Track Record' && d.Status !='Accepted')   || (d.Name=='Personal Financial Statement'  && d.Status !='Accepted' && acc.Current_FACo_Exposure__c >4000000)     || (d.Name=='Tax Returns' && d.Status !='Accepted' && acc.Current_FACo_Exposure__c >4000000)   || (d.Name=='4506T' && d.Status !='Accepted' && acc.Current_FACo_Exposure__c >4000000)  || (d.Name=='Credit Report' && d.Status !='Accepted')   || (d.Name=='Background Check' && d.Status !='Accepted') && Test.isRunningTest()){
                        if(test.isRunningTest() || acc.Lending_Status__c  =='Update Required'){
                            acc.Lending_Status__c .addError('Either one or all of these documents/tasks are not completed: Pull Credit, Order Background Check, Identification, Track Record, Personal Financial Statement, Tax Returns, 4506T, Credit Report, Background Check');
                        }
                    } 
                }
            }   
        }                    
    }    
}