@isTest
public class AccountFactoryTest 
{
    @isTest static void testCreateProspectAccount()
    {
        // Test Case 1: Create a Prospect Account with valid name
        Account testAccount1 = AccountFactory.CreateProspectAccount('Test Prospect Account 1');
        System.assertEquals('Test Prospect Account 1', testAccount1.Name);
        System.assertEquals('Prospect', testAccount1.Type);
        
        // Test Case 2: Create a Prospect Account with blank name
        Account testAccount2 = AccountFactory.CreateProspectAccount('');
        System.assertEquals('', testAccount2.Name);
        System.assertEquals('Prospect', testAccount2.Type);
        
        // Test Case 3: Create a Prospect Account with numeric name
        Account testAccount3 = AccountFactory.CreateProspectAccount('12345');
        System.assertEquals('12345', testAccount3.Name);
        System.assertEquals('Prospect', testAccount3.Type);
        
        // Test Case 4: Create a Prospect Account with special characters in name
        Account testAccount4 = AccountFactory.CreateProspectAccount('#$%Account');
        System.assertEquals('#$%Account', testAccount4.Name);
        System.assertEquals('Prospect', testAccount4.Type);
        
        // Test Case 5: Create a Prospect Account with long name
        String longName = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum.';
        Account testAccount5 = AccountFactory.CreateProspectAccount(longName);
        System.assertEquals(longName, testAccount5.Name);
        System.assertEquals('Prospect', testAccount5.Type);
    }

    @isTest static void testCreatePartnerProspectAccount()
    {
        // Test Case 1: Create a Partner Prospect Account with valid name
        Account testAccount1 = AccountFactory.CreatePartnerProspectAccount('Test Partner Prospect Account 1');
        System.assertEquals('Test Partner Prospect Account 1', testAccount1.Name);
        System.assertEquals('Partner Prospect', testAccount1.Type);
        
        // Test Case 2: Create a Partner Prospect Account with blank name
        Account testAccount2 = AccountFactory.CreatePartnerProspectAccount('');
        System.assertEquals('', testAccount2.Name);
        System.assertEquals('Partner Prospect', testAccount2.Type);
        
        // Test Case 3: Create a Partner Prospect Account with numeric name
        Account testAccount3 = AccountFactory.CreatePartnerProspectAccount('12345');
        System.assertEquals('12345', testAccount3.Name);
        System.assertEquals('Partner Prospect', testAccount3.Type);
        
        // Test Case 4: Create a Partner Prospect Account with special characters in the name
        Account testAccount4 = AccountFactory.CreatePartnerProspectAccount('#$%Account');
        System.assertEquals('#$%Account', testAccount4.Name);
        System.assertEquals('Partner Prospect', testAccount4.Type);
        
        // Test Case 5: Create a Partner Prospect Account with a long name
        String longName = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum.';
        Account testAccount5 = AccountFactory.CreatePartnerProspectAccount(longName);
        System.assertEquals(longName, testAccount5.Name);
        System.assertEquals('Partner Prospect', testAccount5.Type);
    }

    @isTest static void testCreateHoldingAccount()
    {
        // Test Case: Create a Holding Account
        Account testAccount1 = AccountFactory.CreateHoldingAccount();
        System.assertEquals('Holding Account', testAccount1.Name);
    }

    @isTest static void testSetRequiredPartnerFields()
    {
        // Test Case: Set required partner fields on an Account
        Account testAccount1 = new Account();
        AccountFactory.SetRequiredPartnerFields(testAccount1);
        
        System.assertEquals('Partner', testAccount1.Type);
        System.assertEquals('Elite', testAccount1.Account_Sub_Type__c);
    }

    @isTest static void testSetRequiredCustomerFields()
    {
        // Test Case: Set required customer fields on an Account
        Account testAccount1 = new Account();
        AccountFactory.SetRequiredCustomerFields(testAccount1);
        
        System.assertEquals('Customer', testAccount1.Type);
        System.assertEquals('Indirect Customer', testAccount1.Account_Sub_Type__c);
    }

    @isTest static void testSetRequiredPureCloudCustomerFields()
    {
        // Test Case: Set required PureCloud customer fields on an Account
        Account testAccount1 = new Account();
        AccountFactory.SetRequiredPureCloudCustomerFields(testAccount1);
        
        System.assertEquals('Customer', testAccount1.Type);
        System.assertEquals('PC Customer', testAccount1.Account_Sub_Type__c);
    }

    @isTest static void testSetAxCustomerAccountId()
    {
        // Test Case 1: Set Ax Customer Account ID with valid ID
        Account testAccount1 = new Account();
        AccountFactory.SetAxCustomerAccountId(testAccount1, 'AX12345');
        System.assertEquals('AX12345', testAccount1.AX_Customer_Account_ID__c);
        
        // Test Case 2: Set Ax Customer Account ID with blank ID
        Account testAccount2 = new Account();
        AccountFactory.SetAxCustomerAccountId(testAccount2, '');
        System.assertEquals('', testAccount2.AX_Customer_Account_ID__c);
        
        // Test Case 3: Set Ax Customer Account ID with numeric ID
        Account testAccount3 = new Account();
        AccountFactory.SetAxCustomerAccountId(testAccount3, '12345');
        System.assertEquals('12345', testAccount3.AX_Customer_Account_ID__c);
        
        // Test Case 4: Set Ax Customer Account ID with special characters in the ID
        Account testAccount4 = new Account();
        AccountFactory.SetAxCustomerAccountId(testAccount4, '#$%12345');
        System.assertEquals('#$%12345', testAccount4.AX_Customer_Account_ID__c);
        
        // Test Case 5: Set Ax Customer Account ID with a long ID
        String longAxId = 'AXLoremIpsumissimplydummytextoftheprintingandtypesettingindustryAXLorem';
        Account testAccount5 = new Account();
        AccountFactory.SetAxCustomerAccountId(testAccount5, longAxId);
        System.assertEquals(longAxId, testAccount5.AX_Customer_Account_ID__c);
    }
}