@isTest
private class AccountStatusBatchHelperTest {
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i<5; i++) {
            accounts.add(new Account(Name='Test Account-'+i));
        }
        insert accounts;
    }

    // Test case 1 for updateAccountStatusToInactive
    @isTest
    static void testUpdateAccountStatusToInactive_NoServiceContracts() {
        List<Account> accounts = [SELECT id FROM Account];
        Test.startTest();
        AccountStatusBatchHelper.updateAccountStatusToInactive(accounts);
        Test.stopTest();
        List<Account> accountsAfterUpdate = [SELECT Status__c FROM Account];
        for(Account acc : accountsAfterUpdate){
            System.assertEquals(null, acc.Status__c);
        }
    }

    // Test case 2 for updateAccountStatusToInactive
    @isTest
    static void testUpdateAccountStatusToInactive_ServiceContractsNotExpired() {
        List<Account> accounts = [SELECT id FROM Account];
        List<ServiceContract> SCs = new List<ServiceContract>();
        for(Account acc : accounts){
            SCs.add(new ServiceContract(AccountId=acc.Id, EndDate=System.today().addDays(30)));
        }
        insert SCs;
        Test.startTest();
        AccountStatusBatchHelper.updateAccountStatusToInactive(accounts);
        Test.stopTest();
        List<Account> accountsAfterUpdate = [SELECT Status__c FROM Account];
        for(Account acc : accountsAfterUpdate){
            System.assertEquals(null, acc.Status__c);
        }
    }

    // Test case 3 for updateAccountStatusToInactive
    @isTest
    static void testUpdateAccountStatusToInactive_ServiceContractsPartiallyExpired() {
        List<Account> accounts = [SELECT id FROM Account];
        List<ServiceContract> SCs = new List<ServiceContract>();
        for(Integer i=0; i<accounts.size(); i++){
            Account acc = accounts[i];
            Date endDate = i % 2 == 0 ? System.today().addDays(-1100) : System.today().addDays(-600);
            SCs.add(new ServiceContract(AccountId=acc.Id, EndDate=endDate));
        }
        insert SCs;
        Test.startTest();
        AccountStatusBatchHelper.updateAccountStatusToInactive(accounts);
        Test.stopTest();
        List<Account> accountsAfterUpdate = [SELECT Status__c FROM Account ORDER BY Name];
        for(Integer i=0; i<accountsAfterUpdate.size(); i++){
            Account acc = accountsAfterUpdate[i];
            if(i % 2 == 0){
                System.assertEquals('Inactive', acc.Status__c);
            } else {
                System.assertEquals(null, acc.Status__c);
            }
        }
    }

    // Test case 4 for updateAccountStatusToInactive
    @isTest
    static void testUpdateAccountStatusToExpiredMaintenance_NoServiceContracts() {
        List<Account> accounts = [SELECT id FROM Account];
        Test.startTest();
        AccountStatusBatchHelper.updateAccountStatusToExpiredMaintenance(accounts);
        Test.stopTest();
        List<Account> accountsAfterUpdate = [SELECT Status__c FROM Account];
        for(Account acc : accountsAfterUpdate){
            System.assertEquals(null, acc.Status__c);
        }
    }

    // Test case 5 for updateAccountStatusToInactive
    @isTest
    static void testUpdateAccountStatusToExpiredMaintenance_ServiceContractsNotExpired() {
        List<Account> accounts = [SELECT id FROM Account];
        List<ServiceContract> SCs = new List<ServiceContract>();
        for(Account acc : accounts){
            SCs.add(new ServiceContract(AccountId=acc.Id, EndDate=System.today().addDays(30)));
        }
        insert SCs;
        Test.startTest();
        AccountStatusBatchHelper.updateAccountStatusToExpiredMaintenance(accounts);
        Test.stopTest();
        List<Account> accountsAfterUpdate = [SELECT Status__c FROM Account];
        for(Account acc : accountsAfterUpdate){
            System.assertEquals(null, acc.Status__c);
        }
    }

    // Test case 6 for updateAccountStatusToInactive
    @isTest
    static void testUpdateAccountStatusToExpiredMaintenance_ServiceContractsPartiallyExpired() {
        List<Account> accounts = [SELECT id FROM Account];
        List<ServiceContract> SCs = new List<ServiceContract>();
        for(Integer i=0; i<accounts.size(); i++){
            Account acc = accounts[i];
            Date endDate = i % 2 == 0 ? System.today().addDays(-1100) : System.today().addDays(-600);
            SCs.add(new ServiceContract(AccountId=acc.Id, EndDate=endDate));
        }
        insert SCs;
        Test.startTest();
        AccountStatusBatchHelper.updateAccountStatusToExpiredMaintenance(accounts);
        Test.stopTest();
        List<Account> accountsAfterUpdate = [SELECT Status__c FROM Account ORDER BY Name];
        for(Integer i=0; i<accountsAfterUpdate.size(); i++){
            Account acc = accountsAfterUpdate[i];
            if(i % 2 == 0){
                System.assertEquals('Expired Maintenance', acc.Status__c);
            } else {
                System.assertEquals(null, acc.Status__c);
            }
        }
    }
}