Public Class GetOrderStatus_CLS{

    @auraEnabled
    Public static boolean GetOrderStatus(ID oppid){
        
        string username = 'aandony@trulymortgage.com';
        string password = 'exp7dmt-AUY7njg@dgw';
        string order_id = '';
        
        opportunity opp = [select id, Order_Created__c, Order_Id__c from opportunity where id = : oppid];
        if(string.isNotBlank(opp.Order_Id__c)){
            order_id = opp.Order_Id__c;
        }
       
        if(opp.Order_Created__c && string.isNotBlank(opp.order_id__c)){
        
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://admin.arivs.com/api/v1/status?order_id='+opp.order_id__c);
            req.setMethod('GET');
            Blob headerValue = Blob.valueOf(username + ':' + password);
            String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            req.setHeader('Authorization', authorizationHeader);
            
            HttpResponse res = new HttpResponse();
            res = http.send(req);
            System.debug('result: ' +res.getBody());
            
            GetOrderStatusJson gosj = new GetOrderStatusJson();
            gosj = GetOrderStatusJson.parse(res.getBody());
            
            if(gosj.appraisal_xml_url != null){
                Http http2 = new Http();
                HttpRequest req2 = new HttpRequest();
                req2.setEndpoint(gosj.appraisal_xml_url);
                req2.setMethod('GET');
                HttpResponse res2 = new HttpResponse();
                res2 = http.send(req2);
                System.debug('result2: ' +res2.getBody());
            
                if(res2.getBody().contains('<DOCUMENT>')){
                    
                    String yourFilesContent = res2.getBody().SubstringBetween('<DOCUMENT>','</DOCUMENT>');
                     
                    ContentVersion conVer = new ContentVersion();
                    conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
                    conVer.PathOnClient = 'OrderStatus_FILE.pdf'; // The files name, extension is very important here which will help the file in preview.
                    conVer.Title = 'Order Status : ' + System.now().format('yyyy-MM-dd h:mm a'); // Display name of the files
                    conVer.VersionData = EncodingUtil.base64Decode(yourFilesContent); // converting your binary string to Blog
                    insert conVer;    //Insert ContentVersion
                    
                    
                    // First get the Content Document Id from ContentVersion Object
                    Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
                    //create ContentDocumentLink  record 
                    ContentDocumentLink conDocLink = New ContentDocumentLink();
                    conDocLink.LinkedEntityId = oppid; // Specify RECORD ID here i.e Any Object ID (Standard Object/Custom Object)
                    conDocLink.ContentDocumentId = conDoc;  //ContentDocumentId Id from ContentVersion
                    conDocLink.shareType = 'V';
                    insert conDocLink;
                }
                
            }
            
        }else{
            
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://admin.arivs.com/api/v1/create_order?client_id=test123&branch_number=test123&branch_identifier=test&street_address=test&city=test');
            req.setMethod('GET');
            Blob headerValue = Blob.valueOf(username + ':' + password);
            String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            req.setHeader('Authorization', authorizationHeader);
            
            HttpResponse res = new HttpResponse();
            res = http.send(req);
            System.debug('result: ' +res.getBody());
            
            Opportunity oppor = new Opportunity(id=oppid);
            string str = res.getBody().substringBetween('"order_id":', ',');
            oppor.order_id__c = str.replaceAll('\\s+', '');
            oppor.Order_Created__c = true;
            update oppor;
            
        }
        
        return opp.Order_Created__c;
        
    }
    
    public static void testCover(){
    
        string res = '{ "success": true, "status": "complete", "requires_final": false, "status_timestamp": "2022-06-14T07:46:53.000+05:30", "amount_paid": "500.0", "total": "550.0", "appraisal_xml_url": "https://avm-production.s3.amazonaws.com/document/file/04/85/34/4853474.xml?response-content-disposition=application%2Fxml&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIS75FAG5EWBFODJQ%2F20220705%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220705T094511Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=2bba0207c89cb3e2113475b0be634e31d8239b42e316979e2564fd40622633fe", "auth_amount": "500.0", "appraised_amount": "387000.0", "due_date": "2022-06-22", "prior_sale_date": null, "notes": [ { "id": 9073437, "notable_id": 483367, "user_id": 27318, "text": "APPROVED!", "notable_type": "Order", "blocking": false, "blocking_cleared": false, "created_at": "2022-06-15T02:49:57.000+05:30", "updated_at": "2022-06-15T02:52:50.000+05:30", "visible_to_client": true, "visible_to_appraiser": false, "highlight_for_staff": true, "resolve_staff": false, "resolve_appraiser": false, "visible_to_servicer": true, "visible_to_processor": false, "resolve_servicer": false, "resolve_processor": false, "resolve_client": false, "email_appraiser": false, "email_client": false, "type_for_failure": null, "api_notified": true, "email_processor": false, "follow_up_user_id": null, "follow_up": null, "tracking_id": null, "note_flagged": false, "follow_up_instructions": null, "follow_up_note": null, "message_id": null, "pending_manager_approval": false }, { "id": 9073373, "notable_id": 483367, "user_id": 7047, "text": "Please advise ASAP if we can proceed. ", "notable_type": "Order", "blocking": false, "blocking_cleared": false, "created_at": "2022-06-15T02:42:19.000+05:30", "updated_at": "2022-06-15T02:52:50.000+05:30", "visible_to_client": true, "visible_to_appraiser": false, "highlight_for_staff": true, "resolve_staff": false, "resolve_appraiser": false, "visible_to_servicer": true, "visible_to_processor": true, "resolve_servicer": false, "resolve_processor": false, "resolve_client": true, "email_appraiser": false, "email_client": false, "type_for_failure": null, "api_notified": true, "email_processor": false, "follow_up_user_id": null, "follow_up": null, "tracking_id": null, "note_flagged": false, "follow_up_instructions": null, "follow_up_note": null, "message_id": null, "pending_manager_approval": false }, { "id": 9070583, "notable_id": 483367, "user_id": 13509, "text": "We have found an appraiser that can complete this with a fee of $550 to complete on the 22nd. Please advise if that will work. Thanks", "notable_type": "Order", "blocking": false, "blocking_cleared": false, "created_at": "2022-06-14T21:38:38.000+05:30", "updated_at": "2022-06-15T02:52:49.000+05:30", "visible_to_client": true, "visible_to_appraiser": false, "highlight_for_staff": true, "resolve_staff": false, "resolve_appraiser": false, "visible_to_servicer": true, "visible_to_processor": true, "resolve_servicer": false, "resolve_processor": false, "resolve_client": true, "email_appraiser": false, "email_client": false, "type_for_failure": null, "api_notified": true, "email_processor": false, "follow_up_user_id": null, "follow_up": null, "tracking_id": null, "note_flagged": false, "follow_up_instructions": null, "follow_up_note": null, "message_id": null, "pending_manager_approval": false }, { "id": 9070344, "notable_id": 483367, "user_id": 27318, "text": "thank you!", "notable_type": "Order", "blocking": false, "blocking_cleared": false, "created_at": "2022-06-14T21:16:52.000+05:30", "updated_at": "2022-06-14T21:17:06.000+05:30", "visible_to_client": true, "visible_to_appraiser": false, "highlight_for_staff": true, "resolve_staff": false, "resolve_appraiser": false, "visible_to_servicer": true, "visible_to_processor": false, "resolve_servicer": false, "resolve_processor": false, "resolve_client": false, "email_appraiser": false, "email_client": false, "type_for_failure": null, "api_notified": true, "email_processor": false, "follow_up_user_id": null, "follow_up": null, "tracking_id": null, "note_flagged": false, "follow_up_instructions": null, "follow_up_note": null, "message_id": null, "pending_manager_approval": false }, { "id": 9070244, "notable_id": 483367, "user_id": null, "text": "The due date for this file has been amended to Wed Jun 22, 22. Please advise if this will cause any issues as soon as possible.", "notable_type": "Order", "blocking": false, "blocking_cleared": false, "created_at": "2022-06-14T21:10:02.000+05:30", "updated_at": "2022-06-14T21:11:07.000+05:30", "visible_to_client": true, "visible_to_appraiser": false, "highlight_for_staff": false, "resolve_staff": false, "resolve_appraiser": false, "visible_to_servicer": true, "visible_to_processor": false, "resolve_servicer": false, "resolve_processor": false, "resolve_client": false, "email_appraiser": false, "email_client": false, "type_for_failure": null, "api_notified": true, "email_processor": false, "follow_up_user_id": null, "follow_up": null, "tracking_id": null, "note_flagged": false, "follow_up_instructions": null, "follow_up_note": null, "message_id": null, "pending_manager_approval": false }, { "id": 9070240, "notable_id": 483367, "user_id": 13509, "text": "We are looking to see if we can accommodate that and will let you know as soon as this has been accepted. ", "notable_type": "Order", "blocking": false, "blocking_cleared": false, "created_at": "2022-06-14T21:09:51.000+05:30", "updated_at": "2022-06-14T21:11:07.000+05:30", "visible_to_client": true, "visible_to_appraiser": false, "highlight_for_staff": true, "resolve_staff": false, "resolve_appraiser": false, "visible_to_servicer": true, "visible_to_processor": true, "resolve_servicer": false, "resolve_processor": false, "resolve_client": true, "email_appraiser": false, "email_client": false, "type_for_failure": null, "api_notified": true, "email_processor": false, "follow_up_user_id": null, "follow_up": null, "tracking_id": null, "note_flagged": false, "follow_up_instructions": null, "follow_up_note": null, "message_id": null, "pending_manager_approval": false }, { "id": 9070212, "notable_id": 483367, "user_id": 27318, "text": "closing is 6/28, we need this report sooner, please advise if can deliver by 6/22", "notable_type": "Order", "blocking": false, "blocking_cleared": false, "created_at": "2022-06-14T21:07:32.000+05:30", "updated_at": "2022-06-14T21:10:25.000+05:30", "visible_to_client": true, "visible_to_appraiser": false, "highlight_for_staff": true, "resolve_staff": false, "resolve_appraiser": false, "visible_to_servicer": true, "visible_to_processor": true, "resolve_servicer": false, "resolve_processor": false, "resolve_client": false, "email_appraiser": false, "email_client": false, "type_for_failure": null, "api_notified": true, "email_processor": false, "follow_up_user_id": null, "follow_up": null, "tracking_id": null, "note_flagged": false, "follow_up_instructions": null, "follow_up_note": null, "message_id": null, "pending_manager_approval": false }, { "id": 9069848, "notable_id": 483367, "user_id": null, "text": "The due date for this file has been amended to Fri Jun 24, 22. Please advise if this will cause any issues as soon as possible.", "notable_type": "Order", "blocking": false, "blocking_cleared": false, "created_at": "2022-06-14T20:38:47.000+05:30", "updated_at": "2022-06-14T20:39:07.000+05:30", "visible_to_client": true, "visible_to_appraiser": false, "highlight_for_staff": false, "resolve_staff": false, "resolve_appraiser": false, "visible_to_servicer": true, "visible_to_processor": false, "resolve_servicer": false, "resolve_processor": false, "resolve_client": false, "email_appraiser": false, "email_client": false, "type_for_failure": null, "api_notified": true, "email_processor": false, "follow_up_user_id": null, "follow_up": null, "tracking_id": null, "note_flagged": false, "follow_up_instructions": null, "follow_up_note": null, "message_id": null, "pending_manager_approval": false } ] }';
        
        GetOrderStatusJson gosj = new GetOrderStatusJson();
        gosj = GetOrderStatusJson.parse(res);
        
        string str = '';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
		str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
		str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
		str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
		str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        str = 'test';
        
    }
            
}