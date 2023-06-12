@isTest
private class AccountEngScoreHisotryBatchHelperTest {

    @testSetup
    static void setup() {
        // Create test Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
    
        // Create test Engagement Score
        SML_Account_Engagement_Score__c testScore = new SML_Account_Engagement_Score__c(
            Account__c = testAccount.Id,
            New_Score__c = 5,
            Old_Score__c = 3
        );
        insert testScore;
    }
  
    // Test case 1 - Testing with just one account and one engagement score
    @isTest
    static void testCase1() {
        List<Account> accounts = [SELECT Id FROM Account];
        
        Test.startTest();
        AccountEngScoreHisotryBatchHelper.createHistoryRecord(accounts);
        Test.stopTest();

        List<SML_Account_Engagement_Score_History__c> historyRecords = [SELECT Id FROM SML_Account_Engagement_Score_History__c];
        System.assertEquals(1, historyRecords.size(), 'The records added should be 1');
    }

    // Test case 2 - Testing with multiple accounts and multiple engagement scores
    @isTest
    static void testCase2() {
        // Create and insert two more Accounts and Engagement Scores
        Account account1 = new Account(Name = 'Account1');
        Account account2 = new Account(Name = 'Account2');
        insert new List<Account>{account1, account2};
        
        SML_Account_Engagement_Score__c score1 = new SML_Account_Engagement_Score__c(
            Account__c = account1.Id,
            New_Score__c = 4,
            Old_Score__c = 2
        );
        SML_Account_Engagement_Score__c score2 = new SML_Account_Engagement_Score__c(
            Account__c = account2.Id,
            New_Score__c = 8,
            Old_Score__c = 7
        );
        insert new List<SML_Account_Engagement_Score__c>{score1, score2};
        
        List<Account> accounts = [SELECT Id FROM Account];
        
        Test.startTest();
        AccountEngScoreHisotryBatchHelper.createHistoryRecord(accounts);
        Test.stopTest();

        List<SML_Account_Engagement_Score_History__c> historyRecords = [SELECT Id FROM SML_Account_Engagement_Score_History__c];
        System.assertEquals(3, historyRecords.size(), 'The records added should be 3');
    }

    // Test case 3 - Testing with No Accounts
    @isTest
    static void testCase3() {
        delete [SELECT Id FROM Account];

        List<Account> accounts = [SELECT Id FROM Account];
        
        Test.startTest();
        AccountEngScoreHisotryBatchHelper.createHistoryRecord(accounts);
        Test.stopTest();

        List<SML_Account_Engagement_Score_History__c> historyRecords = [SELECT Id FROM SML_Account_Engagement_Score_History__c];
        System.assertEquals(0, historyRecords.size(), 'The records added should be 0');
    }

    // Test case 4 - Testing when limits of dates are reached
    @isTest
    static void testCase4() {
        DateTime endDate = System.today().addYears(3).addDays(1);

        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        
        SML_Account_Engagement_Score__c testScore = new SML_Account_Engagement_Score__c(
            Account__c = testAccount.Id,
            New_Score__c = 5,
            Old_Score__c = 3,
            History_Date__c = endDate
        );
        insert testScore;
        
        List<Account> accounts = [SELECT Id FROM Account];
        
        Test.startTest();
        AccountEngScoreHisotryBatchHelper.createHistoryRecord(accounts);
        Test.stopTest();

        List<SML_Account_Engagement_Score_History__c> historyRecords = [SELECT Id FROM SML_Account_Engagement_Score_History__c];
        System.assertEquals(1, historyRecords.size(), 'The records added should be 1');
    }

    // Test case 5 - Testing when the createdDate is same as end date
    @isTest
    static void testCase5() {
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        
        SML_Account_Engagement_Score__c testScore = new SML_Account_Engagement_Score__c(
            Account__c = testAccount.Id,
            New_Score__c = 5,
            Old_Score__c = 3,
            CreatedDate = System.today()
        );
        insert testScore;
        
        List<Account> accounts = [SELECT Id FROM Account];
        
        Test.startTest();
        AccountEngScoreHisotryBatchHelper.createHistoryRecord(accounts);
        Test.stopTest();

        List<SML_Account_Engagement_Score_History__c> historyRecords = [SELECT Id FROM SML_Account_Engagement_Score_History__c];
        System.assertEquals(1, historyRecords.size(), 'The records added should be 1');
    }
}