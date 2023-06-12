@isTest
public class AccountStatusHelperTest {

    // Test case 1: Check if the account is populated with correct values when a valid opportunityId is passed
    @isTest
    static void testPopulateAccountOppDetails_ValidOppId() {
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;

        Opportunity testOpp = new Opportunity(Name='Test Opp', StageName='Prospecting', CloseDate=System.today(), AccountId=testAccount.Id);
        insert testOpp;

        AccountStatusHelper.populateAccountOppDetails(testAccount, testOpp.Id);

        Account updatedAccount = [SELECT Id, Type, Status__c, New_Logo_Opportunity__c, New_Logo_Converted_Date__c FROM Account WHERE Id = :testAccount.Id];
        
        System.assertEquals('Customer', updatedAccount.Type);
        System.assertEquals('Active', updatedAccount.Status__c);
        System.assertEquals(testOpp.Id, updatedAccount.New_Logo_Opportunity__c);
        System.assertEquals(System.today(), updatedAccount.New_Logo_Converted_Date__c);
    }

    // Test case 2: Check if the account is populated with correct values when passed opportunityId is NULL
    @isTest
    static void testPopulateAccountOppDetails_NullOppId() {
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;

        AccountStatusHelper.populateAccountOppDetails(testAccount, null);

        Account updatedAccount = [SELECT Id, Type, Status__c, New_Logo_Opportunity__c, New_Logo_Converted_Date__c FROM Account WHERE Id = :testAccount.Id];
        
        System.assertEquals('Customer', updatedAccount.Type);
        System.assertEquals('Active', updatedAccount.Status__c);
        System.assertEquals(null, updatedAccount.New_Logo_Opportunity__c);
        System.assertEquals(System.today(), updatedAccount.New_Logo_Converted_Date__c);
    }

    // Test case 3: Check if the account is populated with correct values when no opportunity is linked to account
    @isTest
    static void testPopulateAccountOppDetails_NoOppLinked() {
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;

        AccountStatusHelper.populateAccountOppDetails(testAccount, '');

        Account updatedAccount = [SELECT Id, Type, Status__c, New_Logo_Opportunity__c, New_Logo_Converted_Date__c FROM Account WHERE Id = :testAccount.Id];
        
        System.assertEquals('Customer', updatedAccount.Type);
        System.assertEquals('Active', updatedAccount.Status__c);
        System.assertEquals('', updatedAccount.New_Logo_Opportunity__c);
        System.assertEquals(System.today(), updatedAccount.New_Logo_Converted_Date__c);
    }

    // Test case 4: Check if the account is populated with correct values when a closed opportunity is linked to account
    @isTest
    static void testPopulateAccountOppDetails_ClosedOpp() {
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;

        Opportunity testOpp = new Opportunity(Name='Test Opp', StageName='Closed Won', CloseDate=System.today()-1, AccountId=testAccount.Id);
        insert testOpp;

        AccountStatusHelper.populateAccountOppDetails(testAccount, testOpp.Id);

        Account updatedAccount = [SELECT Id, Type, Status__c, New_Logo_Opportunity__c, New_Logo_Converted_Date__c FROM Account WHERE Id = :testAccount.Id];
        
        System.assertEquals('Customer', updatedAccount.Type);
        System.assertEquals('Active', updatedAccount.Status__c);
        System.assertEquals(testOpp.Id, updatedAccount.New_Logo_Opportunity__c);
        System.assertEquals(System.today(), updatedAccount.New_Logo_Converted_Date__c);
    }

    // Test case 5: Check if the account is populated with correct values when an open opportunity is linked to account
    @isTest
    static void testPopulateAccountOppDetails_OpenOpp() {
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;

        Opportunity testOpp = new Opportunity(Name='Test Opp', StageName='Qualification', CloseDate=System.today()+1, AccountId=testAccount.Id);
        insert testOpp;

        AccountStatusHelper.populateAccountOppDetails(testAccount, testOpp.Id);

        Account updatedAccount = [SELECT Id, Type, Status__c, New_Logo_Opportunity__c, New_Logo_Converted_Date__c FROM Account WHERE Id = :testAccount.Id];
        
        System.assertEquals('Customer', updatedAccount.Type);
        System.assertEquals('Active', updatedAccount.Status__c);
        System.assertEquals(testOpp.Id, updatedAccount.New_Logo_Opportunity__c);
        System.assertEquals(System.today(), updatedAccount.New_Logo_Converted_Date__c);
    }

}