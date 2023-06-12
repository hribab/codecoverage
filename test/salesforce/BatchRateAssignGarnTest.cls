@isTest
private class BatchRateAssignGarnTest {

    // Test start method
    @isTest
    static void testStart() {
        // Test Case 1: Call start method with no records to process
        Test.startTest();
        BatchRateAssignGarn batch = new BatchRateAssignGarn();
        database.QueryLocator q = batch.start(null);
        Test.stopTest();
        System.assertEquals(0, q.locate().size());
        
        // Test Case 2: Call start method with 1 Roll Up Usage Data record having GARN code missing.
        Rolled_Up_Usage_Data__c testRecord = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test');
        insert testRecord;
        Test.startTest();
        database.QueryLocator q2 = batch.start(null);
        Test.stopTest();
        System.assertEquals(1, q2.locate().size());
        
        // Test Case 3: Call start method having GARN code present.
        Rolled_Up_Usage_Data__c testRecord2 = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test', GARN_Account_Code__c = '123');
        insert testRecord2;
        Test.startTest();
        database.QueryLocator q3 = batch.start(null);
        Test.stopTest();
        System.assertEquals(1, q3.locate().size());
        
        // Test Case 4: Call start method with 3 records to process, 2 missing GARN code.
        Rolled_Up_Usage_Data__c testRecord3 = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test1');
        Rolled_Up_Usage_Data__c testRecord4 = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test2');
        insert new List<Rolled_Up_Usage_Data__c>{testRecord3, testRecord4};
        Test.startTest();
        database.QueryLocator q4 = batch.start(null);
        Test.stopTest();
        System.assertEquals(3, q4.locate().size());
        
        // Test Case 5: Call start method with 5 records to process, 3 missing GARN code.
        Rolled_Up_Usage_Data__c testRecord5 = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test3', GARN_Account_Code__c = '123');
        Rolled_Up_Usage_Data__c testRecord6 = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test4');
        insert new List<Rolled_Up_Usage_Data__c>{testRecord5, testRecord6};
        Test.startTest();
        database.QueryLocator q5 = batch.start(null);
        Test.stopTest();
        System.assertEquals(5, q5.locate().size());
    }

    // Test execute method
    @isTest
    static void testExecute() {
        // Test Case 1: Call execute method with no records to process
        Test.startTest();
        BatchRateAssignGarn batch = new BatchRateAssignGarn();
        batch.execute(null, new List<Rolled_Up_Usage_Data__c>());
        Test.stopTest();
        
        // Test Case 2: Call execute method with 1 Roll Up Usage Data record having GARN code missing.
        Rolled_Up_Usage_Data__c testRecord = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test');
        insert testRecord;
        Test.startTest();
        batch.execute(null, new List<Rolled_Up_Usage_Data__c>{testRecord});
        Test.stopTest();
        
        // Test Case 3: Call execute method with 3 records to process, 2 missing GARN code.
        Rolled_Up_Usage_Data__c testRecord2 = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test1');
        Rolled_Up_Usage_Data__c testRecord3 = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test2');
        insert new List<Rolled_Up_Usage_Data__c>{testRecord2, testRecord3};
        Test.startTest();
        batch.execute(null, new List<Rolled_Up_Usage_Data__c>{testRecord2, testRecord3});
        Test.stopTest();
        
        // Test Case 4: Call execute method with 5 records to process, 3 missing GARN code.
        Rolled_Up_Usage_Data__c testRecord4 = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test3', GARN_Account_Code__c = '123');
        Rolled_Up_Usage_Data__c testRecord5 = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test4');
        insert new List<Rolled_Up_Usage_Data__c>{testRecord4, testRecord5};
        Test.startTest();
        batch.execute(null, new List<Rolled_Up_Usage_Data__c>{testRecord4, testRecord5});
        Test.stopTest();
        
        // Test Case 5: Call execute method with a mix of records having GARN code and missing GARN code.
        Rolled_Up_Usage_Data__c testRecord6 = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test5');
        Rolled_Up_Usage_Data__c testRecord7 = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test6', GARN_Account_Code__c = '123');
        insert new List<Rolled_Up_Usage_Data__c>{testRecord6, testRecord7};
        Test.startTest();
        batch.execute(null, new List<Rolled_Up_Usage_Data__c>{testRecord6, testRecord7});
        Test.stopTest();
    }

    // Test finish method
    @isTest
    static void testFinish() {
        // Test Case 1: Call finish method with no records to process
        Test.startTest();
        BatchRateAssignGarn batch = new BatchRateAssignGarn();
        batch.finish(null);
        Test.stopTest();
        
        // Test Case 2: Call finish method after processing records
        Rolled_Up_Usage_Data__c testRecord = new Rolled_Up_Usage_Data__c(Platform_Id_Hash__c = 'Test');
        insert testRecord;
        Test.startTest();
        database.QueryLocator startQ = batch.start(null);
        batch.execute(null, startQ.locate());
        batch.finish(null);
        Test.stopTest();
    }

}