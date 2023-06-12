@isTest
private class AccountEngScoreHistoryBatchTest {
    
    @testSetup
    static void setupTestData() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            Account a = new Account(Name = 'Test Account ' + i);
            accounts.add(a);
        }
        insert accounts;
    }

    // Test case 1: Test the batch with valid Query
    static testMethod void testValidQuery() {
        String query = 'SELECT Id, Name FROM Account';
        AccountEngScoreHistoryBatch batch = new AccountEngScoreHistoryBatch(query);
        
        Test.startTest();
        Id jobId = Database.executeBatch(batch);
        Test.stopTest();
        
        System.assertEquals(jobId, batch.AccountID.getID());
    }

    // Test case 2: Test the batch with invalid Query
    static testMethod void testInvalidQuery() {
        String query = 'SELECT Invalid_Field FROM Account';
        AccountEngScoreHistoryBatch batch;
        try {
            batch = new AccountEngScoreHistoryBatch(query);
            Database.executeBatch(batch);
        } catch (Exception e) {
            System.assert(e.getMessage().contains('Invalid_Field'));
        }
    }

    // Test case 3: Test the batch with empty Query
    static testMethod void testEmptyQuery() {
        String query = '';
        AccountEngScoreHistoryBatch batch;
        try {
            batch = new AccountEngScoreHistoryBatch(query);
            Database.executeBatch(batch);
        } catch (Exception e) {
            System.assert(e.getMessage().contains('EmptyQueryException'));
        }
    }

    // Test case 4: Test the batch with null Query
    static testMethod void testNullQuery() {
        String query = null;
        AccountEngScoreHistoryBatch batch;
        try {
            batch = new AccountEngScoreHistoryBatch(query);
            Database.executeBatch(batch);
        } catch (Exception e) {
            System.assert(e.getMessage().contains('NullQueryException'));
        }
    }

    // Test case 5: Test the batch with different batch sizes
    static testMethod void testBatchSizes() {
        String query = 'SELECT Id, Name FROM Account';
        AccountEngScoreHistoryBatch batch = new AccountEngScoreHistoryBatch(query);
        
        Test.startTest();
        Id jobId = Database.executeBatch(batch, 1);
        Test.stopTest();
        
        System.assertEquals(jobId, batch.AccountID.getID());
        
        Test.startTest();
        jobId = Database.executeBatch(batch, 5);
        Test.stopTest();
        
        System.assertEquals(jobId, batch.AccountID.getID());
    }
}