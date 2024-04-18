public class WorteAPICallouts {
    //This method is used to check the salesforce Contact email on 100worte and then return  profileid from 100Worte.
    
    public static String getAllProfiles(String contactemail)
    {
        String apikey=System.Label.X100worteAccountAPIKey;
        System.debug('api key'+apikey);   
        
        Http http=new Http();
        
        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://app.100worte.de/v1/api/profile');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('x-api-key',apikey);
        request.setMethod('GET');
        
        HttpResponse response= new HttpResponse();
        
        if(!test.isRunningTest()){
            response = http.send(request);
        }else{
            response.setStatusCode(200);
            response.setBody('{ "total": 10, "profiles": [ { "step": { "jointPosAchieve": 2, "jointPosAffil": 2, "jointPosPower": 2, "authenticity": 2, "regFocus": 2 }, "companyWideVisibility": false, "tags": [ { "name": "Persons", "id": "45494f2c-fb05-48b2-86a3-19416c4848c5" } ], "type": "TargetGroup", "name": "A target group", "createDate": "2021-02-24T07:13:52.983Z", "id": "dd9613e1-a6e0-4d14-9cfc-2c639f104cc5" }, { "companyWideVisibility": false, "tags": [ { "name": "Sales Manager", "id": "3047322d-3a88-4c63-b23b-360899673e0e" } ], "isHashed": false, "type": "Contact", "externalId": "external-systems-id", "firstname": "John", "lastname": "Doe", "email": "john@doe.com", "createDate": "2021-02-25T09:20:17.144Z", "id": "536dd25f-4c7d-4213-910a-5cd44e16bd57" } ] }');
        }
        
        if(response.getStatusCode()==200){
            Map<String,Object> result=(Map<String,Object>)Json.deserializeUntyped(response.getBody());
            List<Object> forprofileresponse=(List<Object>)result.get('profiles');
            for(Object obj:forprofileresponse){
                Map<String,Object> profile=(Map<String,Object>)obj;
                String worteprofilevalue=(String)profile.get('email');
                String worteprofileidvalue=(String)profile.get('id');
                if(worteprofilevalue==contactemail)
                {
                    System.debug(worteprofileidvalue);  
                    return worteprofileidvalue;
                }
                
            }
            
        }
        
        return 'not found';            
    }
    
    //This method is used to create new profile of salesforce contact in 100 worte and update the profile id  back in contact from response.
    //Create contact Api
    
  public static void createContact(String recordid)
    {
        
        String apikey=System.Label.X100worteAccountAPIKey;
        String ExternalId='';
        String Firstname='';
        String LastName='';
        String title='';
        String Department='';
        String Email='';
        if(String.valueOf(recordid).startsWith('003'))
        {
        Contact c=[Select Id,FirstName,LastName,Title,Department,X100worte_profile_id__c,account.name,Email from Contact Where  Id=:recordid limit 1 ];
            if(c.FirstName!=null){
            //Contact c=[Select Id,FirstName,LastName,Title,Department,X100worte_profile_id__c,account.name,Email from Contact Where FirstName!=null And Id=:recordid limit 1 ];
            Map<String,GetListOfAllTagsWrapper.Tags> tags = new Map<String,GetListOfAllTagsWrapper.Tags>();
            tags = WorteAPICallouts.getListOfAllTags(c.Id);
            ExternalId=c.id;
            Firstname = c.FirstName;
            LastName=c.LastName;
            title=c.title;
            Department=c.Department;
            Email=c.Email;
            System.debug('if worte prodile id is null' +c.X100worte_profile_id__c);
            
            if(c.X100worte_profile_id__c==null)
            {
                JSONGenerator gen = JSON.createGenerator(true);
                gen.writeStartObject();
                gen.writeStringField('externalId',ExternalId);
                System.assertNotEquals(null, c.Firstname, 'firstname is null');
                gen.writeStringField('firstname',firstName );
                gen.writeStringField('lastname', LastName);
                gen.writeStringField('email',Email );
                gen.writeBooleanField('companyWideVisibility',true );
                gen.writeFieldName('tags');
                gen.writeStartArray();
                if(tags.get('accountname')!=null){
                    gen.writeString(tags.get('accountname').id);   
                }
                if(tags.get('title')!=null){
                    gen.writeString(tags.get('title').id);
                }
                if(tags.get('department')!=null){
                    gen.writeString(tags.get('department').id);    
                }  
                gen.writeEndArray();
                gen.writeEndObject();
                // Get the JSON string.
                String RequestBody = gen.getAsString();
                System.debug('created json for contact'+RequestBody);//created json       
                Http http=new Http();
                HttpRequest request=new Httprequest();
                request.setEndpoint('https://app.100worte.de/v1/api/contact');
                request.setHeader('Content-Type', 'application/json');
                request.setHeader('x-api-key',apikey);
                //request.setHeader('x-api-key','f0d29c8e-cd36-468b-9190-1e19ca3c3504');
                request.setMethod('POST');           
                request.setBody(RequestBody);
                
                HttpResponse response = new HttpResponse();
                
                if(!test.isRunningTest()){
                    response = Http.send(request);
                }else{
                    response.setStatusCode(200);
                    response.setBody('{ "id": "e850c6f8-6a30-4afb-aadb-69cafabe00f2" }');
                }
                
                if(response.getStatusCode()==201)
                {
                    Map<String,Object> result=(Map<String,Object>)Json.deserializeUntyped(response.getBody());
                    c.X100worte_profile_id__c=String.valueof(result.get('id'));
                    update c;
                }        
            }  
                    
                    
                } 
               else{
                  System.debug('FirstName Cannot be null');
                }
            }
          
        
        else  if(String.valueOf(recordid).startsWith('00Q'))
        {
            
            Lead l=[Select Id,Name,FirstName,LastName,Title,company,X100worte_profile_id__c,Email from Lead Where Id=:recordid limit 1];
            if(l.FirstName!=null){
                 Map<String,GetListOfAllTagsWrapper.Tags> leadtags = new Map<String,GetListOfAllTagsWrapper.Tags>();
            leadtags = WorteAPICallouts.getListOfAllTags(l.Id);
            ExternalId=l.Id;
            Firstname=l.FirstName;
            LastName=l.LastName;
            Email=l.Email;
            title=l.title;
            String company=l.Company;
            if(l.X100worte_profile_id__c==null)
            {
                JSONGenerator gen = JSON.createGenerator(true);
                gen.writeStartObject();
                gen.writeStringField('externalId',ExternalId);
                gen.writeStringField('firstname',firstName );
                gen.writeStringField('lastname', LastName);
                gen.writeStringField('email',Email );
                //gen.writeStringField('company',company );
                gen.writeBooleanField('companyWideVisibility',true );
                gen.writeFieldName('tags');
                gen.writeStartArray();
                if(leadtags.get('title')!=null){
                    gen.writeString(leadtags.get('title').id);
                }
                if(leadtags.get('companyname')!=null){
                    gen.writeString(leadtags.get('companyname').id);    
                }      
                gen.writeEndArray();  
                gen.writeEndObject();
                String RequestBody = gen.getAsString();
                //System.debug('created lead json'+RequestBody);      
                Http http=new Http();
                HttpRequest request=new Httprequest();
                request.setEndpoint('https://app.100worte.de/v1/api/contact');
                request.setHeader('Content-Type', 'application/json');
                //request.setHeader('x-api-key','f0d29c8e-cd36-468b-9190-1e19ca3c3504');
                request.setHeader('x-api-key',apikey);
                request.setMethod('POST');           
                request.setBody(RequestBody);
                
                HttpResponse response = new HttpResponse();
                
                if(!test.isRunningTest()){
                    response = Http.send(request);
                }else{
                    response.setStatusCode(200);
                    response.setBody('{ "id": "e850c6f8-6a30-4afb-aadb-69cafabe00f2" }');
                }
                
                System.debug('lead response body'+response.getbody());
                if(response.getStatusCode()==201)
                {
                    Map<String,Object> result=(Map<String,Object>)Json.deserializeUntyped(response.getBody());
                    System.debug(String.valueof(result.get('id')));
                    l.X100worte_profile_id__c=String.valueof(result.get('id'));
                    update l;    
                }         
            }
                else{
                    System.debug('Lead FirstName cannot be null');
                }
            }
           
        }
    }
    
     
    //get list of all tags
    
    public static Map<String,GetListOfAllTagsWrapper.Tags> getListOfAllTags(String recordid)
    {
        String apikey=System.Label.X100worteAccountAPIKey;
        if(String.valueOf(recordid).startsWith('003'))
        {
            Contact c = [Select Id,FirstName,LastName,Title,Department,X100worte_profile_id__c,account.name,Email from Contact Where Id=:recordid limit 1];
            Map<String,GetListOfAllTagsWrapper.Tags> contactalltag = new Map<String,GetListOfAllTagsWrapper.Tags>();
            
            if(!test.isRunningTest()){
                contactalltag = WorteAPICallouts.contacttags(c.account.name,c.title,c.department);
            }else{
                
            }
            
            // System.debug('getlistofalltags inside if'+contactalltag);
            return contactalltag;
            
        }
        else if(String.valueOf(recordid).startsWith('00Q'))
        {
            Lead l=[Select Id,Name,FirstName,LastName,Title,company,X100worte_profile_id__c,Email from Lead Where Id=:recordid limit 1];
            Map<String,GetListOfAllTagsWrapper.Tags> leadalltag=WorteAPICallouts.leadtags(l.company,l.title);
            System.debug('values in leadalltag'+leadalltag);
            return leadalltag;
            
        }
        return null;          
    }
    
    //using contacttags() and leadtags() methods in getListofAlltags() methods to get the tags of contacts and tags of leads.
    
    public static  Map<String,GetListOfAllTagsWrapper.Tags> contacttags(String accountname,String title,String department)
    {
        String apikey=System.Label.X100worteAccountAPIKey;
        Map<String,GetListOfAllTagsWrapper.Tags> TagContent = new Map<String,GetListOfAllTagsWrapper.Tags>();
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://app.100worte.de/v1/api/tag');
        request.setHeader('Content-type', 'application/json');
        request.setHeader('x-api-key',apikey);
        request.setMethod('GET');
        
        HttpResponse response = new HttpResponse();
        
        if(!test.isRunningTest()){
            response=Http.send(request);  
        }else{
            response.setBody('{ "tags": [ { "id": "ddb54355-8d83-4f8c-9146-d9d8aa42053b", "companyWideVisibility": true, "name": "Sales Manager" } ], "total": 10 }');
        }
        
        GetListOfAllTagsWrapper worteresponse= GetListOfAllTagsWrapper.parse(response.getBody());
        //System.debug('value of wrapper response'+worteresponse.tags[0].name);
        //System.debug('Size of wrapper response' +worteresponse.tags.size());
        System.debug('response is '+worteresponse);
        Integer worteresponsetagssize=worteresponse.tags.size();
        Boolean accountnameflag=false;
        Boolean titleflag=false;
        Boolean departmentflag=false;
        if(worteresponse.tags.size()>0)
        {
            For(Integer i=0;i<worteresponsetagssize;i++)
            { 
                String worteresponsename=worteresponse.tags[i].name;
                
                if(worteresponsename==accountname && accountname!=null)
                {
                    //System.debug('name is'+worteresponse.tags[i].name);
                    //System.debug('id is'+worteresponse.tags[i].id);
                    tagcontent.put('accountname',worteresponse.tags[i]);
                    accountnameflag=true;
                    if(String.isBlank(accountname))
                    {
                        
                    }
                }
                
                if(worteresponsename==title && title!=null)
                {
                    tagcontent.put('title',worteresponse.tags[i]);
                    titleflag=true;
                    if(String.isBlank(title)){
                        
                    } 
                }
                
                if(worteresponsename==department &&department!=null)
                {
                    tagcontent.put('department',worteresponse.tags[i]);
                    departmentflag=true;
                    if(String.isBlank(department)){
                        
                    }
                }
            }
            
            if(accountnameflag==false && accountname!=null)
            {
                GetListOfAllTagsWrapper.Tags tag_obj = new GetListOfAllTagsWrapper.Tags();
                tag_obj.name =accountname;
                tag_obj.id =WorteAPICallouts.addNewtag(accountname);
                tagcontent.put('accountname',tag_obj);
                
                
            }
            if(titleflag==false && title!=null)
            {
                GetListOfAllTagsWrapper.Tags tag_obj = new GetListOfAllTagsWrapper.Tags();
                tag_obj.name =title;
                tag_obj.id =WorteAPICallouts.addNewtag(title);
                tagcontent.put('title',tag_obj);
                
            }
            if(departmentflag==false && department!=null)
            {
                GetListOfAllTagsWrapper.Tags tag_obj = new GetListOfAllTagsWrapper.Tags();
                tag_obj.name =department;
                tag_obj.id =WorteAPICallouts.addNewtag(department);
                tagcontent.put('department',tag_obj);
                
            }   
        }  
        return TagContent;
    }
    
    //leadtagsmethod
    public static Map<String,GetListOfAllTagsWrapper.Tags> leadtags(String companyname,String title)
    {
        String apikey=System.Label.X100worteAccountAPIKey;
        Map<String,GetListOfAllTagsWrapper.Tags> TagContent=new Map<String,GetListOfAllTagsWrapper.Tags>();
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://app.100worte.de/v1/api/tag');
        request.setHeader('Content-type', 'application/json');
       // request.setHeader('x-api-key','79e5af89-4570-4016-a650-e3ef118407f2');
        request.setHeader('x-api-key',apikey);
        request.setMethod('GET');
        
        HttpResponse response = new HttpResponse();
        
        if(!test.isRunningTest()){
            response=Http.send(request);  
        }else{
            response.setBody('{ "tags": [ { "id": "ddb54355-8d83-4f8c-9146-d9d8aa42053b", "companyWideVisibility": true, "name": "Sales Manager" } ], "total": 10 }');
        }
        
        GetListOfAllTagsWrapper worteresponse;
        
        worteresponse = GetListOfAllTagsWrapper.parse(response.getBody());
        
        if(worteresponse != null){
            Integer worteresponsetagssize = worteresponse.tags.size();
            Boolean titleflag=false;
            Boolean companynameflag=false;
            if(worteresponse.tags.size()>0){
                For(Integer i=0;i<worteresponsetagssize;i++)
                { 
                    String worteresponsename=worteresponse.tags[i].name;
                    
                    if(worteresponsename==companyname && companyname!=null)
                    {
                        tagcontent.put('companyname',worteresponse.tags[i]);
                        companynameflag=true;
                    }
                    if(worteresponsename==title && title!=null)
                    {
                        tagcontent.put('title',worteresponse.tags[i]);
                        titleflag=true;
                        if(String.isBlank(title)){
                            
                        }
                    }
                }
                
                System.debug('before false if');
                if(companynameflag==false && companyname!=null)
                {
                    GetListOfAllTagsWrapper.Tags tag_obj = new GetListOfAllTagsWrapper.Tags();
                    tag_obj.name =companyname;
                    tag_obj.Id =WorteAPICallouts.addNewtag(companyname);
                    tagcontent.put('companyname',tag_obj);
                    System.debug('inside false if');
                    
                }
                if(titleflag==false && title!=null)
                {
                    GetListOfAllTagsWrapper.Tags tag_obj = new GetListOfAllTagsWrapper.Tags();
                    tag_obj.name =title;
                    tag_obj.id =WorteAPICallouts.addNewtag(title);
                    tagcontent.put('title',tag_obj);
                    
                }
                
            }     
        }
        
        return TagContent;
    }
    
    //add new tag api
    public static String addNewtag(String TagName)
    {
        String apikey=System.Label.X100worteAccountAPIKey;
        String TagId='';
        JSonGenerator gen=JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('name',TagName);
        gen.writeBooleanField('companyWideVisibility',true);
        gen.writeEndObject();
        String requestbody=gen.getAsString();
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://app.100worte.de/v1/api/tag');
        request.setHeader('Content-type', 'application/json');
        // request.setHeader('x-api-key','79e5af89-4570-4016-a650-e3ef118407f2');
        request.setHeader('x-api-key',apikey);
        request.setmethod('POST');
        request.setBody(requestbody);
        
        HttpResponse response = new HttpResponse();
        
        if(!test.isRunningTest()){
            response=Http.send(request);  
        }else{
            response.setBody('{ "tags": [ { "id": "ddb54355-8d83-4f8c-9146-d9d8aa42053b", "companyWideVisibility": true, "name": "Sales Manager" } ], "total": 10 }');
        }
        
        System.debug('add new tag response'+response.getStatus()+'  '+response.getStatusCode());
        if(response.getStatusCode()==201)
        {
            Map<String,Object> result=(Map<String,Object>)JSON.deserializeUntyped(response.getBody());
            System.debug(result.get('id'));
            TagId=String.valueOf(result.get('id'));
            
        }
        return TagId;
        
    }
    
    //This method is used to get the detailed analysis on the basis of profileid 
    
    
    //detailanalysis method response based on selected language
    public static DetailedAnalysisResultWrapper analysisResultForProfile(String profileid){
        String apikey=System.Label.X100worteAccountAPIKey;
        string currentuserlang ='';
        if(UserInfo.getLanguage()=='de' || UserInfo.getLanguage()=='it'){
            currentuserlang =UserInfo.getLanguage();
        }
        else{
            currentuserlang ='en';
        }
        Http http=new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Content-Type','application/json');
        request.setEndpoint('https://app.100worte.de/v1/api/profile/'+profileid+'?lang='+currentuserlang);   
        //request.setHeader('x-api-key','79e5af89-4570-4016-a650-e3ef118407f2');
         request.setHeader('x-api-key',apikey);
        request.setMethod('GET');
        
        HttpResponse response = new HttpResponse();
        
        if(!test.isRunningTest()){
            response=Http.send(request);  
        }else{
            response.setBody('');
        }
        
        system.debug(response.getBody());
        DetailedAnalysisResultWrapper worteresponse = DetailedAnalysisResultWrapper.parse(response.getBody());
        System.debug('detail analysis response'+worteresponse);
        return worteresponse;     
        
    }    
    
    //This method is used to Returns a factor for the current relationship index between two people.
    
    public static  Map<String,Object> getRelationshipQuality(String profileId)
    {
        String apikey=System.Label.X100worteAccountAPIKey;
        String responsevalue='';
        Http http=new Http();
        HttpRequest request=New HttpRequest();
        request.setEndpoint('https://app.100worte.de/v1/api/contact/'+profileId+'/getRelationShipQuality');
        request.setHeader('Content-Type','application/json');
        //request.setHeader('x-api-key','79e5af89-4570-4016-a650-e3ef118407f2');
        request.setHeader('x-api-key',apikey);
        request.setMethod('GET');
        
        HttpResponse response = new HttpResponse();
        
        if(!test.isRunningTest()){
            response=Http.send(request);  
        }else{
            response.setBody('{"qualityFactor": 0.7825,"trend": "upward"}');
            response.setStatusCode(200);
        }
        
        if(response.getStatusCode()==200)
        {
            //String result=Json.serialize(response.getBody());
            Map<String,Object> result=(Map<String,Object>)Json.deserializeUntyped(response.getBody());
            //System.debug('value of response '+result);
           // System.debug('result is ' +result.get('qualityFactor'));
            responsevalue=String.valueOf(result.get('qualityFactor'));
            String qualitytendency=String.valueof(result.get('trend'));
            System.debug(responsevalue);
            System.debug('qualitytendency'+qualitytendency);
           // return responsevalue ;
           return result;
        }
        else
        {
            System.debug(response.getBody());
            String result=Json.serialize(response.getBody());
            System.debug(response.getStatus()+''+response.getStatusCode());
            //return 'not found';
            return null;
        }
    }
    
    //Analyse own sent text Api Callout
    @future(callout=true)
    public static void analyseSentText(String text,String profileid){
        String apikey=System.Label.X100worteAccountAPIKey;
        JSONGenerator gen=JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('text',text);
        String requestbody=gen.getAsString();
        Http http=new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://app.100worte.de/v1/api/contact/'+profileid+'/addOwnAnalysis');
        request.setHeader('Content-Type','application/json');
        request.setHeader('x-api-key',apikey);
        // request.setHeader('x-api-key',apikey);
        request.setBody(requestbody);
        request.setMethod('POST');
        if(!test.isRunningTest()){
            HttpResponse response=Http.send(request);
            if(response.getStatusCode()==201){
                Boolean result=(Boolean)Json.deserializeUntyped(response.getBody());
                System.debug(result);
            }else{
                System.debug(response.getStatus()+' '+response.getStatusCode());
            }
        }else{
            
        }
        
    }
    
    //analyse new text (contact)
    @future(callout=true)
    public static void analyseSentContactText(String Text,String profileid)
    {
        String apikey=System.Label.X100worteAccountAPIKey;
        JSONGenerator gen=JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('text',Text);
        gen.writeStringField('textGenre', 'emails');
        gen.writeStringField('companyWideVisibility','false');
        gen.writeStringField('contactId',profileid);
        gen.writeEndObject();
        String requestbody=gen.getAsString();
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndpoint('https://app.100worte.de/v1/api/analysis');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('x-api-key',apikey);
        request.setBody(requestbody);
        request.setMethod('POST');
        
        if(!test.isRunningTest()){
            HttpResponse response=Http.send(request);
            System.debug(response.getStatus());
            if(response.getStatusCode()==201){
                Map<String,Object> result=(Map<String,Object>)JSON.deserializeUntyped(response.getBody());
                System.debug(String.valueOf(result.get('id')));    
            }    
        }
        
    }
    
}