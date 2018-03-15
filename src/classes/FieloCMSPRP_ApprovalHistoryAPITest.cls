@isTest
public class FieloCMSPRP_ApprovalHistoryAPITest {

    private static testMethod void approvalHistoryAPI(){

        Id programId = FieloCMSPLT_MockupFactory.createProgram();

        Id componentLibraryId = FieloCMSPLT_MockupFactory.createComponentLibrary();
        FieloCMS__ComponentLibrary__c compLib = new FieloCMS__ComponentLibrary__c(Id = componentLibraryId, Name = 'Attachments View');
        Id subsectionId = FieloCMSPLT_MockupFactory.createMenuSection();

        FieloCMS__Component__c component1 = new FieloCMS__Component__c( Name = 'Default', FieloCMS__Section__c = subsectionId, FieloCMS__ComponentLibrary__c = componentLibraryId, FieloCMS__DetailView__c = 'Modal' );
        component1.FieloCMS__ComponentLibrary__r = compLib;
        component1.FieloCMS__DetailParameter__c = 'id';
        insert component1;

        Id memberId = FieloCMSPLT_MockupFactory.createMember('Member 1', 'a@b.com.br', programId, null);

        Account a = new Account(Name = 'Account');
        insert a;

        FieloPRP__Invoice__c invoice = new FieloPRP__Invoice__c(
            FieloPRP__InvoiceNumber__c = 'XPTO',
            FieloPRP__Date__c = System.today(),
            FieloPRP__Description__c = 'teste',
            FieloPRP__Distributor__c = a.Id,
            FieloPRP__Amount__c = 10,
            FieloPRP__Member__c = memberId
        );
        insert invoice;

        invoice.FieloPRP__Status__c = 'Approved';

        update invoice;

        Test.setCurrentPageReference(new PageReference('Page.fielocms__page')); 
		System.currentPageReference().getParameters().put('id', invoice.Id);

        FieloCMSPRP_ApprovalHistoryAPI c = new FieloCMSPRP_ApprovalHistoryAPI();
        c.getBulkData( new List<FieloCMS__Component__c> { component1 } );
        c.getData( component1 , 1, null, null );
    }
}