import { LightningElement } from 'lwc';
import { OmniscriptBaseMixin } from 'omnistudio/omniscriptBaseMixin';


export default class PdfLWC extends OmniscriptBaseMixin(LightningElement) {
    siteURL;

    connectedCallback() {
		const jsonData = JSON.parse(JSON.stringify(this.omniJsonData));
        console.log('jsondata values' +JSON.stringify(this.omniJsonData));
        console.log('leadid is' +this.omniJsonData.LeadId);
        const fullFileURL = window.location.origin;
        console.log('fullFIleURL' +fullFileURL);
        this.siteURL = fullFileURL + '/apex/LeadPdf?Id=' + this.omniJsonData.LeadId;
        console.log('siteurl is ' +this.siteURL);
        return this.siteURL;

	}

}
/*
import { LightningElement , track , api} from 'lwc';
import { OmniscriptBaseMixin } from 'omnistudio/omniscriptBaseMixin';
export default class PdfLWC extends OmniscriptBaseMixin(LightningElement){
    //@api recordId;
    @track leadid;
    @track leadval;
   // siteURL;

    connectedCallback(){
       // this.leadid = this.omniJsonData.LeadId;
       // console.log('leadid from omniscript is'+this.leadid);
       // console.log('omnijsondata value' +this.omniJsonData);
        //this.leadval = this.omniJsonData.Id;
        //console.log('id value is' +this.leadval);
       // console.log('recordId is'+this.recordId);
       // this.siteURL = '/apex/LeadPdf?Id=' + this.recordId;
       // return this.siteURL;

    }

}
*/