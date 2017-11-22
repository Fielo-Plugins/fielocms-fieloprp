global with sharing class FieloCMSPRP_InvoiceItemAPI implements FieloCMS.DataInterface{
	global Id invoiceId {set;get;}

	global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){                
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;
            
            String whereCondition = 'FieloPRP__Invoice__r.FieloPRP__Member__c = \'' + FieloCMSPLT_MemberService.getCurrentMemberId() + '\'';
            if(String.isNotBlank(c.FieloCMSPRP_CustomDetailParameter__c) && ApexPages.CurrentPage().getParameters().containsKey(c.FieloCMSPRP_CustomDetailParameter__c)){
                invoiceId = ApexPages.CurrentPage().getParameters().get(c.FieloCMSPRP_CustomDetailParameter__c);
                whereCondition += ' AND FieloPRP__Invoice__c = \'' + invoiceId + '\'';
            }
            whereCondition += ' LIMIT ' + String.valueOf(c.FieloCMS__Limit__c);
            whereCondition += ' OFFSET 0';

            String fieldSet = String.join(new List<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c)),',');
            if(String.isBlank(fieldSet)) fieldSet = 'Id';
            newMapData.put(c.Id, Database.query('SELECT ' + fieldSet + ' FROM FieloPRP__InvoiceItem__c WHERE ' + whereCondition));
        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){        
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));

        String whereCondition = 'FieloPRP__Invoice__r.FieloPRP__Member__c = \'' + FieloCMSPLT_MemberService.getCurrentMemberId() + '\'';
        if(String.isNotBlank(filters)){
            Map<String, String> filtersMap = (Map<String, String>)JSON.deserialize(filters, Map<string,String>.class);
            // Assemble Where Condition
            if (!filtersMap.isEmpty()){
                if (filtersMap.containsKey(component.FieloCMSPRP_CustomDetailParameter__c)) {
                    whereCondition += ' AND FieloPRP__Invoice__c = \'' + filtersMap.get(component.FieloCMSPRP_CustomDetailParameter__c) + '\'';
                }
            }
        }

        whereCondition += ' LIMIT ' + String.valueOf(component.FieloCMS__Limit__c);
        
        if(offset != null)
            whereCondition += ' OFFSET ' + String.valueOf(offset);

        String fieldSet = String.join(new List<String>(FieloCMSPLT_OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c)),',');
        if(String.isBlank(fieldSet)) fieldSet = 'Id';

        String query = 'SELECT ' + fieldSet + ' FROM FieloPRP__InvoiceItem__c WHERE ' + whereCondition;
        return Database.query(query);
    }
}