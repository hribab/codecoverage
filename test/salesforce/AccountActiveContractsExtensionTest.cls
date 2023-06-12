@isTest
private class AccountActiveContractsExtensionTest {
    @isTest static void testConstructor() {
        // Set up test data
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        // Instantiate the StandardController for the test
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        
        // Instantiate the AccountActiveContractsExtension
        AccountActiveContractsExtension ext = new AccountActiveContractsExtension(sc);
        
        // Assert accountId is correct
        System.assertEquals(acc.Id, ext.accountId);
    }

    @isTest static void testInit_NoContracts() {        
        // Set up test data
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        // Instantiate the extension
        AccountActiveContractsExtension ext = new AccountActiveContractsExtension(new ApexPages.StandardController(acc));
        
        // Call the init method, passing account
        ext.init(acc.Id);
        
        // Assert contracts is empty
        System.assertEquals(0, ext.contracts.size());
    }

    @isTest static void testInit_WithGCRContracts() {
        // Set up test data
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        GCR_Content_Document_Detail__c gcrContractTest = new GCR_Content_Document_Detail__c(
            Account_Name__c = acc.Id,
            Document_Name__c = 'Test GCR Contract',
            Effective_Date__c = Date.today(),
            Expiration_Renewal_Date__c = Date.today().addDays(30)
        );
        insert gcrContractTest;
        
        // Instantiate the extension
        AccountActiveContractsExtension ext = new AccountActiveContractsExtension(new ApexPages.StandardController(acc));
        
        // Call the init method, passing account
        ext.init(acc.Id);
        
        // Assert contracts size is 1 and GCR Contract is present
        System.assertEquals(1, ext.contracts.size());
        System.assertEquals('Test GCR Contract', ext.contracts[0].strDocumentName);
        System.assertEquals('GCR', ext.contracts[0].strRecordType);
    }

    @isTest static void testInit_WithExpiredGCRContracts() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        GCR_Content_Document_Detail__c gcrContractTest = new GCR_Content_Document_Detail__c(
            Account_Name__c = acc.Id,
            Document_Name__c = 'Test Expired GCR Contract',
            Effective_Date__c = Date.today().addDays(-60),
            Expiration_Renewal_Date__c = Date.today().addDays(-30)
        );
        insert gcrContractTest;

        // Instantiate the extension
        AccountActiveContractsExtension ext = new AccountActiveContractsExtension(new ApexPages.StandardController(acc));
        
        // Call the init method, passing account
        ext.init(acc.Id);
        
        // Assert contracts size is 0 (expired GCR Contract should be excluded)
        System.assertEquals(0, ext.contracts.size());
    }

    @isTest static void testInit_WithOpportunityContracts() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Opportunity oppTest = new Opportunity(
            Name = 'Test Opportunity',
            AccountId = acc.Id,
            CloseDate = Date.today(),
            StageName = '6.Closed',
            Win_Loss_Status__c = 'Won',
            Term_Commitment__c = '1 Year'
        );
        insert oppTest;
        
        // Instantiate the extension
        AccountActiveContractsExtension ext = new AccountActiveContractsExtension(new ApexPages.StandardController(acc));

        // Call the init method, passing account
        ext.init(acc.Id);
        
        // Assert contracts size is 1 and Opportunity Contract is present
        System.assertEquals(1, ext.contracts.size());
        System.assertEquals('Opportunity', ext.contracts[0].strRecordType);
    }

    @isTest static void testInit_WithExpiredOpportunityContracts() {      
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Opportunity oppTest = new Opportunity(
            Name = 'Test Expired Opportunity',
            AccountId = acc.Id,
            CloseDate = Date.today().addMonths(-Integer.ValueOf(Label.Account_Active_Contract_Expiry_Months) - 1),
            StageName = '6.Closed',
            Win_Loss_Status__c = 'Won',
            Term_Commitment__c = '1 Year'
        );
        insert oppTest;

        // Instantiate the extension
        AccountActiveContractsExtension ext = new AccountActiveContractsExtension(new ApexPages.StandardController(acc));

        // Call the init method, passing account
        ext.init(acc.Id);
        
        // Assert contracts size is 0 (expired Opportunity Contract should be excluded)
        System.assertEquals(0, ext.contracts.size());
    }

    @isTest static void testCreateContent() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        GCR_Content_Document_Detail__c gcr = new GCR_Content_Document_Detail__c(Account_Name__c = acc.Id, Document_Name__c = 'Test Contract');
        insert gcr;
        
        Attachment att = new Attachment(Name = 'Test Attachment', ParentId = gcr.Id, Body = Blob.valueOf('Test Data'), ContentType = 'application/pdf');
        insert att;
        
        AccountActiveContractsExtension ext = new AccountActiveContractsExtension(new ApexPages.StandardController(acc));
        ext.strContractId = gcr.Id;
        ext.strAttachmentId = att.Id;
        
        Test.startTest();
        ext.createContent();
        Test.stopTest();

        gcr = [SELECT Public_URL__c FROM GCR_Content_Document_Detail__c WHERE Id =: gcr.Id];
        System.assertNotEquals(null, gcr.Public_URL__c);
    }
}