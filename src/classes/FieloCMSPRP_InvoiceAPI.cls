global class FieloCMSPRP_InvoiceAPI implements FieloCMS.DataInterface{
    global Map<Id, Object> getBulkData(List<FieloCMS__Component__c> components){                
        Map<Id,Object> newMapData = new Map<Id,Object>();
        //Prepare all the queries
        for(FieloCMS__Component__c c : components){            
            if(c.FieloCMS__Limit__c == null)
                c.FieloCMS__Limit__c = 5;

            newMapData.put(c.Id, FieloCMSPRP_InvoiceService.getInvoices(FieloCMSPLT_OrganizationUtil.getFieldSet(c.FieloCMS__FieldSet__c), FieloCMSPLT_MemberService.getCurrentMemberId(), c.FieloCMS__Limit__c.intValue(), null, null, null, false));
        }
        return newMapData;
    }

    global List<sObject> getData(FieloCMS__Component__c component, Integer pageNumber, String orderBy, String filters){        
        if(component.FieloCMS__Limit__c == null)
            component.FieloCMS__Limit__c = 5;

        //Calculate the offset from the Page Number
        Integer offset = Integer.valueOf(component.FieloCMS__Limit__c * (pageNumber - 1));
        return FieloCMSPRP_InvoiceService.getInvoices(FieloCMSPLT_OrganizationUtil.getFieldSet(component.FieloCMS__FieldSet__c), FieloCMSPLT_MemberService.getCurrentMemberId(), component.FieloCMS__Limit__c.intValue(), offset, null, filters, true);
    }
}