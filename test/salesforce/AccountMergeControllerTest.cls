@isTest
public class AccountMergeControllerTest {

    @testSetup
    static void setupData() {
        // Create test accounts
        Account acc1 = new Account(Name = 'TestAccount1');
        Account acc2 = new Account(Name = 'TestAccount2');
        insert new List<Account>{acc1, acc2};

        // Create test opportunities
        Opportunity opp1 = new Opportunity(Name = 'TestOpp1', StageName = 'Prospecting', CloseDate = Date.today(), AccountId = acc1.Id);
        Opportunity opp2 = new Opportunity(Name = 'TestOpp2', StageName = 'Prospecting', CloseDate = Date.today(), AccountId = acc1.Id);
        insert new List<Opportunity>{opp1, opp2};

        // Create test contacts
        Contact con1 = new Contact(FirstName = 'Test', LastName = 'Contact1', AccountId = acc1.Id);
        Contact con2 = new Contact(FirstName = 'Test', LastName = 'Contact2', AccountId = acc1.Id);
        insert new List<Contact>{con1, con2};

        // Create test cases
        Case cs1 = new Case(Subject = 'Test Case 1', AccountId = acc1.Id);
        Case cs2 = new Case(Subject = 'Test Case 2', AccountId = acc1.Id);
        insert new List<Case>{cs1, cs2};
    }

    @isTest
    static void testConstructor() {
        // Test AccountMergeController constructor
        Test.startTest();
        AccountMergeController controller = new AccountMergeController();
        Test.stopTest();
        
        System.assertNotEquals(null, controller.fromAccount, 'From account should not be null');
        System.assertNotEquals(null, controller.toAccount, 'To account should not be null');
    }

    @isTest
    static void testFindRelatedRecords() {
        // Test findRelatedRecords method
        AccountMergeController controller = new AccountMergeController();
        controller.fromAccount = [SELECT Id, Name FROM Account WHERE Name = 'TestAccount1' LIMIT 1];

        Test.startTest();
        controller.findRelatedRecords();
        Test.stopTest();

        System.assertEquals(2, controller.opportunityWrappers.size(), 'Opportunity wrappers size should be 2');
        System.assertEquals(2, controller.caseWrappers.size(), 'Case wrappers size should be 2');
        System.assertEquals(2, controller.ContactWrappers.size(), 'Contact wrappers size should be 2');
    }

    @isTest
    static void testMoveLeft() {
        // Test moveLeft method
        AccountMergeController controller = new AccountMergeController();
        controller.fromAccount = [SELECT Id, Name FROM Account WHERE Name = 'TestAccount1' LIMIT 1];
        controller.findRelatedRecords();

        // Select first opportunity wrapper
        controller.opportunityWrappers.get(0).isSelected = true;

        Test.startTest();
        controller.moveLeft();
        Test.stopTest();

        System.assertEquals(true, controller.opportunityWrappers.get(0).isMoved, 'First opportunity wrapper should be moved');
        System.assertEquals(false, controller.opportunityWrappers.get(1).isMoved, 'Second opportunity wrapper should not be moved');
    }

    @isTest
    static void testMoveRight() {
        // Test moveRight method
        AccountMergeController controller = new AccountMergeController();
        controller.fromAccount = [SELECT Id, Name FROM Account WHERE Name = 'TestAccount1' LIMIT 1];
        controller.findRelatedRecords();

        // Select first opportunity wrapper and move left
        controller.opportunityWrappers.get(0).isSelected = true;
        controller.moveLeft();

        // Select first opportunity wrapper again and move right
        controller.opportunityWrappers.get(0).isSelected = true;

        Test.startTest();
        controller.moveRight();
        Test.stopTest();

        System.assertEquals(false, controller.opportunityWrappers.get(0).isMoved, 'First opportunity wrapper should not be moved');
        System.assertEquals(false, controller.opportunityWrappers.get(1).isMoved, 'Second opportunity wrapper should not be moved');
    }

    @isTest
    static void testMergeSelected() {
        // Test mergeSelected method
        AccountMergeController controller = new AccountMergeController();

        Test.startTest();
        PageReference pageRef = controller.mergeSelected();
        Test.stopTest();

        System.assertEquals(null, pageRef, 'Page reference should be null');
    }
}