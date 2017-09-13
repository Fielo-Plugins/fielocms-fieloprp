global class FieloCMSPRP_InvoiceAPI implements FieloCMS.DataInterface{
	global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){                
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;

            if(c.FieloCMS__ComponentLibrary__r.Name == 'My Invoices'){
                Id memberId = FieloCMSPLT_MemberService.getCurrentMemberId();
                String query = 'SELECT ';
                query += String.join(new List<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)), ',');
                query += ' FROM FieloPRP__Invoice__c';
                query += ' WHERE FieloPRP__Member__c =: memberId';
                query += ' ORDER BY LastModifiedDate DESC';
                query += ' LIMIT ' + String.valueOf(c.FieloCMS__Limit__c);
                query += ' OFFSET 0';
                newMapData.put(c.Id, Database.query(query));
            }
            if(c.FieloCMS__ComponentLibrary__r.Name == 'Invoice Detail' || c.FieloCMS__ComponentLibrary__r.Name == 'Invoice Form'){
                Id memberId = FieloCMSPLT_MemberService.getCurrentMemberId();
                String recordId = ApexPages.CurrentPage().getParameters().get( c.FieloCMS__DetailParameter__c );

                if (c.FieloCMS__ComponentLibrary__r.Name == 'Invoice Form' && (recordId == null || recordId == '')) {
                    FieloPRP__Invoice__c invoice = new FieloPRP__Invoice__c();
                    for(String field: new List<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c))){
                        invoice.put(field,null);
                    }
                    newMapData.put(c.Id, (sObject)invoice);
                } else {
                    String query = 'SELECT ';
                    query += String.join(new List<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)), ',');
                    query += ' FROM FieloPRP__Invoice__c';
                    query += ' WHERE Id = :recordId ';
                    query += ' AND FieloPRP__Member__c =: memberId';
                    query += ' ORDER BY LastModifiedDate DESC';
                    query += ' LIMIT ' + String.valueOf(c.FieloCMS__Limit__c);
                    query += ' OFFSET 0';
                    newMapData.put(c.Id, Database.query(query));
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
        Id memberId = FieloCMSPLT_MemberService.getCurrentMemberId();
        String query = 'SELECT Id,' + String.join(new List<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c)), ',') + ' FROM FieloPRP__Invoice__c WHERE FieloPRP__Member__c =: memberId';
        query += ' ORDER BY LastModifiedDate DESC';
        query += ' LIMIT ' + String.valueOf(component.FieloCMS__Limit__c);
        query += ' OFFSET ' + String.valueOf(offset);
        return Database.query(query);
    }
}