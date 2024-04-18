({
    doinitHelper : function(component,event,helper){
        
        if(component.get('v.ApplicationPageWrapper.applicationSubmitted')){
            //alert('test');
            component.set('v.showSummaryButton',false);
        }
        var recordId=component.get('v.recordId');        
        var action=component.get('c.getwrapperdata');
        action.setParams({'recordId':recordId});
        action.setCallback(this, function(response){
            var state=response.getState(); 
            console.log('state: '+state);
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                console.log('application values' +JSON.stringify(result));
                component.set('v.ApplicationPageWrapper',result);
                console.log('current question: '+result.currentQuestion);
                if(result.currentQuestion != null && result.currentQuestion != '' && result.currentQuestion != 'undefined'){
                    component.set('v.displayedSection',result.currentQuestion);
                }else{
                    component.set('v.displayedSection','debtprovider');
                }
                //alert(component.get('v.displayedSection'));
                console.log('sector: '+result.Sector);
                console.log('sub industry: '+result.Sub_industry);
                console.log('product: '+result.Product);
                console.log('country: '+result.Country_of_Incorporation);
                
                let button = component.find('NextButton');
                if(result.Debt_Factor_PO_provider_in_place != null){
                    button.set('v.disabled',false);
                }else{
                    button.set('v.disabled',true);
                }
            }            
        });
        $A.enqueueAction(action);
        
        var action1=component.get('c.getDebtPicklist');
        action1.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                var industryMap1 = [];
                for(var key in result){
                    industryMap1.push({label: result[key], value: key});
                }
                component.set("v.debtproviderMap", industryMap1);
                console.log('debtproviderMap: ' +industryMap1);
            }
        });
        $A.enqueueAction(action1);        
        
        var action2=component.get('c.getCompanyPolicy');
        action2.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                var industryMap2 = [];
                for(var key in result){
                    industryMap2.push({label: result[key], value: key});
                }
                component.set("v.insuranceMap", industryMap2);
                console.log('insuranceMap: ' +industryMap2);            
            }
        });
        $A.enqueueAction(action2);
        
        var action3 = component.get('c.getSeasonalityToBusiness');
        action3.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                var industryMap3 = [];
                for(var key in result){
                    industryMap3.push({label: result[key], value: key});
                }
                component.set("v.businessseasonalityMap", industryMap3);
                console.log('businessseasonalityMap: ' +industryMap3);
            }
        });
        $A.enqueueAction(action3);
        
        var action4 = component.get("c.getRegions");
        action4.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.qualitychecksList", result);
            }
        });
        $A.enqueueAction(action4);
        
        var action6=component.get('c.getCompanyInstallmentProgress');
        action6.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                var industryMap6 = [];
                for(var key in result){
                    industryMap6.push({label: result[key], value: key});
                }
                component.set("v.progressbillingMap", industryMap6);
                console.log('progressbillingMap: ' +industryMap6);
            }
        });
        $A.enqueueAction(action6);
        
        var action7=component.get('c.getCompanyInstallmentProgress');
        action7.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                var industryMap7 = [];
                for(var key in result){
                    industryMap7.push({label: result[key], value: key});
                }
                component.set("v.installmentbillingMap", industryMap7);
                console.log('installmentbillingMap: ' +industryMap7);
            }
        });
        $A.enqueueAction(action7);
        
        var action5 = component.get("c.getAmount");
        action5.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                component.set("v.twelvemonthsalesList", result);
                console.log('twelvemonthsalesList: ' +result);
            }
        });
        $A.enqueueAction(action5);
        
        var action8=component.get('c.getDebtPro');
        action8.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                var industryMap7 = [];
                for(var key in result){
                    industryMap7.push({label: result[key], value: key});
                }
                component.set("v.pacaMap", industryMap7);
                console.log('pacaMap: ' +industryMap7);
            }
        });
        $A.enqueueAction(action8);
        
        var action9=component.get('c.getPurchaseOrder');
        action9.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                var industryMap7 = [];
                for(var key in result){
                    industryMap7.push({label: result[key], value: key});
                }
                component.set("v.cancellablepoMap", industryMap7);
                console.log('cancellablepoMap : ' +industryMap7);
            }
        });
        $A.enqueueAction(action9);  
        
        var action10=component.get('c.getAllowUsToPlug');
        action10.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                var industryMap9 = [];
                for(var key in result){
                    industryMap9.push({label: result[key], value: key});
                }
                component.set("v.allowaccountingMap", industryMap9);
                console.log('allowaccountingMap: ' +industryMap9);
            }
        });
        $A.enqueueAction(action10);
        
        var manualArAction = component.get('c.getManualArList');
        manualArAction.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                component.set("v.manualrecordList", result);
                console.log('manualrecordList: ' +result);
            }
        });
        $A.enqueueAction(manualArAction);
        
        var questions;
        
        questions = [{label:'Is there a Debt provider/ Factor / PO facility currently in place?',apiName:'Debt_Factor_PO_provider_in_place__c'},{label:'Does your company operate with trade insurance policy?',apiName:'Company_operate_w_trade_insur_policy__c'},{label:'Is there a seasonality to your business?',apiName:'Seasonality_To_The_Business__c'},{label:'Are there quality checks in place?*',apiName:'Quality_Checks_in_Place__c'},{label:'Does your company practice Progress Billings?',apiName:'Company_practice_Progress_Billings__c'},{label:'Does your company practice Installments Billings?',apiName:'Company_practice_Installments_Billings__c'},{label:'Sales Last 12 month (USD):',apiName:'Sales_Last_12_Months_USD__c'},{label:'Are you subject to PACA?',apiName:'Is_There_Debt_Pro__c'},{label:'Is your purchase order(PO) cancellable?',apiName:'Purchase_Order_PO_Cancellable__c'},{label:'Would you allow us to plug in your Quickbooks/Accounting platforms?',apiName:'Allow_Us_To_Plug_Into_Acctng_platform__c'}];
        
        var recordId=component.get('v.recordId');
        var questionsaction=component.get('c.applicationdata');
        questionsaction.setParams({'recordId':recordId});
        questionsaction.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                console.log(result);
                var result = questions.map(function(data, index){
                    var answer = result[data.apiName] ? result[data.apiName] : '';
                    data['answer'] = answer;
                    return data;
                });
                console.log(result);
                component.set('v.questionAnswer', result);
            }            
        });
        $A.enqueueAction(questionsaction);
        
        if(component.get('v.ApplicationPageWrapper.applicationSubmitted')){
            //component.set('v.displayedSection','summary');
        }
        
    },
    
    
    displatQuestionToEditHelper: function(component,event,helper){
        
        var apiName = event.getParam("currentQuestionToEdit");
        
        if(component.get('v.test')){
            component.set('v.gotosummary',true);
        }else{
            component.set('v.showSummaryButton',true);
        }
        
        if(apiName == 'Debt_Factor_PO_provider_in_place__c'){
            component.set('v.displayedSection','debtprovider');
            
        }else if(apiName == 'Company_operate_w_trade_insur_policy__c'){
            component.set('v.displayedSection','insurance');
            
        }else if(apiName == 'Seasonality_To_The_Business__c'){
            component.set('v.displayedSection','businessseasonality');
            
        }else if(apiName == 'Quality_Checks_in_Place__c'){
            component.set('v.displayedSection','qualitychecks');
            
        }else if(apiName == 'Company_practice_Progress_Billings__c'){
            component.set('v.displayedSection','progressbilling');
            
        }else if(apiName == 'Company_practice_Installments_Billings__c'){
            component.set('v.displayedSection','installmentbilling');
            
        }else if(apiName == 'Sales_Last_12_Months_USD__c'){
            component.set('v.displayedSection','twelvemonthsale');
            
        }else if(apiName == 'Is_There_Debt_Pro__c'){
            component.set('v.displayedSection','subjecttopaca');
            
        }else if(apiName == 'Purchase_Order_PO_Cancellable__c'){
            component.set('v.displayedSection','cancellablePO');
            
        }else if(apiName == 'Allow_Us_To_Plug_Into_Acctng_platform__c'){
            component.set('v.displayedSection','allowaccounting');
            
        }else if(apiName == 'Debt_Factor_PO_provider_in_place__c'){
            
        }
    },
    
    navigateToSummaryHelper : function(component,event,helper,noOfQuestion){
        
        if(noOfQuestion == 'all'){
            var questions = [{label:'Is there a Debt provider/ Factor / PO facility currently in place?',apiName:'Debt_Factor_PO_provider_in_place__c'},{label:'Does your company operate with trade insurance policy?',apiName:'Company_operate_w_trade_insur_policy__c'},{label:'Is there a seasonality to your business?',apiName:'Seasonality_To_The_Business__c'},{label:'Are there quality checks in place?*',apiName:'Quality_Checks_in_Place__c'},{label:'Does your company practice Progress Billings?',apiName:'Company_practice_Progress_Billings__c'},{label:'Does your company practice Installments Billings?',apiName:'Company_practice_Installments_Billings__c'},{label:'Sales Last 12 month (USD):',apiName:'Sales_Last_12_Months_USD__c'},{label:'Are you subject to PACA?',apiName:'Is_There_Debt_Pro__c'},{label:'Is your purchase order(PO) cancellable?',apiName:'Purchase_Order_PO_Cancellable__c'},{label:'Would you allow us to plug in your Quickbooks/Accounting platforms?',apiName:'Allow_Us_To_Plug_Into_Acctng_platform__c'}];
        }else{
            var questions = [{label:'Is there a Debt provider/ Factor / PO facility currently in place?',apiName:'Debt_Factor_PO_provider_in_place__c'},{label:'Does your company operate with trade insurance policy?',apiName:'Company_operate_w_trade_insur_policy__c'},{label:'Is there a seasonality to your business?',apiName:'Seasonality_To_The_Business__c'},{label:'Are there quality checks in place?*',apiName:'Quality_Checks_in_Place__c'},{label:'Does your company practice Progress Billings?',apiName:'Company_practice_Progress_Billings__c'},{label:'Does your company practice Installments Billings?',apiName:'Company_practice_Installments_Billings__c'},{label:'Sales Last 12 month (USD):',apiName:'Sales_Last_12_Months_USD__c'}];
        }
        
        var appdata = component.get('v.ApplicationPageWrapper');
        var saveaction = component.get('c.updatewrapper');
        console.log('obj: '+appdata);
        saveaction.setParams({
            'wrapperobj':JSON.stringify(appdata),
            'savedata' : component.set('v.displayedSection')
        });
        
        saveaction.setCallback(this, function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state==='SUCCESS'){
                
                var result=response.getReturnValue();
                console.log(result);
                var result = questions.map(function(data, index){
                    var answer = result[data.apiName] ? result[data.apiName] : '';
                    data['answer'] = answer;
                    return data;
                });
                console.log(result);
                component.set('v.questionAnswer', result);
                component.set('v.showSummaryButton', false);
                component.set('v.displayedSection','summary');
                console.log('result: ' +result);            
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
        component.set('v.displayedSection','summary');
    },
    
    
    handlelistofcustomersFilesHelper : function(component,event,helper) {
        var uploadedFiles = event.getParam("files");  
        var docids=[];
        for(var i=0;i<uploadedFiles.length;i++){
            docids.push(uploadedFiles[i].documentId);
        }
        
        var recid = component.get('v.recordId');
        var documentIds = uploadedFiles[0].documentId;  
        var fileName = uploadedFiles[0].name;  
        
        var action=component.get('c.sendDataToAws');
        action.setParams({'documentId':docids,
                          'appId':recid
                         });
        action.setCallback(this, function(response){
            var state=response.getState();
            console.log('state: '+state);
            if(state==='SUCCESS'){
                let button = component.find('NextButton');
                button.set('v.disabled',false);
                var result=response.getReturnValue();   
                console.log('res: '+result.invoice_number);
                component.set('v.showProcessedList',true);
                component.set('v.processedrecordList',result);
            }
            component.set('v.spinner',false);
        });
        $A.enqueueAction(action);
        
    },
    
    convertArrayOfObjectsToCSVInvoice : function(component,objRecords) {
        var csvStringResult,counter,keys,lineDivider,columnDivider;
        if(objRecords==null || !objRecords.length){
            return null;         
        }
        columnDivider=',';
        lineDivider='\n';
        keys=['Name','issue_date__c','invoice_currency__c','invoice_total__c','issuer__c'];
        csvStringResult='';
        csvStringResult+=keys.join(columnDivider);
        csvStringResult+=lineDivider;
        for(var i=0;i<objRecords.length;i++){
            counter=0;
            for(var tempKey in keys){
                var skey=keys[tempKey];
                if(objRecords[i][skey] != null && objRecords[i][skey] != '' && objRecords[i][skey] != 'undefined'){
                    if(counter>0){
                        csvStringResult+=columnDivider;
                    }
                    csvStringResult+='"'+objRecords[i][skey]+'"';
                    counter ++;
                }else{
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Warning !",
                        "type" : "Warning",
                        "message": "Incomplete data !"
                    });
                    toastEvent.fire();
                    return null;
                }
            }
            csvStringResult+=lineDivider;
            console.log('csvStringResult: '+csvStringResult);
        }
        return csvStringResult
    },
    
    
    convertArrayOfObjectsToCSV : function(component,objRecords) {
        var csvStringResult,counter,keys,lineDivider,columnDivider;
        if(objRecords==null || !objRecords.length){
            return null;         
        }
        columnDivider=',';
        lineDivider='\n';
        keys=['customer','Total_Ar','Ar0_30','Ar30_60','Ar60_90','Ar90_120','Ar120_Plus'];
        csvStringResult='';
        csvStringResult+=keys.join(columnDivider);
        csvStringResult+=lineDivider;
        for(var i=0;i<objRecords.length;i++){
            counter=0;
            for(var tempKey in keys){
                var skey=keys[tempKey];
                if(objRecords[i][skey] != null && objRecords[i][skey] != '' && objRecords[i][skey] != 'undefined'){
                    if(counter>0){
                        csvStringResult+=columnDivider;
                    }
                    csvStringResult+='"'+objRecords[i][skey]+'"';
                    counter ++;
                }else{
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Warning !",
                        "type" : "Warning",
                        "message": "Incomplete data !"
                    });
                    toastEvent.fire();
                    return null;
                }
            }
            csvStringResult+=lineDivider;
            console.log('csvStringResult: '+csvStringResult);
        }
        return csvStringResult
    },
    
    
    addManualArRecordaddRowDebtors : function(component, event) {
        var recList = component.get("v.processedrecordList");
        var action=component.get('c.getManualArInvoice');
        action.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                recList.push(result);
                component.set("v.processedrecordList", recList);
                //document.getElementById(component.get("v.processedrecordList").length - 1).focus();
                console.log('rec list: '+component.get("v.processedrecordList"));
            }else{
                
            }
        });
        $A.enqueueAction(action); 
    },
    
    
    addManualArRecord: function(component, event) {
        var recList = component.get("v.manualrecordList");
        var action=component.get('c.getManualAr');
        action.setCallback(this, function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var result=response.getReturnValue();
                recList.push(result);
                component.set("v.manualrecordList", recList);
                console.log('rec list: '+component.get("v.manualrecordList")[0].customerName);
            }else{
                
            }
        });
        $A.enqueueAction(action);  
    },
    
    
    HandleNavigationButtonsHelper : function(component,event,helper){
        
        var currentQuestion = component.get('v.displayedSection');
        let button = component.find('NextButton');
        var applicationRec = component.get('v.ApplicationPageWrapper');
        if(currentQuestion == 'debtprovider'){
            var debt = component.get('v.ApplicationPageWrapper.Debt_Factor_PO_provider_in_place');
            if(debt != null  && debt != ''){
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
            
        }else if(currentQuestion == 'insurance'){
            var debt = component.get('v.ApplicationPageWrapper.Company_operate_w_trade_insur_policy');
            if(debt != null  && debt != ''){
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
            
        }else if(currentQuestion == 'insurancename'){
            var debt = document.getElementById('insuranceNameId').value
            if(debt != null && debt != '' && debt != 'undefined'){
                component.set('v.ApplicationPageWrapper.Name_of_Insurance_Provider',debt);                
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
            
        }else if(currentQuestion == 'businessseasonality'){
            var debt = component.get('v.ApplicationPageWrapper.Seasonality_To_The_Business');
            if(debt != null  && debt != ''){
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
            
        }else if(currentQuestion == 'qualitychecks'){
            var debt = component.get('v.ApplicationPageWrapper.Quality_Checks_in_Place');
            if(debt != null  && debt != ''){
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
            
        }else if(currentQuestion == 'progressbilling'){
            var debt = component.get('v.ApplicationPageWrapper.Company_practice_Progress_Billings');
            if(debt != null  && debt != ''){
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
            
        }else if(currentQuestion == 'installmentbilling'){
            var debt = component.get('v.ApplicationPageWrapper.Company_practice_Installments_Billings');
            if(debt != null && debt != ''){
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
            
        }else if(currentQuestion == 'twelvemonthsale'){
            var debt = component.get('v.ApplicationPageWrapper.Sales_Last_12_Months_USD');
            if(debt != null && debt != ''){
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
            
        }else if(currentQuestion == 'subjecttopaca'){
            var debt = component.get('v.ApplicationPageWrapper.Is_There_Debt_Pro');
            if(debt != null && debt != ''){
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
            
        }else if(currentQuestion == 'cancellablePO'){
            var debt = component.get('v.ApplicationPageWrapper.Purchase_Order_PO_Cancellable');
            if(debt != null && debt != ''){
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
            
        }else if(currentQuestion == 'allowaccounting'){
            var debt = component.get('v.ApplicationPageWrapper.Allow_Us_To_Plug_Into_Acctng_platform');
            if(debt != null && debt != ''){
                button.set('v.disabled',false);
            }else{
                button.set('v.disabled',true);
            }
        }
    },
    
    
    nextQuestionHelper : function(component,event,helper){
        
        var apprec = component.get('v.ApplicationPageWrapper');
        var currentQuestion = component.get('v.displayedSection');
        let button = component.find('NextButton');
        
        if(currentQuestion == 'debtprovider'){
            var valuevar = component.get('v.ApplicationPageWrapper.Debt_Factor_PO_provider_in_place');
            if(valuevar != null && valuevar != '' && valuevar != 'undefined'){
                this.savedata(component,event,helper);
                component.set('v.displayedSection','insurance');
            }
            
        }else if(currentQuestion == 'insurance'){
            
            var insure = component.get('v.ApplicationPageWrapper.Company_operate_w_trade_insur_policy');
            
            if(insure != null && insure != ''){
                
                var debt = document.getElementById('insuranceNameId').value;
                console.log('testing: '+debt);
                if(debt != null && debt != ''){
                    button.set('v.disabled',false);
                }else{
                    button.set('v.disabled',true);
                }
                
                if(insure == 'Yes'){
                    this.savedata(component,event,helper);
                    component.set('v.displayedSection','insurancename');
                }else{
                    this.savedata(component,event,helper);
                    component.set('v.displayedSection','businessseasonality');
                }
            }
            
        }else if(currentQuestion == 'insurancename'){
            var valuevar = component.get('v.ApplicationPageWrapper.Name_of_Insurance_Provider');
            if(valuevar != null && valuevar != '' && valuevar != 'undefined'){
                this.savedata(component,event,helper);
                component.set('v.displayedSection','businessseasonality');
            }
            
        }else if(currentQuestion == 'businessseasonality'){
            var valuevar = component.get('v.ApplicationPageWrapper.Seasonality_To_The_Business');
            if(valuevar != null && valuevar != '' && valuevar != 'undefined'){
                this.savedata(component,event,helper);
                component.set('v.displayedSection','qualitychecks');
            }
            
        }else if(currentQuestion == 'qualitychecks'){
            var valuevar = component.get('v.ApplicationPageWrapper.Quality_Checks_in_Place');
            if(valuevar != null && valuevar != '' && valuevar != 'undefined'){
                this.savedata(component,event,helper);
                component.set('v.displayedSection','progressbilling');
            }
            
        }else if(currentQuestion == 'progressbilling'){
            var valuevar = component.get('v.ApplicationPageWrapper.Company_practice_Progress_Billings');
            if(valuevar != null && valuevar != '' && valuevar != 'undefined'){
                this.savedata(component,event,helper);
                component.set('v.displayedSection','installmentbilling');
            }
            
        }else if(currentQuestion == 'installmentbilling'){
            var valuevar = component.get('v.ApplicationPageWrapper.Company_practice_Installments_Billings');
            if(valuevar != null && valuevar != '' && valuevar != 'undefined'){
                this.savedata(component,event,helper);
                component.set('v.displayedSection','twelvemonthsale');
            }
            
        }else if(currentQuestion == 'twelvemonthsale'){
            var showpaca = false;
            console.log('sector: '+apprec.Sector);
            console.log('sub industry: '+apprec.Sub_industry);
            console.log('product: '+apprec.Product);
            console.log('country: '+apprec.Country_of_Incorporation);
            
            var valuevar = component.get('v.ApplicationPageWrapper.Sales_Last_12_Months_USD');
            if(valuevar != null && valuevar != '' && valuevar != 'undefined'){
                
                if(apprec.Country_of_Incorporation == 'United States'){
                    if(apprec.Sector == 'Agriculture, Forestry, Fishing, Hunting'){
                        if(apprec.Sub_industry == 'Fruit and Tree Nut Farming' || apprec.Sub_industry == 'Vegetable and Melon Farming'){
                            showpaca = true;
                        }
                    }else if(apprec.Sector == 'Manufacturing'){
                        if(apprec.Sub_industry == 'Fruit and Vegetable Preserving and Specialty Food Manufacturing'){
                            showpaca = true;
                        }
                    }else if(apprec.Sector == 'Wholesale Trade'){
                        if(apprec.Sub_industry == 'Farm Product Raw Material Merchant Wholesalers' || apprec.Sub_industry == 'Grocery and Related Product Merchant Wholesalers'){
                            showpaca = true;
                        }
                    }else if(apprec.Sector == 'Retail Trade'){
                        if(apprec.Sub_industry == 'Grocery Stores' || apprec.Sub_industry == 'Specialty Food Stores'){
                            showpaca = true;
                        }
                    }
                }
                
                if(showpaca){
                    this.savedata(component,event,helper);
                    component.set('v.displayedSection','subjecttopaca');
                    component.set('v.showpaca',true);
                }else{
                    if(apprec.Product == 'Factoring' || apprec.Product == 'Factoring & PO'){
                        this.savedata(component,event,helper);
                        if(apprec.Product == 'Factoring & PO'){
                            component.set('v.displayedSection','cancellablePO');
                        }else{
                            component.set('v.displayedSection','allowaccounting');
                        }
                    }else{
                        var appdata = component.get('v.ApplicationPageWrapper');
                        var saveaction = component.get('c.updatewrapper');
                        console.log('obj: '+appdata);
                        saveaction.setParams({
                            'wrapperobj':JSON.stringify(appdata),
                            'savedata' : 'thankyoumessage'
                        });
                        
                        saveaction.setCallback(this, function(response){
                            var state=response.getState();
                            var result=response.getReturnValue();
                            if(state==='SUCCESS'){
                                
                                var result=response.getReturnValue();
                                console.log(result);
                                console.log(result);
                                component.set('v.questionAnswer', result);
                                //component.set('v.displayedSection','summary');
                                console.log('result: ' +result);  
                                component.set('v.displayedSection','thankyoumessage');
                                component.set('v.gotosummary',true);
                                component.set('v.test',true);
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
                }
            }
            
        }else if(currentQuestion == 'subjecttopaca'){
            
            var valuevar = component.get('v.ApplicationPageWrapper.Is_There_Debt_Pro');
            if(valuevar != null && valuevar != '' && valuevar != 'undefined'){
                if(apprec.Product == 'Factoring' || apprec.Product == 'Factoring & PO'){
                    this.savedata(component,event,helper);
                    if(apprec.Product == 'Factoring & PO'){
                        component.set('v.displayedSection','cancellablePO');
                    }else{
                        component.set('v.displayedSection','allowaccounting');
                    }
                }else{
                    var appdata = component.get('v.ApplicationPageWrapper');
                    var saveaction = component.get('c.updatewrapper');
                    console.log('obj: '+appdata);
                    saveaction.setParams({
                        'wrapperobj':JSON.stringify(appdata),
                        'savedata' : component.get('v.displayedSection')
                    });
                    
                    saveaction.setCallback(this, function(response){
                        var state=response.getState();
                        var result=response.getReturnValue();
                        if(state==='SUCCESS'){
                            
                            var result=response.getReturnValue();
                            console.log(result);
                            /*var result = questions.map(function(data, index){
                                var answer = result[data.apiName] ? result[data.apiName] : '';
                                data['answer'] = answer;
                                return data;
                            });*/
                            console.log(result);
                            component.set('v.questionAnswer', result);
                            component.set('v.displayedSection','summary');
                            console.log('result: ' +result);   
                            component.set('v.gotosummary',true);
                            component.set('v.showSummaryButton',true);
                            
                            component.set('v.test',true);
                            component.set('v.displayedSection','thankyoumessage');
                            
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
            }
            
        }else if(currentQuestion == 'thankyoumessage'){
            
            
        }else if(currentQuestion == 'cancellablePO'){
            var valuevar = component.get('v.ApplicationPageWrapper.Purchase_Order_PO_Cancellable');
            if(valuevar != null && valuevar != '' && valuevar != 'undefined'){
                this.savedata(component,event,helper);
                component.set('v.displayedSection','allowaccounting');
            }
            
        }else if(currentQuestion == 'allowaccounting'){
            var valuevar = component.get('v.ApplicationPageWrapper.Allow_Us_To_Plug_Into_Acctng_platform');
            if(valuevar != null && valuevar != '' && valuevar != 'undefined'){
                if(apprec.Allow_Us_To_Plug_Into_Acctng_platform == 'Yes'){
                    this.savedata(component,event,helper);
                    component.set('v.displayedSection','downloadnda');
                }else{
                    this.savedata(component,event,helper);
                    component.set('v.displayedSection','listofcustomers');
                }
            }
            
        }else if(currentQuestion == 'downloadnda'){
            this.savedata(component,event,helper);
            component.set('v.displayedSection','ageingreport');
            
        }else if(currentQuestion == 'listofcustomers'){
            this.savedata(component,event,helper);
            component.set('v.displayedSection','ageingreport');
            
        }else if(currentQuestion == 'ageingreport'){
            var selectedAgeing = component.get('v.ageingreportValue');
            console.log('selectedAgeing: '+selectedAgeing);
            if(selectedAgeing == 'Utilize Scanning Tool'){
                component.set('v.displayedSection','scanningtool');
            }else if(selectedAgeing == 'Upload marco Template'){
                component.set('v.displayedSection','macrotemplate');
            }else if(selectedAgeing == 'Manually'){
                button.set('v.disabled',false);
                component.set('v.displayedSection','manually');
            }
            
        }else if(currentQuestion == 'scanningtool' || currentQuestion == 'macrotemplate' || currentQuestion == 'manually'){
            this.savedataandGotoSummary(component,event,helper,'full');
            component.set('v.displayedSection','summary');
            component.set('v.showSummaryButton',false);
        }
    },
    
    
    savedataandGotoSummary : function(component,event,helper,type){
        //alert('save data');
        var questions;
        if(type == 'full'){
            var questions = [{label:'Is there a Debt provider/ Factor / PO facility currently in place?',apiName:'Debt_Factor_PO_provider_in_place__c'},{label:'Does your company operate with trade insurance policy?',apiName:'Company_operate_w_trade_insur_policy__c'},{label:'Is there a seasonality to your business?',apiName:'Seasonality_To_The_Business__c'},{label:'Are there quality checks in place?*',apiName:'Quality_Checks_in_Place__c'},{label:'Does your company practice Progress Billings?',apiName:'Company_practice_Progress_Billings__c'},{label:'Does your company practice Installments Billings?',apiName:'Company_practice_Installments_Billings__c'},{label:'Sales Last 12 month (USD):',apiName:'Sales_Last_12_Months_USD__c'},{label:'Are you subject to PACA?',apiName:'Is_There_Debt_Pro__c'},{label:'Is your purchase order(PO) cancellable?',apiName:'Purchase_Order_PO_Cancellable__c'},{label:'Would you allow us to plug in your Quickbooks/Accounting platforms?',apiName:'Allow_Us_To_Plug_Into_Acctng_platform__c'}];
        }else{
            var questions = [{label:'Is there a Debt provider/ Factor / PO facility currently in place?',apiName:'Debt_Factor_PO_provider_in_place__c'},{label:'Does your company operate with trade insurance policy?',apiName:'Company_operate_w_trade_insur_policy__c'},{label:'Is there a seasonality to your business?',apiName:'Seasonality_To_The_Business__c'},{label:'Are there quality checks in place?*',apiName:'Quality_Checks_in_Place__c'},{label:'Does your company practice Progress Billings?',apiName:'Company_practice_Progress_Billings__c'},{label:'Does your company practice Installments Billings?',apiName:'Company_practice_Installments_Billings__c'},{label:'Sales Last 12 month (USD):',apiName:'Sales_Last_12_Months_USD__c'}];
        }
        var appdata = component.get('v.ApplicationPageWrapper');
        var saveaction = component.get('c.updatewrapper');
        console.log('obj: '+appdata);
        saveaction.setParams({
            'wrapperobj':JSON.stringify(appdata),
            'savedata' : component.get('v.displayedSection')
        });
        
        saveaction.setCallback(this, function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state==='SUCCESS'){
                
                var result=response.getReturnValue();
                console.log(result);
                var result = questions.map(function(data, index){
                    var answer = result[data.apiName] ? result[data.apiName] : '';
                    data['answer'] = answer;
                    return data;
                });
                console.log(result);
                component.set('v.questionAnswer', result);
                component.set('v.displayedSection','summary');
                console.log('result: ' +result);            
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
    },
    
    
    previousQuestionHelper : function(component,event,helper){
        
        var apprec = component.get('v.ApplicationPageWrapper');
        var currentQuestion = component.get('v.displayedSection');
        if(currentQuestion == 'insurance'){
            component.set('v.displayedSection','debtprovider');
            
        }else if(currentQuestion == 'insurancename'){
            component.set('v.displayedSection','insurance');
            
        }else if(currentQuestion == 'businessseasonality'){
            var insure = component.get('v.ApplicationPageWrapper.Company_operate_w_trade_insur_policy');
            if(insure != null && insure == 'Yes'){
                component.set('v.displayedSection','insurancename');
            }else{
                component.set('v.displayedSection','insurance');
            }
            
        }else if(currentQuestion == 'qualitychecks'){
            component.set('v.displayedSection','businessseasonality');
            
        }else if(currentQuestion == 'progressbilling'){
            component.set('v.displayedSection','qualitychecks');
            
        }else if(currentQuestion == 'installmentbilling'){
            component.set('v.displayedSection','progressbilling');
            
        }else if(currentQuestion == 'twelvemonthsale'){
            component.set('v.displayedSection','installmentbilling');
            
        }else if(currentQuestion == 'subjecttopaca'){
            component.set('v.displayedSection','twelvemonthsale');
            
        }else if(currentQuestion == 'cancellablePO'){
            if(component.get('v.showpaca')){
                component.set('v.displayedSection','subjecttopaca');
            }else{
                component.set('v.displayedSection','twelvemonthsale');
            }
            
        }else if(currentQuestion == 'allowaccounting'){
            component.set('v.displayedSection','cancellablePO');
            
        }else if(currentQuestion == 'downloadnda'){
            component.set('v.displayedSection','allowaccounting');         
            
        }else if(currentQuestion == 'listofcustomers'){
            component.set('v.displayedSection','allowaccounting');
            
        }else if(currentQuestion == 'ageingreport'){
            if(apprec.Allow_Us_To_Plug_Into_Acctng_platform == 'Yes'){
                let button = component.find('NextButton');
                component.set('v.displayedSection','downloadnda');
            }else{
                let button = component.find('NextButton');
                button.set('v.disabled',false);
                component.set('v.displayedSection','listofcustomers');
            }
            
        }else if(currentQuestion == 'scanningtool' || currentQuestion == 'macrotemplate' || currentQuestion == 'manually'){
            component.set('v.displayedSection','ageingreport');
        }
    },
    
    
    assignselectedvaluesHelper : function(component,event,helper){
        
        if(event.getParam("picklisttype") == 'qualitychecks'){
            if(event.getParam("singleselectvalue") != 'undefined' && event.getParam("singleselectvalue") != null){
                component.set('v.ApplicationPageWrapper.Quality_Checks_in_Place',event.getParam("singleselectvalue"));
                console.log('country:'+component.get('v.ApplicationPageWrapper.Quality_Checks_in_Place'));
                let button = component.find('NextButton');
                button.set('v.disabled',false);
            }
        }
        
        if(event.getParam("picklisttype") == 'salesamount'){
            if(event.getParam("singleselectvalue") != 'undefined' && event.getParam("singleselectvalue") != null){
                component.set('v.ApplicationPageWrapper.Sales_Last_12_Months_USD',event.getParam("singleselectvalue"));
                console.log('sales:'+component.get('v.ApplicationPageWrapper.Sales_Last_12_Months_USD'));
                let button = component.find('NextButton');
                button.set('v.disabled',false);
            }
        }
        
        if(event.getParam("picklisttype") == 'ageingreport'){
            if(event.getParam("singleselectvalue") != 'undefined' && event.getParam("singleselectvalue") != null){
                component.set('v.ageingreportValue',event.getParam("singleselectvalue"));
                console.log('ageing report: '+component.get('v.ageingreportValue'));
            }
        }
    },
    
    savedata : function(component,event,helper){
        var appdata = component.get('v.ApplicationPageWrapper');
        var saveaction = component.get('c.updatewrapper');
        console.log('obj: '+appdata);
        //alert(component.get('v.displayedSection'));
        saveaction.setParams({
            'wrapperobj':JSON.stringify(appdata),
            'savedata' : component.get('v.displayedSection')
        });
        
        saveaction.setCallback(this, function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state==='SUCCESS'){
                
                var result=response.getReturnValue();
                console.log(result);
                
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
    },
    
    handleUploadFinishedHelper : function(component,event,helper){
        var saveaction = component.get('c.updateTimestamp');
        var rid = component.get('v.recordId');
        console.log('test:'+rid);
        saveaction.setParams({'appid':rid});
        
        saveaction.setCallback(this, function(response){
            var state=response.getState();
            var result=response.getReturnValue();
            if(state==='SUCCESS'){
                var uploadedFiles = event.getParam("files");
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "type" : "success",
                    "message": uploadedFiles.length+" files have been uploaded successfully!"
                });
                toastEvent.fire();
                console.log(result);
                
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