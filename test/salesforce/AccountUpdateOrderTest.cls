@isTest
public class AccountUpdateOrderTest {
    @isTest
    static void updateAccountTest1() {
        // Test case 1: Test with valid Order data
        // Setup
        Account acc = new Account(Name = 'Test Account', Genesys_Care_Ops__c = NULL, Genesys_Care_specialist__c = NULL, Genesys_Care_Offering__c = NULL);
        insert acc;
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', Gene_Care_Specialist__c = 'Specialist', Quote_Mtce_Ops__c = 'Ops');
        insert opp;
        Quote__c quote = new Quote__c(OpportunityId__c = opp.Id, Genesys_Care__c = 'Care', Current_Maint_Rate__c = 5000, BigMachines__Is_Primary__c = True);
        insert quote;
        Order__c order = new Order__c(Opportunity__c = opp.Id, Quote__c = quote.Id, End_User_Name__c = acc.Id);
        insert order;

        Test.startTest();
        AccountUpdateOrder.updateAccount(new Map<id, Order__c>{order.id => order}, null);
        Test.stopTest();

        Account updatedAcc = [SELECT Genesys_Care_Ops__c, Genesys_Care_specialist__c, Genesys_Care_Offering__c, GC_contractual_rate__c FROM Account WHERE Id = :acc.Id];
        
        System.assertEquals('Ops', updatedAcc.Genesys_Care_Ops__c);
        System.assertEquals('Specialist', updatedAcc.Genesys_Care_specialist__c);
        System.assertEquals('Care', updatedAcc.Genesys_Care_Offering__c);
        System.assertEquals(5000, updatedAcc.GC_contractual_rate__c);
    }

    @isTest
    static void updateAccountTest2() {
        // Test case 2: Test with empty newOrderMap
        Test.startTest();
        AccountUpdateOrder.updateAccount(new Map<id, Order__c>(), null);
        Test.stopTest();
        // This test case should not throw any error as the method should not process anything if the newOrderMap is empty
    }

    @isTest
    static void updateAccountTest3() {
        // Test case 3: Test with Opportunity Name as null
        // Setup
        Account acc = new Account(Name = 'Test Account', Genesys_Care_Ops__c = NULL, Genesys_Care_specialist__c = NULL, Genesys_Care_Offering__c = NULL);
        insert acc;
        Opportunity opp = new Opportunity(Name = NULL, Gene_Care_Specialist__c = 'Specialist', Quote_Mtce_Ops__c = 'Ops');
        insert opp;
        Quote__c quote = new Quote__c(OpportunityId__c = opp.Id, Genesys_Care__c = 'Care', Current_Maint_Rate__c = 5000, BigMachines__Is_Primary__c = True);
        insert quote;
        Order__c order = new Order__c(Opportunity__c = opp.Id, Quote__c = quote.Id, End_User_Name__c = acc.Id);
        insert order;

        Test.startTest();
        AccountUpdateOrder.updateAccount(new Map<id, Order__c>{order.id => order}, null);
        Test.stopTest();
        // This test case should not throw any error as the method should not process anything if the Opportunity Name is null
    }

    @isTest
    static void updateAccountTest4() {
        // Test case 4: Test with BigMachines__Is_Primary__c as false
        // Setup
        Account acc = new Account(Name = 'Test Account', Genesys_Care_Ops__c = NULL, Genesys_Care_specialist__c = NULL, Genesys_Care_Offering__c = NULL);
        insert acc;
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', Gene_Care_Specialist__c = 'Specialist', Quote_Mtce_Ops__c = 'Ops');
        insert opp;
        Quote__c quote = new Quote__c(OpportunityId__c = opp.Id, Genesys_Care__c = 'Care', Current_Maint_Rate__c = 5000, BigMachines__Is_Primary__c = False);
        insert quote;
        Order__c order = new Order__c(Opportunity__c = opp.Id, Quote__c = quote.Id, End_User_Name__c = acc.Id);
        insert order;

        Test.startTest();
        AccountUpdateOrder.updateAccount(new Map<id, Order__c>{order.id => order}, null);
        Test.stopTest();
        // This test case should not throw any error as the method should not process anything if the BigMachines__Is_Primary__c is false
    }

    @isTest
    static void updateAccountTest5() {
        // Test case 5: Test with End_User_Name__c as null
        // Setup
        Account acc = new Account(Name = 'Test Account', Genesys_Care_Ops__c = NULL, Genesys_Care_specialist__c = NULL, Genesys_Care_Offering__c = NULL);
        insert acc;
        Opportunity opp = new Opportunity(Name = 'Test Opportunity', Gene_Care_Specialist__c = 'Specialist', Quote_Mtce_Ops__c = 'Ops');
        insert opp;
        Quote__c quote = new Quote__c(OpportunityId__c = opp.Id, Genesys_Care__c = 'Care', Current_Maint_Rate__c = 5000, BigMachines__Is_Primary__c = True);
        insert quote;
        Order__c order = new Order__c(Opportunity__c = opp.Id, Quote__c = quote.Id, End_User_Name__c = null);
        insert order;

        Test.startTest();
        AccountUpdateOrder.updateAccount(new Map<id, Order__c>{order.id => order}, null);
        Test.stopTest();
        // This test case should not throw any error as the method should not process anything if the End_User_Name__c is null
    }
}