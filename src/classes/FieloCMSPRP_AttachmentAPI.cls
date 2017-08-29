global with sharing class FieloCMSPRP_AttachmentAPI implements FieloCMS.DataInterface{
	
	global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){                
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;
            
            String whereCondition = '';
            if(String.isNotBlank(c.FieloCMSPRP_CustomDetailParameter__c) && ApexPages.CurrentPage().getParameters().containsKey(c.FieloCMSPRP_CustomDetailParameter__c)){
                Id parentId = ApexPages.CurrentPage().getParameters().get(c.FieloCMSPRP_CustomDetailParameter__c);
                whereCondition = ' ParentId = \'' + parentId + '\'';
            }else{
                whereCondition = ' ParentId = != null ';
            }
            whereCondition += ' LIMIT ' + String.valueOf(c.FieloCMS__Limit__c);
            newMapData.put(c.Id, Database.query('SELECT Id, ' + String.join(new List<String>(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)), ',') + ' FROM Attachment WHERE ' + whereCondition));

            // Workaround
            if(c.FieloCMS__ComponentLibrary__r.Name == 'Attachments View'){
	            for(Attachment attachment: ((List<Attachment>) newMapData.get(c.Id))) {
	            	String attachmentURL = URL.getSalesforceBaseUrl().toExternalForm();
                    attachmentURL += '/servlet/servlet.FileDownload?file=';
                    attachmentURL += attachment.Id;
                    attachmentURL += '&oid=';
                    attachmentURL += UserInfo.getOrganizationId();

					attachment.Description = attachmentURL;
	            }
	        }
        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){        
        
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));

        Map<String, String> filtersMap = (Map<String, String>)JSON.deserialize(filters, Map<string,String>.class);

        // Assembles Where Condition
        String whereCondition = '';

        if (!filtersMap.isEmpty()){
            if (filtersMap.containsKey(component.FieloCMSPRP_CustomDetailParameter__c)) {
                whereCondition += ' ParentId = \'' + filtersMap.get(component.FieloCMSPRP_CustomDetailParameter__c) + '\'';
            }
        }

        whereCondition += ' LIMIT ' + String.valueOf(component.FieloCMS__Limit__c);
        whereCondition += ' OFFSET ' + String.valueOf(offset);
        // Workaround
        List<sObject> records = Database.query('SELECT ' + String.join(new List<String>(OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c)), ',') + ' FROM Attachment WHERE ' + whereCondition);

        if(component.FieloCMS__ComponentLibrary__r.Name == 'Attachments View'){
            for(Attachment attachment: (List<Attachment>)records ) {
                String attachmentURL = URL.getSalesforceBaseUrl().toExternalForm();
                attachmentURL += '/servlet/servlet.FileDownload?file=';
                attachmentURL += attachment.Id;
                attachmentURL += '&oid=';
                attachmentURL += UserInfo.getOrganizationId();

                attachment.Description = attachmentURL;
            }
        }

        return records;
    }
}