@isTest
private class BatchScheduleUpdateTest {

    // Test case 1: Test the execute method with a non-empty database and with a batch size of 10
    @isTest
    static void testExecuteNonEmptyDatabaseBatchSize10() {

        // Insert test data
        insertTestData();

        // Create a new instance of BatchScheduleUpdate, then call the execute method
        BatchScheduleUpdate bsu = new BatchScheduleUpdate();
        Test.startTest();
        bsu.execute(null);
        Test.stopTest();

        // Check the results
        System.assertEquals(10, [SELECT count() FROM Account WHERE Specialization__c = 'Test']);    
    }

    // Test case 2: Test the execute method with an empty database and with a batch size of 10
    @isTest
    static void testExecuteEmptyDatabaseBatchSize10()
    {
        // Create a new instance of BatchScheduleUpdate, then call the execute method
        BatchScheduleUpdate bsu = new BatchScheduleUpdate();
        Test.startTest();
        bsu.execute(null);
        Test.stopTest();

        // Check the results
        System.assertEquals(0, [SELECT count() FROM Account WHERE Specialization__c = 'Test']);    
    }

    // Test case 3: Test the execute method with a non-empty database and with a batch size of 5
    @isTest
    static void testExecuteNonEmptyDatabaseBatchSize5()
    {
        // Insert test data
        insertTestData();

        // Create a new instance of BatchScheduleUpdate, then call the execute method
        BatchScheduleUpdate bsu = new BatchScheduleUpdate();
        Test.startTest();
        bsu.execute(null, 5);
        Test.stopTest();

        // Check the results
        System.assertEquals(10, [SELECT count() FROM Account WHERE Specialization__c = 'Test']);
    }

    // Test case 4: Test the execute method with a non-empty database and with a batch size of 1
    @isTest
    static void testExecuteNonEmptyDatabaseBatchSize1()
    {
        // Insert test data
        insertTestData();

        // Create a new instance of BatchScheduleUpdate, then call the execute method
        BatchScheduleUpdate bsu = new BatchScheduleUpdate();
        Test.startTest();
        bsu.execute(null, 1);
        Test.stopTest();

        // Check the results
        System.assertEquals(10, [SELECT count() FROM Account WHERE Specialization__c = 'Test']);
    }

    // Test case 5: Test the execute method with a non-empty database and with a batch size of 20
    @isTest
    static void testExecuteNonEmptyDatabaseBatchSize20()
    {
        // Insert test data
        insertTestData();

        // Create a new instance of BatchScheduleUpdate, then call the execute method
        BatchScheduleUpdate bsu = new BatchScheduleUpdate();
        Test.startTest();
        bsu.execute(null, 20);
        Test.stopTest();

        // Check the results
        System.assertEquals(10, [SELECT count() FROM Account WHERE Specialization__c = 'Test']);
    }

    // Helper method to insert test data
    private static void insertTestData()
    {
        // Create a list of Accounts
        List<Account> accounts = new List<Account>();

        // Populate the list with 10 test Accounts
        for (Integer i = 0; i < 10; i++)
        {
            Account acc = new Account(Name = 'Test Account ' + i);
            accounts.add(acc);
        }

        // Insert the list of Accounts
        insert accounts;
    }
}