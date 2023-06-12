@isTest
private class AccountHierarchyTest {
    
    @testSetup
    static void setup() {
        // Create a RecordType for Account
        RecordType rt = new RecordType(Name = 'TestRecord', SobjectType = 'Account');
        insert rt;

        // Create a Country
        Country__c country = new Country__c(Name = 'Test Country');
        insert country;

        // Create a Parent Account
        Account parent = new Account(Name = 'Parent Account', RecordTypeId = rt.Id, Country__c = country.Id);
        insert parent;

        // Create a Child Account
        Account child = new Account(Name = 'Child Account', ParentId = parent.Id, RecordTypeId = rt.Id, Country__c = country.Id, City__c = 'Test City');
        insert child;
    }

    // Test case 1: Test AccountHierarchy constructor with a standard controller
    static testMethod void testAccountHierarchyConstructor() {
        Account parent = [SELECT Id FROM Account WHERE Name = 'Parent Account'];
        
        Test.setCurrentPage(new PageReference('/apex/AccountHierarchy?id=' + parent.Id));
        ApexPages.StandardController stdController = new ApexPages.StandardController(parent);
        AccountHierarchy hierarchy = new AccountHierarchy(stdController);

        System.assertEquals(parent, hierarchy.acct);
    }

    // Test case 2: Test setCon property when there is a child account
    static testMethod void testSetConWithChildAccount() {
        Account parent = [SELECT Id FROM Account WHERE Name = 'Parent Account'];
        
        Test.setCurrentPage(new PageReference('/apex/AccountHierarchy?id=' + parent.Id));
        ApexPages.StandardController stdController = new ApexPages.StandardController(parent);
        AccountHierarchy hierarchy = new AccountHierarchy(stdController);

        System.assertNotEquals(null, hierarchy.setCon);
        System.assertEquals(1, hierarchy.setCon.getResultSize());
    }

    // Test case 3: Test setCon property when there is no child account
    static testMethod void testSetConWithoutChildAccount() {
        Account child = [SELECT Id FROM Account WHERE Name = 'Child Account'];
        
        Test.setCurrentPage(new PageReference('/apex/AccountHierarchy?id=' + child.Id));
        ApexPages.StandardController stdController = new ApexPages.StandardController(child);
        AccountHierarchy hierarchy = new AccountHierarchy(stdController);

        System.assertNotEquals(null, hierarchy.setCon);
        System.assertEquals(0, hierarchy.setCon.getResultSize());
    }

    // Test case 4: Test isGroupAccount property when it is a group account
    static testMethod void testIsGroupAccountTrue() {
        Account parent = [SELECT Id, RecordType.Name FROM Account WHERE Name = 'Parent Account'];
        parent.RecordType.Name = 'GroupAccount';
        update parent;

        Test.setCurrentPage(new PageReference('/apex/AccountHierarchy?id=' + parent.Id));
        ApexPages.StandardController stdController = new ApexPages.StandardController(parent);
        AccountHierarchy hierarchy = new AccountHierarchy(stdController);

        System.assertEquals(true, hierarchy.isGroupAccount);
    }

    // Test case 5: Test isGroupAccount property when it is not a group account
    static testMethod void testIsGroupAccountFalse() {
        Account parent = [SELECT Id FROM Account WHERE Name = 'Parent Account'];
        
        Test.setCurrentPage(new PageReference('/apex/AccountHierarchy?id=' + parent.Id));
        ApexPages.StandardController stdController = new ApexPages.StandardController(parent);
        AccountHierarchy hierarchy = new AccountHierarchy(stdController);

        System.assertEquals(false, hierarchy.isGroupAccount);
    }
}