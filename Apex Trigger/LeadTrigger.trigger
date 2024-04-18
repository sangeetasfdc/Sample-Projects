trigger LeadTrigger on Lead (before insert, before update, after Insert, after update) {
    Set<String> countries = new Set<String>{'Ecuador', 'Peru', 'Colombia', 'Mexico'};
        List<Id> leadsId = new List<Id>();
    Set<String> StandardAppCountries = new Set<String>{'Argentina','Australia','Austria','Bahamas','Belgium','Belize','Bermuda','Bolivia',
        'Brazil','Bulgaria','Canada','Cayman Islands','Chile','China','Costa Rica','Croatia','Cyprus','Czech Republic',
        'Denmark','Dominican Republic','El Salvador','Estonia','European Union','Fiji','Finland','France','Germany','Greece',
        'Grenada','Guatemala','Honduras','Hong Kong','Hungary','Iceland','India','Indonesia','Ireland','Isle of Man','Israel','Italy',
        'Ivory Coast','Jamaica','Japan','Jordan','Latvia','Liechtenstein','Lithuania','Luxembourg','Malaysia','Maldives','Malta','Mauritius',

        'Poland','Portugal','Puerto Rico','Qatar','Seychelles','Singapore','Slovakia','Slovenia','Solomon Islands','South Africa','Spain',
        'Sri Lanka','St Vincent and the Grenadines','Suriname','Sweden','Switzerland','Taiwan','Thailand','Trinidad and Tobago','Tunisia',
        'Turkey','United Arab Emirates','United Kingdom','United States','Uruguay','Vietnam'};
            
            if(Trigger.isBefore && Trigger.isInsert){
                for(Lead lead : Trigger.New){
                    if(lead.Expected_Total_Facility_Size__c != NULL){
                        Boolean isContainHypen = lead.Expected_Total_Facility_Size__c.contains('-');
                        Integer upperBond = 0;
                        String data = lead.Expected_Total_Facility_Size__c;
                        if(data != NULL){
                            if(isContainHypen){
                                upperBond = Integer.valueOf(data.subString(data.lastIndexOfIgnoreCase('$')+1 , data.length()).trim().replaceAll(',',''));
                            }else{
                                upperBond = Integer.valueOf(data.subString(1, data.lastIndexOfIgnoreCase('+')).trim().replaceAll(',',''));
                            }
                        }
                        
                        /* if the facility size is less than 150000 then its change the leadsource*/
                        
                        system.debug(upperBond);
                        if(countries.contains(lead.Country_of_Incorporation__c) && upperBond <= 150000){
                            lead.LeadSource = 'UWL Application Template';
                        }
                        
                        /* if the facility size is greater than 150000 then its change the leadsource*/
                        else if(countries.contains(lead.Country_of_Incorporation__c) && upperBond >= 150000){
                            lead.LeadSource = 'Standard Application';
                        }
                        
                        /* standardAppCountries name */
                        else if(StandardAppCountries.contains(lead.Country_of_Incorporation__c)){
                            lead.LeadSource = 'Standard Application';
                        }
                    }
                }
            }
    
    if(Trigger.isAfter && Trigger.isInsert){
        for(Lead lead : Trigger.New){
            if(!lead.emailsentfirst__c && lead.Application_Status__c == 'Pre-Approved'){
                leadsId.add(lead.Id);
            }
        }
        
        /* for sending Marco Email Verify page */
        if(!leadsId.isEmpty()){
            LeadCovertHandler.sendVerifyEmail(leadsId);
        }
    }
    
    
    if(Trigger.isAfter && trigger.isUpdate ){
        List<Database.LeadConvert> leads = new List<Database.LeadConvert>();
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        for(Lead lead : Trigger.New){
            if(trigger.oldmap.get(lead.Id).Has_Email_Verifed__c != lead.Has_Email_Verifed__c && lead.Has_Email_Verifed__c){
                Database.LeadConvert lc = new Database.LeadConvert();
                lc.setConvertedStatus(convertStatus.MasterLabel);
                lc.setLeadId(lead.id);
                leads.add(lc);
            }
        }
        
        /*for Application Record create in both conditions standard and UWL*/
        
        List<Id> contactIds = new List<Id>();
        List<Id> opportunityId = new List<Id>();
        map<string,string> appConMap = new map<string,string>();
        
        if(!leads.isEmpty()){
            List<Database.LeadConvertResult> lcr = Database.convertLead(leads, true);
            List<Application__c> applicationList = new List<Application__c>();
            for(Database.LeadConvertResult result : lcr){
                if(result.isSuccess()){
                    Application__c app = new Application__c();
                    app.Name = result.getOpportunityId();
                    app.Account__c = result.getAccountId();
                    app.Contact__c = result.getContactId();
                    app.Industry__c = Trigger.newMap.get(result.getLeadId()).Industry;
                    app.Opportunity__c = result.getOpportunityId();
                    app.Application_submitted_timestamp__c = trigger.newMap.get(result.getLeadId()).createdDate;
                    applicationList.add(app);
                    opportunityId.add(result.getOpportunityId());
                    if(Trigger.newMap.get(result.getLeadId()).LeadSource == 'Standard Application'){
                        contactIds.add(app.Contact__c);
                    }
                }                
            }
            
            /* map */
            
            Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>([SELECT Id,Name,AccountId FROM Opportunity WHERE ID IN : opportunityId]);
            if(!oppMap.isEmpty()){
                for(Application__c app :  applicationList){
                    Id recordId = app.Name;
                    app.Name = oppMap.get(recordId).Name;
                }
            }
            
            if(!applicationList.isEmpty()){
                INSERT applicationList;
            }
            
            for(application__c app : applicationList){
                appConMap.put(app.Contact__c,app.Id);
            }
            
            /*for commununity User */
            
            List<Profile> Profile = [SELECT Id FROM Profile WHERE Name ='Custom Customer Community Login User'];
            List<contact> contacts = [SELECT Id,email,firstName,lastname,accountId FROM Contact WHERE Id IN : contactIds AND Email != NULL];
            List<user> usr = new List<user>();
            
            String orgId = UserInfo.getOrganizationId();
            String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
            Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
            String uniqueName = orgId + dateString + randomInt;
            if(uniqueName.length()>51){
                uniqueName=uniqueName.substring(0,51);
            }
            for(Contact con : contacts){ 
                string nick = con.email!=null?con.email.substring(0, con.email.indexOf('@')):''; nick += Datetime.now().getTime();       
                User newUser = new User(
                    SignUpApplicationId__c = appConMap.get(con.id),
                    alias = uniqueName.substring(18, 23),
                    email = con.email,
                    emailencodingkey = 'UTF-8',
                    firstname = con.firstName,
                    lastname = con.lastname,
                    languagelocalekey = 'en_US',
                    localesidkey = 'en_US',
                    contactId = con.Id,
                    timezonesidkey = 'America/Los_Angeles',
                    username = con.Email,
                    CommunityNickname = nick,
                    ProfileId = Profile[0].Id,
                    
                    IsActive = true);
                    usr.add(newUser); 
            }  
            
            if(!usr.isEmpty()){
                Insert usr;
            }
            if(!contactIds.isEmpty()){
              LeadCovertHandler.sendWelcomeEmail(contactIds);

            }
        }
        
    }              
    
}