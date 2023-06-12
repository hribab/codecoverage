//Naresh Kumar	06/09/2016
public without sharing class AccountStatusBatchHelper {

	//SELECT id FROM Account WHERE ID IN (SELECT AccountId FROM ServiceContract WHERE EndDate < LAST_N_DAYS:1095)
	public static void updateAccountStatusToInactive(List<Account> accounts){
		Set<Id> setOfAccountIds = new Set<Id>();
		for(Account eachAccount : accounts){
			setOfAccountIds.add(eachAccount.id);
		}
		List<ServiceContract> SCs = [SELECT id, AccountId, EndDate FROM ServiceContract WHERE AccountId IN : setOfAccountIds];
		Map<Id, Boolean> mapOfAccountIdVsIsExpired = new Map<Id, Boolean>();		
		for(ServiceContract eachSC : SCs){
			if(eachSC.EndDate > System.today().addDays(-1095))
				mapOfAccountIdVsIsExpired.put(eachSC.AccountId, true);
			else
				mapOfAccountIdVsIsExpired.put(eachSC.AccountId, false);				
		}
		List<Account> accountsToBeUpdated = new List<Account>();
		for(Id eachAccountId : mapOfAccountIdVsIsExpired.keyset()){
			if(mapOfAccountIdVsIsExpired.get(eachAccountId) && !mapOfAccountIdVsIsExpired.get(eachAccountId)){
				Account accountToBeUpdated = new Account( id = eachAccountId, Status__c = 'Inactive' );
				accountsToBeUpdated.add(accountToBeUpdated);	
			}
		}
		if(!accountsToBeUpdated.isEmpty())
			update accountsToBeUpdated;		
	}
	
	//SELECT id FROM Account WHERE ID IN (SELECT AccountId FROM ServiceContract WHERE EndDate < LAST_N_DAYS:120 AND EndDate >= LAST_N_DAYS:1095)
	public static void updateAccountStatusToExpiredMaintenance(List<Account> accounts){
		Set<Id> setOfAccountIds = new Set<Id>();
		for(Account eachAccount : accounts){
			setOfAccountIds.add(eachAccount.id);
		}
		List<ServiceContract> SCs = [SELECT id, AccountId, EndDate FROM ServiceContract WHERE AccountId IN : setOfAccountIds];
		Map<Id, Boolean> mapOfAccountIdVsIsExpired = new Map<Id, Boolean>();		
		for(ServiceContract eachSC : SCs){
			if(eachSC.EndDate > System.today().addDays(-1095))
				mapOfAccountIdVsIsExpired.put(eachSC.AccountId, true);
			else
				mapOfAccountIdVsIsExpired.put(eachSC.AccountId, false);				
		}
		List<Account> accountsToBeUpdated = new List<Account>();
		for(Id eachAccountId : mapOfAccountIdVsIsExpired.keyset()){
			if(mapOfAccountIdVsIsExpired.get(eachAccountId) && !mapOfAccountIdVsIsExpired.get(eachAccountId)){
				Account accountToBeUpdated = new Account( id = eachAccountId, Status__c = 'Expired Maintenance' );
				accountsToBeUpdated.add(accountToBeUpdated);	
			}
		}
		if(!accountsToBeUpdated.isEmpty())
			update accountsToBeUpdated;		
	}
	
	
}