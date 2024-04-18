({
    openQuestion : function(component, event, helper) {
        var ctarget = event.currentTarget;
        var id_str = ctarget.dataset.value;
        console.log(id_str);
        var cmpEvent = component.getEvent("summaryEventQuestion");
        cmpEvent.setParams({ "currentQuestionToEdit" : id_str });
        cmpEvent.fire(); 
    },
    
    submitbtn : function(component, event, helper){
        let button = component.find('submitbuttonid');
        var saveaction = component.get('c.submitApplication');
        var recid = component.get('v.appid');
        console.log('recid: '+recid);
        saveaction.setParams({
            'appid' : recid
        });
        saveaction.setCallback(this, function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            console.log('state'+state);
            if(state==='SUCCESS'){
                component.set('v.appSubmitted',true);
                button.set('v.disabled',true);          
            }else{
                var errors = saveaction.getError();
                if(errors) {
                    if(errors[0] && errors[0].message) {
                        console.log('error: ' +errors[0].message);  
                    }
                }
            }
        });
        $A.enqueueAction(saveaction);
    }
})