//Naresh Kumar  02/05/2016
/*
Modified By:         Swastika Rajkhowa(Rsystems)
Modified Date:       04/04/2016
Function   :         Added a function UpdateCustomAddress to update Address, Country and state custom field by Billing Address if it is not blank and custom field should be blank.
*/
public without sharing class AccountHelper {
    
    public static void onAfterUpdate(List<Account> newList, Map<Id, Account> oldMap){
        //Map<Id, Account> accountIdVsAccount = new Map<Id, Account>([SELECT RecordType.DeveloperName FROM Account WHERE id IN : oldMap.keyset()]);
        List<Account> accountsToBeUpdated = new List<Account>();
        Set<Id> masterAccountIds = new Set<Id>();
        //Looping over each account 
        for(Account eachAccount : newList){           
            if(eachAccount.RecordTypeId != oldMap.get(eachAccount.id).RecordTypeId 
                && oldMap.get(eachAccount.id).Account_RecordType_Developer_Name__c == 'EMGCustomerRecordType'){
                Account accountToBeUpdated = new Account( id = eachAccount.id );
                accountToBeUpdated.New_Logo_Converted_Date__c = System.today();
                accountsToBeUpdated.add(accountToBeUpdated);            
            }
            //Getting master account ids when an account gets merged.
            if(eachAccount.Status__c == 'Merged' && eachAccount.Status__c != oldMap.get(eachAccount.id).Status__c
                && eachAccount.Merge_to__c != null){
                masterAccountIds.add(eachAccount.Merge_to__c);
            }
                    
        }
        if(!accountsToBeUpdated.isEmpty())
            update accountsToBeUpdated;
            
        if(!masterAccountIds.isEmpty())
            SMLHelperWTS.updateSMLRealTimeF(masterAccountIds);
    }
    
    public static void onBeforeUpdate(List<Account> newList, Map<Id, Account> oldMap){
        //Looping over each account 
        for(Account eachAccount : newList){
            /* 
            if(eachAccount.Type == 'Customer' && oldMap.get(eachAccount.id).Type == 'Prospect'){
                eachAccount.Status__c = 'Active';                       
            }
            */
            if(oldMap.get(eachAccount.id).Type == 'Inactive' && eachAccount.Status__c == 'Active'){
                eachAccount.New_Logo_Converted_Date__c = null;                      
            }           
        }       
    }
    
    
    //Naresh Kumar, 04/29/2016. Commenting out below part of the class. Need to deploy it to production.
    /*
    //Created by Swastika to update custom address fields by Billing Address
     public static void UpdateCustomAddress(List<Account> newList){
       if(checkRecursive.runOnce())
        {       
         List<Account> lst_AccountToUpdate = new List<Account>();
         Set<Id> accIds = new Set<Id>();
         
         // Interate selected Acc records
        for (Account Acc : newList){
            accIds.add(Acc.id); 
        }
        
         List<Account> lst_Accounts=[select Id,BillingState,StateProvince__c,BillingCountry,Country__c,BillingStreet,BillingCity,BillingPostalCode,Street1__c,City__c from Account where Id in:accIds];  
         for(Account eachAccount : lst_Accounts){ 
             string strAddress=(String.isBlank(eachAccount.BillingStreet)==false ? eachAccount.BillingStreet+',':'') + (String.isBlank(eachAccount.BillingCity)==false ? eachAccount.BillingCity+',':'') + (String.isBlank(eachAccount.BillingState)==false ? eachAccount.BillingState+',':'') + (String.isBlank(eachAccount.BillingPostalCode)==false ? eachAccount.BillingPostalCode+',':'')+ (String.isBlank(eachAccount.BillingCountry)==false ? eachAccount.BillingCountry+',':'') ;
                 if(!String.isBlank(strAddress))
                     strAddress = strAddress.substring(0,strAddress.length()-1); //remove the last ',' character if the string is not blank
                 if(eachAccount.Street1__c==null && !String.isBlank(strAddress))
                     eachAccount.Street1__c= strAddress;
                 if  (eachAccount.BillingCity!=null && eachAccount.City__c==null)                  
                     eachAccount.City__c=eachAccount.BillingCity;  
                 if (eachAccount.BillingState!=null && eachAccount.StateProvince__c==null)  
                      eachAccount.StateProvince__c=eachAccount.BillingState;                 
                 lst_AccountToUpdate.add(eachAccount); //Added in the list
         }
          if(!lst_AccountToUpdate.isEmpty())
            update lst_AccountToUpdate;     
     }
     }
     */
}