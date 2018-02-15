global class FieloCMSPRP_CloneInvoiceButtonAPI implements FieloCMS.ViewSubComponentInterface{
    public ApexPages.Component getSubComponent(FieloCMS.Field field, SObject record){
        Component.FieloCMSPRP_CloneInvoiceButton button = new Component.FieloCMSPRP_CloneInvoiceButton();
        if(record != null){
            button.record = record;
        }else{
            button.expressions.record = '{!record}';
        }

        String pathPrefix = !Test.isRunningTest() ? Site.getPathPrefix() : '';

        String clonePageField = (field == null ? '' : (field.attributes == null ? '' : (field.attributes.containsKey('cloneRedirectPage') ? (field.attributes.get('cloneRedirectPage') instanceof Id ? 'pageId' : 'p') : '')));

        button.href = (pathPrefix != '' ? pathPrefix + '/' : '');

        if (clonePageField != '' || Test.isRunningTest()) {
            button.href += '?' + clonePageField + '=' + (field != null ? (field.attributes != null ? field.attributes.get('cloneRedirectPage') : '') : '') + '&cloneId=';
        }

        return button;
    }
}