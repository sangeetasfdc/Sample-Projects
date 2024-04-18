public class invoiceWrapper{
    @AuraEnabled 
    public List<String> issue_date {get;set;} // in json: date
    @AuraEnabled 
    public List<String> invoice_number {get;set;} 
    @AuraEnabled 
    public List<String> invoice_total {get;set;} 
    @AuraEnabled 
    public List<String> issuer {get;set;} 
    @AuraEnabled 
    public List<String> invoice_currency {get;set;} 
     
        
    public invoiceWrapper(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'date') {
                        issue_date = arrayOfString(parser);
                    } else if (text == 'invoice_number') {
                        invoice_number = arrayOfString(parser);
                    } else if (text == 'invoice_total') {
                        invoice_total = arrayOfString(parser);
                    } else if (text == 'issuer') {
                        issuer = arrayOfString(parser);
                    } else if(text == 'invoice_currency'){
						invoice_currency = arrayOfString(parser);
                    }else {
                        System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    private static List<String> arrayOfString(System.JSONParser p) {
        List<String> res = new List<String>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(p.getText());
        }
        return res;
    }
    
    public static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT || 
                curr == System.JSONToken.START_ARRAY) {
                    depth++;
                } else if (curr == System.JSONToken.END_OBJECT ||
                           curr == System.JSONToken.END_ARRAY) {
                               depth--;
                           }
        } while (depth > 0 && parser.nextToken() != null);
    }
    
    
}