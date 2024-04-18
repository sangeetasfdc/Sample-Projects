public class DetailedAnalysisResultWrapper
{
    public class Authenticity {
		@AuraEnabled public String key;
		@AuraEnabled public String title;
		@AuraEnabled public String value;
	}

	public class Composition {
		@AuraEnabled public String name;
		@AuraEnabled public Boolean present;
	}

	@AuraEnabled public Boolean isHashed;
	@AuraEnabled public Boolean companyWideVisibility;
    @AuraEnabled public List<List<Tags>> tags;
	@AuraEnabled public String type;
	@AuraEnabled public String externalId;
	@AuraEnabled public String firstname;
	@AuraEnabled public String lastname;
	@AuraEnabled public String email;
	@AuraEnabled public String createDate;
	@AuraEnabled public String id;
	@AuraEnabled public Double wordCount;
	@AuraEnabled public Integer analysesCount;
	@AuraEnabled public String contentLanguage;
	@AuraEnabled public Boolean inconsistentLanguage;
	@AuraEnabled public Boolean isOwn;
	//public Manova manova;
	@AuraEnabled public Assessment assessment;
	//public Profile profile;

	/*public class RequiredTexts {
		public Integer min;
		public Integer max;
	}*/

	public class Categories {
		@AuraEnabled public String key;
		@AuraEnabled public String title;
		@AuraEnabled public String info;
		@AuraEnabled public List<Composition> composition;
	}

	public class Assessment {
		@AuraEnabled public Processing processing;
		@AuraEnabled public Processing needs;
		@AuraEnabled public Authenticity authenticity;
		@AuraEnabled public Instructions instructions;
	}

	public class Instructions {
		@AuraEnabled public String type;
		@AuraEnabled public List<String> questions;
		@AuraEnabled public String words;
		//public String summary;
	}
     
	public class Tags {
		@AuraEnabled public Boolean companyWideVisibility;
		@AuraEnabled public String name;
		@AuraEnabled public String createdAt;
		@AuraEnabled public String updatedAt;
		@AuraEnabled public String id;
	}
	

	/*public class Profile {
		public Double auxverb;
		public Double jointPosPower;
		public Double regFocus;
		public Double jointPosAffil;
		public Double authenticity;
		public Double personalPronouns;
		public Double article;
		public Double impersonalPronouns;
		public Double jointPosAchieve;
		public Double negation;
		public Double preposition;
		public Double adverb;
		public Double quant;
	}*/

	/*public class Manova {
		public RequiredTexts requiredTexts;
		public Boolean significant;
	}*/

	public class Processing {
		@AuraEnabled public String key;
		@AuraEnabled public String title;
		@AuraEnabled public String value;
		@AuraEnabled public List<Categories> categories;
	}

	
	public static DetailedAnalysisResultWrapper  parse(String json) {
        if(String.isNotBlank(json)){
            return (DetailedAnalysisResultWrapper) System.JSON.deserialize(json, DetailedAnalysisResultWrapper.class);
        }else{
            String json0 = '';
            String json1 = '';
            String json2 = '';
            String json3 = '';
            return null;
        }
	}

}