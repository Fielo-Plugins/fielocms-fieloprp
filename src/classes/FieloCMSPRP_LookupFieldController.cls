public class FieloCMSPRP_LookupFieldController {
	@RemoteAction
	public static Map<String, Object> getValues(String sObjectName, Integer recordsPerPage, Integer pageNumber, String filterJson, String whereCondition){
		Integer offset = Integer.valueOf(recordsPerPage * (pageNumber - 1));

		String whereClause = '';

		if(String.isNotBlank(filterJson)){
			Map<String,Object> filter = (Map<String, Object>) JSON.deserializeUntyped(filterJson);
			if (filter.containsKey('Name')) {
				whereClause = ' WHERE Name LIKE \'%' + filter.get('Name') + '%\'';
			}
			if (filter.containsKey('Id')) {
				whereClause = ' WHERE Id = \'' + filter.get('Id') + '\'';
			}
		}
		
		if (whereCondition != '' && whereCondition != null) {
			whereClause += whereClause == '' ?
				' WHERE ' + whereCondition :
				' AND ' + whereCondition;
		}
		
		List<sObject> records = Database.query('Select Id, Name From ' + sObjectName + whereClause +
			' ORDER BY LastModifiedDate LIMIT ' + (recordsPerPage + 1) +
			' OFFSET ' + offset);

		Boolean hasNext = records.size() > recordsPerPage;

		if (hasNext) {
			records.remove(records.size()-1);
		}

		return new Map<String, Object>{
			'Records' => (Object) records,
			'hasNext' => (Object) hasNext
		};
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
