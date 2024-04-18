public class ViewPdf {
    
    public Lead leadrec; 

    public string publicUrl {get;set;}  
    
    public ViewPdf(ApexPages.StandardController controller){
        
        try{
            string leadId = ApexPages.currentPage().getParameters().get('Id');
            leadrec = new Lead();
            this.leadrec  = [select Id , Email, Quote_sent__c from Lead Where Id=: ApexPages.currentPage().getParameters().get('Id') limit 1];
            
            AggregateResult[] DoscAggregate = [SELECT max(ContentDocumentId)cdm from ContentDocumentLink where LinkedEntityId  = :leadId];      
            string docid = string.valueOf(DoscAggregate[0].get('cdm'));  
            ContentVersion cv = [SELECT id, VersionData, FileExtension FROM ContentVersion WHERE ContentDocumentId = :docid];
            ContentDistribution cdb = [select id, DistributionPublicUrl from contentdistribution where contentversionId = :cv.id];
            publicUrl = cdb.DistributionPublicUrl;
        }catch(Exception e){
            publicUrl = 'https://trulyinvestor--dev.sandbox.my.salesforce.com/sfc/p/2C000000D05i/a/2C000000LE3Y/AD0tz3sCuzBVS_k2wdOaboYOluS52TXnKUiyIA9WQcE';
        }
        
        
    }
    
    public PageReference SendPdf() {
    
        leadrec.Quote_sent__c  = true;
        
        update leadrec;
        
        List<ContentDocumentLink> cdlList = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =:leadrec.Id];
        
        List<ContentVersion> cvList = [SELECT id, VersionData, FileExtension FROM ContentVersion WHERE ContentDocumentId = :cdlList[0].ContentDocumentId AND IsLatest = true];
        
   Blob fileData = cvList[0].VersionData; 
        Messaging.EmailFileAttachment emlAtt = new Messaging.EmailFileAttachment();
        emlAtt.setFilename('MyFile.' + cvList[0].FileExtension);
        emlAtt.setBody(fileData);
        emlAtt.setInline(false);
        //Apex Single email message
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setUseSignature(false);
        mail.setToAddresses(new String[] { leadrec.Email });
        mail.setSubject('Test Email With Attachment');
        mail.setHtmlBody('Please find the attachment.');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { emlAtt });
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        string acc;
        acc = convertLeadCls.convertLeadMethod(new List<lead>{leadrec});
        
        if(string.isNotBlank(acc)){
            PageReference pg = new PageReference('/'+acc);
            pg.setRedirect(true);
            return pg;
 
        
        
        
        }

 
        
        return null;
    }
}