({
    nextQuestion: function(component, event, helper) {
        //alert('test');
        var currentQuestion = component.get('v.displayedSection');
        if (currentQuestion == 'country') {
            if (component.get('v.scountry') != null && component.get('v.scountry') != '' && component.get('v.scountry') != 'undefined') {
                component.set('v.progress', '9');
                component.set('v.displayedSection', 'currency');
                let button = component.find('nextbuttonid');
                if (component.get('v.scurrency') != null && component.get('v.scurrency') != '' && component.get('v.scurrency') != 'undefined') {
                    button.set('v.disabled', false);
                }else{
                    button.set('v.disabled', true);
                }
            }
            
        } else if (currentQuestion == 'currency') {
            if (component.get('v.scurrency') != null && component.get('v.scurrency') != '' && component.get('v.scurrency') != 'undefined') {
                component.set('v.progress', '18');
                component.set('v.displayedSection', 'region');
                let button = component.find('nextbuttonid');
                if (component.get('v.selectedRegion') != null && component.get('v.selectedRegion') != '' && component.get('v.selectedRegion') != 'undefined') {
                    button.set('v.disabled', false);
                }else{
                    button.set('v.disabled', true);
                }
            }
            
        } else if (currentQuestion == 'region') {
            if (component.get('v.selectedRegion') != null && component.get('v.selectedRegion') != '' && component.get('v.selectedRegion') != 'undefined') {
                component.set('v.progress', '27');
                component.set('v.displayedSection', 'source');
                let button = component.find('nextbuttonid');
                if (component.get('v.selectedSource') != null && component.get('v.selectedSource') != '' && component.get('v.selectedSource') != 'undefined') {
                    button.set('v.disabled', false);
                }else{
                    button.set('v.disabled', true);
                }
            }
            
        } else if (currentQuestion == 'source') {
            if (component.get('v.selectedSource') != null && component.get('v.selectedSource') != '' && component.get('v.selectedSource') != 'undefined') {
                
                var src = component.get('v.selectedSource');
                console.log('src: '+src);
                let button = component.find('nextbuttonid');
                if(src == 'Referral' || src == 'Other'){
                    component.set('v.progress', '27');
                    component.set('v.displayedSection', 'sourceName');
                    console.log('other source name: '+component.get('v.sourceNameVal'));
                    if (component.get('v.sourceNameVal') != null && component.get('v.sourceNameVal') != '' && component.get('v.sourceNameVal') != 'undefined') {
                        button.set('v.disabled', false);
                    }else{
                        button.set('v.disabled', true);
                    }
                }else{
                    component.set('v.progress', '36');
                    component.set('v.displayedSection', 'organization');
                    if (component.get('v.organisationname') != null && component.get('v.organisationname') != '' && component.get('v.organisationname') != 'undefined') {
                        button.set('v.disabled', false);
                    }else{
                        button.set('v.disabled', true);
                    }
                }    
            }
            
        }else if (currentQuestion == 'sourceName') {
            if (component.get('v.selectedSource') != null && component.get('v.selectedSource') != '' && component.get('v.selectedSource') != 'undefined') {
                component.set('v.progress', '36');                    
                component.set('v.displayedSection', 'organization');                    
                let button = component.find('nextbuttonid');
                if (component.get('v.organisationname') != null && component.get('v.organisationname') != '' && component.get('v.organisationname') != 'undefined') {
                    button.set('v.disabled', false);
                }else{
                    button.set('v.disabled', true);
                }
            }
            
            
        } else if (currentQuestion == 'organization') {
            if (component.get('v.organisationname') != null && component.get('v.organisationname') != '' && component.get('v.organisationname') != 'undefined') {
                component.set('v.progress', '45');
                component.set('v.displayedSection', 'contact');
                let button = component.find('nextbuttonid');
                if (component.get('v.contactname') != null && component.get('v.contactname') != '' && component.get('v.contactname') != 'undefined') {
                    button.set('v.disabled', false);
                }else{
                    button.set('v.disabled', true);
                }
            }
            
        } else if (currentQuestion == 'contact') {
            if (component.get('v.contactname') != null && component.get('v.contactname') != '' && component.get('v.contactname') != 'undefined') {
                component.set('v.progress', '54');
                component.set('v.displayedSection', 'email');
                let button = component.find('nextbuttonid');
                var emailv = component.get("v.emailverified");
                var emailv2 = component.get("v.UserExists");
                if (component.get('v.Email') != null && component.get('v.Email') != '' && component.get('v.Email') != 'undefined') {
                    if(emailv || emailv2){
                        button.set('v.disabled', true);
                    }else{
                        button.set('v.disabled', true);
                    }
                }else{
                    button.set('v.disabled', true);
                }
            }
            
        } else if (currentQuestion == 'email') {
            //alert('spinner on');
            component.set("v.spinner", true);
            
            var emailentered = document.getElementById('emailid').value;
            component.set('v.Email', emailentered);
            console.log('email: '+component.get('v.Email'));
            //alert(emailentered);
            if (component.get('v.Email') != null && component.get('v.Email') != '' && component.get('v.Email') != 'undefined') {
                if (emailentered) {
                    console.log('valid');
                    var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                    var validformat = emailentered.match(regExpEmailformat);
                    
                    if (validformat) {
                        component.set('v.Email', emailentered);
                        /*var apikey = $A.get("$Label.c.API_key");
                        var url = "https://emailvalidation.abstractapi.com/v1/?api_key=" + apikey;
                        url = url + "&email=" + emailentered;
                        //alert(url);
                        var xmlHttp = new XMLHttpRequest();
                        xmlHttp.onreadystatechange = function() {
                            
                            if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                                if (xmlHttp.responseText) {
                                    var response = JSON.parse(xmlHttp.responseText);
                                    console.log('response' + xmlHttp.responseText);
                                    console.log('valid' + response.is_valid_format.value);
                                    //alert('smtp check:'+response.is_smtp_valid.value);
                                    if (response.is_valid_format.value != 'undefined') {*/
                                        if ((/*response.is_valid_format.value && response.is_smtp_valid.value &&*/ emailentered != '' && emailentered != 'undefined' && emailentered != null)) {
                                            //alert('test');
                                            let button = component.find('nextbuttonid');
                                            console.log('test');
                                            //document.getElementById('validation').innerHTML = "";
                                            component.set('v.Email', emailentered);
                                            component.set("v.emailverified",true);
                                            //alert('existing user');
                                            console.log('checkForExistingUser');
                                            var action = component.get("c.checkExistingUser");
                                            action.setParams({
                                                UserEmail: emailentered
                                            });
                                            //alert('user');
                                            
                                            action.setCallback(this, function(response) {
                                                var state = response.getState();
                                                console.log('state'+state);
                                                component.set("v.spinner", false);
                                                if (state === "SUCCESS") {
                                                    var result = response.getReturnValue();
                                                    console.log('result: '+result);
                                                    if(result){
                                                        component.set("v.UserExists",true);
                                                        button.set('v.disabled', true);
                                                        document.getElementById("validation").style.display = "none";
                                                        document.getElementById("existinguservalidation").style.display = "block";
                                                        return;
                                                    }else{
                                                        //button.set('v.disabled', false);
                                                        component.set("v.UserExists",false);
                                                        component.set('v.displayedSection', 'sector');
                                                        component.set('v.progress', 63);
                                                        let button = component.find('nextbuttonid');
                                                        if (component.get('v.selectedSector') != null && component.get('v.selectedSector') != '' && component.get('v.selectedSector') != 'undefined') {
                                                            button.set('v.disabled', false);
                                                        }else{
                                                            button.set('v.disabled', true);
                                                        }
                                                    }
                                                    console.log('success:'+result); 
                                                } else if (state === "INCOMPLETE") {
                                                    
                                                    
                                                } else if (state === "ERROR") {
                                                    var errors = response.getError();
                                                    if (errors) {
                                                        if (errors[0] && errors[0].message) {
                                                            console.log("Error message: " + errors[0].message);
                                                        }
                                                    } else {
                                                        console.log("Unknown error");
                                                    }
                                                }
                                            });
                                            $A.enqueueAction(action);
                                        } else {
                                            
                                            //alert(response.is_smtp_valid.value);
                                            let button = component.find('nextbuttonid');
                                            button.set('v.disabled', true);
                                            component.set("v.UserExists",false);
                                            document.getElementById("validation").style.display = "block";
                                            document.getElementById('validation').innerHTML = "please enter valid email";
                                            document.getElementById("existinguservalidation").style.display = "none";
                                            component.set("v.emailverified",false);
                                            component.set("v.spinner", false);
                                            //alert('spinner off');
                                        }
                                        //alert('off');
                                        component.set("v.spinner", false);
                                    //}
                                //}
                            
                        //}
                        
                        //xmlHttp.open("GET", url, false); // true for asynchronous
                        //xmlHttp.send(null);
                    }else{
                        let button = component.find('nextbuttonid');
                        component.set("v.spinner", false);
                        button.set('v.disabled', true);
                        document.getElementById("validation").style.display = "block";
                        document.getElementById('validation').innerHTML = "please enter valid email";
                        document.getElementById("existinguservalidation").style.display = "none";
                        document.getElementById("existinguservalidation").innerHTML = " ";
                    }
                }
            }else{
                component.set("v.spinner", false);
                let button = component.find('nextbuttonid');
                button.set('v.disabled', true);
                document.getElementById("validation").style.display = "none";
                document.getElementById('validation').innerHTML = "";
            }
            
        }  else if (currentQuestion == 'sector') {
            if (component.get('v.selectedSector') != null && component.get('v.selectedSector') != '' && component.get('v.selectedSector') != 'undefined') {
                component.set('v.progress', '72');
                component.set('v.displayedSection', 'industry');
                let button = component.find('nextbuttonid');
                if (component.get('v.selectedIndustry') != null && component.get('v.selectedIndustry') != '' && component.get('v.selectedIndustry') != 'undefined') {
                    button.set('v.disabled', false);
                }else{
                    button.set('v.disabled', true);
                }
            }
        } else if (currentQuestion == 'industry') {
            if (component.get('v.selectedIndustry') != null && component.get('v.selectedIndustry') != '' && component.get('v.selectedIndustry') != 'undefined') {
                console.log('test');
                component.set('v.progress', '81');
                component.set('v.displayedSection', 'product');
                let button = component.find('nextbuttonid');
                if (component.get('v.selectedProduct') != null && component.get('v.selectedProduct') != '' && component.get('v.selectedProduct') != 'undefined') {
                    button.set('v.disabled', false);
                }else{
                    button.set('v.disabled', true);
                }
            }
            
            
        } else if (currentQuestion == 'product') {
            if (component.get('v.selectedProduct') != null && component.get('v.selectedProduct') != '' && component.get('v.selectedProduct') != 'undefined') {
                component.set('v.progress', '90');
                component.set('v.displayedSection', 'amount');
                let button = component.find('nextbuttonid');
                 if (component.get('v.selectedamount') != null && component.get('v.selectedamount') != '' && component.get('v.selectedamount') != 'undefined') {
                    button.set('v.disabled', false);
                    console.log("enabled");
                 }else{
                     button.set('v.disabled', true);
                     console.log("disabled");
                 }
            }
             //alert('product next');
        } else if (currentQuestion == 'amount') {
            
            var action = component.get("c.ApprovalCriteria");
            action.setParams({
                country: component.get('v.scountry'),
                curr: component.get('v.scurrency'),
                Region: component.get('v.selectedRegion'),
                source: component.get('v.selectedSource'),
                sector: component.get('v.selectedSector'),
                Industry: component.get('v.selectedIndustry'),
                Product: component.get('v.selectedProduct'),
                amount: component.get('v.selectedAmount'),
                Email: component.get('v.Email'),
                OrganisationName: component.get('v.organisationname'),
                Contactname: component.get('v.contactname'),
                sourceNameVal:component.get('v.sourceNameVal')
            });
            
            action.setCallback(this, function(response) {
                var state = response.getState();
                
                if (state === "SUCCESS") {
                    component.set('v.progress', '100');
                    var result = response.getReturnValue();
                    console.log(result);
                    component.set('v.displaybuttons', 'hidebuttons');
                    if (result == 'Pre-Approved') {
                        component.set('v.displayedSection', 'successmessage');
                        component.set('v.approvalstatus','approved');
                    } else {
                        component.set('v.displayedSection', 'errormessage');
                    }
                } else if (state === "INCOMPLETE") {
                    // do something
                    
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " +
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
            });
            $A.enqueueAction(action);
        }
    },
    
    EmailEnterPress: function(component, event, helper) {
        alert('EmailEnterPress');
        var emailentered = document.getElementById('emailid').value;
        
        if (emailentered) {
            
            var regExpEmailformat = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            var validformat = emailentered.match(regExpEmailformat);
            
            if (validformat) {
                component.set('v.Email', emailentered);
                var apikey = $A.get("$Label.c.API_key");
                var url = "https://emailvalidation.abstractapi.com/v1/?api_key=" + apikey;
                url = url + "&email=" + emailentered;
                
                var xmlHttp = new XMLHttpRequest();
                xmlHttp.onreadystatechange = function() {
                    
                    if (xmlHttp.readyState === 4 && xmlHttp.status === 200)
                        if (xmlHttp.responseText) {
                            var response = JSON.parse(xmlHttp.responseText);
                            console.log('response' + response);
                            console.log('valid' + response.is_valid_format.value);
                            
                            if (response.is_valid_format.value != 'undefined') {
                                if ((response.is_valid_format.value && response.is_smtp_valid.value && emailentered != '' && emailentered != 'undefined' && emailentered != null)) {
                                    
                                } else {
                                    component.set("v.UserExists",false);
                                    document.getElementById("validation").style.display = "block";
                                    document.getElementById('validation').innerHTML = "please enter valid email";
                                    let button = component.find('nextbuttonid');
                                    button.set('v.disabled', true);
                                    component.set("v.emailverified",false);
                                    component.set("v.spinner", false);
                                }
                            }
                        }
                    
                }
                
                xmlHttp.open("GET", url, false); // true for asynchronous
                xmlHttp.send(null);
                
                let button = component.find('nextbuttonid');
                console.log('test');
                document.getElementById('validation').innerHTML = "";
                component.set('v.Email', emailentered);
                component.set("v.emailverified",true);
                
                console.log('checkForExistingUser');
                var action = component.get("c.checkExistingUser");
                action.setParams({
                    UserEmail: emailentered
                });
                
                action.setCallback(this, function(response) {
                    
                    var state = response.getState();
                    console.log('state'+state);
                    component.set("v.spinner", false); 
                    
                    if (state === "SUCCESS") {
                        var result = response.getReturnValue();
                        if(result){
                            component.set("v.UserExists",true);
                            button.set('v.disabled', true);
                            document.getElementById("validation").style.display = "none";
                            return;
                        }else{
                            button.set('v.disabled', false);
                            component.set("v.UserExists",false);
                            component.set('v.displayedSection', 'sector');
                            component.set('v.progress', 63);
                            let button = component.find('nextbuttonid');
                            if (component.get('v.selectedSector') != null && component.get('v.selectedSector') != '' && component.get('v.selectedSector') != 'undefined') {
                                button.set('v.disabled', false);
                            }else{
                                button.set('v.disabled', true);
                            }
                        }
                        console.log('success'+result);
                        
                    } else if (state === "INCOMPLETE") {
                        
                        
                    } else if (state === "ERROR") {
                        var errors = response.getError();
                        if (errors) {
                            if (errors[0] && errors[0].message) {
                                console.log("Error message: " + errors[0].message);
                            }
                        } else {
                            console.log("Unknown error");
                        }
                    }
                });
                $A.enqueueAction(action);
            }else{
                let button = component.find('nextbuttonid');
                component.set("v.spinner", false);
                button.set('v.disabled', true);
            }
        }
    }
    
})