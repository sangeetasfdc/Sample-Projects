({
    
    // To prepopulate the seleted value pill if value attribute is filled
    doInit : function( component, event, helper ) {
        helper.doInitHelper(component);
        // Listen to enter events 
        window.addEventListener('keyup', function(event) {
            if (event.key === 'Enter') {
            }
        });
        
        var selectedval = component.get('v.selectedvalue');
        if(selectedval != null && selectedval != ''){
            component.set('v.searchString', selectedval);
        }
    },
    
    // When a keyword is entered in search box
    filterOptions : function( component, event, helper ) {
        
        try {
            if(!$A.util.isEmpty(component.get('v.searchString')) && !component.get('v.dontfilter')){
                helper.filterOptionsHelper(component);
            }else{
                $A.util.removeClass(component.find('resultsDiv'),'slds-is-open');
            }
        }
        catch(err) {
            console.log('error:'+err.message);
        }
        
    },
    
    // When an item is selected
    selectItem : function( component, event, helper ) {
        if(!$A.util.isEmpty(event.currentTarget.id)) {
            helper.selectItemHelper(component, event);
        }
    },
    
    showOptions : function( component, event, helper ) {
        var disabled = component.get("v.disabled");
        if(!disabled) {
            component.set("v.message", '');
            component.set('v.searchString', '');
            var options = component.get("v.options");
            options.forEach( function(element,index){
                element.isVisible = true;
            });
            component.set("v.options", options);
            if(!$A.util.isEmpty(component.get('v.options'))) {
                $A.util.toggleClass(component.find('resultsDiv'),'slds-is-open');
            } 
        }
    },
    
    // To remove the selected item.
    removePill : function( component, event, helper ){
        helper.removePillHelper(component, event);
    },
    
    // To close the dropdown if clicked outside the dropdown.
    blurEvent : function( component, event, helper ){
        helper.blurEventHelper(component, event);
    },
    
    callKeyUp : function( component, event, helper ) {
        if(!$A.util.isEmpty(event.currentTarget.id)) {
            helper.callKeyUpHelper(component, event);
        }
    },
    
    removeClass2 : function(cmp, event) {
        //alert('test');
        var params = event.getParam('arguments');
        if (params) {
            var param1 = params.close;
            if(param1){
                var closedrpdwn = cmp.find('resultsDiv');
                $A.util.removeClass(closedrpdwn,'slds-is-open');
            }
        }
    },
    
    setWidth : function(cmp, event) {
        var params = event.getParam('arguments');
        if (params) {
            var param1 = params.width;
            cmp.set("v.Swidth", param1);
        }
    }
    
})