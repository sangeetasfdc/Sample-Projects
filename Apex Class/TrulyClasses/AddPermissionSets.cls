public class AddPermissionSets{
    @future
    public static void AssignPermissionSetToUsers(Id usersId){
        String PermissionSetIdVal = [select id from permissionset where Label = 'Financial Services Community Extension'].id;
        List<PermissionSetAssignment> permissionSetList = new List<PermissionSetAssignment>();
        for (User u : [Select Id, Name FROM User Where Id =: usersId]){ 
            PermissionSetAssignment psa = new PermissionSetAssignment (PermissionSetId = PermissionSetIdVal, AssigneeId = u.Id);
            permissionSetList.add(psa);
        }
        Insert permissionSetList;
    }
}