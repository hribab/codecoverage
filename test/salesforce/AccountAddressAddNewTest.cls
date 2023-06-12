@isTest
private class AccountAddressAddNewTest {

    // Helper method to create a test account with address fields
    private static Account createTestAccount() {
        Account testAccount = new Account(Name = 'Test Account');
        testAccount.Street1__c = '123 test street';
        testAccount.Street2__c = 'Apt. 456';
        testAccount.City__c = 'Test City';
        testAccount.StateProvince__c = 'TS';
        testAccount.ZipCode__c = '12345';
        insert testAccount;
        
        Country__c testCountry = new Country__c(Name = 'Test Country');
        insert testCountry;
        
        testAccount.Country__c = testCountry.Id;
        update testAccount;
        
        return testAccount;
    }

    // Test case 1: Account has a valid address
    @isTest
    static void validAddress() {
        Account testAccount = createTestAccount();
        
        Test.startTest();
        AccountAddressAddNew addr = new AccountAddressAddNew(testAccount);
        Test.stopTest();
        
        Address__c result = [SELECT Id, Account__c, Address_Line_1__c FROM Address__c WHERE Account__c = :testAccount.Id];
        System.assertEquals(testAccount.Id, result.Account__c);
        System.assertEquals('123 test street', result.Address_Line_1__c);
    }

    // Test case 2: Account has an empty street1 address
    @isTest
    static void emptyStreet1() {
        Account testAccount = createTestAccount();
        testAccount.Street1__c = '';
        update testAccount;
        
        Test.startTest();
        AccountAddressAddNew addr = new AccountAddressAddNew(testAccount);
        Test.stopTest();
        
        Integer resultCount = [SELECT count() FROM Address__c WHERE Account__c = :testAccount.Id];
        System.assertEquals(0, resultCount);
    }

    // Test case 3: Account has a null street1 address
    @isTest
    static void nullStreet1() {
        Account testAccount = createTestAccount();
        testAccount.Street1__c = null;
        update testAccount;
        
        Test.startTest();
        AccountAddressAddNew addr = new AccountAddressAddNew(testAccount);
        Test.stopTest();

        Integer resultCount = [SELECT count() FROM Address__c WHERE Account__c = :testAccount.Id];
        System.assertEquals(0, resultCount);
    }

    // Test case 4: Account has a valid address but exception occurs during insert
    @isTest
    static void exceptionDuringInsert() {
        Account testAccount = createTestAccount();

        // Cause an exception by not providing a required field value
        testAccount.Name = '';
        update testAccount;
        
        Test.startTest();
        AccountAddressAddNew addr = new AccountAddressAddNew(testAccount);
        Test.stopTest();
        
        Integer resultCount = [SELECT count() FROM Address__c WHERE Account__c = :testAccount.Id];
        System.assertEquals(0, resultCount);
    }

    // Test case 5: Account has a valid address and a non-existing country ID
    @isTest
    static void nonExistingCountry() {
        Account testAccount = createTestAccount();

        // Update account with a non-existing country ID
        testAccount.Country__c = 'a06XXXXXXXXXXXXX';
        update testAccount;
        
        Test.startTest();
        AccountAddressAddNew addr = new AccountAddressAddNew(testAccount);
        Test.stopTest();
        
        Integer resultCount = [SELECT count() FROM Address__c WHERE Account__c = :testAccount.Id];
        System.assertEquals(0, resultCount);
    }
}