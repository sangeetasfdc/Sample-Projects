({
    doInit: function(component, event, helper) {
        
        helper.doinitHelper(component, event, helper);
        helper.addManualArRecord(component, event);
        
        /********** Listen to keyboard events ***********/
        window.addEventListener('keyup', function(event) {
            if (event.key === 'Enter') {
                helper.nextQuestionHelper(component,event,helper);
                helper.HandleNavigationButtonsHelper(component,event,helper);
            }
        });
    },
    
    
    // Display All Questions in Summary
    navigateToSummary : function(component,event,helper){
        component.set('v.showSummaryButton',false);
        helper.navigateToSummaryHelper(component,event,helper,'all');
    },
    
    
    //Display less Questions in Summary
    navigateToSummary2 : function(component,event,helper){
        helper.navigateToSummaryHelper(component,event,helper,'less');
        component.set('v.gotosummary',false);
    },
    
    displatQuestionToEdit : function(component,event,helper){
        helper.displatQuestionToEditHelper(component,event,helper);
    },
    
    handlelistofcustomersFiles : function(component,event,helper){
        component.set('v.spinner',true);
        helper.handlelistofcustomersFilesHelper(component,event,helper);
        //component.set('v.spinner',false);
    },
    
    handleUploadFinished : function(component,event,helper){
        
        helper.handleUploadFinishedHelper(component,event,helper);
    },
    
    HandleNavigationButtons : function(component,event,helper){
        helper.HandleNavigationButtonsHelper(component,event,helper);
    },
    
    previousQuestion : function(component,event,helper){
        helper.previousQuestionHelper(component,event,helper);
        helper.HandleNavigationButtonsHelper(component,event,helper);
    },
    
    nextQuestion : function(component,event,helper){
        helper.nextQuestionHelper(component,event,helper);
        helper.HandleNavigationButtonsHelper(component,event,helper);
    },
    
    downloadnda : function(component, event, helper) {
        var elementLink = document.createElement('a');
        elementLink.href = $A.get('$Resource.SampleMarcoTemplateExcel');
        elementLink.target = '_self';
        elementLink.download = 'Manual-A/R-report.csv';
        document.body.appendChild(elementLink);
        elementLink.click();
    },
    
    assignselectedvalues : function(component, event, helper) {
        helper.assignselectedvaluesHelper(component, event, helper);
    },
    
    addRow: function(component, event, helper) {
        helper.addManualArRecord(component, event);
    },
    
    addRowDebtors: function(component, event, helper) {
        helper.addManualArRecordaddRowDebtors(component, event);
    },
    
    exportToCsvDebtors : function(component, event, helper){
        var recordId=component.get('v.recordId');        
        var finalListToDownload=component.get("v.processedrecordList");
        var csv=helper.convertArrayOfObjectsToCSVInvoice(component,finalListToDownload); 
        console.log('csv:'+csv);
        if(csv==null){
            return ;
        }    
        var action1=component.get('c.UploadFileToApplAndUpdateInvoice');
        action1.setParams({
            'manualList': csv,
            'applicationId': recordId,
            'invoiceList': component.get("v.processedrecordList")
        });
        action1.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                let button = component.find('NextButton');
                button.set('v.disabled',false);
                var result=response.getReturnValue();
                var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success !",
                        "type" : "Success",
                        "message": "Invoices updated !"
                    });
                    toastEvent.fire();
            }else{
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                }                
            }
        });
        $A.enqueueAction(action1); 
    },
    
    exportToCsv :function(component, event, helper){
        var recordId=component.get('v.recordId');        
        var finalListToDownload=component.get("v.manualrecordList");
        var csv=helper.convertArrayOfObjectsToCSV(component,finalListToDownload); 
        console.log('csv:'+csv);
        if(csv==null){
            return ;
        }    
        var action1=component.get('c.UploadFileToAppl');
        action1.setParams({
            'manualList': csv,
            'applicationId': recordId
        });
        action1.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                let button = component.find('NextButton');
                button.set('v.disabled',false);
                var result=response.getReturnValue();
            }else{
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                }                
            }
        });
        $A.enqueueAction(action1); 
    },
    
    removeRowInvoice: function(component, event, helper) {
        var accountList = component.get("v.processedrecordList");
        var selectedItem = event.currentTarget;
        var index = selectedItem.dataset.record;
        accountList.splice(index, 1);
        component.set("v.processedrecordList", accountList);
    },
    
    removeRow: function(component, event, helper) {
        var accountList = component.get("v.manualrecordList");
        var selectedItem = event.currentTarget;
        var index = selectedItem.dataset.record;
        accountList.splice(index, 1);
        component.set("v.manualrecordList", accountList);
    }
})