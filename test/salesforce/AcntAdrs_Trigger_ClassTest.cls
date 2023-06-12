@isTest
private class AcntAdrs_Trigger_Class_Test {
    // Helper method to create a test Account
    private static Account createTestAccount(String name) {
        Account testAccount = new Account(Name = name);
        insert testAccount;
        return testAccount;
    }
    
    // Helper method to create a test Address
    private static Address__c createTestAddress(Id accountId, String type, Boolean isPrimary) {
        Address__c testAddress = new Address__c(Account__c = accountId, Type__c = type, Is_Primary__c = isPrimary);
        insert testAddress;
        return testAddress;
    }

    // Test case 1: After inserting a new 'Sold To' address
    @isTest static void testOnAfterInsert_NewSoldTo() {
        Account testAccount = createTestAccount('Test Account 1');

        Address__c newAddress = createTestAddress(testAccount.Id, 'Sold To', false);
        Test.startTest();
        AcntAdrs_Trigger_Class.onAfterInsert(new List<Address__c>{newAddress});
        Test.stopTest();

        Address__c updatedAddress = [SELECT Id, Is_Primary__c FROM Address__c WHERE Id = :newAddress.Id];
        System.assertEquals(true, updatedAddress.Is_Primary__c, 'Newly inserted Sold To address should be set as primary');
    }
    
    // Test case 2: After inserting a new 'End User' address with no existing Sold To address
    @isTest static void testOnAfterInsert_NewEndUser_NoSoldTo() {
        Account testAccount = createTestAccount('Test Account 2');

        Address__c newAddress = createTestAddress(testAccount.Id, 'End User', false);
        Test.startTest();
        AcntAdrs_Trigger_Class.onAfterInsert(new List<Address__c>{newAddress});
        Test.stopTest();

        Address__c updatedAddress = [SELECT Id, Is_Primary__c FROM Address__c WHERE Id = :newAddress.Id];
        System.assertEquals(true, updatedAddress.Is_Primary__c, 'Newly inserted End User address should be set as primary');
    }
    
    // Test case 3: After inserting a new 'End User' address with an existing Sold To address
    @isTest static void testOnAfterInsert_NewEndUser_WithSoldTo() {
        Account testAccount = createTestAccount('Test Account 3');
        Address__c soldToAddress = createTestAddress(testAccount.Id, 'Sold To', true);

        Address__c newAddress = createTestAddress(testAccount.Id, 'End User', false);
        Test.startTest();
        AcntAdrs_Trigger_Class.onAfterInsert(new List<Address__c>{newAddress});
        Test.stopTest();
        
        Address__c updatedSoldTo = [SELECT Id, Is_Primary__c FROM Address__c WHERE Id = :soldToAddress.Id];
        Address__c updatedEndUser = [SELECT Id, Is_Primary__c FROM Address__c WHERE Id = :newAddress.Id];
        System.assertEquals(true, updatedSoldTo.Is_Primary__c, 'Existing Sold To address should remain primary');
        System.assertEquals(false, updatedEndUser.Is_Primary__c, 'Newly inserted End User address should NOT be set as primary');
    }
    
    // Test case 4: After inserting a new 'Bill To' address with no existing 'Sold To' or 'End User' addresses
    @isTest static void testOnAfterInsert_NewBillTo_NoExisting() {
        Account testAccount = createTestAccount('Test Account 4');

        Address__c newAddress = createTestAddress(testAccount.Id, 'Bill To', false);
        Test.startTest();
        AcntAdrs_Trigger_Class.onAfterInsert(new List<Address__c>{newAddress});
        Test.stopTest();

        Address__c updatedAddress = [SELECT Id, Is_Primary__c FROM Address__c WHERE Id = :newAddress.Id];
        System.assertEquals(true, updatedAddress.Is_Primary__c, 'Newly inserted Bill To address should be set as primary');
    }
    
    // Test case 5: After inserting multiple new addresses
    @isTest static void testOnAfterInsert_MultipleNewAddresses() {
        Account testAccount = createTestAccount('Test Account 5');

        Address__c newAddress1 = createTestAddress(testAccount.Id, 'Corporate', false);
        Address__c newAddress2 = createTestAddress(testAccount.Id, 'Ship To', false);
        Address__c newAddress3 = createTestAddress(testAccount.Id, 'Bill To', false);
        Address__c newAddress4 = createTestAddress(testAccount.Id, 'End User', false);
        Address__c newAddress5 = createTestAddress(testAccount.Id, 'Sold To', false);
        
        Test.startTest();
        AcntAdrs_Trigger_Class.onAfterInsert(new List<Address__c>{newAddress1, newAddress2, newAddress3, newAddress4, newAddress5});
        Test.stopTest();
        
        Address__c updatedAddress1 = [SELECT Id, Is_Primary__c FROM Address__c WHERE Id = :newAddress1.Id];
        Address__c updatedAddress2 = [SELECT Id, Is_Primary__c FROM Address__c WHERE Id = :newAddress2.Id];
        Address__c updatedAddress3 = [SELECT Id, Is_Primary__c FROM Address__c WHERE Id = :newAddress3.Id];
        Address__c updatedAddress4 = [SELECT Id, Is_Primary__c FROM Address__c WHERE Id = :newAddress4.Id];
        Address__c updatedAddress5 = [SELECT Id, Is_Primary__c FROM Address__c WHERE Id = :newAddress5.Id];
        
        System.assertEquals(false, updatedAddress1.Is_Primary__c, 'Newly inserted Corporate address should NOT be set as primary');
        System.assertEquals(false, updatedAddress2.Is_Primary__c, 'Newly inserted Ship To address should NOT be set as primary');
        System.assertEquals(false, updatedAddress3.Is_Primary__c, 'Newly inserted Bill To address should NOT be set as primary');
        System.assertEquals(false, updatedAddress4.Is_Primary__c, 'Newly inserted End User address should NOT be set as primary');
        System.assertEquals(true, updatedAddress5.Is_Primary__c, 'Newly inserted Sold To address should be set as primary');
    }
}