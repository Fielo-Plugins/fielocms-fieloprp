@isTest
private class FieloCMSPRP_InvoiceApiTest{

    private static testMethod void invoicesApi(){

        Id programId = FieloCMSPLT_MockupFactory.createProgram();

        Id componentLibraryId = FieloCMSPLT_MockupFactory.createComponentLibrary();
        Id subsectionId = FieloCMSPLT_MockupFactory.createMenuSection();

        FieloPLT__Member__c member = new FieloPLT__Member__c(Name = 'test', FieloPLT__Email__c = 'test@fielo.com', FieloPLT__Program__c = programId, FieloPLT__User__c = UserInfo.getUserId());
        insert member;

        FieloPRP__Invoice__c invoice = new FieloPRP__Invoice__c(FieloPRP__Date__c = Date.today(), FieloPRP__Member__c = member.Id, FieloPRP__Amount__c = 100);
        insert invoice;

        FieloCMS__Component__c component1 = new FieloCMS__Component__c( Name = 'Default', FieloCMS__Section__c = subsectionId, FieloCMS__ComponentLibrary__c = componentLibraryId, FieloCMS__DetailView__c = 'Modal' );
        insert component1;
        
        FieloCMSPRP_InvoiceAPI c = new FieloCMSPRP_InvoiceAPI();
        c.getBulkData( new List<FieloCMS__Component__c> { component1 } );
        c.getData( component1 , 2, null, null );
    }
}