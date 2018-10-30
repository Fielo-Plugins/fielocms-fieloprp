public class FieloCMSPRP_InvoiceService {
    
    public static List<sObject> getInvoices(Set<String> fields, Id memberId, Integer quantity, Integer offset, String orderBy, String dynamicFilter, Boolean translatePicklists){
        Map<String,Schema.SObjectField> invoiceFieldMap = Schema.SObjectType.FieloPRP__Invoice__c.fields.getMap();
        
        Set<String> fieldSet = new Set<String>();
        fieldSet.add('Id');

        for(String fieldName : fields) {
            if ( translatePicklists && invoiceFieldMap.containsKey(fieldName) && invoiceFieldMap.get(fieldName).getDescribe().getType().name().toLowerCase() == 'picklist') {
                fieldSet.add( 'toLabel(' + fieldName + ') ' + fieldName );
            } else {
                fieldSet.add(fieldName);
            }
        }
        

        //writes the query
        String query = 'SELECT ' + String.join(new List<String>(fieldSet), ',');

        //evaluate conditions
        String conditions = '';
        query += ' FROM FieloPRP__Invoice__c WHERE FieloPRP__Member__c =: memberId';

        if(String.isNotBlank(dynamicFilter) && dynamicFilter != '[]'){
            query += ' AND ' + FieloCMSPLT_FilterService.getDynamicWhereCondition(dynamicFilter, 'FieloPRP__Invoice__c', '');
        }

        //add the order to the query
        if(!String.isBlank(orderBy)){
            query += ' ORDER BY ' + orderBy;
        }else{
            query += ' ORDER BY LastModifiedDate DESC';
        }

        if(quantity != null && quantity > 0)
            query += ' LIMIT ' + quantity;

        if(offset != null && offset > 0)
            query += ' OFFSET ' + offset;

        return Database.query(query);
    }

}