@isTest
private class FieloCMSPRP_FieldTest{

    private static testMethod void fieldTest(){

    	Map<String,Object> mapValues = new Map<String,Object>();
    	mapValues.put('apiName','test');
    	mapValues.put('label','test');
    	mapValues.put('type','test');
        FieloCMSPRP_Field field1 = new FieloCMSPRP_Field(mapValues);
        String test = field1.apiName;
        test = field1.label;
        test = field1.type;
        test = field1.attributesJSON;
        Boolean testbool = field1.multiLanguage;
        testbool = field1.showLabel;

        FieloCMSPRP_Field field2 = new FieloCMSPRP_Field(mapValues, Account.Name.getDescribe());
        FieloCMSPRP_Field field3 = new FieloCMSPRP_Field(Account.Name.getDescribe(), 'Record-Edit');

        List<FieloCMSPRP_Field> elements = new List<FieloCMSPRP_Field>{field1,field2,field3};
        elements.sort();
        Boolean areEquals = field2.equals(field3);
        Set<FieloCMSPRP_Field> setFields = new Set<FieloCMSPRP_Field>();
        setFields.add(field2);
        setFields.add(field3);

        mapValues.put('type','Picklist');
        FieloCMSPRP_Field field4 = new FieloCMSPRP_Field(mapValues, Account.Type.getDescribe());
        FieloCMSPRP_Field field5 = new FieloCMSPRP_Field(Account.Name.getDescribe(), 'List');
    }
}