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
                whereCondition = ' ParentId != null ';
            }
            whereCondition += ' LIMIT ' + String.valueOf(c.FieloCMS__Limit__c);
            String fieldset = String.join(new List<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)), ',');
            if(String.isBlank(fieldset)) fieldset = 'Id';
            newMapData.put(c.Id, Database.query('SELECT ' + fieldset + ' FROM Attachment WHERE ' + whereCondition));

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

        // Assembles Where Condition
        String whereCondition = '';

        if(filters != null){
            Map<String, String> filtersMap = (Map<String, String>)JSON.deserialize(filters, Map<string,String>.class);
            if (!filtersMap.isEmpty()){
                if (filtersMap.containsKey(component.FieloCMSPRP_CustomDetailParameter__c)) {
                    whereCondition += ' WHERE ParentId = \'' + filtersMap.get(component.FieloCMSPRP_CustomDetailParameter__c) + '\'';
                }
            }
        }

        if(component.FieloCMS__Limit__c != null)
            whereCondition += ' LIMIT ' + String.valueOf(component.FieloCMS__Limit__c);
        
        if(offset != null)
            whereCondition += ' OFFSET ' + String.valueOf(offset);
            
        // Workaround
        String fieldset = String.join(new List<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c)), ',');
        if(String.isBlank(fieldset)) fieldset = 'Id';
        List<sObject> records = Database.query('SELECT ' + fieldset + ' FROM Attachment ' + whereCondition);

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