@isTest
private class FieloCMSPRP_CloneInvoiceButtonAPITest{

    public class FieldTest{
        String apiName {get;set;}
        String Label {get;set;}
        String type {get;set;}
        Boolean showLabel {get;set;}
        Map<String,Object> attributes {get;set;}
    }

    private static testMethod void FieloCMSPRP_CloneInvoiceButtonAPI(){

        Id programId = FieloCMSPLT_MockupFactory.createProgram();

        Id memberId = FieloCMSPLT_MockupFactory.createMember('Member 1', 'a@b.com.br', programId, null);

        Account a = new Account(Name = 'Account');
        insert a;

        FieloPRP__Invoice__c invoice = new FieloPRP__Invoice__c(
            FieloPRP__InvoiceNumber__c = 'XPTO',
            FieloPRP__Date__c = System.today(),
            FieloPRP__Description__c = 'teste',
            FieloPRP__Distributor__c = a.Id,
            FieloPRP__Member__c = memberId
        );
        insert invoice;

        Attachment at = new Attachment(
            ParentId = invoice.Id,
            Name = 'Test',
            Body = Blob.valueOf('Test')
        );
        insert at;

        FieloCMSPRP_CloneInvoiceButtonAPI c = new FieloCMSPRP_CloneInvoiceButtonAPI();

        Test.startTest();

        ApexPages.Component button = c.getSubComponent(null,invoice);
        
        button = c.getSubComponent(null,null);

        Test.stopTest();
    }
}