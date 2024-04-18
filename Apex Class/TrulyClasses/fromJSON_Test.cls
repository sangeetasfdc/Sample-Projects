@istest
public class fromJSON_Test {
    static testMethod void myUnitTest() {
        ExecuteProductSummaryClass eps=new ExecuteProductSummaryClass();
     
      string methodName = 'setAttributesConfiguration';
     Map<String, Object> input = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
         eps.invokeMethod(methodName, input, output, options);
        
       lead led = new lead();
        led.Firstname = 'test';
        led.lastname = 'te23';
        
        led.Email = 'ter@gmail.com';
        led.Phone = '123456788';
        led.Status = 'Nurturing';
        
        insert led;
        
        
    }
}