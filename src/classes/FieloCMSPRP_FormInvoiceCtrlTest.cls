@isTest
private class FieloCMSPRP_FormInvoiceCtrlTest{

    private static testMethod void unitTest(){

        Id programId = FieloCMSPLT_MockupFactory.createProgram();

        FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = programId, FieloPLT__User__c = UserInfo.getUserId());
        insert member;

        FieloPRP__Invoice__c invoice = new FieloPRP__Invoice__c(FieloPRP__Date__c = Date.today(), FieloPRP__Member__c = member.Id, FieloPRP__Amount__c = 100);
        insert invoice;

        Id componentLibraryId = FieloCMSPLT_MockupFactory.createComponentLibrary();
        update new FieloCMS__ComponentLibrary__c(Id = componentLibraryId, FieloCMS__SObject__c = 'FieloPRP__Invoice__c');
        //FieloCMS__ComponentLibrary__c compLib = new FieloCMS__ComponentLibrary__c(Id = componentLibraryId, Name = 'Attachments View');
        Id subsectionId = FieloCMSPLT_MockupFactory.createMenuSection();

        FieloCMS__Component__c componentAux = new FieloCMS__Component__c( FieloCMS__Fieldset__c = '', FieloCMS__Section__c = subsectionId, FieloCMS__ComponentLibrary__c = componentLibraryId, FieloCMS__DetailView__c = 'Modal' );
        insert componentAux;

        FieloCMS__Component__c component1 = new FieloCMS__Component__c( Name = 'Default', FieloCMS__Section__c = subsectionId, FieloCMS__ComponentLibrary__c = componentLibraryId, FieloCMS__DetailView__c = 'Modal', FieloCMSPRP_MainSourceComponent__c = componentAux.Id, FieloCMSPRP_SecondarySourceComponent__c = componentAux.Id, FieloCMSPRP_ProductSourceComponent__c = componentAux.Id);

        insert component1;
        
        Attachment at = new Attachment(ParentId = invoice.Id, Name = 'Test', Body = Blob.valueOf('Test'));
        insert at;

        FieloCMSPRP_FormInvoiceCtrl instance = new FieloCMSPRP_FormInvoiceCtrl();
        instance.getComponent( component1 );
        //FieloCMSPRP_FormInvoiceCtrl.getFieldsStructure(component1, 'FieloPRP__Invoice__c');
        
        FieloCMSPRP_Field field3 = new FieloCMSPRP_Field(Account.Name.getDescribe(), 'Record-Edit');
        List<FieloCMSPRP_Field> elements = new List<FieloCMSPRP_Field>{field3};
        FieloCMSPRP_FormInvoiceCtrl.addItemsRequiredFields(elements);
        
        FieloCMSPRP_FormInvoiceCtrl.submit(invoice, null, new List<Attachment>{at}, 'submit');
        String test = instance.currencyCode;
        FieloPLT__Program__c programTest = instance.currentProgram;

        FieloCMSPRP_FormInvoiceCtrl.saveAttachment(invoice.Id, 'Test', 'test', 'jpeg');
        FieloCMSPRP_FormInvoiceCtrl.saveTheChunk(invoice.Id, 'Test', 'test', 'jpeg', at.Id); 
        FieloCMSPRP_FormInvoiceCtrl.queryRecords('FieloPRP__Invoice__c', new List<String>{'Name'}, null, 5, 2, null, null);

        FieloCMSPRP_FormInvoiceCtrl.changeStatus(invoice, 'close');
    }
}