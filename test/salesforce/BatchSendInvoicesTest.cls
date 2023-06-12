@isTest
private class BatchSendInvoicesTest {
    @testSetup
    static void setupTestData() {
        //Create Account
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        //Create Contract
        Contract con = new Contract(AccountId = acc.Id, Status = 'Activated');
        insert con;

        // Create the Invoice
        Invoice__c inv = new Invoice__c(Status__c = 'Invoice Attached', Order__r.Contract_Lookup__c = con.Id);
        insert inv;

        // Create the Cloud_Billing_Log__c record
        Cloud_Billing_Log__c log = new Cloud_Billing_Log__c(Status__c = 'Submitted');
        insert log;
    }

    // Test case 1: Test normal execution
    static testMethod void testNormalExecution() {
        Test.startTest();

        // Setup the CloudBillingData instance
        CloudBillingData data = new CloudBillingData();
        data.subsidiary = 'All';
        data.region = 'All';
        data.edition = 'All';

        // Get the Cloud_Billing_Log__c record
        Cloud_Billing_Log__c existingLog = [SELECT Id FROM Cloud_Billing_Log__c LIMIT 1];

        // Create the BatchSendInvoices instance
        BatchSendInvoices batch = new BatchSendInvoices(data, existingLog);
        // Process the batch
        Id batchId = Database.executeBatch(batch);

        Test.stopTest();

        // Validate the results
        List<Invoice__c> updatedInvoices = [SELECT Id, Status__c FROM Invoice__c LIMIT 1];
        System.assertEquals(1, updatedInvoices.size(), 'Invoice not processed');
        System.assertEquals('Send Email', updatedInvoices[0].Status__c, 'Status not updated');
    }

    // Test case 2: Test with missing Cloud_Billing_Log__c record
    static testMethod void testMissingLogExecution() {
        Test.startTest();

        // Setup the CloudBillingData instance
        CloudBillingData data = new CloudBillingData();
        data.subsidiary = 'All';
        data.region = 'All';
        data.edition = 'All';

        // Create the BatchSendInvoices instance without the log
        BatchSendInvoices batch = new BatchSendInvoices(data, null);
        // Process the batch
        Id batchId = Database.executeBatch(batch);

        Test.stopTest();

        // Validate the results
        List<Invoice__c> updatedInvoices = [SELECT Id, Status__c FROM Invoice__c LIMIT 1];
        System.assertEquals(1, updatedInvoices.size(), 'Invoice not processed');
        System.assertEquals('Send Email', updatedInvoices[0].Status__c, 'Status not updated');

        // Validate that a new Cloud_Billing_Log__c record was created
        List<Cloud_Billing_Log__c> logRecords = [SELECT Id FROM Cloud_Billing_Log__c];
        System.assertEquals(2, logRecords.size(), 'New log record not created');
    }

    // Test case 3: Test with no matching Invoices
    static testMethod void testNoMatchingInvoices() {
        Test.startTest();

        // Setup the CloudBillingData instance
        CloudBillingData data = new CloudBillingData();
        data.subsidiary = 'Nonexistent';
        data.region = 'All';
        data.edition = 'All';

        // Get the Cloud_Billing_Log__c record
        Cloud_Billing_Log__c existingLog = [SELECT Id FROM Cloud_Billing_Log__c LIMIT 1];

        // Create the BatchSendInvoices instance
        BatchSendInvoices batch = new BatchSendInvoices(data, existingLog);
        // Process the batch
        Id batchId = Database.executeBatch(batch);

        Test.stopTest();

        // Validate the results
        List<Invoice__c> notUpdatedInvoices = [SELECT Id, Status__c FROM Invoice__c WHERE Status__c = 'Invoice Attached' LIMIT 1];
        System.assertEquals(1, notUpdatedInvoices.size(), 'Invoice should not be processed');
        System.assertEquals('Invoice Attached', notUpdatedInvoices[0].Status__c, 'Status should not change');
    }

    // Test case 4: Test with no Invoices in the database
    static testMethod void testNoInvoicesInDatabase() {
        // Delete all existing Invoices
        delete [SELECT Id FROM Invoice__c];

        Test.startTest();

        // Setup the CloudBillingData instance
        CloudBillingData data = new CloudBillingData();
        data.subsidiary = 'All';
        data.region = 'All';
        data.edition = 'All';

        // Get the Cloud_Billing_Log__c record
        Cloud_Billing_Log__c existingLog = [SELECT Id FROM Cloud_Billing_Log__c LIMIT 1];

        // Create the BatchSendInvoices instance
        BatchSendInvoices batch = new BatchSendInvoices(data, existingLog);
        // Process the batch
        Id batchId = Database.executeBatch(batch);

        Test.stopTest();

        // Validate the results - there should be no Invoices to update
        List<Invoice__c> notUpdatedInvoices = [SELECT Id, Status__c FROM Invoice__c LIMIT 1];
        System.assertEquals(0, notUpdatedInvoices.size(), 'There should be no Invoices in the database');
    }

    // Test case 5: Test with an exception during execution
    static testMethod void testExceptionDuringExecution() {
        // Set up the mock BatchSendInvoices class to throw an exception
        MockBatchSendInvoicesException throwException = new MockBatchSendInvoicesException();

        Test.startTest();
        Id batchId = Database.executeBatch(throwException);
        Test.stopTest();

        // Validate the results - there should be no Invoices updated
        List<Invoice__c> notUpdatedInvoices = [SELECT Id, Status__c FROM Invoice__c WHERE Status__c = 'Invoice Attached' LIMIT 1];
        System.assertEquals(1, notUpdatedInvoices.size(), 'Invoice should not be processed');
        System.assertEquals('Invoice Attached', notUpdatedInvoices[0].Status__c, 'Status should not change');
    }

    // Creates a Mock class with an exception in the execute method
    private class MockBatchSendInvoicesException extends BatchSendInvoices {
        public MockBatchSendInvoicesException() {
            super(null, null);
        }

        public override void execute(Database.BatchableContext BC, List<SObject> sObjects) {
            throw new Exception('Test Exception');
        }
    }
}