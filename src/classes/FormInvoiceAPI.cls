global class FormInvoiceAPI implements FieloCMS.ViewInterface{
	global ApexPages.Component getComponent(FieloCMS__Component__c c){
        List<String> fields = new List<String>();
        for (String field: c.getPopulatedFieldsAsMap().keySet()) {
            if (field != 'FieloCMS__ComponentLibrary__r' && field != 'RecordType') {
                fields.add(field);
            }
        }
        String query = 'Select ' + String.join(fields, ',') + ', FieloCMS__ComponentLibrary__r.FieloCMS__sObject__c FROM FieloCMS__Component__c';

        FieloCMS__Component__c mainComponent = Database.query(query + ' Where Id = \'' + c.MainSourceComponent__c + '\'');
        FieloCMS__Component__c secondaryComponent = Database.query(query + ' Where Id = \'' + c.SecondarySourceComponent__c + '\'');
        List<Field> invoiceFieldSet = getFieldsStructure(mainComponent, mainComponent.FieloCMS__ComponentLibrary__r.FieloCMS__sObject__c);
		List<Field> invoiceItemFieldSet = getFieldsStructure(secondaryComponent, secondaryComponent.FieloCMS__ComponentLibrary__r.FieloCMS__sObject__c);
        Component.Widget1 formInvoice = new Component.Widget1(config = c);
        formInvoice.invoiceFieldSet = invoiceFieldSet;
        formInvoice.invoiceItemFieldSet = invoiceItemFieldSet;
        formInvoice.record = new FieloPRP__Invoice__c();
        formInvoice.itemRecord = new FieloPRP__InvoiceItem__c(FieloPRP__Quantity__c=0);
        return formInvoice;
    }

    public static List<Field> getFieldsStructure(FieloCMS__Component__c component, String sObjectName){
        List<Field> fieldsList = new List<Field>();
        if(component.FieloCMS__FieldSet__c != null){
            Map<String,Schema.SObjectField> fieldsDescribeMap = Schema.describeSObjects(new String[]{ sObjectName })[0].fields.getMap();
            
            for(Object field : (List<Object>)JSON.deserializeUntyped(component.FieloCMS__FieldSet__c)){
                Map<String, Object> attributes = (Map<String, Object>)field;
                // Si es un campo verifica que tenga acceso de lectura y/o esritura ( caso de un Edit)
                if ( attributes.get('type') != 'Subcomponent' ) {
                    Schema.DescribeFieldResult describeField = fieldsDescribeMap.get( (String) attributes.get('apiName') ).getDescribe();
                    if(describeField.isAccessible() && (component.FieloCMS__Layout__c != 'Edit' || describeField.isUpdateable())){
                        fieldsList.add( new Field( attributes, describeField ) );
                    }
                } else {
                    fieldsList.add( new Field( attributes ) );
                }

            }
        }
        system.debug('fieldsList');
        system.debug(fieldsList);
        return fieldsList;
    }
    
    @RemoteAction
    global static FieloPRP__Invoice__c submit(FieloPRP__Invoice__c invoice, List<FieloPRP__InvoiceItem__c> items, List<Attachment> attachments) {
        invoice.FieloPRP__Member__c = MemberService.getCurrentMemberId();
        return FieloPRP.InvoiceService.submitInvoice(invoice, items, attachments);
    }

    public String currencyCode {get{
        return UserInfo.getDefaultCurrency();
    }
        set;
    }

    @RemoteAction
    global static Id saveAttachment(Id parentId, String fileName, String base64Data, String contentType) { 
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = new Attachment();
        a.parentId = parentId;
 
        a.Body = EncodingUtil.base64Decode(base64Data);
        a.Name = fileName;
        a.ContentType = contentType;
        
        insert a;
        
        return a.Id;
    }

    @RemoteAction
    global static Id saveTheChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId) { 
        if (fileId == '') {
            fileId = saveAttachment(parentId, fileName, base64Data, contentType);
        } else {
            appendToFile(fileId, base64Data);
        }
        
        return Id.valueOf(fileId);
    }
    
    private static void appendToFile(Id fileId, String base64Data) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = [
            SELECT Id, Body
            FROM Attachment
            WHERE Id = :fileId
        ];
        
        String existingBody = EncodingUtil.base64Encode(a.Body);
        a.Body = EncodingUtil.base64Decode(existingBody + base64Data); 
        
        update a;
    }

    @RemoteAction
    global static Boolean deleteAttachments(List<String> attachmentIds){
        Boolean result = false;
        Set<Id> attachmentIdsSet = new Set<Id>();
        for(String singleId: attachmentIds) {
            try {
                attachmentIdsSet.add((Id)singleId);
            } catch (Exception e) {
                continue;
            }
        }
        if(!attachmentIdsSet.isEmpty()) {
            String query = 'Select Id, Name From Attachment Where Id in :attachmentIdsSet';
            List<Attachment> attachments = Database.query(query);
            delete attachments;
            result = true;
        }
        return result;
    }
}