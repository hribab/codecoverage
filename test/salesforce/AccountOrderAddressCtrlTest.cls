@isTest
public class AccountOrderAddressCtrlTest {
    @isTest
    static void testAccountOrderAddressCtrl() {
        // Test data setup
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Address__c addr1 = new Address__c(
            Account__c = acc.Id,
            Address_Line_1__c = '123 Main St',
            Address_Line_2__c = 'Apt 4B',
            City__c = 'Test City',
            State__c = 'CA',
            Country__c = 'USA',
            Zipcode__c = '12345',
            Type__c = 'End User'
        );
        insert addr1;

        Address__c addr2 = new Address__c(
            Account__c = acc.Id,
            Address_Line_1__c = '456 Broadway',
            Address_Line_2__c = '',
            City__c = 'Another City',
            State__c = 'NY',
            Country__c = 'USA',
            Zipcode__c = '98765',
            Type__c = 'Sold To'
        );
        insert addr2;

        Test.startTest();

        // Test constructor
        ApexPages.StandardController controller = new ApexPages.StandardController(acc);
        AccountOrderAddressCtrl ext = new AccountOrderAddressCtrl(controller);

        // Test initial state
        System.assertEquals(2, ext.accountAddresses.size(), '2 account addresses should be found');
        System.assertEquals(false, ext.showCreateNewPopupFlag, 'Popup flag should be initially false');

        // Test hideCreateNewPopup
        ext.showCreateNewPopupFlag = true;
        ext.hideCreateNewPopup();
        System.assertEquals(false, ext.showCreateNewPopupFlag, 'Popup flag should be false after hide');

        // Test createNewAddress: record with selected value and unique address
        ext.selectedValue = 'End User';
        ext.accountAdd = addr1.clone();
        ext.accountAdd.Address_Line_2__c = 'New Unit';
        PageReference pageRef = ext.createNewAddress();
        System.assertNotEquals(null, pageRef, 'Page redirect expected sucessful address creation');
        System.assertEquals(acc.Id, pageRef.getUrl().substring(1), 'Page should redirect to account page');

        // Test createNewAddress: record with no selected value
        ext.selectedValue = '';
        pageRef = ext.createNewAddress();
        System.assertEquals(null, pageRef, 'Page redirect not expected without selected value');

        // Test createNewAddress: record with existing address
        ext.selectedValue = 'End User';
        ext.accountAdd = addr1.clone();
        pageRef = ext.createNewAddress();
        System.assertEquals(null, pageRef, 'Page redirect not expected for duplicate address');

        // Test getAddress: no test data available for external API call

        // Test reflectSelAddress: no address selected
        ext.reflectSelAddress();
        System.assertEquals(false, ext.accountAdd.isAddressFilled(), 'No address should be reflected');

        // Test reflectSelAddress: address selected
        ext.index = '2';
        ext.reflectSelAddress();
        System.assertNotEquals(null, ext.accountAdd, 'The selected address should be reflected');

    }
}