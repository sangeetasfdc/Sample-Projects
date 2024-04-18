global with sharing class ExecuteSummaryClass implements omnistudio.VlocityOpenInterface {
    
    global boolean invokeMethod(String methodName,Map<String,Object> input, Map<String,Object> output,Map<String,Object> options){
        Boolean result=true;
        try{
            if(methodName.equalsIgnoreCase('getLead')){
                getLead(input,output,options);
            }else{
                output.put('result','');
            }
            
        }catch(Exception e){
            return false;
        }
        return result;
    }
    
    public void getLead(Map<String,Object> input, Map<String,Object> output,Map<String,Object> options){

        String leadIdval=(String)input.get('LeadId');
        System.debug('leadId' +leadIdval);
        List<Lead> leadlist = new List<Lead>();
        //leadlist = [select id,currentTime__c,RecordType.Name,Calc_property_Rental_Income__c from lead where id=:leadIdval and RecordType.Name='Truly Lead Record'];
        leadlist=[SELECT Id,currentTime__c,Calc_property_Rental_Income__c,Calc_Number_of_Units__c,Calc_Credit_Event__c,Calc_Properties_listed_for_Sale__c,Est_FICO_Score__c,Calc_Broker_Compensation_Amount__c,Calc_Referral_Compensation_Amount__c,Calc_Refinance_Type__c, Calc_Occupancy__c, Calc_Rental_Duration__c, Calc_Property_Type__c, Calc_Loan_Purpose__c, Calc_Loan_Program__c, Calc_Channel__c, Calc_Annual_Insurance__c, Calc_Annual_Tax__c, Calc_CurrentOccupancy__c, Calc_12_Month_Actual_Rent_Verification__c, Calc_Declining_Market__c, Calc_Est_Monthly_Market_Rent__c, Calc_Total_Experience__c, Calc_New_Construction_Experience__c, Target_Sales_Price_ARV__c, Calc_Purchase_Concession__c, Calc_Purchase_allowable_fees__c, Calc_Property_Type_Eligibility__c, Calc_Other_Holdback_Amount__c, Calc_Taxes__c, Calc_Monthly_Rent__c, Calc_Liens__c, Calc_Insurance__c, Calc_HOA__c, Calc_Est_Property_Value__c, Calc_Completed_Improvements__c, Calc_Purchase_Price__c, Saved_OS__c, Calc__c, Calc_Prepayment_Penalty_Term__c, Calc_Requested_Loan_Amount__c, Calc_Multifamily_Mixed_Use_DSCR__c, Calc_Cost_of_Future_Improvements__c, Calc_Previously_Completed_Improvements__c, Calc_Estimated_land_Value__c, LeadID18__c, Calc_Acquisition_Date__c, New_Construction_Experience__c, Total_Experience__c, Citizenship_Status__c FROM Lead where Id =: leadIdval];
        system.debug('leadlist values' +leadlist);
        List<Object> l =new List<Object>();
        Map<String,Object> m = new Map<String,Object>();
        // m.put('fieldId','field@occupancy-type');
        
        Map<String,Object> m1 = new Map<String,Object>();
        
        //rental income map starts
        
        Map<String,Object> compensation= new Map<String,Object>();
        Map<String,Object> compensationvalues = new Map<String,Object>();
        
        //referral-compensation-amount map
        
        Map<String,Object> rental = new Map<String,Object>();
        Map<String,Object> rentalvalues = new Map<String,Object>();
        
        
        //guarantor type map
        
        Map<String,Object> gt= new Map<String,Object>();
        Map<String,Object> gtvalues = new Map<String,Object>();
        
        //previously-completed-improvements map
        
        // Map<String,Object> pci= new Map<String,Object>();
        // Map<String,Object> pcivalues = new Map<String,Object>();
        
        //purchase-price map
        
        Map<String,Object> pp= new Map<String,Object>();
        Map<String,Object> ppvalues = new Map<String,Object>();
        
        //12-months-actual-rent-verification map
        
        Map<String,Object> arv= new Map<String,Object>();
        Map<String,Object> arvvalues = new Map<String,Object>();
        
        //refinance-type map
        
        Map<String,Object> rt= new Map<String,Object>();
        Map<String,Object> rtvalues = new Map<String,Object>();
        
        //loan-purpose map
        
        Map<String,Object> lp= new Map<String,Object>();
        Map<String,Object> lpvalues = new Map<String,Object>();
        
        //decision-credit-score json map
        
        Map<String,Object> dc= new Map<String,Object>();
        Map<String,Object> dcvalues = new Map<String,Object>();
        
        //properties-listed-for-sale-in-last-12-months json map
        
        Map<String,Object> plf= new Map<String,Object>();
        Map<String,Object> plfvalues = new Map<String,Object>();
        
        //state map
        
        Map<String,Object> state = new Map<String,Object>();
        Map<String,Object> statevalues = new Map<String,Object>();
        
        //credit event map
        
        Map<String,Object> credevnt= new Map<String,Object>();
        Map<String,Object> credevntvalues = new Map<String,Object>();
        
        //property-type map
        
        Map<String,Object> pt= new Map<String,Object>();
        Map<String,Object> ptvalues = new Map<String,Object>();
        
        //loan-program map
        
        Map<String,Object> loanprog= new Map<String,Object>();
        Map<String,Object> loanprogvalues = new Map<String,Object>();
        
        //heavy-rehab-experience map
        
        Map<String,Object> hre= new Map<String,Object>();
        Map<String,Object> hrevalues = new Map<String,Object>();
        
        //deed-in-lieu map
        
        Map<String,Object> dil= new Map<String,Object>();
        Map<String,Object> dilvalues = new Map<String,Object>();
        
        //county map
        
        Map<String,Object> county= new Map<String,Object>();
        Map<String,Object> countyvalues = new Map<String,Object>();
        
        //annual-taxes map
        
        Map<String,Object> annualtax= new Map<String,Object>();
        Map<String,Object> annualtaxvalues = new Map<String,Object>();
        
        //annual-hoa map
        
        Map<String,Object> annualhoa= new Map<String,Object>();
        Map<String,Object> annualhoavalues = new Map<String,Object>();
        
        //annual insurance map
        
        Map<String,Object> annualinsurance= new Map<String,Object>();
        Map<String,Object> annualinsurancevalues = new Map<String,Object>();
        
        //current-occupancy map
        
        Map<String,Object> currentoccup= new Map<String,Object>();
        Map<String,Object> currentoccupvalues = new Map<String,Object>();
        
        //acquisition-date map
        
        Map<String,Object> acq= new Map<String,Object>();
        Map<String,Object> acqvalues = new Map<String,Object>();
        
        //prepayment-penalty-term map
        
        Map<String,Object> ppt= new Map<String,Object>();
        Map<String,Object> pptvalues = new Map<String,Object>();
        
        //declining-markets map
        
        Map<String,Object> dm= new Map<String,Object>();
        Map<String,Object> dmvalues = new Map<String,Object>();
        
        //rental duration map
        
        Map<String,Object> rd= new Map<String,Object>();
        Map<String,Object> rdvalues = new Map<String,Object>();
        
        
        //number-of-units map
        
        Map<String,Object> nou= new Map<String,Object>();
        Map<String,Object> nouvalues = new Map<String,Object>();
        
        //appraised-value map
        
        Map<String,Object> apv= new Map<String,Object>();
        Map<String,Object> apvvalues = new Map<String,Object>();
        
        //total experience map
        
        Map<String,Object> te= new Map<String,Object>();
        Map<String,Object> tevalues = new Map<String,Object>();
        
        //foreclosure map
        
        Map<String,Object> foreclosure= new Map<String,Object>();
        Map<String,Object> foreclosurevalues = new Map<String,Object>();
        
        //channel map
        
        Map<String,Object> channel= new Map<String,Object>();
        Map<String,Object> channelvalues = new Map<String,Object>();
        
        
        //short-sale map
        
        Map<String,Object> ss= new Map<String,Object>();
        Map<String,Object> ssvalues = new Map<String,Object>();
        
        //bankruptcy map
        
        Map<String,Object> bankruptcy= new Map<String,Object>();
        Map<String,Object> bankruptcyvalues = new Map<String,Object>();
        
        //base-loan-amount map
        
        Map<String,Object> bla= new Map<String,Object>();
        Map<String,Object> blavalues = new Map<String,Object>();
        
        //borrower-type map
        
        Map<String,Object> bt= new Map<String,Object>();
        Map<String,Object> btvalues = new Map<String,Object>();
        
        
        //outputfieldsvalue map
        
        Map<String,Object> ofv = new Map<String,Object>();
        
        
        for(Lead leadobj : leadlist){
            
            output.put('currentTime',leadobj.currentTime__c);
            output.put('pricingProfileId','181');ofv.put('type','none');output.put('outputFieldsFilter',ofv);if(leadobj.Calc_Occupancy__c == 'Investment'){m.put('fieldId','field@occupancy-type');m1.put('type','enum');m1.put('enumTypeId','occupancy-type');m1.put('variantId',leadobj.Calc_Occupancy__c);m.put('value',m1);l.add(m);}
            rental.put('fieldId','property-rental-income');rentalvalues.put('type','number');rentalvalues .put('value',string.valueOf(leadobj.Calc_property_Rental_Income__c));System.debug('leadobj.Calc_property_Rental_Income__c' +leadobj.Calc_property_Rental_Income__c);rental.put('value',rentalvalues);l.add(rental);
            compensation.put('fieldId','field@referral-compensation-amount');compensationvalues.put('type','number');compensationvalues.put('value',string.valueOf(leadobj.Calc_Referral_Compensation_Amount__c));compensation.put('value',compensationvalues);l.add(compensation);gt.put('fieldId','field@guarantor-type');gtvalues.put('type','enum');gtvalues.put('enumTypeId','guarantor-type');gtvalues.put('variantId',leadobj.Citizenship_Status__c);gt.put('value',gtvalues);l.add(gt);pp.put('fieldId','field@purchase-price');ppvalues.put('type','number');ppvalues.put('value',string.valueOf(leadobj.Calc_Purchase_Price__c));system.debug('Calc_Purchase_Price__c: '+ leadobj.Calc_Purchase_Price__c);pp.put('value',ppvalues);l.add(pp);lp.put('fieldId','field@loan-purpose');lpvalues.put('type','enum');lpvalues.put('enumTypeId','loan-purpose');lpvalues.put('variantId',leadobj.Calc_Loan_Purpose__c);lp.put('value',lpvalues);l.add(lp); dc.put('fieldId','field@decision-credit-score');dcvalues.put('type','number');dcvalues.put('value',string.valueOf(leadobj.Est_FICO_Score__c));dc.put('value',dcvalues);l.add(dc); 
            
            plf.put('fieldId','field@properties-listed-for-sale-in-last-12-months');plfvalues.put('type','enum');plfvalues.put('enumTypeId','yes-no');plfvalues.put('variantId',leadobj.Calc_Properties_listed_for_Sale__c);plf.put('value',plfvalues);l.add(plf); credevnt.put('fieldId','field@credit-event');credevntvalues.put('type','enum');credevntvalues.put('enumTypeId','yes-no');credevntvalues.put('variantId',leadobj.Calc_Credit_Event__c);credevnt.put('value',credevntvalues);
            l.add(credevnt); pt.put('fieldId','field@property-type');ptvalues.put('type','enum');ptvalues.put('enumTypeId','property-type');ptvalues.put('variantId',leadobj.Calc_Property_Type__c);pt.put('value',ptvalues);l.add(pt); loanprog.put('fieldId','field@loan-program');loanprogvalues.put('type','enum');loanprogvalues.put('enumTypeId','loan-program');loanprogvalues.put('variantId','single-asset-rental');loanprog.put('value',loanprogvalues);l.add(loanprog); 
            hre.put('fieldId','field@heavy-rehab-experience');hrevalues.put('type','number');hrevalues.put('value','0');hre.put('value',hrevalues);l.add(hre); dil.put('fieldId','field@deed-in-lieu');dilvalues.put('type','enum');dilvalues.put('enumTypeId','deed-in-lieu');dilvalues.put('variantId','not-applicable');
            dil.put('value',dilvalues);l.add(dil);  county.put('fieldId','field@county');countyvalues.put('type','string');countyvalues.put('value','12011');
            county.put('value',countyvalues);l.add(county); annualtax.put('fieldId','field@annual-taxes');annualtaxvalues.put('type','number');annualtaxvalues.put('value',string.valueOf(leadobj.Calc_Annual_Tax__c));annualtax.put('value',annualtaxvalues);l.add(annualtax); annualhoa.put('fieldId','field@annualhoa');annualhoavalues.put('type','number');annualhoavalues.put('value',string.valueOf(leadobj.Calc_HOA__c));annualhoa.put('value',annualhoavalues);l.add(annualhoa); annualinsurance.put('fieldId','field@annual-insurance');annualinsurancevalues.put('type','number');annualinsurancevalues.put('value',string.valueOf(leadobj.Calc_Annual_Insurance__c));annualinsurance.put('value',annualinsurancevalues);l.add(annualinsurance); 
            currentoccup.put('fieldId','field@current-occupancy');currentoccupvalues.put('type','enum');currentoccupvalues.put('enumTypeId','current-occupancy');currentoccupvalues.put('variantId',leadobj.Calc_CurrentOccupancy__c);currentoccup.put('value',currentoccupvalues);l.add(currentoccup); 
            
            acq.put('fieldId','field@acquisition-date');acqvalues.put('type','date');acqvalues.put('value',leadobj.Calc_Acquisition_Date__c);acq.put('value',acqvalues);l.add(acq); ppt.put('fieldId','field@prepayment-penalty-term');pptvalues.put('type','enum');pptvalues.put('enumTypeId','prepayment-penalty-term');pptvalues.put('variantId','3-year-prepay');ppt.put('value',pptvalues);l.add(ppt); dm.put('fieldId','field@declining-markets');dmvalues.put('type','enum');dmvalues.put('enumTypeId','yes-no');dmvalues.put('variantId',leadobj.Calc_Declining_Market__c);dm.put('value',dmvalues);l.add(dm); 
            
            //rental-duration json
            rd.put('fieldId','field@rental-duration');rdvalues.put('type','enum');rdvalues.put('enumTypeId','rental-duration');rdvalues.put('variantId',leadobj.Calc_Rental_Duration__c);rd.put('value',rdvalues);l.add(rd); nou.put('fieldId','field@number-of-units');nouvalues.put('type','number');nouvalues.put('value',string.valueOf(leadobj.Calc_Number_of_Units__c));nou.put('value',nouvalues);l.add(nou); apv.put('fieldId','field@appraised-value');apvvalues.put('type','number');apvvalues.put('value','500000.00');apv.put('value',apvvalues);l.add(apv); te.put('fieldId','field@total-experience');tevalues.put('type','number');tevalues.put('value',string.valueOf(leadobj.Calc_Total_Experience__c));te.put('value',tevalues);l.add(te); 
            
            foreclosure .put('fieldId','field@foreclosure');foreclosurevalues.put('type','enum');foreclosurevalues.put('enumTypeId','foreclosure');foreclosurevalues.put('variantId','not-applicable');foreclosure .put('value',foreclosurevalues);l.add(foreclosure ); channel.put('fieldId','field@channel');channelvalues.put('type','enum');channelvalues.put('enumTypeId','channel');channelvalues.put('variantId','correspondent');channel.put('value',channelvalues);l.add(channel);  ss.put('fieldId','field@short-sale');ssvalues.put('type','enum');ssvalues.put('enumTypeId','short-sales');ssvalues.put('variantId','not-applicable');ss.put('value',ssvalues);l.add(ss); bankruptcy.put('fieldId','field@bankruptcy');bankruptcyvalues.put('type','enum');bankruptcyvalues.put('enumTypeId','bankruptcy');bankruptcyvalues.put('variantId','not-applicable');bankruptcy.put('value',bankruptcyvalues);l.add(bankruptcy); 
        }
        
        output.put('creditApplicationFields',l); 
        System.debug('output json is' +output);
        
    }
    
}