//Naresh Kumar  04/07/2016
public without sharing class AccountRevenueForecastHelper {
    public static Boolean CHANGE_VALUES_UPDATED = false;
    public static void onBeforeInsertUpdate(List<Account_Revenue_Forecast__c> newList){
        //Looping over new list
        for(Account_Revenue_Forecast__c eachRecord : newList){
            if(eachRecord.Manual_Update__c){
                eachRecord.Manual_Update__c = false;
                continue;
            }
            Integer threshold = 10000;
            Integer negativeThreshold = -10000;
            if((eachRecord.Q1_2016_Risk__c > 0 && eachRecord.Q1_2016_Risk__c > threshold) 
                || (eachRecord.Q2_2016_Risk__c > 0 && eachRecord.Q2_2016_Risk__c > threshold)
                || (eachRecord.Q3_2016_Risk__c > 0 && eachRecord.Q3_2016_Risk__c > threshold) 
                || (eachRecord.Q4_2016_Risk__c > 0 && eachRecord.Q3_2016_Risk__c > threshold)
                || (eachRecord.Q1_2016_Upside__c > 0 && eachRecord.Q1_2016_Upside__c > threshold)
                || (eachRecord.Q2_2016_Upside__c > 0 && eachRecord.Q2_2016_Upside__c > threshold)
                || (eachRecord.Q3_2016_Upside__c > 0 && eachRecord.Q3_2016_Upside__c > threshold)
                || (eachRecord.Q4_2016_Upside__c > 0 && eachRecord.Q4_2016_Upside__c > threshold)
                
                || (eachRecord.Q1_2016_Low_Diff__c > threshold || eachRecord.Q1_2016_Low_Diff__c < negativeThreshold)
                || (eachRecord.Q2_2016_Low_Diff__c > threshold || eachRecord.Q2_2016_Low_Diff__c < negativeThreshold)
                || (eachRecord.Q3_2016_Low_Diff__c > threshold || eachRecord.Q3_2016_Low_Diff__c < negativeThreshold)
                || (eachRecord.Q4_2016_Low_Diff__c > threshold || eachRecord.Q4_2016_Low_Diff__c < negativeThreshold)
                
                || (eachRecord.Q1_2016_Land_Diff__c > threshold || eachRecord.Q1_2016_Land_Diff__c < negativeThreshold)
                || (eachRecord.Q2_2016_Land_Diff__c > threshold || eachRecord.Q2_2016_Land_Diff__c < negativeThreshold)
                || (eachRecord.Q3_2016_Land_Diff__c > threshold || eachRecord.Q3_2016_Land_Diff__c < negativeThreshold)
                || (eachRecord.Q4_2016_Land_Diff__c > threshold || eachRecord.Q4_2016_Land_Diff__c < negativeThreshold)
                
                || (eachRecord.Q1_2016_Best_Diff__c > threshold || eachRecord.Q1_2016_Best_Diff__c < negativeThreshold)
                || (eachRecord.Q2_2016_Best_Diff__c > threshold || eachRecord.Q2_2016_Best_Diff__c < negativeThreshold)
                || (eachRecord.Q3_2016_Best_Diff__c > threshold || eachRecord.Q3_2016_Best_Diff__c < negativeThreshold)
                || (eachRecord.Q4_2016_Best_Diff__c > threshold || eachRecord.Q4_2016_Best_Diff__c < negativeThreshold)){                   
                eachRecord.Comment_Validation__c = true;
            }
        }
    }   
    public static void onAfterUpdate(List<Account_Revenue_Forecast__c> newList, Map<Id, Account_Revenue_Forecast__c> oldMap){
        /*
        if(CHANGE_VALUES_UPDATED)
            return;
        List<Account_Revenue_Forecast__c> accountRevenueForecastToBeUpdated = new List<Account_Revenue_Forecast__c>();
        //Looping over new list
        for(Account_Revenue_Forecast__c eachRecord : newList){
            Account_Revenue_Forecast__c oldRecord = oldMap.get(eachRecord.id);
            Account_Revenue_Forecast__c newRecord = new Account_Revenue_Forecast__c( id = eachRecord.id );
            //Low Change Q1
            if(eachRecord.Q1_2016_Low__c != oldRecord.Q1_2016_Low__c)
                newRecord.Low_Change_Q1__c = (eachRecord.Q1_2016_Low__c == null ? 0 : eachRecord.Q1_2016_Low__c) - (oldRecord.Q1_2016_Low__c == null ? 0 : oldRecord.Q1_2016_Low__c);
            if(eachRecord.Q2_2016_Low__c != oldRecord.Q2_2016_Low__c)
                newRecord.Low_Change_Q2__c = (eachRecord.Q2_2016_Low__c == null ? 0 : eachRecord.Q2_2016_Low__c) - (oldRecord.Q2_2016_Low__c == null ? 0 : oldRecord.Q2_2016_Low__c);
            if(eachRecord.Q3_2016_Low__c != oldRecord.Q3_2016_Low__c)
                newRecord.Low_Change_Q3__c = (eachRecord.Q3_2016_Low__c == null ? 0 : eachRecord.Q3_2016_Low__c) - (oldRecord.Q3_2016_Low__c == null ? 0 : oldRecord.Q3_2016_Low__c);
            if(eachRecord.Q4_2016_Low__c != oldRecord.Q4_2016_Low__c)
                newRecord.Low_Change_Q4__c = (eachRecord.Q4_2016_Low__c == null ? 0 : eachRecord.Q4_2016_Low__c) - (oldRecord.Q4_2016_Low__c == null ? 0 : oldRecord.Q4_2016_Low__c);
            //Land Change Q1
            if(eachRecord.Q1_2016_Land__c != oldRecord.Q1_2016_Land__c)
                newRecord.Land_Change_Q1__c = (eachRecord.Q1_2016_Land__c == null ? 0 : eachRecord.Q1_2016_Land__c) - (oldRecord.Q1_2016_Land__c == null ? 0 : oldRecord.Q1_2016_Land__c);
            if(eachRecord.Q2_2016_Land__c != oldRecord.Q2_2016_Land__c)
                newRecord.Land_Change_Q2__c = (eachRecord.Q2_2016_Land__c == null ? 0 : eachRecord.Q2_2016_Land__c) - (oldRecord.Q2_2016_Land__c == null ? 0 : oldRecord.Q2_2016_Land__c);
            if(eachRecord.Q3_2016_Land__c != oldRecord.Q3_2016_Land__c)
                newRecord.Land_Change_Q3__c = (eachRecord.Q3_2016_Land__c == null ? 0 : eachRecord.Q3_2016_Land__c) - (oldRecord.Q3_2016_Land__c == null ? 0 : oldRecord.Q3_2016_Land__c);
            if(eachRecord.Q4_2016_Land__c != oldRecord.Q4_2016_Land__c)
                newRecord.Land_Change_Q4__c = (eachRecord.Q4_2016_Land__c == null ? 0 : eachRecord.Q4_2016_Land__c) - (oldRecord.Q4_2016_Land__c == null ? 0 : oldRecord.Q4_2016_Land__c);
            //Best Change Q1
            if(eachRecord.Q1_2016_Best__c != oldRecord.Q1_2016_Best__c)
                newRecord.Best_Change_Q1__c = (eachRecord.Q1_2016_Best__c == null ? 0 : eachRecord.Q1_2016_Best__c) - (oldRecord.Q1_2016_Best__c == null ? 0 : oldRecord.Q1_2016_Best__c);
            if(eachRecord.Q2_2016_Best__c != oldRecord.Q2_2016_Best__c)
                newRecord.Best_Change_Q2__c = (eachRecord.Q2_2016_Best__c == null ? 0 : eachRecord.Q2_2016_Best__c) - (oldRecord.Q2_2016_Best__c == null ? 0 : oldRecord.Q2_2016_Best__c);
            if(eachRecord.Q3_2016_Best__c != oldRecord.Q3_2016_Best__c)
                newRecord.Best_Change_Q3__c = (eachRecord.Q3_2016_Best__c == null ? 0 : eachRecord.Q3_2016_Best__c) - (oldRecord.Q3_2016_Best__c == null ? 0 : oldRecord.Q3_2016_Best__c);
            if(eachRecord.Q4_2016_Best__c != oldRecord.Q4_2016_Best__c)
                newRecord.Best_Change_Q4__c = (eachRecord.Q4_2016_Best__c == null ? 0 : eachRecord.Q4_2016_Best__c) - (oldRecord.Q4_2016_Best__c == null ? 0 : oldRecord.Q4_2016_Best__c);
            Integer threshold = 10000;
            Integer thresholdNegative = -10000;
            if(newRecord.Low_Change_Q1__c > threshold || newRecord.Low_Change_Q1__c < thresholdNegative
                || newRecord.Low_Change_Q2__c > threshold || newRecord.Low_Change_Q2__c < thresholdNegative
                || newRecord.Low_Change_Q3__c > threshold || newRecord.Low_Change_Q3__c < thresholdNegative
                || newRecord.Low_Change_Q4__c > threshold || newRecord.Low_Change_Q4__c < thresholdNegative
                || newRecord.Low_Change_Q4__c > threshold || newRecord.Low_Change_Q4__c < thresholdNegative
                
                || newRecord.Land_Change_Q4__c > threshold || newRecord.Land_Change_Q4__c < thresholdNegative
                || newRecord.Land_Change_Q4__c > threshold || newRecord.Land_Change_Q4__c < thresholdNegative
                || newRecord.Land_Change_Q4__c > threshold || newRecord.Land_Change_Q4__c < thresholdNegative
                || newRecord.Land_Change_Q4__c > threshold || newRecord.Land_Change_Q4__c < thresholdNegative
                
                || newRecord.Best_Change_Q4__c > threshold || newRecord.Best_Change_Q4__c < thresholdNegative
                || newRecord.Best_Change_Q4__c > threshold || newRecord.Best_Change_Q4__c < thresholdNegative
                || newRecord.Best_Change_Q4__c > threshold || newRecord.Best_Change_Q4__c < thresholdNegative
                || newRecord.Best_Change_Q4__c > threshold || newRecord.Best_Change_Q4__c < thresholdNegative){
                newRecord.Comment_Validation__c = true; 
            }
            accountRevenueForecastToBeUpdated.add(newRecord);       
            CHANGE_VALUES_UPDATED = true;   
        }
        if(!accountRevenueForecastToBeUpdated.isEmpty())
            update accountRevenueForecastToBeUpdated;
        */
    }
    /*
    public static void onBeforeUpdate(List<Account_Revenue_Forecast__c> newList, Map<Id, Account_Revenue_Forecast__c> oldMap){
        //Looping over new list
        for(Account_Revenue_Forecast__c eachRecord : newList){
            Account_Revenue_Forecast__c oldRecord = oldMap.get(eachRecord.id);
            Decimal threshold = 0;
            //LOW           
            eachRecord.Comment_Validation__c = false;
            threshold = getThreshold(eachRecord.Q1_2016_Low__c, oldRecord.Q1_2016_Low__c, threshold);
            threshold = getThreshold(eachRecord.Q2_2016_Low__c, oldRecord.Q2_2016_Low__c, threshold);
            threshold = getThreshold(eachRecord.Q3_2016_Low__c, oldRecord.Q3_2016_Low__c, threshold);
            threshold = getThreshold(eachRecord.Q4_2016_Low__c, oldRecord.Q4_2016_Low__c, threshold);
            Account_Revenue_Forecast_Settings__c lowThreshold = Account_Revenue_Forecast_Settings__c.getAll().get('Low');
            if(lowThreshold != null && lowThreshold.Threshold__c != null && threshold >= lowThreshold.Threshold__c){
                eachRecord.Comment_Validation__c = true;            
                continue;
            }
            //LAND
            threshold = getThreshold(eachRecord.Q1_2016_Land__c, oldRecord.Q1_2016_Land__c, threshold);
            threshold = getThreshold(eachRecord.Q2_2016_Land__c, oldRecord.Q2_2016_Land__c, threshold);
            threshold = getThreshold(eachRecord.Q3_2016_Land__c, oldRecord.Q3_2016_Land__c, threshold);
            threshold = getThreshold(eachRecord.Q4_2016_Land__c, oldRecord.Q4_2016_Land__c, threshold);
            lowThreshold = Account_Revenue_Forecast_Settings__c.getAll().get('Land');
            if(lowThreshold != null && lowThreshold.Threshold__c != null && threshold >= lowThreshold.Threshold__c){
                eachRecord.Comment_Validation__c = true;
                continue;   
            }
            //BEST
            threshold = getThreshold(eachRecord.Q1_2016_Best__c, oldRecord.Q1_2016_Best__c, threshold);
            threshold = getThreshold(eachRecord.Q2_2016_Best__c, oldRecord.Q2_2016_Best__c, threshold);
            threshold = getThreshold(eachRecord.Q3_2016_Best__c, oldRecord.Q3_2016_Best__c, threshold);
            threshold = getThreshold(eachRecord.Q4_2016_Best__c, oldRecord.Q4_2016_Best__c, threshold);
            lowThreshold = Account_Revenue_Forecast_Settings__c.getAll().get('Best');
            if(lowThreshold != null && lowThreshold.Threshold__c != null && threshold >= lowThreshold.Threshold__c){
                eachRecord.Comment_Validation__c = true;                
            }                                   
        }
    }
    
    private static Decimal getThreshold(Decimal newValue, Decimal OldValue, Decimal threshold){
        if(newValue != null && oldValue != null && (oldValue - newValue) > threshold)
            return oldValue - newValue;
        return threshold;
    }
    */
    
    /**
    *   Method Name :   beforeInsertArfGsfieldPopulate()
    *   Description :   This method used to update the ARF records if Gs and ARF contains same account id and offering type
        Added by Priyank as discussed with JJ.
    */
    
    public Static void beforeInsertArfGsfieldPopulate(List<Account_Revenue_Forecast__c> listArfObj){
    
        Map<string,string> mapAccountIdOfferingInsert = new Map<string,string>();//map of  account id and offeringtype of ARF records which are going to be insert.
        Map<string,string> mapAccountIdOfferingFromGs = new Map<string,string>();//map of account id and offeringtype of Gs records.
        Map<string,string> mapAccountIdGsObj = new Map<string,string>();//map of account id and gsObject id.
        Map<String, String> map_GSNameARFOffering = new Map<String, String>{'PureCloud' => 'PureCloud', 'PureConnect Cloud' => 'PureConnect', 'PureEngage Cloud' => 'PureEngage', 'PureEnagae Cloud Outbound' => 'Outbound', 'Premier Edition' => 'Premier', 'Cloud Solution Partner (PPU)' => 'Cloud Solution Partner (PPU)'};
       
        //For loop to iterate list of ARF and fill the data in mapAccountIdOfferingInsert
        for(Account_Revenue_Forecast__c arfObj : listArfObj){
            if(arfObj.GS_Relationship__c == null && arfObj.Account__c != null && arfObj.Offering_Type__c!=null){
                mapAccountIdOfferingInsert.put(arfObj.Account__c,arfObj.Offering_Type__c);
            }
        }
        
        //Query on Gs relationship to retrive GS record with respect to map of mapAccountIdOfferingInsert which contains account id and offeringtype
        for(JBCXM__GSRelationship__c gsObj : [SELECT id,Name,JBCXM__Account__c,Offerings_Type__c FROM JBCXM__GSRelationship__c WHERE JBCXM__Account__c IN : mapAccountIdOfferingInsert.KeySet()]){    //AND Offerings_Type__c IN : mapAccountIdOfferingInsert.values()]){
            //filling map for accountId and offering type below.
             /*
             if(gsObj.Name=='Purecloud'){
                mapAccountIdOfferingFromGs.put(gsObj.JBCXM__Account__c,'Purecloud');
            }else if(gsObj.Name=='PureConnect Cloud'){
                mapAccountIdOfferingFromGs.put(gsObj.JBCXM__Account__c,'PureConnect');
            }else if(gsObj.Name=='PureEngage Cloud'){
                mapAccountIdOfferingFromGs.put(gsObj.JBCXM__Account__c,'PureEngage');
            }else if(gsObj.Name=='PureEnagae Cloud Outbound'){
                mapAccountIdOfferingFromGs.put(gsObj.JBCXM__Account__c,'Outbound');
            }else if(gsObj.Name=='Premier Edition'){
                mapAccountIdOfferingFromGs.put(gsObj.JBCXM__Account__c,'Premier');
            }
            */
            //filling map for Account Id and GSObj id below.
            if(map_GSNameARFOffering.containsKey(gsObj.Name)){
                mapAccountIdOfferingFromGs.put(gsObj.JBCXM__Account__c, map_GSNameARFOffering.get(gsObj.Name));
                mapAccountIdGsObj.put(gsObj.JBCXM__Account__c,gsObj.id);
            }
            
        }
        
        //For loop to iterate list of ARF
        for(Account_Revenue_Forecast__c arfObj : listArfObj){ 
            if(mapAccountIdOfferingFromGs.containsKey(arfObj.Account__c) && arfObj.Offering_Type__c != null && mapAccountIdOfferingFromGs.get(arfObj.Account__c) == arfObj.Offering_Type__c){
                arfObj.GS_Relationship__c = mapAccountIdGsObj.get(arfObj.Account__c);
            }
        }
    }
}