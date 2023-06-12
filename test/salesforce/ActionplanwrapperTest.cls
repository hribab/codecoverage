@isTest
private class ActionplanwrapperTest {
    @isTest
    static void testActionplanWrapperConstructorWithSAP() {
        // Test case 1: Testing the constructor with Salesaid_Action_Plan__c parameter
        
        Salesaid_Action_Plan__c testSAP = new Salesaid_Action_Plan__c(
            Complete__c = false,
            Description__c = 'Test Description',
            Owner__c = 'Test Owner',
            Proposed_Activity__c = 'Test Activity',
            target_Date__c = Date.newInstance(2022, 10, 11)
        );
        insert testSAP;

        Actionplanwrapper testWrapper = new Actionplanwrapper(testSAP);

        System.assertEquals(testSAP.id, testWrapper.ActionplanID);
        System.assertEquals(testSAP.Complete__c, testWrapper.Complete);
        System.assertEquals(testSAP.Description__c, testWrapper.Description);
        System.assertEquals(testSAP.Owner__c, testWrapper.Owner);
        System.assertEquals(testSAP.Proposed_Activity__c, testWrapper.Activity);
        System.assertEquals(testSAP.target_Date__c, testWrapper.target);
    }

    @isTest
    static void testActionplanWrapperConstructorWithIndex() {
        // Test case 2: Testing the constructor with Integer parameter

        Integer testIndex = 5;
        Actionplanwrapper testWrapper = new Actionplanwrapper(testIndex);

        System.assertEquals(testIndex, testWrapper.index);
        System.assertEquals(testIndex + 1, testWrapper.SAP.rownumber__c);
    }

    @isTest
    static void testActionplanWrapperConstructorWithNegativeIndex() {
        // Test case 3: Testing the constructor with a negative Integer parameter

        Integer testIndex = -5;
        Actionplanwrapper testWrapper = new Actionplanwrapper(testIndex);

        System.assertEquals(testIndex, testWrapper.index);
        System.assertEquals(testIndex + 1, testWrapper.SAP.rownumber__c);
    }

    @isTest
    static void testActionplanWrapperConstructorWithZeroIndex() {
        // Test case 4: Testing the constructor with a zero Integer parameter

        Integer testIndex = 0;
        Actionplanwrapper testWrapper = new Actionplanwrapper(testIndex);

        System.assertEquals(testIndex, testWrapper.index);
        System.assertEquals(testIndex + 1, testWrapper.SAP.rownumber__c);
    }

    @isTest
    static void testActionplanWrapperConstructorWithLargeIndex() {
        // Test case 5: Testing the constructor with a large Integer parameter

        Integer testIndex = 1000000;
        Actionplanwrapper testWrapper = new Actionplanwrapper(testIndex);

        System.assertEquals(testIndex, testWrapper.index);
        System.assertEquals(testIndex + 1, testWrapper.SAP.rownumber__c);
    }
}