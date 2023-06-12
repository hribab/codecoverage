@isTest
public class AccountBillingInfoUtilTest {

    @testSetup
    static void setUp() {
        // Insert record type
        RecordType rt = new RecordType(Name = 'Cloud Monthly Billing Order', SObjectType = 'Order');
        insert rt;

        // Insert account
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        // Insert order
        Order ord = new Order(AccountId = acc.Id, Status = 'Draft');
        ord.RecordTypeId = rt.Id;
        insert ord;

        // Insert Account_Order_Address__c
        Account_Order_Address__c addr = new Account_Order_Address__c(Order__c = ord.Id, Address_Type__c = 'Bill To', Email__c = 'test@example.com', Additional_Emails__c = 'additional@example.com');
        insert addr;
        
        // Insert Account_Billing_Info__c
        Account_Billing_Info__c billingInfo = new Account_Billing_Info__c(Order__c = ord.Id, Document_Type__c = 'Invoice', Attachment_Name__c = 'TestAttachment');
        insert billingInfo;
    }

    @isTest
    static void testAttachPDF_Success() {
        Account_Billing_Info__c abi = [SELECT Id FROM Account_Billing_Info__c][0];
        String output = AccountBillingInfoUtil.attachPDF(abi.Id);
        System.assertEquals('PDF Successfully Attached', output);

        List<Attachment> attachments = [SELECT Id, Name, ParentId, ContentType, Body FROM Attachment WHERE ParentId = :abi.Id];
        System.assertEquals(1, attachments.size());
        System.assertEquals(abi.Id, attachments[0].ParentId);
        System.assertEquals('TestAttachment.pdf', attachments[0].Name);
        System.assertEquals('application/pdf', attachments[0].ContentType);
        
        if (Test.isRunningTest()) {
            System.assertEquals('UNIT.TEST', attachments[0].Body.toString());
        }
    }

    @isTest
    static void testAttachPDF_UpdateStatus() {
        Account_Billing_Info__c abi = [SELECT Id, Status__c FROM Account_Billing_Info__c WHERE Status__c = null][0];
        AccountBillingInfoUtil.attachPDF(abi.Id);
        
        Account_Billing_Info__c updatedAbi = [SELECT Id, Status__c FROM Account_Billing_Info__c WHERE Id = :abi.Id];
        System.assertEquals('PDF Attached', updatedAbi.Status__c);
    }

    @isTest
    static void testAttachPDF_NewStatus() {
        Account_Billing_Info__c abi = [SELECT Id FROM Account_Billing_Info__c WHERE Status__c = 'New'][0];
        AccountBillingInfoUtil.attachPDF(abi.Id);
        
        Account_Billing_Info__c updatedAbi = [SELECT Id, Status__c FROM Account_Billing_Info__c WHERE Id = :abi.Id];
        System.assertEquals('PDF Attached', updatedAbi.Status__c);
    }

    @isTest
    static void testAttachPDF_EmailsPopulated() {
        Account_Billing_Info__c abi = [SELECT Id, Email1__c, Email2__c FROM Account_Billing_Info__c WHERE Email1__c = null AND Email2__c = null][0];
        AccountBillingInfoUtil.attachPDF(abi.Id);
        
        Account_Billing_Info__c updatedAbi = [SELECT Id, Email1__c, Email2__c FROM Account_Billing_Info__c WHERE Id = :abi.Id];
        System.assertEquals('test@example.com', updatedAbi.Email1__c);
        System.assertEquals('additional@example.com', updatedAbi.Email2__c);
    }

    @isTest
    static void testAttachPDF_BillingOrderType() {
        Account_Billing_Info__c abi = [SELECT Id, Order__r.RecordType.Name FROM Account_Billing_Info__c WHERE Order__r.RecordType.Name = 'Cloud Monthly Billing Order'][0];
        String output = AccountBillingInfoUtil.attachPDF(abi.Id);
        System.assertEquals('PDF Successfully Attached', output);
        
        Account_Billing_Info__c updatedAbi = [SELECT Id, Order__r.RecordType.Name FROM Account_Billing_Info__c WHERE Id = :abi.Id];
        System.assertEquals('Cloud Monthly Billing Order', updatedAbi.Order__r.RecordType.Name);
    }
}