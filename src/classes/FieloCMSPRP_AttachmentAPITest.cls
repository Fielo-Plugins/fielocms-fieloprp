@isTest
private class FieloCMSPRP_AttachmentAPITest{

    private static testMethod void attachmentApi(){

        Id programId = FieloCMSPLT_MockupFactory.createProgram();

        Id componentLibraryId = FieloCMSPLT_MockupFactory.createComponentLibrary();
        FieloCMS__ComponentLibrary__c compLib = new FieloCMS__ComponentLibrary__c(Id = componentLibraryId, Name = 'Attachments View');
        Id subsectionId = FieloCMSPLT_MockupFactory.createMenuSection();

        FieloCMS__Component__c component1 = new FieloCMS__Component__c( Name = 'Default', FieloCMS__Section__c = subsectionId, FieloCMS__ComponentLibrary__c = componentLibraryId, FieloCMS__DetailView__c = 'Modal' );
        component1.FieloCMS__ComponentLibrary__r = compLib;
        insert component1;
        
        Account a = new Account(Name = 'Account');
        insert a;

        Attachment at = new Attachment(ParentId = a.Id, Name = 'Test', Body = Blob.valueOf('Test'));
        insert at;

        FieloCMSPRP_AttachmentAPI c = new FieloCMSPRP_AttachmentAPI();
        c.getBulkData( new List<FieloCMS__Component__c> { component1 } );
        c.getData( component1 , 1, null, null );
    }
}