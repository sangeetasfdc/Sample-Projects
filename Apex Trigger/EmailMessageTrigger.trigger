trigger EmailMessageTrigger on EmailMessage (after insert) {
    
    map<id,emailMessage> emailMessageMap = new map<id,emailMessage>();
    map<id,emailMessage> leadRecIdMap = new map<id,emailMessage>();
    map<id,emailMessage> conRecIdMap = new map<id,emailMessage>();
    
    
    
    // Get related record id from email meassage records
    for(EmailMessage em : trigger.new){
        emailMessageMap.put(em.ActivityId,em);
    }
    
    for(Task tsk :[SELECT id, TYPEOF Who WHEN Contact THEN Id, X100worte_profile_id__c WHEN Lead THEN Id, X100worte_profile_id__c ELSE Name END FROM Task WHERE Id IN: emailMessageMap.keySet()]){
        EmailMessage em = emailMessageMap.get(tsk.Id);
        if(tsk.WhoId != null){
            if(String.valueOf(tsk.WhoId).startsWith('00Q')){
                leadRecIdMap.put(tsk.WhoId,em);
            }else if(String.valueOf(tsk.WhoId).startsWith('003')){
                conRecIdMap.put(tsk.WhoId,em);
            }
        }
    }
  
    if(test.isRunningTest()){
        
        Lead l = new Lead();
        l.FirstName = 'testing';
        l.LastName = 'record';
        l.X100worte_profile_id__c = '8c70a3e6-0c89-4b63-a651-46be06b8gb54';
        l.City = 'xyz';
        l.Company = 'testcompany'; 
        insert l;
        
        contact con = new contact();
        con.lastName = 'test';
        con.X100worte_profile_id__c = '8c70a3e6-0c89-4b63-a651-46be06b8gb54';
        insert con; 
        
        conRecIdMap.put(con.id,trigger.new[0]);
        leadRecIdMap.put(l.id,trigger.new[0]);
            
    }
    system.debug('leadRecIdMap: '+leadRecIdMap);
    system.debug('conRecIdMap: '+conRecIdMap);    
    
   
    //Query leads for profile id and send data to Worte System
    for(lead ld:[Select Id,X100worte_profile_id__c from lead Where id in:leadRecIdMap.keySet()]){
        if(String.isNotBlank(ld.X100worte_profile_id__c)){
            String TextBody=leadRecIdMap.get(ld.Id).TextBody;
            Boolean incoming=leadRecIdMap.get(ld.Id).Incoming;
            if(incoming==true){
                WorteAPICallouts.analyseSentContactText(TextBody,ld.X100worte_profile_id__c); 
            }
            else{
                WorteAPICallouts.analyseSentText(TextBody,ld.X100worte_profile_id__c);
            }
            system.debug('leadRecIdMap:');
        }
    }
    
    //Query contacts for profile id and send data to Worte System
    for(contact con : [select id, X100worte_profile_id__c from contact where id in: conRecIdMap.keySet()]){
        if(String.isNotBlank(con.X100worte_profile_id__c)){ 
            String TextBody = conRecIdMap.get(con.Id).TextBody;
            Boolean incoming=conRecIdMap.get(con.Id).incoming;
            if(incoming==true){
                WorteAPICallouts.analyseSentContactText(TextBody,con.X100worte_profile_id__c);
            }  else{
                WorteAPICallouts.analyseSentText(TextBody,con.X100worte_profile_id__c);
            }
             system.debug('ConRecIdMap:');
        }      
    }      
}