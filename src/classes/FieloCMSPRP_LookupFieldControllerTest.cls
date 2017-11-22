@isTest
private class FieloCMSPRP_LookupFieldControllerTest{

    private static testMethod void lookupFieldTest(){
        FieloCMSPRP_LookupFieldController.csObject = '[Account]';
        String whereCondition = 'Name = \'Test\'';
        FieloCMSPRP_LookupFieldController.getValues('Account', 5, 1, null, whereCondition);
		SObject testRecord = FieloCMSPRP_LookupFieldController.record;
    }
}