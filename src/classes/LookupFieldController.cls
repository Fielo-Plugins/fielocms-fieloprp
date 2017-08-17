global class LookupFieldController {
	@RemoteAction
	global static List<sObject> getValues(String sObjectName){
		return Database.query('Select Id, Name From ' + sObjectName);
	}
}