global class FieloCMSPRP_FormInvoiceAPI implements FieloCMS.ViewInterface{
	global ApexPages.Component getComponent(FieloCMS__Component__c c){
        String query = 'Select FieloCMS__FieldSet__c, FieloCMS__Layout__c, FieloCMS__ComponentLibrary__r.FieloCMS__sObject__c FROM FieloCMS__Component__c ' +
            ' WHERE Id in (\'' + c.FieloCMSPRP_MainSourceComponent__c + '\',\'' + c.FieloCMSPRP_SecondarySourceComponent__c + '\',\'' + c.FieloCMSPRP_ProductSourceComponent__c + '\')';

        Map<Id,FieloCMS__Component__c> components = new Map<Id,FieloCMS__Component__c>( (List<FieloCMS__Component__c>) Database.query(query));

        FieloCMS__Component__c mainComponent = components.get(c.FieloCMSPRP_MainSourceComponent__c);
        FieloCMS__Component__c secondaryComponent = components.get(c.FieloCMSPRP_SecondarySourceComponent__c);
        FieloCMS__Component__c productComponent = components.get(c.FieloCMSPRP_ProductSourceComponent__c);

        List<FieloCMSPRP_Field> invoiceFieldSet = getFieldsStructure(mainComponent, mainComponent.FieloCMS__ComponentLibrary__r.FieloCMS__sObject__c);
        List<FieloCMSPRP_Field> invoiceItemFieldSet = getFieldsStructure(secondaryComponent, secondaryComponent.FieloCMS__ComponentLibrary__r.FieloCMS__sObject__c);
		List<FieloCMSPRP_Field> productFieldSet = getFieldsStructure(productComponent, productComponent.FieloCMS__ComponentLibrary__r.FieloCMS__sObject__c);

        //Check for required fields
        invoiceItemFieldSet = addItemsRequiredFields(invoiceItemFieldSet);
        
        Component.FieloCMSPRP_FormInvoice formInvoice = new Component.FieloCMSPRP_FormInvoice(config = c);
        formInvoice.mainObject = mainComponent.FieloCMS__ComponentLibrary__r.FieloCMS__sObject__c;
        formInvoice.secondaryObject = secondaryComponent.FieloCMS__ComponentLibrary__r.FieloCMS__sObject__c;
        formInvoice.productObject = productComponent.FieloCMS__ComponentLibrary__r.FieloCMS__sObject__c;
        formInvoice.invoiceFieldSet = invoiceFieldSet;
        formInvoice.invoiceItemFieldSet = invoiceItemFieldSet;
        formInvoice.productFieldSet = productFieldSet;
        formInvoice.record = new FieloPRP__Invoice__c();
        formInvoice.itemRecord = new FieloPRP__InvoiceItem__c(FieloPRP__Quantity__c=0);

        Set<String> productFields = new Set<String>();
        for(FieloCMSPRP_Field productField: productFieldSet) {
            productFields.add(productField.apiName);
        }

        formInvoice.recentProducts = Database.query('Select ' + String.join(new List<String>(productFields),',') + ' From ' + formInvoice.productObject + ' ORDER BY LastModifiedDate LIMIT 10');
        FieloPLT__PublicSettings__c pubSettings = FieloPLT__PublicSettings__c.getInstance(UserInfo.getProfileId());
        formInvoice.productFieldName = pubSettings.FieloPRP__ProductLookupField__c;

        return formInvoice;
    }

    public static List<FieloCMSPRP_Field> getFieldsStructure(FieloCMS__Component__c component, String sObjectName){
        List<FieloCMSPRP_Field> fieldsList = new List<FieloCMSPRP_Field>();
        if(component.FieloCMS__FieldSet__c != null){
            Map<String,Schema.SObjectField> fieldsDescribeMap = Schema.describeSObjects(new String[]{ sObjectName })[0].fields.getMap();
            
            for(Object field : (List<Object>)JSON.deserializeUntyped(component.FieloCMS__FieldSet__c)){
                Map<String, Object> attributes = (Map<String, Object>)field;
                // Si es un campo verifica que tenga acceso de lectura y/o esritura ( caso de un Edit)
                if ( attributes.get('type') != 'Subcomponent' ) {
                    Schema.DescribeFieldResult describeField = fieldsDescribeMap.get( (String) attributes.get('apiName') ).getDescribe();
                    if(describeField.isAccessible() && (component.FieloCMS__Layout__c != 'Edit' || describeField.isUpdateable())){
                        fieldsList.add( new FieloCMSPRP_Field( attributes, describeField ) );
                    }
                } else {
                    fieldsList.add( new FieloCMSPRP_Field( attributes ) );
                }

            }
        }
        system.debug('fieldsList');
        system.debug(fieldsList);
        return fieldsList;
    }

    public static List<FieloCMSPRP_Field> addItemsRequiredFields(List<FieloCMSPRP_Field> fieldSet) {
        Set<String> fieldNames = new Set<String>();
        List<FieloCMSPRP_Field> fields = new List<FieloCMSPRP_Field>();
        for (FieloCMSPRP_Field field: fieldSet) {
            fieldNames.add(field.apiName);
        }
        if (!fieldNames.contains('FieloPRP__Quantity__c')) {
            DescribeFieldResult fieldDescribe = Schema.describeSObjects(new String[]{ 'FieloPRP__InvoiceItem__c' })[0].fields.getMap().get('FieloPRP__Quantity__c').getDescribe();
            fields.add(
                new FieloCMSPRP_Field(
                    new Map<String, Object> {
                        'type' => String.valueOf(fieldDescribe.getType()),
                        'apiName' => fieldDescribe.getName(),
                        'label'=> fieldDescribe.getLabel()
                    }
                )
            );
        }
        fields.addAll(fieldSet);
        return fields;
    }
    
    @RemoteAction
    global static Map<String, Object> submit(FieloPRP__Invoice__c invoice, List<FieloPRP__InvoiceItem__c> items, List<Attachment> attachments, String submitMode) {
        invoice.FieloPRP__Member__c = MemberService.getCurrentMemberId();
        try{
            FieloPRP__Invoice__c submittedInvoice = FieloPRP.InvoiceService.submitInvoice(invoice, items, attachments);
            if (submitMode == 'Close') {
                submittedInvoice = FieloPRP.InvoiceService.closeInvoice(submittedInvoice.Id);
            }
            return new Map<String, Object>{
                'object' => submittedInvoice,
                'status' => 'OK'
            };
        } catch (DmlException e) {
            return new Map<String, Object>{
                'result' => '',
                'status' => 'NOK',
                'message' => e.getDmlMessage(0)
            };
        }
    }

    public String currencyCode {get{
        return UserInfo.getDefaultCurrency();
    }
        set;
    }

    public FieloPLT__Program__c currentProgram {get{
        Id memberId = MemberService.getCurrentMemberId();
        FieloPLT__Member__c member = [SELECT Id, Name, FieloPLT__Program__r.Id, FieloPLT__Program__r.Name, FieloPLT__Program__r.FieloPRP__RequestInvoiceProducts__c, FieloPLT__Program__r.FieloPRP__ProductInjectQuery__c FROM FieloPLT__Member__c WHERE Id = :memberId];
        return member.FieloPLT__Program__r;
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

    @RemoteAction
    global static List<sObject> queryRecords(String objectName, List<String> fields, String filter, Integer offSet, String injectQuery) {
        String query = 'Select ' +
            String.join(new List<String>(new Set<String>(fields)), ',') +
            ' FROM ' +
            objectName;
        Map<String, String> filterMap;
        if (filter != '') {
            filterMap = (Map<String, String>) JSON.deserialize(filter, Map<String, String>.class);
        }
        String whereClause = '';
        List<String> statements = new List<String>();
        for(String fieldName: filterMap.keySet()) {
            if (filterMap.get(fieldName) != '') {
                statements.add(fieldName + ' like \'%' + filterMap.get(fieldName) + '%\'');
            }
        }
        if (!statements.isEmpty()) {
            whereClause = String.join(statements, ' AND ');
            if (injectQuery!='') {
                whereClause += ' AND ' + injectQuery;
            }
        } else if (injectQuery!='') {
            whereClause = injectQuery;
        }
        if (whereClause != '') {
            query += ' WHERE ' + whereClause;
        }
        query += ' ORDER BY LastModifiedDate DESC ';
        // query += ' LIMIT 30';
        query += ' OFFSET ' + String.valueOf(offSet);

        system.debug('query');
        system.debug(query);

        return Database.query(query);
    }
}