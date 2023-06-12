public without sharing class AccountUpdateOrder 
{
    public static void updateAccount (Map<id,Order__c> newOrderMap, Map<id,Order__c> oldOrderMap) 
    {
        if(!newOrderMap.isEmpty()) {
            List<Account> accToBeUpdates = new List<Account>();
            Set<id> setAccIds = new Set<id>();            
            for(Order__c ord:[Select Opportunity__r.Gene_Care_Specialist__c,Quote__r.Current_Maint_Rate__c,Opportunity__r.Quote_Mtce_Ops__c, End_User_Name__c, 
                                    End_User_Name__r.Genesys_Care_Ops__c, End_User_Name__r.Genesys_Care_specialist__c, End_User_Name__r.Genesys_Care_Offering__c,
                              		Opportunity__c,Quote__r.Genesys_Care__c,
                                    Opportunity__r.Name, Quote__r.BigMachines__Is_Primary__c from Order__c 
                                    where id IN :newOrderMap.keyset()])
            {
                if(ord.Opportunity__r.Name !=null && ord.Quote__r.BigMachines__Is_Primary__c && ord.End_User_Name__c!=null && !setAccIds.contains(ord.End_User_Name__c) ){ 
                    Account accToBeUpdated = new Account(id=ord.End_User_Name__c); 
                    // Overwrite fields only if values are available
                    if(ord.End_User_Name__r.Genesys_Care_Ops__c == NULL && ord.Opportunity__r.Quote_Mtce_Ops__c != null)
                    	accToBeUpdated.Genesys_Care_Ops__c = ord.Opportunity__r.Quote_Mtce_Ops__c;
                    
                    if(ord.End_User_Name__r.Genesys_Care_specialist__c == NULL && ord.Opportunity__r.Gene_Care_Specialist__c != null)
                    	accToBeUpdated.Genesys_Care_specialist__c = ord.Opportunity__r.Gene_Care_Specialist__c;
                    
                    if(ord.End_User_Name__r.Genesys_Care_Offering__c == NULL && ord.Quote__r.Genesys_Care__c != null)
                    	accToBeUpdated.Genesys_Care_Offering__c = ord.Quote__r.Genesys_Care__c;
                    
                    if(ord.Quote__r.Current_Maint_Rate__c != null)
                    	accToBeUpdated.GC_contractual_rate__c  = ord.Quote__r.Current_Maint_Rate__c;
                    
                    accToBeUpdates.add(accToBeUpdated);
                    setAccIds.add(ord.End_User_Name__c);
                }   
            }

         
            try
            {
                if(!accToBeUpdates.isEmpty())
                    update accToBeUpdates;
            }catch(exception e)
            {
                System.debug('******EXCEPTION!****'+e.getmessage());
            }        
        }
    }
}