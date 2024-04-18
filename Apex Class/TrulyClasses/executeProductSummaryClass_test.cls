@istest
public class executeProductSummaryClass_test {
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
    
    static testMethod void myUnitTest2() {
        lead led = new lead();
        led.Firstname = 'test';
        led.lastname = 'te23';
        led.Email = 'ter@gmail.com';
        led.Phone = '123456788';
        led.Status = 'Nurturing';
        insert led;
        ExecuteProductCls eps = new ExecuteProductCls();
        string methodName = 'getexcuteProductBody';
        string methodName2 = 'getexcuteProductBody';
        Map<String, Object> input = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        eps.invokeMethod(methodName, input, output, options);
        eps.invokeMethod(methodName2, input, output, options);
        
    }
    
    static testMethod void myUnitTest3() {
        lead led = new lead();
        led.Firstname = 'test';
        led.lastname = 'te23';
        led.Email = 'ter@gmail.com';
        led.Phone = '123456788';
        led.Status = 'Nurturing';
        insert led;
        ExecuteProductCls eps = new ExecuteProductCls();
        string methodName2 = 'createRecords';
        Map<String, Object> input = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        eps.invokeMethod(methodName2, input, output, options);
        
    }
    
    static testMethod void myUnitTest4() {
        ExecuteSummaryClass eps=new ExecuteSummaryClass();
        string methodName = 'getLead';
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