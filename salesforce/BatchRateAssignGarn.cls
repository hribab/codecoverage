global class BatchRateAssignGarn implements Database.Batchable<SObject>, Database.Stateful
{

    public Cloud_Billing_Log__c objJobLog;
    
    	// *** constructor ***
    public BatchRateAssignGarn()
    {         
        // Initialization Code
    }

    global Database.QueryLocator start(Database.BatchableContext BC) 
    {              
        System.debug('start');
        System.debug(objJobLog);
		if(objJobLog == null)
            objJobLog = new Cloud_Billing_Log__c(Type__c = 'Populate Garn', Time__c = DateTime.now());
        
        objJobLog.Exceptions__c = (objJobLog.Exceptions__c == null) ? '':objJobLog.Exceptions__c;
		
        String strQuery = 'SELECT Id,Platform_Id_Hash__c FROM Rolled_Up_Usage_Data__c WHERE GARN_Account_Code__c = null';
//strQuery = strQuery + ' and Id = \'a9zP00000002bxzIAA\'';
        System.debug('populateMissingGARNCodes: strSOQL ' + strQuery);
        return Database.getQueryLocator(strQuery);
    }

    global void execute(Database.BatchableContext BC, List<SObject> sObjects)
    {
        System.Debug('execute');
        // DB Save-point
        Savepoint objSP = Database.setSavepoint();
        try 
        {           
            // Storing Roll Up records to be processed in current batch
            List<Rolled_Up_Usage_Data__c> list_GARNCodeMissingData = (List<Rolled_Up_Usage_Data__c>)sObjects;
            CloudBillingUtil.populateGARNCodesFromCloudDeployment(list_GARNCodeMissingData);
            update list_GARNCodeMissingData;
        }
        catch(Exception e) 
        {
            System.debug('Exception <<<< ' + e.getMessage());
            // Record exception in Log
            objJobLog.Exceptions__c += e.getMessage() + '\n';
            // Roll back changes in case of DML failure
            Database.rollback(objSP);
        }
    }
    
    	/*** Populate GARN Code on Roll Up Usage Data records in case it's missing ***
	private void populateMissingGARNCodes()
	{
        String strQuery = 'SELECT Id,Platform_Id_Hash__c FROM Rolled_Up_Usage_Data__c WHERE GARN_Account_Code__c = null ';
        if (Label.Cloud_Billing_Rating_Limit_Where_Clause != 'NONE') {
            strQuery = strQuery + strLimitRating;
        }
        strQuery = strQuery + ' LIMIT 9999';
        System.debug('populateMissingGARNCodes: strSOQL ' + strQuery);
        List<Rolled_Up_Usage_Data__c> list_GARNCodeMissingData = (List<Rolled_Up_Usage_Data__c>)Database.query(strQuery);

		if(!list_GARNCodeMissingData.isEmpty())
		{
			//Util.populateGARNCodes(list_GARNCodeMissingData); 
			Util.populateGARNCodesFromCloudDeployment(list_GARNCodeMissingData);
			update list_GARNCodeMissingData;
		}	
	}
*/
    // *** Finish Method : Exception notifications and other final code ***
    global void finish(Database.BatchableContext BC) 
    {
        System.Debug('finish');
        // Insert/Update Log record
        if(objJobLog != null)
            upsert objJobLog;
        
        // Invoke reconciliation batch jobs
        // No Scheduled Separately through ScheduleBatchReconcileRollupData
        //Database.executeBatch(new BatchReconcileRollupData(),10000);
		// The above method calls Database.executeBatch(new BatchReconcileServiceUsageData(),10000); after finishing		
    }

}