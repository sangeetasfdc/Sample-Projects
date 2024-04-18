public without sharing class CommunityPasswordSetController {
    Public string password{get;set;}
    Public string confirmpassword{get;set;}
    public string username;
    public user user_obj;
    public boolean success{get;set;}
    
    public CommunityPasswordSetController(){
        success=true;
        username=ApexPages.currentPage().getParameters().get('id');
        if(string.isNotBlank(username)){
            user_obj=[SELECT Id,Username,SignUpApplicationId__c  FROM USER WHERE username=:username];
        }
        
    }
    
    public PageReference resetPassword(){
        String starturl='/s';
        
        if(String.IsNotBlank(user_obj.SignUpApplicationId__c)){
            starturl ='/s/application/'+user_obj.SignUpApplicationId__c;
        }
        system.debug('user_obj'+user_obj);
        System.setPassword(user_obj.Id, apexpages.currentPage().getParameters().get('inpval'));
        if(!Test.isRunningTest()){
            system.debug('user_obj.username:'+user_obj.username);
            system.debug('inpval:'+apexpages.currentPage().getParameters().get('inpval'));
            system.debug('starturl'+starturl);
            PageReference pr = Site.login(user_obj.username, apexpages.currentPage().getParameters().get('inpval'),starturl);
            system.debug('pr'+pr);
            pr.setRedirect(true);
            return pr;
        }else{
            return null;
        }
        
    }
    
}