({
    doInitHelper : function(component) {
        
        $A.util.toggleClass(component.find('resultsDiv'),'slds-is-open');
        var value = component.get('v.value');
        var values = component.get('v.values');
        
        
        if( !$A.util.isEmpty(value) || !$A.util.isEmpty(values) ) {
            alert('test');
            var searchString;
            var count = 0;
            var multiSelect = component.get('v.multiSelect');
            var options = component.get('v.options');
            
            options.forEach( function(element, index) {
                if(multiSelect) {
                    if(values.includes(element.value)) {
                        element.selected = true;
                        count++;
                    }  
                }else{
                    
                    if(element.value == value) {
                        searchString = element.label;
                    }
                }
            });
            if(multiSelect)
                component.set('v.searchString', count + ' options selected');
            else
                component.set('v.searchString', searchString);
            component.set('v.options', options);
            console.log('options: '+options);
        }
    },
    
    filterOptionsHelper : function(component) {
        component.set("v.message", '');
        var searchText = component.get('v.searchString');
        var options = component.get("v.options");
        var minChar = component.get('v.minChar');
        if(searchText.length >= minChar) {
            var flag = true;
            options.forEach( function(element,index) {
                if(element.label.toLowerCase().trim().startsWith(searchText.toLowerCase().trim())) {
                    element.isVisible = true;
                    flag = false;
                } else {
                    element.isVisible = false;
                }
            });
            component.set("v.options",options);
            if(flag) {
                component.set("v.message", "No results found for '" + searchText + "'");
            }
        }
        $A.util.addClass(component.find('resultsDiv'),'slds-is-open');
    },
    
    selectItemHelper : function(component, event) {
        
        var options = component.get('v.options');
        var multiSelect = component.get('v.multiSelect');
        var searchString = component.get('v.searchString');
        var values = component.get('v.values') || [];
        var value;
        var count = 0;
        
        options.forEach( function(element, index) {
            
            if(element.value === event.currentTarget.id) {
                
                if(multiSelect){
                    
                    if(values.includes(element.value)) {
                        values.splice(values.indexOf(element.value), 1);
                    }else{
                        values.push(element.value);
                    }
                    element.selected = element.selected ? false : true;  
                    
                    if(component.get('v.picklisttype') == 'currency'){
                        var cmpEvent = component.getEvent("cmpEventSingle");
                        cmpEvent.setParams({ "multiselectvalue" : values });
                        cmpEvent.setParams({ "picklisttype" : 'currency' });
                        cmpEvent.fire();  
                    }
                    
                    if(component.get('v.picklisttype') == 'region'){
                        var cmpEvent = component.getEvent("cmpEventSingle");
                        cmpEvent.setParams({ "multiselectvalue" : values });
                        cmpEvent.setParams({ "picklisttype" : 'region' });
                        cmpEvent.fire();  
                    }
                    
                }else{
                    
                    value = element.value;
                    searchString = element.label;
                    
                    if(component.get('v.picklisttype') == 'country'){
                        var cmpEvent = component.getEvent("cmpEventSingle");
                        cmpEvent.setParams({ "singleselectvalue" : value });
                        cmpEvent.setParams({ "picklisttype" : 'country' });
                        cmpEvent.fire(); 
                    }
                    
                    if(component.get('v.picklisttype') == 'source'){
                        var cmpEvent = component.getEvent("cmpEventSingle");
                        cmpEvent.setParams({ "singleselectvalue" : value });
                        cmpEvent.setParams({ "picklisttype" : 'source' });
                        cmpEvent.fire();  
                    }
                    
                    if(component.get('v.picklisttype') == 'sector'){
                        var cmpEvent = component.getEvent("cmpEventSingle");
                        cmpEvent.setParams({ "singleselectvalue" : value });
                        cmpEvent.setParams({ "picklisttype" : 'sector' });
                        cmpEvent.fire();  
                    }
                    
                    if(component.get('v.picklisttype') == 'subindustry'){
                        var cmpEvent = component.getEvent("cmpEventSingle");
                        cmpEvent.setParams({ "singleselectvalue" : value });
                        cmpEvent.setParams({ "picklisttype" : 'subindustry' });
                        cmpEvent.fire();  
                    }                    
                    
                    if(component.get('v.picklisttype') == 'amount'){
                        var cmpEvent = component.getEvent("cmpEventSingle");
                        cmpEvent.setParams({ "singleselectvalue" : value });
                        cmpEvent.setParams({ "picklisttype" : 'amount' });
                        cmpEvent.fire();  
                    }
                    
                    if(component.get('v.picklisttype') == 'product'){
                        var cmpEvent = component.getEvent("cmpEventSingle");
                        cmpEvent.setParams({ "singleselectvalue" : value });
                        cmpEvent.setParams({ "picklisttype" : 'product' });
                        cmpEvent.fire(); 
                    }
                    
                    if(component.get('v.picklisttype') == 'qualitychecks'){
                        var cmpEvent = component.getEvent("cmpEventSingle");
                        cmpEvent.setParams({ "singleselectvalue" : value });
                        cmpEvent.setParams({ "picklisttype" : 'qualitychecks' });
                        cmpEvent.fire();
                    }
                    
                    if(component.get('v.picklisttype') == 'salesamount'){
                        var cmpEvent = component.getEvent("cmpEventSingle");
                        cmpEvent.setParams({ "singleselectvalue" : value });
                        cmpEvent.setParams({ "picklisttype" : 'salesamount' });
                        cmpEvent.fire(); 
                    }
                    
                    if(component.get('v.picklisttype') == 'ageingreport'){
                        var cmpEvent = component.getEvent("cmpEventSingle");
                        cmpEvent.setParams({ "singleselectvalue" : value });
                        cmpEvent.setParams({ "picklisttype" : 'ageingreport' });
                        cmpEvent.fire(); 
                    }
                }
            }
            
            if(element.selected) {
                count++;
            }
        });
        component.set('v.value', value);
        component.set('v.values', values);
        component.set('v.options', options);
        if(multiSelect)
            component.set('v.searchString', count + ' options selected');
        else
            component.set('v.searchString', searchString);
        if(multiSelect)
            event.preventDefault();
        else
            $A.util.removeClass(component.find('resultsDiv'),'slds-is-open');
    },
    
    removePillHelper : function(component, event) {
        var value = event.getSource().get('v.name');
        var multiSelect = component.get('v.multiSelect');
        var count = 0;
        var options = component.get("v.options");
        var values = component.get('v.values') || [];
        options.forEach( function(element, index) {
            if(element.value === value) {
                element.selected = false;
                values.splice(values.indexOf(element.value), 1);
            }
            if(element.selected) {
                count++;
            }
        });
        if(multiSelect){
            component.set('v.searchString', count + ' options selected');
            if(component.get('v.picklisttype') == 'currency'){
                var cmpEvent = component.getEvent("cmpEventSingle");
                cmpEvent.setParams({ "multiselectvalue" : values });
                cmpEvent.setParams({ "picklisttype" : 'currency' });
                cmpEvent.fire();  
            }
            
            if(component.get('v.picklisttype') == 'region'){
                var cmpEvent = component.getEvent("cmpEventSingle");
                cmpEvent.setParams({ "multiselectvalue" : values });
                cmpEvent.setParams({ "picklisttype" : 'region' });
                cmpEvent.fire();  
            }
        }else{
            if(component.get('v.picklisttype') == 'country'){
                var cmpEvent = component.getEvent("cmpEventSingle");
                cmpEvent.setParams({ "singleselectvalue" : value });
                cmpEvent.setParams({ "picklisttype" : 'country' });
                cmpEvent.fire(); 
            }
            
            if(component.get('v.picklisttype') == 'source'){
                var cmpEvent = component.getEvent("cmpEventSingle");
                cmpEvent.setParams({ "singleselectvalue" : value });
                cmpEvent.setParams({ "picklisttype" : 'source' });
                cmpEvent.fire();  
            }
            
            if(component.get('v.picklisttype') == 'sector'){
                var cmpEvent = component.getEvent("cmpEventSingle");
                cmpEvent.setParams({ "singleselectvalue" : value });
                cmpEvent.setParams({ "picklisttype" : 'sector' });
                cmpEvent.fire();  
            }
            
            if(component.get('v.picklisttype') == 'subindustry'){
                var cmpEvent = component.getEvent("cmpEventSingle");
                cmpEvent.setParams({ "singleselectvalue" : value });
                cmpEvent.setParams({ "picklisttype" : 'subindustry' });
                cmpEvent.fire();  
            }                    
            
            if(component.get('v.picklisttype') == 'amount'){
                var cmpEvent = component.getEvent("cmpEventSingle");
                cmpEvent.setParams({ "singleselectvalue" : value });
                cmpEvent.setParams({ "picklisttype" : 'amount' });
                cmpEvent.fire();  
            }
            
            if(component.get('v.picklisttype') == 'product'){
                var cmpEvent = component.getEvent("cmpEventSingle");
                cmpEvent.setParams({ "singleselectvalue" : value });
                cmpEvent.setParams({ "picklisttype" : 'product' });
                cmpEvent.fire(); 
            }
        }
        
        component.set('v.values', values)
        component.set("v.options", options);
    },
    
    blurEventHelper : function(component, event) {
        var selectedValue = component.get('v.value');
        var multiSelect = component.get('v.multiSelect');
        var previousLabel;
        var count = 0;
        var options = component.get("v.options");
        options.forEach( function(element, index) {
            if(element.value === selectedValue) {
                previousLabel = element.label;
            }
            if(element.selected){
                count++;
            }
        });
        if(multiSelect)
            component.set('v.searchString', count + ' options selected');
        else
            component.set('v.searchString', previousLabel);
        
        if(multiSelect)
            $A.util.removeClass(component.find('resultsDiv'),'slds-is-open');
    },
    
    callKeyUpHelper : function(component, event, helper) {  
        //alert('test');  
        if ( event.keyCode == 13 )  {
            var selectedValue = component.get('v.value');
            alert(selectedValue);
            var multiSelect = component.get('v.multiSelect');
            var previousLabel;
            var count = 0;
            var options = component.get("v.options");
            options.forEach( function(element, index) {
                value = element.value;
                searchString = element.label;
                if(component.get('v.picklisttype') == 'country'){
                    var cmpEvent = component.getEvent("cmpEventSingle");
                    cmpEvent.setParams({ "singleselectvalue" : value });
                    cmpEvent.setParams({ "picklisttype" : 'country' });
                    cmpEvent.fire(); 
                }
            });
        }
    }
    
    
})