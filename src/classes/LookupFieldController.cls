public class LookupFieldController {
	@RemoteAction
	public static List<sObject> getValues(String sObjectName){
		return Database.query('Select Id, Name From ' + sObjectName);
	}

	public static String csObject {get;set;}

	public static sObject record {get{
		Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();

        /* Get the token for the sobject based on the type. */
        system.debug('****ObjectName' + csObject);
        Schema.SObjectType st = gd.get(csObject.replace('[','').replace(']',''));

        /* Instantiate the sobject from the token. */
		if (st != null) {
			Sobject s = st.newSobject();
			s.put('Id','000000000000000');
			s.put('Name','Blank');
			return s;
		}
        return null;
	}set;}
}
