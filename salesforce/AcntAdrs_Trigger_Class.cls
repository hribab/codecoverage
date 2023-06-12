/*
Raghu R : 2/3/2014 : MDM Project : Utility class  for the trigger AccountAddress_Trigger.

*/
public with sharing class AcntAdrs_Trigger_Class {
  
  Public Static void onAfterInsert(List<Address__c> TriggerNew) {  	  
  updateAdrsAsPrimary(TriggerNew);
  }    
  
   private static void updateAdrsAsPrimary(List<Address__c> TriggerNew)
   {
  	 Set<id> acntIds = new Set<id>();
  	 List<Address__c> adrUpdateList = new List<Address__c>();
  	 Map<id,List<Address__c>> addrListEachOrder = new Map<id,List<Address__c>>();
  	 Map<String, Map<String,Boolean>> eachAcntMap = new Map<String, Map<String,Boolean>>(); 
  	 Set<String> addrsTypeSet = new Set<String>();
  	  Map<String,Integer> AddrsSortMap = new Map<String,Integer>{'Sold To'=> 1,'End User' => 2,'Bill To' => 3 ,'Ship To' => 4,'Corporate' => 5 };
  	  Map<Integer,Address__c> triggerNewSortMap = new Map<Integer,Address__c>();

  	 for(Address__c eachAdress : TriggerNew)
  	 {  	  	
  	  	if(eachAdress.Account__c != null)
  	  	{
  	    	acntIds.add(eachAdress.Account__c);
  	    	triggerNewSortMap.put(AddrsSortMap.get(eachAdress.Type__c),eachAdress);
  	  	}
  	  }  

  	  List<Address__c> sortedTriggernew = new List<Address__c>();
  	  
  	  List<Integer> keys = new List<Integer>(triggerNewSortMap.keySet());
      keys.sort();
      
      system.debug('-----------------keys---------------'+keys);
       
      for(Integer key : keys){ 
         sortedTriggernew.add(triggerNewSortMap.get(key)); 
        }
  	  
  	  system.debug('-------------------------------acntIds------------------------------'+acntIds);
  	    	 
  	  for(Address__c eachAdr : [Select Id,Type__c,Account__c from Address__c where Account__c in:acntIds])
  	  {
  	     List<Address__c> eachAdrList = new List<Address__c>();
  	     if(addrListEachOrder.get(eachAdr.Account__c) != null)
  	     {
  	       eachAdrList = addrListEachOrder.get(eachAdr.Account__c);
  	     }
  	      eachAdrList.add(eachAdr);
  	      addrListEachOrder.put(eachAdr.Account__c,eachAdrList);    
  	   }


     if(addrListEachOrder.keySet().size() > 0)
     {
   
      for( Id Acntid : addrListEachOrder.keySet())
      {
        Map<String,Boolean> eachFlagMap = new Map<String,Boolean>();
      
        for(Address__c eachAdr : addrListEachOrder.get(AcntId))
     	{
         eachFlagMap.put(eachAdr.Type__c,true);  	  	 
     	}
        eachAcntMap.put(Acntid,eachFlagMap);
       }  	 
     }
   
  	  
  	   Map<id,String> updatedAddressMap = new Map<id,String>();
  	   Set<id> addressIdSet = new Set<id>();
  	  
  	   for(Address__c eachAdress : sortedTriggernew)
  	   {        
        Boolean soldToFlag = false , endUserFlag = false , billToFlag = false , shipToFlag = false ,corporateFlag = false;
        
         if(eachAcntMap.get(eachAdress.Account__c) != null)
         {
         	if(eachAcntMap.get(eachAdress.Account__c).get('Sold To') != null) { soldToFlag = eachAcntMap.get(eachAdress.Account__c).get('Sold To'); }
            if(eachAcntMap.get(eachAdress.Account__c).get('End User') != null) { endUserFlag = eachAcntMap.get(eachAdress.Account__c).get('End User'); }
            if(eachAcntMap.get(eachAdress.Account__c).get('Bill To') != null) { billToFlag = eachAcntMap.get(eachAdress.Account__c).get('Bill To');  }
            if(eachAcntMap.get(eachAdress.Account__c).get('Ship To') != null) { shipToFlag = eachAcntMap.get(eachAdress.Account__c).get('Ship To'); }
            if(eachAcntMap.get(eachAdress.Account__c).get('Corporate') != null) { corporateFlag = eachAcntMap.get(eachAdress.Account__c).get('Corporate'); }
         }
         
  	  	if(eachAdress.Type__c == 'Sold To')
  	  	{
  	     eachAdress.Is_Primary__c = true;
  	     addressIdSet.add(eachAdress.Id);
  	     updatedAddressMap.put(eachAdress.Account__c,'Created');
  	   	} 

  	  	if(eachAdress.Type__c == 'End User' && !soldToFlag && updatedAddressMap.get(eachAdress.Account__c) != 'Created')
  	  	{
  	  	  eachAdress.Is_Primary__c = true;
  	  	  updatedAddressMap.put(eachAdress.Account__c,'Created');
  	      addressIdSet.add(eachAdress.Id);  	  	  
  	  	}
  	  	
  	  	if(eachAdress.Type__c == 'Bill To' && !soldToFlag && !endUserFlag  && updatedAddressMap.get(eachAdress.Account__c) != 'Created')
  	  	{
  	  	  eachAdress.Is_Primary__c = true;
  	  	  addressIdSet.add(eachAdress.Id);	
  	  	  updatedAddressMap.put(eachAdress.Account__c,'Created'); 
  	   	 }
  	  	
  	  	if(eachAdress.Type__c == 'Ship To' && !soldToFlag && !endUserFlag && !billToFlag  && updatedAddressMap.get(eachAdress.Account__c) != 'Created')
  	  	{
  	  	  eachAdress.Is_Primary__c = true;
  	  	  addressIdSet.add(eachAdress.Id); 	  	  
  	  	  updatedAddressMap.put(eachAdress.Account__c,'Created');
  	  	}
  	  	
  	  	if(eachAdress.Type__c == 'Corporate' && !soldToFlag && !endUserFlag && !billToFlag && !shipToFlag  && updatedAddressMap.get(eachAdress.Account__c) != 'Created')
  	  	{
  	  	 eachAdress.Is_Primary__c = true;
  	  	 updatedAddressMap.put(eachAdress.Account__c,'Created');
  	     addressIdSet.add(eachAdress.Id); 	 	  	  
  	  	}
  	  } 


  	  for(Address__c eachAdr : [Select Id,Type__c,Is_Primary__c from Address__c where Account__c in:acntIds])
  	  {
  	  	if(!addressIdSet.contains(eachAdr.id) && updatedAddressMap.size() > 0 )
  	  	{
  	  	 if(eachAdr.Is_Primary__c == true)
  	  	 {
  	    	 eachAdr.Is_Primary__c = false;	
  	         adrUpdateList.add(eachAdr);
  	  	 }
  	  	}
  	  }
  	 update adrUpdateList;  	  
   }
}