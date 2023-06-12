@isTest
public class AccountRevenueForecastHelperTest {
    
    @isTest
    static void testOnBeforeInsertUpdate() {
        List<Account_Revenue_Forecast__c> newList = new List<Account_Revenue_Forecast__c>();

        // Test case 1: Manual_Update__c is true
        newList.add(new Account_Revenue_Forecast__c(Manual_Update__c = true));

        // Test cases 2-5: Various combinations of threshold checks
        newList.add(new Account_Revenue_Forecast__c(Q1_2016_Risk__c = 11000));
        newList.add(new Account_Revenue_Forecast__c(Q2_2016_Upside__c = 15000, Q2_2016_Best_Diff__c = -11000));
        newList.add(new Account_Revenue_Forecast__c(Q4_2016_Low_Diff__c = 11000, Q3_2016_Land_Diff__c = 14999));
        newList.add(new Account_Revenue_Forecast__c(Q1_2016_Low_Diff__c = -11000, Q2_2016_Land_Diff__c = 10001));

        Test.startTest();
        AccountRevenueForecastHelper.onBeforeInsertUpdate(newList);
        Test.stopTest();

        // Assert manual update check
        System.assert(newList[0].Manual_Update__c == false);

        // Assert Comment_Validation__c is set to true for records with threshold met
        System.assert(newList[1].Comment_Validation__c == true);
        System.assert(newList[2].Comment_Validation__c == true);
        System.assert(newList[3].Comment_Validation__c == true);
        System.assert(newList[4].Comment_Validation__c == true);
    }

    @isTest
    static void testBeforeInsertArfGsfieldPopulate() {
      Map<String, String> map_GSNameARFOffering = new Map<String, String>{'PureCloud' => 'PureCloud', 'PureConnect Cloud' => 'PureConnect', 'PureEngage Cloud' => 'PureEngage', 'PureEnagae Cloud Outbound' => 'Outbound', 'Premier Edition' => 'Premier', 'Cloud Solution Partner (PPU)' => 'Cloud Solution Partner (PPU)'};
         
        List<Account_Revenue_Forecast__c> listArfObj = new List<Account_Revenue_Forecast__c>();
        Set<Id> accounts = new Set<Id>();

        for (Integer i = 0; i < 5; i++) {
            Account a = new Account(Name='TestAccount' + i);
            insert a;
            accounts.add(a.Id);
            
            JBCXM__GSRelationship__c gs = new JBCXM__GSRelationship__c(Name=map_GSNameARFOffering.keySet()[i], JBCXM__Account__c=a.Id);
            insert gs;

            listArfObj.add(new Account_Revenue_Forecast__c(Account__c=a.Id, Offering_Type__c=map_GSNameARFOffering.values()[i]));
        }
        Test.startTest();
        AccountRevenueForecastHelper.beforeInsertArfGsfieldPopulate(listArfObj);
        Test.stopTest();

        for (Account_Revenue_Forecast__c arfObj : listArfObj) {
            System.assert(map_GSNameARFOffering.get(arfObj.GS_Relationship__r.Name) == arfObj.Offering_Type__c);
        }
    }
}