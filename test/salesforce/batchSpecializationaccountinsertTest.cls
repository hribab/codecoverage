@isTest
private class batchSpecializationaccountinsertTest {

    @testSetup
    static void setupTestData() {
        Account testAccount = new Account(Name = 'Test Account', status__c = 'Active', RecordType__c = 'Enterprise - Business Partner');
        insert testAccount;
    }

    // Test case 1: Test start method with active accounts
    @isTest
    static void testStartActiveAccounts() {
        batchSpecializationaccountinsert batchJob = new batchSpecializationaccountinsert();
        
        Test.startTest();
        Database.QueryLocator ql = batchJob.start(null);
        Test.stopTest();
        
        Integer expectedCount = [SELECT COUNT() FROM Account WHERE status__c = 'Active' and RecordType__c = 'Enterprise - Business Partner'];
        System.assertEquals(expectedCount, ql.getQuery().getTotalSize(), 'start method should return active accounts');
    }

    // Test case 2: Test start method with no active accounts
    @isTest
    static void testStartNoActiveAccounts() {
        update new Account(Id = [SELECT Id FROM Account LIMIT 1].Id, status__c = 'Inactive');
        
        batchSpecializationaccountinsert batchJob = new batchSpecializationaccountinsert();
        
        Test.startTest();
        Database.QueryLocator ql = batchJob.start(null);
        Test.stopTest();

        System.assertEquals(0, ql.getQuery().getTotalSize(), 'start method should return no accounts when none are active');
    }

    // Test case 3: Test execute method with no accounts
    @isTest
    static void testExecuteWithNoAccounts() {
        batchSpecializationaccountinsert batchJob = new batchSpecializationaccountinsert();
          
        Test.startTest();
        batchJob.execute(null, new List<Account>());
        Test.stopTest();

        // Assert no accounts are updated since the method was called with no accounts
        System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Specialization__c != null], 'no accounts should be updated');
    }

    // Test case 4: Test execute method with one account
    @isTest
    static void testExecuteWithOneAccount() {
        PartnerSpecializationUtility sUtil = new PartnerSpecializationUtility();
        Account testAccount = [SELECT Id FROM Account LIMIT 1];

        batchSpecializationaccountinsert batchJob = new batchSpecializationaccountinsert();
        
        Test.startTest();
        batchJob.execute(null, new List<Account>{testAccount});
        Test.stopTest();

        // Assert the account is updated with the correct specialization
        sUtil.accountId = testAccount.Id;
        sUtil.getSpecializationByOffering();

        Account updatedAccount = [SELECT Specialization__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(sUtil.specialization, updatedAccount.Specialization__c, 'the account should be updated with the correct specialization');
    }

    // Test case 5: Test finish method
    @isTest
    static void testFinish() {
        batchSpecializationaccountinsert batchJob = new batchSpecializationaccountinsert();
        
        Test.startTest();
        batchJob.finish(null);
        Test.stopTest();

        // No exception should be thrown, as no code is present in the finish method
    }
}