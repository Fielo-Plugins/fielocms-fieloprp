global class NewInvoiceAPI implements FieloCMS.ViewInterface{
	global ApexPages.Component getComponent(FieloCMS__Component__c c){
        Component.Widget2 newInvoice = new Component.Widget2(config = c);
        return newInvoice;
    }
}