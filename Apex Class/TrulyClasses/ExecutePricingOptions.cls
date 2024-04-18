global with sharing class ExecutePricingOptions implements omnistudio.VlocityOpenInterface {

    global boolean invokeMethod(String methodName,Map<String,Object> input, Map<String,Object> output,Map<String,Object> options){
        
        /****************** Functionality to delete the remaining unselected Pricing options *******************/
        string PricingOptionId = string.valueOf(input.get('PricingOption'));
        string leadId = string.valueOf(input.get('leadId'));
        
        Loan_Pass_Option__c lpo = new Loan_Pass_Option__c();
        lpo.id = PricingOptionId;
        lpo.option_selected__c = true;
        Update lpo;
        
        List<Loan_Pass_Option__c> LPOList = new List<Loan_Pass_Option__c>();
        List<LoanPass_Approved_product__c> LPAPList = new List<LoanPass_Approved_product__c>();
        
            
        for(Loan_Pass_Option__c loanPassOp : [select id, Option_Selected__c, current_option_selected__c from Loan_Pass_Option__c where Lead_Referral__c = :leadId]){
        
            if(PricingOptionId.equalsIgnoreCase(loanPassOp.id)){
                loanPassOp.current_option_selected__c = true;
                loanPassOp.Option_Selected__c = false;
                
            }else{
                loanPassOp.Option_Selected__c = false;
            }
            LPOList.add(loanPassOp);
        
        }
        
        if(!LPOList.isEmpty()){
            Update LPOList;
        }
        
        Loan_Pass_Option__c lpop = [select id, Final_pi_payment__c, LoanPass_Approved_product__r.LTV__c,Reserve_requirement__c,  LoanPass_Approved_product__r.Final_dscr__c, Discount_fee__c, Adjusted_interest_rate__c, Compensation__c, test_number__c, LoanPass_Approved_product__r.Product_max_ltv_dollar__c, LoanPass_Approved_product__r.preset_loan_term__c, LoanPass_Approved_product__r.Amortization_type__c from Loan_Pass_Option__c where id = : PricingOptionId];
        
        Lead ld = new Lead();
        ld.id = leadId;
        ld.Lender_fee__c = lpop.test_number__c;
        ld.preset_loan_term__c = lpop.LoanPass_Approved_product__r.preset_loan_term__c;
        ld.Amortization_type__c = lpop.LoanPass_Approved_product__r.Amortization_type__c;
        ld.Product_max_ltv_dollar__c = lpop.LoanPass_Approved_product__r.Product_max_ltv_dollar__c;
        ld.Final_dscr__c = lpop.LoanPass_Approved_product__r.Final_dscr__c;
        ld.LTV__c = lpop.LoanPass_Approved_product__r.LTV__c;
        ld.Adjusted_interest_rate__c = lpop.Adjusted_interest_rate__c;
        ld.Compensation__c = lpop.Compensation__c;
        ld.Discount_fee__c = lpop.Discount_fee__c;
        ld.Final_pi_payment__c = lpop.Final_pi_payment__c;
        ld.Reserve_requirement__c = lpop.Reserve_requirement__c;
        ld.Prequal_Letter__c = true;
        Update ld;
        
        return true;
    }

}