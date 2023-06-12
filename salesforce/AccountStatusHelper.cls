//Naresh Kumar	06/16/206
public without sharing class AccountStatusHelper {
	public static void populateAccountOppDetails(Account account, Id opportunityId){
		account.Type = 'Customer';
		account.Status__c = 'Active';
		account.New_Logo_Opportunity__c = opportunityId;
		account.New_Logo_Converted_Date__c = System.today();		
	}	
}