@isTest
public class AccountFactory 
{
    public static Account CreateProspectAccount(String name)
    {
        Account result = CreateAccount(name);
        result.Type = 'Prospect';
        result.RecordTypeId = '012U0000000Le3h'; // EMG - Prospect Record Type
        result.Payment_Terms__c = 'Net 30';
        result.Maintenance_CPI_Rate__c = 'CPI';
        return result;
    }
    
    public static Account CreatePartnerProspectAccount(String name)
    {        
        Account result = CreateAccount(name);
        result.Type = 'Partner Prospect';
        result.RecordTypeId = '012U0000000Le3p';  // Enterprise - Prospective Partner
        result.Payment_Terms__c = 'Net 30';
        result.Maintenance_CPI_Rate__c = 'CPI';
        return result;
    }

    public static Account CreateHoldingAccount()
    {
        Account result = CreateAccount('Holding Account');
        return result;
    }
    
    public static void SetRequiredPartnerFields(Account account)
    {
        system.debug('SetRequiredPartnerFields()');   
        //system.debug('===> Account: ' + account );
        account.Type = 'Partner';
        account.Account_Sub_Type__c = 'Elite';
        account.Pricesheet_Permission__c = 'ININ-USD;ININ-CAD;';
        account.Software_Price_Multiplier__c = 115.5;
        account.Education_Price_Multiplier__c = 105.30;
        account.Phone = '317-555-1212';
        account.CleanStatus = 'Acknowledged';
        account.Payment_Terms__c = 'Net 30';
        account.RecordTypeId = '012U0000000Le3g';  // EMG - Customer Record Type
        account.Approved_for_PureCloud_Billing__c = true;
    }
    
    public static void SetRequiredCustomerFields(Account account)
    {        
        account.Type = 'Customer';
        account.Account_Sub_Type__c = 'Indirect Customer';
        account.Phone = '317-555-1212';
        account.CleanStatus = 'Acknowledged';
        account.RecordTypeId = '012U0000000Le3g';  // EMG - Customer Record Type
    }
    
    public static void SetRequiredPureCloudCustomerFields(Account account)
    {        
        account.Type = 'Customer';
        account.Account_Sub_Type__c = 'PC Customer';
        account.Phone = '317-555-1212';
        account.CleanStatus = 'Acknowledged';
        account.RecordTypeId = '012U0000000Le3g';  // EMG - Customer Record Type
    }
    
    public static void SetAxCustomerAccountId (Account account, String AxId)
    {
        account.AX_Customer_Account_ID__c = AxId;
    }    
    
    private static Account CreateAccount(String name)
    {
        return new Account(
            Name = name,
            ININ_Account_Name__c = name
        );        
    }    
}