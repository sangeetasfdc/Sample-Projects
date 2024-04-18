({
    doInit: function(component, event, helper) {
        
        component.set('v.displayedSection','country');
        console.log('doInit');
        var action = component.get("c.getCountries");
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state: '+state);
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.allcountries", result);
                console.log('countries:'+ result);
            }
        });
        $A.enqueueAction(action);
        
        var action2 = component.get("c.getCurrency");
        action2.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.allcurrencies", result);
            }
        });
        $A.enqueueAction(action2);
        
        var action3 = component.get("c.getRegions");
        action3.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.allregions", result);
            }
        });
        $A.enqueueAction(action3);
        
        var action4 = component.get("c.getSources");
        action4.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.allsources", result);
            }
        });
        $A.enqueueAction(action4);
        
        var action5 = component.get("c.getSectors");
        action5.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.allsectors", result);
            }
        });
        $A.enqueueAction(action5);
        
        var action7 = component.get("c.getProducts");
        action7.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.allproducts", result);
            }
        });
        $A.enqueueAction(action7);
        
        var action8 = component.get("c.getAmount");
        action8.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.allamounts", result);
            }
        });
        $A.enqueueAction(action8);
        
        // Listen to enter events 
        window.addEventListener('keyup', function(event) {
            if (event.key === 'Enter') {
                helper.nextQuestion(component, event, helper);
            }
        });
    },
    
    assignselectedvalues : function(component, event, helper) {
        
        if(event.getParam("picklisttype") == 'country'){
            if(event.getParam("singleselectvalue") != 'undefined' && event.getParam("singleselectvalue") != null){
                component.set('v.scountry',event.getParam("singleselectvalue"));
                let button = component.find('nextbuttonid');
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
        }
        
        if(event.getParam("picklisttype") == 'currency'){
            if(event.getParam("multiselectvalue") != 'undefined' && event.getParam("multiselectvalue") != null ){
                component.set('v.scurrency',event.getParam("multiselectvalue"));
                let button = component.find('nextbuttonid');
                if(component.get('v.scurrency') != null & component.get('v.scurrency').length > 0){
                    button.set('v.disabled',false);
                }else{
                    button.set('v.disabled',true);
                }
            }else{
                button.set('v.disabled',true);
            }
        }
        
        if(event.getParam("picklisttype") == 'region'){
            if(event.getParam("multiselectvalue") != 'undefined' && event.getParam("multiselectvalue") != null){
                component.set('v.selectedRegion',event.getParam("multiselectvalue"));
                let button = component.find('nextbuttonid');
                if(component.get('v.selectedRegion') != null & component.get('v.selectedRegion').length > 0){
                    button.set('v.disabled',false);
                }else{
                    button.set('v.disabled',true);
                }
            }else{
                button.set('v.disabled',true);
            }
        }
        
        if(event.getParam("picklisttype") == 'source'){
            if(event.getParam("singleselectvalue") != 'undefined' && event.getParam("singleselectvalue") != null){
                component.set('v.selectedSource',event.getParam("singleselectvalue"));
                var src = component.get('v.selectedSource');
                if(src != 'Referral' && src != 'Other'){
                    component.set('v.sourceNameVal','');
                }
                let button = component.find('nextbuttonid');
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
        }
        
        if(event.getParam("picklisttype") == 'sector'){
            if(event.getParam("singleselectvalue") != 'undefined' && event.getParam("singleselectvalue") != null){
                component.set('v.selectedSector',event.getParam("singleselectvalue"));
                let button = component.find('nextbuttonid');
                button.set('v.disabled',false);
                var action6 = component.get("c.getDependentPicklistValues");
                action6.setParams({ selectedvalue : event.getParam("singleselectvalue") });
                action6.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        component.set("v.allsubIndustries", result);
                    }
                });
                $A.enqueueAction(action6);
            }else{
                button.set('v.disabled',true);
            }
        }
        
        if(event.getParam("picklisttype") == 'subindustry'){
            if(event.getParam("singleselectvalue") != 'undefined' && event.getParam("singleselectvalue") != null){
                component.set('v.selectedIndustry',event.getParam("singleselectvalue"));
                let button = component.find('nextbuttonid');
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
        }
        
        if(event.getParam("picklisttype") == 'product'){
            if(event.getParam("singleselectvalue") != 'undefined' && event.getParam("singleselectvalue") != null){
                component.set('v.selectedProduct',event.getParam("singleselectvalue"));
                let button = component.find('nextbuttonid');
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
        }
        
        if(event.getParam("picklisttype") == 'amount'){
            if(event.getParam("singleselectvalue") != 'undefined' && event.getParam("singleselectvalue") != null){
                component.set('v.selectedAmount',event.getParam("singleselectvalue"));
                let button = component.find('nextbuttonid');
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
        }
        
        console.log('country:'+component.get('v.scountry'));
        console.log('currency:'+component.get('v.scurrency'));
        console.log('region:'+component.get('v.selectedRegion'));
        console.log('source:'+component.get('v.selectedSource'));
        console.log('sector:'+component.get('v.selectedSector'));
        console.log('industry:'+component.get('v.selectedIndustry'));
        console.log('product:'+component.get('v.selectedProduct'));
    },
    
    nextQuestioncntrl : function(component, event, helper) {
        console.log('nextbutton');
        helper.nextQuestion(component, event, helper);
    },
    
    previousQuestion : function(component, event, helper){
        var currentQuestion = component.get('v.displayedSection');
        if(currentQuestion == 'country'){
        }else if(currentQuestion == 'currency'){
            component.set('v.displayedSection','country');
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
        }else if(currentQuestion == 'region'){
            component.set('v.progress','9');
            component.set('v.displayedSection','currency');
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
        }else if(currentQuestion == 'source'){
            component.set('v.progress','18');
            component.set('v.displayedSection','region');
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
            
        }else if(currentQuestion == 'sourceName'){
            component.set('v.progress','27');
            component.set('v.displayedSection','source');
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
        }else if(currentQuestion == 'organization'){
            if(component.get("v.sourceNameVal") != null && component.get("v.sourceNameVal") != ''){
                component.set('v.progress','27');
                component.set('v.displayedSection','sourceName');
            }else{
                component.set('v.progress','27');
                component.set('v.displayedSection','source');
            }
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
        }else if(currentQuestion == 'contact'){
            component.set('v.progress','36');
            component.set('v.displayedSection','organization');
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
        }else if(currentQuestion == 'email'){
            component.set('v.progress','45');
            component.set('v.displayedSection','contact');
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
        }else if(currentQuestion == 'sector'){
            component.set('v.progress','54');
            component.set('v.displayedSection','email');
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
        }else if(currentQuestion == 'industry'){
            component.set('v.progress','63');
            component.set('v.displayedSection','sector');
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
        }else if(currentQuestion == 'product'){
            component.set('v.progress','72');
            component.set('v.displayedSection','industry');
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
        }else if(currentQuestion == 'amount'){
            component.set('v.progress','81');
            component.set('v.displayedSection','product');
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
        }
    },
    
    enableNext : function(component, event, helper){
        var orgval = document.getElementById('orgid').value;
        if(orgval != null && orgval != '' && orgval != 'undefined'){
            component.set('v.organisationname',orgval);
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
        }else{
            let button = component.find('nextbuttonid');
            button.set('v.disabled',true);
        }
    },
    
    enableNextsourcename : function(component, event, helper){
        var orgval = document.getElementById('sourceNameid').value;
        
        if(orgval != null && orgval != '' && orgval != 'undefined'){
            component.set('v.sourceNameVal',orgval);
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
        }else{
            let button = component.find('nextbuttonid');
            button.set('v.disabled',true);
        }
    },
    
    enableNextcontactname : function(component, event, helper){
        var orgval = document.getElementById('conid').value;
        
        if(orgval != null && orgval != '' && orgval != 'undefined'){
            component.set('v.contactname',orgval);
            let button = component.find('nextbuttonid');
            button.set('v.disabled',false);
        }else{
            let button = component.find('nextbuttonid');
            button.set('v.disabled',true);
        }
    },
    
    enableNextEmail : function(component, event, helper){
        
        var emailentered = document.getElementById('emailid').value;
        if(emailentered.length > 5 && emailentered != null && emailentered != '' && emailentered != 'undefined'){
            let button = component.find('nextbuttonid');
            var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            var validformat = emailentered.match(regExpEmailformat);
            if (validformat) {
                button.set('v.disabled',false);
                document.getElementById("validation").style.display = "none";
                document.getElementById('validation').innerHTML = "";
            }else{
             	button.set('v.disabled',true);  
                document.getElementById("validation").style.display = "block";
                document.getElementById('validation').innerHTML = "please enter valid email";
                document.getElementById("existinguservalidation").style.display = "none";
                document.getElementById("existinguservalidation").innerHTML = " ";
                
            }
        }
    },
    
    ContactUs : function(component, event, helper) {
        window.open("https://marcofi.typeform.com/to/s67swqaj?typeform-source=www.marcofi.com");
    },
    
    startApplication : function(component, event, helper) {
        window.open("https://portal-marcofinancial2021.cs198.force.com/marconifinancial");
    },    
    
    getintouch : function(component, event, helper) {
        window.open("https://marcofi.typeform.com/to/s67swqaj?typeform-source=www.marcofi.com");
    },
    
    communitylogin : function(component, event, helper) {
        window.open("https://portal-marcofinancial2021.cs198.force.com/marconifinancial/s/");
    }
    
    
})