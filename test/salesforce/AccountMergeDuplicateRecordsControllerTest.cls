@isTest
public class AccountMergeDuplicateRecordsControllerTest {
    @testSetup
    static void setup() {
        RecordType accRecordType = new RecordType (Name = 'Test Record Type', SobjectType = 'Account');
        insert accRecordType;

        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Alias = 'csale',
            Email = 'testuser@example.com',
            Username = 'testuser@example.com',
            CommunityNickname = 'testuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id
        );
        insert testUser;

        Account acc1 = new Account(Name = 'Test Account 1', RecordTypeId = accRecordType.Id, Status__c='Active');
        Account acc2 = new Account(Name = 'Test Account 2', RecordTypeId = accRecordType.Id, Status__c='Inactive', OwnerId = testUser.Id);
        insert new List<Account>{acc1, acc2};
    }

    static testMethod void testAccountMergeDuplicateRecordsController() {
        // Test Data
        Account testAcc = [SELECT Id, Name FROM Account WHERE Name = 'Test Account 1'];
        ApexPages.StandardController stdCtrl = new ApexPages.StandardController(testAcc);
        
        // Test AccountMergeDuplicateRecordsController
        AccountMergeDuplicateRecordsController accountMergeCtrl = new AccountMergeDuplicateRecordsController(stdCtrl);
        
        // Test searchAccounts() method
        accountMergeCtrl.RecordType = 'All';
        accountMergeCtrl.searchAccounts();

        System.assertEquals(2, accountMergeCtrl.searchResults.size(), 'There should be 2 search results for account name "Test Account".');

        // Test doNext() method - success case
        accountMergeCtrl.searchResults[0].selected = true;
        accountMergeCtrl.searchResults[1].selected = true;

        PageReference nextPage = accountMergeCtrl.doNext();
        System.assertNotEquals(null, nextPage, 'doNext() should successfully navigate to the next page.');

        // Test doNext() method - error case - not enough records selected
        accountMergeCtrl.searchResults[1].selected = false;
        nextPage = accountMergeCtrl.doNext();
        System.assertEquals(null, nextPage, 'doNext() should not proceed without 2 or 3 records selected.');

        // Test doNext() method - error case - merging records with different record types
        accountMergeCtrl.searchResults[1].selected = true;
        accountMergeCtrl.searchResults[1].accRecord.RecordTypeId = '012000000000000000';
        nextPage = accountMergeCtrl.doNext();
        System.assertEquals(null, nextPage, 'doNext() should not proceed with different Account Record Types for Party Account to merge.');
    }
}