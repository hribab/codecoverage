@isTest
public class AccountAddressmergeTestClass {
    @testSetup
    static void setupData() {
        List<Account> accountList = new List<Account>();
        for(Integer i=0; i<10; i++) {
            Account acc = new Account(Name='Test Account '+i, 
                                      Street1__c = 'Street1_' + i, 
                                      Street2__c = 'Street2_' + i,
                                      Street3__c = 'Street3_' + i,
                                      Billingcountry = 'USA', 
                                      Country__c = 'Country_' + i,
                                      Country_Name__c = 'United States', 
                                      City__c = 'City_' + i, 
                                      BillingCity = 'Test City',
                                      BillingState = 'Test State', 
                                      StateProvince__c = 'StateProvince_' + i,
                                      RecordType__c = 'RecordType_' + i, 
                                      BillingPostalCode = '12345',
                                      ZipCode__c = 'ZipCode_' + i);
            
            accountList.add(acc);
        }
        insert accountList;
        
        List<Country__c> countryList = new List<Country__c>();
        for(Integer i=0; i<5; i++) {
            Country__c con = new Country__c(Name = 'Country_' + i);
            countryList.add(con);
        }
        insert countryList;
    }
    
    //Test for constructor
    @isTest
    static void testConstructor() {
        String accRecId = [SELECT Id FROM Account LIMIT 1].Id;
        AccountAddressmerge obj1 = new AccountAddressmerge(accRecId);
        System.assertNotEquals(NULL, obj1);
        
        AccountAddressmerge obj2 = new AccountAddressmerge();
        System.assertNotEquals(NULL, obj2);
    }
    
    //Tests for the execute method
    @isTest 
    static void testExecute1() {
        Test.startTest();
        AccountAddressmerge am = new AccountAddressmerge();
        Database.BatchableContext bc;
        Database.QueryLocator ql = am.start(bc);
        List<Account> scope = Database.query(ql.getQuery());
        am.execute(bc, scope);
        Test.stopTest();
        List<Account> accountList = [SELECT Addressbatch__c FROM Account];
        for(Account acc : accountList) {
            System.assertEquals(true, acc.Addressbatch__c);
        }
    }
    
    @isTest 
    static void testExecute2() {
        Test.startTest();
        String accRecId = [SELECT Id FROM Account LIMIT 1].Id;
        AccountAddressmerge am = new AccountAddressmerge(accRecId);
        Database.BatchableContext bc;
        Database.QueryLocator ql = am.start(bc);
        List<Account> scope = Database.query(ql.getQuery());
        am.execute(bc, scope);
        Test.stopTest();
        List<Account> accountList = [SELECT Addressbatch__c FROM Account];
        for(Account acc : accountList) {
            System.assertEquals(true, acc.Addressbatch__c);
        }
    }
  
    //Tests for the start method
    @isTest 
    static void testStart1() {
        AccountAddressmerge am = new AccountAddressmerge();
        Database.BatchableContext bc;
        Test.startTest();
        Database.QueryLocator ql = am.start(bc);
        Test.stopTest();
        List<Account> accountList = Database.query(ql.getQuery());
        System.assertEquals(100, accountList.size());
    }
    
    @isTest 
    static void testStart2() {
        String accRecId = [SELECT Id FROM Account LIMIT 1].Id;
        AccountAddressmerge am = new AccountAddressmerge(accRecId);
        Database.BatchableContext bc;
        Test.startTest();
        Database.QueryLocator ql = am.start(bc);
        Test.stopTest();
        List<Account> accountList = Database.query(ql.getQuery());
        System.assertEquals(100, accountList.size());
    }

    //Test for the finish method
    @isTest 
    static void testFinish() {
        AccountAddressmerge am = new AccountAddressmerge();
        Database.BatchableContext bc;
        Test.startTest();
        am.finish(bc);
        Test.stopTest();
    }
}