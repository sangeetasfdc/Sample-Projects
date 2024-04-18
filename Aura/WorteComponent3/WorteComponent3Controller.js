({
  doinit: function(component, event, helper) {
    //Updating ProfileID and Creating contacts
    var recordId = component.get("v.recordId");

    var relationshipquality = $A.get("$Label.c.X100worterelationshipquality");
    component.set("v.X100worterelationshipquality", relationshipquality);

    var relationshiptendency = $A.get("$Label.c.X100worterelationshiptendency");
    component.set("v.X100worterelationshiptendency", relationshiptendency);

    var hintsforspeech = $A.get("$Label.c.X100wortehintsforspeech");
    component.set("v.X100wortehintsforspeech", hintsforspeech);

    var textappears = $A.get("$Label.c.X100wortetextAppears", textappears);
    component.set("v.X100wortetextAppears", textappears);

    var more = $A.get("$Label.c.X100wortemore", more);
    component.set("v.X100wortemore", more);

    var less = $A.get("$Label.c.X100worteless", less);
    component.set("v.X100worteless", less);

    var motivationanalysis = $A.get(
      "$Label.c.X100wortemotiveanalysis",
      motivationanalysis
    );
    component.set("v.X100wortemotiveanalysis", motivationanalysis);

    var abstractness = $A.get("$Label.c.X100worteabstractness", abstractness);
    component.set("v.X100worteabstractness", abstractness);

    var attention = $A.get("$Label.c.X100worteattention", attention);
    component.set("v.X100worteattention", attention);

    var processing = $A.get("$Label.c.X100worteprocessing", processing);
    component.set("v.X100worteprocessing", processing);

    var needs = $A.get("$Label.c.X100worteneeds", needs);
    component.set("v.X100worteneeds", needs);

    var regulatoryfit = $A.get(
      "$Label.c.X100worteregulatoryfit",
      regulatoryfit
    );
    component.set("v.X100worteregulatoryfit", regulatoryfit);

    var questionone = $A.get(
      "$Label.c.X100wortehintforspeechheadline1",
      questionone
    );
    component.set("v.X100wortehintforspeechheadline1", questionone);

    var questiontwo = $A.get(
      "$Label.c.X100wortehintforspeechheadline2",
      questiontwo
    );
    component.set("v.X100wortehintforspeechheadline2", questiontwo);

    var questionthree = $A.get(
      "$Label.c.X100wortehintforspeechheadline3",
      questionthree
    );
    component.set("v.X100wortehintforspeechheadline3", questionthree);

    var emotionality = $A.get("$Label.c.X100worteemotionality", emotionality);
    component.set("v.X100worteemotionality", emotionality);

    var wordsanalysedforprofile = $A.get(
      "$Label.c.X100wortewordsAnalyzedForProfile",
      wordsanalysedforprofile
    );
    component.set(
      "v.X100wortewordsAnalyzedForProfile",
      wordsanalysedforprofile
    );

    var answer = $A.get("$Label.c.X100worteanswer", answer);
    component.set("v.X100worteanswer", answer);

    var wordcount = $A.get("$Label.c.X100wortewordcount", wordcount);
    component.set("v.X100wortewordcount", wordcount);

    var wordcount2 = $A.get("$Label.c.X100wortewordcount2", wordcount2);
    component.set("v.X100wortewordcount2", wordcount2);

    //alert(recordId);
    var action = component.get("c.GetProfileID");
    action.setParams({
      recordId: recordId
    });
    action.setCallback(this, function(response) {
      var state = response.getState();
      var value = response.getReturnValue();
      //console.log('Record: '+value);
      if (value === "Please enter Email") {
        if (state === "SUCCESS") {
          component.set("v.profilenotfound", response.getReturnValue());
        }
      }
    });
    $A.enqueueAction(action);

    //Getting Profile values

    var action2 = component.get("c.AnalysisResult");
    action2.setParams({
      recordId: recordId
    });
    action2.setCallback(this, function(response) {
      var state = response.getState();
      if (state === "SUCCESS") {
        var data = Math.round(response.getReturnValue().wordCount);
        if (data != null) {
          component.set("v.Hidesection", data);
          component.set("v.detailanlaysis", response.getReturnValue());
          console.log("Record: " + response.getReturnValue());
          component.set(
            "v.wordCount",
            Math.round(response.getReturnValue().wordCount)
          );
        }
      }
    });
    $A.enqueueAction(action2);

    // Getting Relationship Quality

    var action3 = component.get("c.RelationshipQuality");
    action3.setParams({
      recordId: recordId
    });
    action3.setCallback(this, function(response) {
      var state = response.getState();
      console.log("value of quality is" + response.getReturnValue());
      //var quality=Math.round(response.getReturnValue());
      if (response.getReturnValue() != null) {
        var quality = Math.round(response.getReturnValue().qualityFactor);
        var trend = response.getReturnValue().trend;
        //alert(response.getReturnValue().qualityFactor);
        //alert(response.getReturnValue().trend);
        component.set("v.trend", trend);
          console.log('trend value is '+trend);
      } else {
        component.set("v.trend", "nodata");
      }

      var prgBar = component.find("prgBar");
      if (state === "SUCCESS") {
        //alert(response.getReturnValue());
        if (quality >= 80) {
          component.set("v.progress", "Good");
          $A.util.removeClass(prgBar, "slds-is-low");
          $A.util.removeClass(prgBar, "slds-is-medium");
          $A.util.addClass(prgBar, "slds-is-high");
        } else if (quality >= 60 && quality < 80) {
          component.set("v.progress", "Ok");
          $A.util.removeClass(prgBar, "slds-is-high");
          $A.util.removeClass(prgBar, "slds-is-low");
          $A.util.addClass(prgBar, "slds-is-medium");
        } else if (quality < 60) {
          //component.set('v.progressbar','Red');
          component.set("v.progress", "Not Good");
          $A.util.removeClass(prgBar, "slds-is-medium");
          $A.util.removeClass(prgBar, "slds-is-high");
          $A.util.addClass(prgBar, "slds-is-low");
        } else {
          component.set("v.progressbar", "black");
          $A.util.removeClass(prgBar, "slds-is-medium");
          $A.util.removeClass(prgBar, "slds-is-high");
          $A.util.removeClass(prgBar, "slds-is-low");
          $A.util.addClass(prgBar, "slds-is-critical");
        }

        component.set("v.quality", quality);
        console.log("Record: " + Math.round(response.getReturnValue()));
      }
    });
    $A.enqueueAction(action3);

    //Get tags

    var action4 = component.get("c.getTags");
    action4.setParams({
      recordId: recordId
    });
    action4.setCallback(this, function(response) {
      var state = response.getState();
      var tagonpage = "";

      if (state === "SUCCESS") {
        var tags = response.getReturnValue();
        console.log("Record: " + response.getReturnValue());
        //for(var i=0;i<=tags.length;i++){
        component.set("v.tag", response.getReturnValue());
        /*console.log('Record: '+response.getReturnValue().department);
                console.log('Record: '+response.getReturnValue().title);
                console.log('Record: '+response.getReturnValue().accountId);
                }*/
      }
    });
    $A.enqueueAction(action4);
  },

  ProfileComp: function(component, event, helper) {
    var toggleText = component.find("ProfileComp");
    $A.util.toggleClass(toggleText, "toggle");
    var label = component.find("label");
    $A.util.toggleClass(label, "slds-hide");
    var label2 = component.find("label2");
    $A.util.toggleClass(label2, "toggle");
  },

  ProfileDetailComp: function(component, event, helper) {
    var toggleText = component.find("ProfileDetailComp");
    $A.util.toggleClass(toggleText, "toggle");
    var label = component.find("label3");
    $A.util.toggleClass(label, "slds-hide");
    var label2 = component.find("label4");
    $A.util.toggleClass(label2, "toggle");
  },

  MotiveInfo: function(component, event, helper) {
    component.set("v.isMotiveOpen", true);
  },

  closeMotiveInfo: function(component, event, helper) {
    component.set("v.isMotiveOpen", false);
  },

  RegulatoryFitInfo: function(component, event, helper) {
    component.set("v.isRegulatoryFitOpen", true);
  },

  closeRegulatoryFitInfo: function(component, event, helper) {
    component.set("v.isRegulatoryFitOpen", false);
  },

  AbstractnessInfo: function(component, event, helper) {
    component.set("v.isAbstractnessOpen", true);
  },

  closeAbstractnessInfo: function(component, event, helper) {
    component.set("v.isAbstractnessOpen", false);
  },

  EmotionalityInfo: function(component, event, helper) {
    component.set("v.isEmotionalityOpen", true);
  },

  closeEmotionalityInfo: function(component, event, helper) {
    component.set("v.isEmotionalityOpen", false);
  },
  // function automatic called by aura:waiting event
  showSpinner: function(component, event, helper) {
    // make Spinner attribute true for displaying loading spinner
    component.set("v.spinner", true);
  },

  // function automatic called by aura:doneWaiting event
  hideSpinner: function(component, event, helper) {
    // make Spinner attribute to false for hiding loading spinner
    component.set("v.spinner", false);
  }
});