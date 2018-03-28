global class FieloCMSPRP_ContentDocumentAPI implements FieloCMS.DataInterface{
	global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components) {
		Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;

            Id parentId;
            if(String.isNotBlank(c.FieloCMSPRP_CustomDetailParameter__c) && ApexPages.CurrentPage().getParameters().containsKey(c.FieloCMSPRP_CustomDetailParameter__c)){
                parentId = ApexPages.CurrentPage().getParameters().get(c.FieloCMSPRP_CustomDetailParameter__c);
            }
            // Testing
            if (Test.isRunningTest()) {
            	parentId = c.FieloCMSPRP_CustomDetailParameter__c;
            }

            newMapData.put(c.Id,
            	FieloCMSPRP_FileService.getFiles(
            		parentId,
            		FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c),
            		1,
            		Integer.valueOf(c.FieloCMS__Limit__c),
            		c.FieloCMS__ComponentLibrary__r.Name == 'Files View' ? 'ContentType like \'%image%\'' : '',
            		c.FieloCMS__ComponentLibrary__r.Name == 'Files View' ? String.format('ContentDocument.FileType IN ({0},{1},{2},{3})', new List<String>{'\'JPG\'','\'JPEG\'','\'PNG\'','\'GIF\''}) : ''
            	)
            );
        }
        return newMapData;
	}

	global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters) {
		if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        // Assembles Where Condition
        Id parentId;

        if(filters != null){
            List<Map<String, String>> filtersMapList = (List<Map<String, String>>)JSON.deserialize(filters, List<Map<String, String>>.class);
            if (!filtersMapList.isEmpty()){
            	for (Map<String,String> filterMap: filtersMapList) {
            		if (filterMap.containsKey('field')) {
            			if (filterMap.get('field') == 'RecordId__c') {
            				parentId = filterMap.get('value');
            			}
            		}
            	}
            }
        }
            
        List<sObject> records = FieloCMSPRP_FileService.getFiles(
    		parentId,
    		FieloCMSPLT_OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c),
    		pageNumber,
    		Integer.valueOf(component.FieloCMS__Limit__c),
    		component.FieloCMS__ComponentLibrary__r.Name == 'Files View' ? 'ContentType like \'%image%\'' : '',
    		component.FieloCMS__ComponentLibrary__r.Name == 'Files View' ? String.format('ContentDocument.FileType IN ({0},{1},{2},{3})', new List<String>{'\'JPG\'','\'JPEG\'','\'PNG\'','\'GIF\''}) : ''
    	);

    	System.debug(JSON.serializePretty(records));

        return records;
	}
}