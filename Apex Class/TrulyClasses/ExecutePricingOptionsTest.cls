@istest
public class ExecutePricingOptionsTest {
    @istest
    public static void Testmethods(){
        ExecutePricingOptions eps=new ExecutePricingOptions();
        lead led = new lead();
        led.Firstname = 'test';
        led.lastname = 'te23';
        led.Email = 'ter@gmail.com';
        led.Phone = '123456788';
        led.Status = 'Nurturing';
        insert led;
        
        Loan_Pass_Option__c Lps =new Loan_Pass_Option__c();
        lps.Lead_Referral__c = led.id;
        lps.option_selected__c = false;
        lps.Discount_fee__c = 10;
        lps.Adjusted_interest_rate__c = 10;
        lps.Compensation__c = 10;
        lps.test_number__c= 12;
        lps.Reserve_requirement__c = 120;
        insert lps;
        
        string methodName = '';
        Map<String, Object> input = new Map<String, Object>();
        input.put('PricingOption',lps.Id);
        input.put('leadId',led.Id);
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        eps.invokeMethod(methodName, input, output, options);
       
    }
}