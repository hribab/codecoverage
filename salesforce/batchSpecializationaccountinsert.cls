global class batchSpecializationaccountinsert implements Database.Batchable<sObject>{
    
   global  Database.QueryLocator start (Database.BatchableContext Accinfo){ 
    //String query = 'SELECT Id, Name, PartnerType__c, Specialization__c, Partner_Tier__c, Partner_Business_Size__c FROM Account where status__c=\'Active\' and Id=\'001U000000YdGkT\'';
    String query = 'SELECT Id, Name, PartnerType__c, Specialization__c, Partner_Tier__c, Partner_Business_Size__c FROM Account where status__c=\'Active\' and RecordType__c = \'Enterprise - Business Partner\'';
            return Database.getQueryLocator(query);
   }
    
    global void execute(Database.BatchableContext Accinfo, List<Account> Scopeaccount)
    {
        Set<String> accIds = new Set<String>();
        for(account a: Scopeaccount)
            accIds.add(a.id);
        PartnerSpecializationUtility sUtil= new PartnerSpecializationUtility();
        Map<String, String> accSpecialities = new Map<String, String > ();
        
        for(String abc: accIds)
        {         
        sUtil.accountId = abc;
        sUtil.getSpecializationByOffering(); 
        accSpecialities.put(abc, sUtil.specialization);
        }       
        if(accSpecialities.size()>0){
        for(Account acc : Scopeaccount){
            if(accSpecialities.containsKey(acc.id))
                acc.Specialization__c =accSpecialities.get(acc.id);  
        }
        }
         update Scopeaccount;
    } 
    
    global void finish(Database.batchableContext Accinfo){    

       } 
}