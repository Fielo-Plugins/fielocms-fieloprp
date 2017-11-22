@isTest
private class FieloCMSPRP_InvoiceItemApiTest{

    private static testMethod void invoicesitemApi(){

        Id programId = FieloCMSPLT_MockupFactory.createProgram();
        update new FieloPLT__Program__c(Id = programId, FieloPRP__RequestInvoiceProducts__c = true);

        Id componentLibraryId = FieloCMSPLT_MockupFactory.createComponentLibrary();
        Id subsectionId = FieloCMSPLT_MockupFactory.createMenuSection();

        FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = programId, FieloPLT__User__c = UserInfo.getUserId());
        insert member;

        FieloPRP__Invoice__c invoice = new FieloPRP__Invoice__c(FieloPRP__Date__c = Date.today(), FieloPRP__Member__c = member.Id);
        insert invoice;

        FieloPRP__InvoiceItem__c invoiceItem = new FieloPRP__InvoiceItem__c(FieloPRP__Invoice__c = invoice.Id, FieloPRP__TotalPrice__c = 20);
        insert invoiceItem;

        FieloCMS__Component__c component1 = new FieloCMS__Component__c( Name = 'Default', FieloCMS__Section__c = subsectionId, FieloCMS__ComponentLibrary__c = componentLibraryId, FieloCMS__DetailView__c = 'Modal' );
        insert component1;
        
        FieloCMSPRP_InvoiceItemAPI c = new FieloCMSPRP_InvoiceItemAPI();
        c.invoiceId = invoice.Id;
        c.getBulkData( new List<FieloCMS__Component__c> { component1 } );
        c.getData( component1 , 2, null, null );
    }
}