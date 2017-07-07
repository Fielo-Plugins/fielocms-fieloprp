global class InvoiceAPI implements FieloCMS.DataInterface{
	global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){                
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;

            if(c.FieloCMS__ComponentLibrary__r.Name == 'My Invoices'){
                Id memberId = MemberService.getCurrentMemberId();
                String query = 'SELECT ';
                query += String.join(new List<String>(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)), ',');
                query += ' FROM FieloPRP__Invoice__c';
                query += ' WHERE FieloPRP__Member__c =: memberId';
                query += ' LIMIT ' + String.valueOf(c.FieloCMS__Limit__c);
                query += ' OFFSET 0';
                newMapData.put(c.Id, Database.query(query));
            }
            if(c.FieloCMS__ComponentLibrary__r.Name == 'Invoice Detail'){
                Id memberId = MemberService.getCurrentMemberId();
                String recordId;
                if ( String.isBlank(c.FieloCMS__RecordId__c) ) {
                    recordId = ApexPages.CurrentPage().getParameters().get( c.FieloCMS__DetailParameter__c );
                } else {
                    recordId = c.FieloCMS__RecordId__c;
                }
                String query = 'SELECT ';
                query += String.join(new List<String>(OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)), ',');
                query += ' FROM FieloPRP__Invoice__c';
                query += ' WHERE Id = :recordId ';
                query += ' AND FieloPRP__Member__c =: memberId';
                query += ' LIMIT ' + String.valueOf(c.FieloCMS__Limit__c);
                query += ' OFFSET 0';
                newMapData.put(c.Id, Database.query(query));
            }
        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){        
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));                
        Id memberId = MemberService.getCurrentMemberId();
        String query = 'SELECT Id,' + String.join(new List<String>(OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c)), ',') + ' FROM FieloPRP__Invoice__c WHERE FieloPRP__Member__c =: memberId';
        query += ' LIMIT ' + String.valueOf(component.FieloCMS__Limit__c);
        query += ' OFFSET ' + String.valueOf(offset);
        return Database.query(query);
    }
}