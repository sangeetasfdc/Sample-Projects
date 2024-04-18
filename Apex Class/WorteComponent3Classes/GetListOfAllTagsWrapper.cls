public class GetListOfAllTagsWrapper {
    public class Tags {
		@AuraEnabled public Boolean companyWideVisibility;
		@AuraEnabled public String name;
		@AuraEnabled public String createdAt;
		@AuraEnabled public String updatedAt;
		@AuraEnabled public String id;
	}

	public List<Tags> tags;
	@AuraEnabled public Integer total;

	
	public static GetListOfAllTagsWrapper parse(String json) {
		return (GetListOfAllTagsWrapper) System.JSON.deserialize(json, GetListOfAllTagsWrapper.class);
	}

}