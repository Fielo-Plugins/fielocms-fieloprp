public class FieloCMSPRP_InvoiceService {
	
	public static List<FieloPRP__Invoice__c> getInvoices(Set<String> fields, Id memberId, Integer quantity, Integer offset, String orderBy, String dynamicFilter){

        //writes the query
        String query = 'SELECT ' + String.join(new List<String>(fields), ',');

        //evaluate conditions
        String conditions = '';
        query += ' FROM FieloPRP__Invoice__c WHERE FieloPRP__Member__c =: memberId';

        if(String.isNotBlank(dynamicFilter)){
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