public class ExecuteProductfromJSON{

    public String productId;    //15075
    public String productName;  //Single Property Rental - 40 Year IO (60% LTV Max)
    public String productCode;  //SAR-40YF-IO-LTR-60
    public String investorName; //Truly Mortgage
    public String investorCode; //TM
    public boolean isPricingEnabled;
    public cls_productFields[] productFields;
    public cls_calculatedFields[] calculatedFields;
    public cls_status status;
    
    public class cls_productFields {
        public String fieldId;  //field@product-loan-program
        public cls_value value;
    }
    
    public class cls_value {
        public String type; //number
        public String value;    //7.375
        public string count;
        public string unit;
        public string variantId;
    }
    
    public class cls_calculatedFields {
        public String fieldId;  //calc@adjusted-interest-rate
        public cls_value value;
    }
    
    public class cls_status {
        public String type; //approved
        
        public cls_priceScenarios[] priceScenarios;
        public cls_priceAdjustments[] priceAdjustments;
        public cls_marginAdjustments[] marginAdjustments;
        public cls_rateAdjustments[] rateAdjustments;
        public cls_stipulations[] stipulations;
    }
    
    public class cls_priceScenarios {
        public cls_priceScenarioFields[] priceScenarioFields;
        public cls_calculatedFields[] calculatedFields;
        //public cls_status status;
    }
    
    public class cls_priceScenarioFields {
        public String fieldId;  //base-interest-rate
        public cls_value value;
    }
    
    public class cls_priceAdjustments {
        public String ruleId;   //31788
        public String amount;   //0
        public String description;  //DSCR - 2.409 / LTV - 60.000%
    }
    
    public class cls_marginAdjustments {
    
    }
    
    public class cls_rateAdjustments {
        public String ruleId;   //32118
        public String amount;   //6.875
        public String description;  //LLRA - Base Rate
    }
    
    public class cls_stipulations {
    
    }
    
    public static ExecuteProductfromJSON parse(String json){
        return (ExecuteProductfromJSON) System.JSON.deserialize(json, ExecuteProductfromJSON.class);
    }
}