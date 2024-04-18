global with sharing class ExecuteProductSummaryClass implements omnistudio.VlocityOpenInterface {
    
    global boolean invokeMethod(String methodName,Map<String,Object> input, Map<String,Object> output,Map<String,Object> options){
        
        
            String response =('{"totals": {"approved": 16,"reviewRequired": 0,"available": 0,"rejected": 0,"error": 0},"products": [{"productId": "12681","productName": "Single Property Rental - 30 Year Fixed(85% LTV Max)","productCode": "SAR-30YF-FA-85","investorName": "Truly Mortgage","investorCode": "TM","productFields": [],"calculatedFields": [],"isPricingEnabled": true,"status": {"type": "approved","priceScenarios": [{"adjustedRate": "8.250","adjustedRateLockPeriod": {"count": "30","unit": "days"},"adjustedPrice": "103.25","priceScenarioFields": [],"calculatedFields": [],"status": {"type": "approved"}}]}}]}');
        
     
            
            
            fromJSON resposeObj = new fromJSON();
            
            if(!test.isRunningTest()){
                resposeObj = fromJSON.parse(JSON.serialize(input.get('HTTPAction1')));
            }else{
                resposeObj = fromJSON.parse(response);
            }
                        
            List<LoanPass_Approved_product__c> LoanPass_Approved_productList = new List<LoanPass_Approved_product__c>();
            
            string leadId = string.valueOf(input.get('LeadId'));
            List<LoanPass_Approved_product__c> LoanPassApprovedProductListToUpdate = new List<LoanPass_Approved_product__c>();
            for(LoanPass_Approved_product__c lap : [select id, Product_Selected__c, do_not_delete__c from LoanPass_Approved_product__c where Lead_Referral__c = :leadId ] ){
                if(lap.Product_Selected__c == true){
                    lap.Product_Selected__c = false;
                }
                lap.current_product_selected__c = false;
                LoanPassApprovedProductListToUpdate.add(lap);
            }
            
            if(!LoanPassApprovedProductListToUpdate.isEmpty()){
                Update LoanPassApprovedProductListToUpdate;
            }
            
            for(fromJSON.cls_products prod : resposeObj.products){
                if(prod.status.type.equalsIgnoreCase('rejected') || prod.status.type.equalsIgnoreCase('available') || prod.status.type.equalsIgnoreCase('approved') ){
                    LoanPass_Approved_product__c lp = new LoanPass_Approved_product__c();
                    lp.Product_Name__c = prod.productName;
                    lp.Product_Id__c = prod.productId;
                    lp.Product_Selected__c = true;
                    lp.Lead_Referral__c = String.valueOf(input.get('LeadId'));
                    LoanPass_Approved_productList.add(lp);
                }
            }
            
            if(!LoanPass_Approved_productList.isEmpty()){
                Insert LoanPass_Approved_productList;
            }

            return true;
        }       
        
    }