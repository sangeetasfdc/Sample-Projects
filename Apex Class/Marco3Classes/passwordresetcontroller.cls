public with sharing class passwordresetcontroller
{
	public Id contactIdPassedCtrl{get; set;}

	public String getProfileName()
	{
		String profileName = '';

		List<User> usersFromContact = [SELECT Profile.Name FROM User WHERE ContactId = 
                :contactIdPassedCtrl LIMIT 1];

		if(!usersFromContact.isEmpty())
		{
			profileName = usersFromContact[0].Profile.Name;
		}

		return profileName;
	}
}