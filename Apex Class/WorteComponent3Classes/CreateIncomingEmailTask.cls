global class CreateIncomingEmailTask implements messaging.Inboundemailhandler {
    List <lead> leadlist;
    List<Contact> contactlist;
   
    global messaging.InboundEmailresult handleInboundEmail(messaging.InboundEmail email, messaging.InboundEnvelope envelope) {
        contactlist=new List<Contact>();
        leadlist = new list <lead>();
        system.debug('@@@@@email:' + email);
        system.debug('@@@@@envelope:' + envelope);
        messaging.InboundEmailresult result = new messaging.InboundEmailresult();
        string Activityname = email.fromname;
        system.debug('@@@@@Activityname:' + Activityname);
        String fromemailaddresss = email.fromAddress;
        string des = email.plaintextbody;
        string tasksubject = email.subject;
         String TextBody=des;
        List<Contact> contactlist=[select id,X100worte_profile_id__c from Contact where email = :fromemailaddresss And X100worte_profile_id__c!=null limit 1  ];
        if(contactlist.size()>0 && contactlist!=null ){
        Task tkobj = new Task(Description = TextBody, subject = 'Email:'+ tasksubject, Priority = 'Medium', ActivityDate = System.today(), ReminderDateTime = System.now(), WhoId = contactlist[0].id);
        insert tkobj;  
            if(String.isNotBlank(contactlist[0].X100worte_profile_id__c)){
            WorteAPICallouts.analyseSentContactText(TextBody,contactlist[0].X100worte_profile_id__c);
            system.debug('contact textbody is :'+TextBody);  
            
            }
        }
        else{
        List <lead> leadlist = [select id,X100worte_profile_id__c from lead where email = : fromemailaddresss And X100worte_profile_id__c!=null limit 1];
        system.debug('@@@@@fromemailaddresss:' + fromemailaddresss);   
       Task tkobj = new Task(Description =TextBody, subject = 'Email:'+ tasksubject, Priority = 'Medium', ActivityDate = System.today(), ReminderDateTime = System.now(), WhoId = leadlist[0].id);
            insert tkobj;
           
        system.debug('@@@@@tkobj:' + tkobj);   
            
            if(String.isNotBlank(leadlist[0].X100worte_profile_id__c)){
            WorteAPICallouts.analyseSentContactText(TextBody,leadlist[0].X100worte_profile_id__c);
            system.debug('lead textbody is :'+TextBody);  
                
           
            }
            
        }
        
        
        return null;
    }
}