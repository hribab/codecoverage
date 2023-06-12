global class BatchRateCloudUsageData implements Database.Batchable<SObject>, Database.Stateful
{    
    public final static Integer SERVICE_TYPE_OUTBOUND_CALLING = 1;
    public final static Integer SERVICE_TYPE_INBOUND_CALLING = 2;
    public final static Integer DEVICE_TYPE_WIRELINE = 3;
    public final static Integer DEVICE_TYPE_WIRELESS = 13;

    // Log Record for this job
    public Cloud_Billing_Log__c objJobLog;
    // iTracks 24752 
	public class CallingRateNotFoundException extends Exception {}

    // *** constructor ***
    public BatchRateCloudUsageData()
    {         
        // Initialization Code
    }
    
    // For Testing, limit rating to a certain set of RUUD records. Must not be pushed to production
    String strLimitRating = Label.Cloud_Billing_Rating_Limit_Where_Clause;
    
    // *** Start Method : Querying unprocessed Rolled Up Usage records ***
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {              
        System.debug(objJobLog);
        if (objJobLog == null) {
            System.debug('Need to Create new Job Log');
            objJobLog = CloudBillingUtil.createNewCloudBillingLog('Rating','Submitted');
        } else {
            System.debug('objJobLog Exists ' + objJobLog);
        }
        
        objJobLog.Exceptions__c = (objJobLog.Exceptions__c == null) ? '':objJobLog.Exceptions__c;
		
		// Populate GARN Code on Roll Up Usage Data records in case it's missing
		populateMissingGARNCodes();
        
        // iTracks 24752 add column Calling_Rate_Identifier_Inbound__c
        // iTracks 25080 add column Service_Identifier_Default and Source_Name__c
        String strSOQL = 'SELECT Id,Rollup_Id__c,Service_Identifier__c,Service_Identifier_Default__c,Contract_Service_Identifier__c,Contract_Service_Identifier_Default__c,'
            + 'Start_Time__c,End_Time__c,Device_Steering_Digits__c,Billable_6__c,Billable_30__c,'
            + 'Destination_Device_Career__c,Gigabyte_Count__c,Inbound_Device__c,'
            + 'Billable_60__c,Count__c,Total_Duration__c,Service_Type__c,Usage_Type__c,GARN_Account_Code__c,Region_Code__c,Calling_Rate_Identifier__c,'
            + 'Default_Calling_Rate_Identifier__c,Calling_Rate_Identifier_Inbound__c,Source_Name__c,Platform_Id__c,Platform_Id_Hash__c,Processed__c,Device_Type__c,'
            + 'Rated_Amount__c,Rate__c,Activity_Type__c'
            + ', PCV_Service_Identifier__c'
            + ', PCV_Service_Identifier_Default__c'
            + ', (SELECT Id FROM Rolled_Up_Usage_Data_Taxes__r)'
            + ' FROM Rolled_Up_Usage_Data__c WHERE Processed__c = false ';
        if (!Test.isRunningTest() && strLimitRating != 'NONE') {
            strSOQL = strSOQL + strLimitRating;
        }
        // Must be ordered by Start Time or Calling Rates will not work properly
        strSOQL = strSOQL + ' ORDER BY Start_Time__c';

        if (Test.isRunningTest())
        {
            strSOQL += ' Limit 200';
        }

        System.debug('strSOQL ' + strSOQL);
        return Database.getQueryLocator(strSOQL);
    }

    // Concatenate str onto comment placing space if comment is not empty
    @TestVisible
    private String concatComment(String comment, String str) {
    	if (String.isEmpty(comment)) {
    		return str;
    	}
    	return comment + ' ' + str;
    }

    public static List<String> pushCarrierContractServiceIdentifiers(Rolled_Up_Usage_Data__c objRollUpData, 
                                                              List<String> listContractServiceIdentifiers,
                                                              Map<String, String> map_CarrierDigitsToCarrierName) {
        List<String> listCarrierContractServiceIdentifiers = new List<String>();
        if (map_CarrierDigitsToCarrierName.containsKey(objRollUpData.Inbound_Device__c)) {
            String strCarrierDigits = map_CarrierDigitsToCarrierName.get(objRollUpData.Inbound_Device__c);
            System.Debug('pushCarrierContractServiceIdentifiers: strCarrierDigits got ' + strCarrierDigits);
            for (String strContractServiceIdentifier : listContractServiceIdentifiers) {
                String strNewContractServiceIdentifier = strCarrierDigits + '#' + strContractServiceIdentifier;
                System.Debug('pushCarrierContractServiceIdentifiers: Adding dynamic carrier contract service identifer ' + strNewContractServiceIdentifier);
                listCarrierContractServiceIdentifiers.add(strNewContractServiceIdentifier);
            }
            System.Debug('pushCarrierContractServiceIdentifiers: Return listCarrierContractServiceIdentifiers ' + listCarrierContractServiceIdentifiers);
        }
        return listCarrierContractServiceIdentifiers;
    }

        // *** Execute Method : Processing roll up records in batches (default batch size = 200) ***
    global void execute(Database.BatchableContext BC, List<SObject> sObjects) 
    {
        // DB Save-point
        Savepoint objSP = Database.setSavepoint();
        try 
        {           
            // Storing Roll Up records to be processed in current batch
            List<Rolled_Up_Usage_Data__c> list_RolledUpUsageData = (List<Rolled_Up_Usage_Data__c>)sObjects;
            
            // List of Service usage data corresponding to Roll Up Usage data (1:1 relationship)
            List<Service_Usage__c> list_ServiceUsageData = new List<Service_Usage__c>();
            
            // List of Service usage data to be created/inserted
            List<Service_Usage__c> list_ServiceUsageDataToBeCreated = new List<Service_Usage__c>();
            
            // Contract Tier Set Months to be created/inserted
            List<Contract_Tier_Set_Month__c> list_TierSetMonthsToBeCreated = new List<Contract_Tier_Set_Month__c>();
            
            // Set of GARN Account Codes
            Set<String> set_GARNCodes = new Set<String>();
            
            // Set of Contract Service Identifiers
            Set<String> set_ContractServiceIdentifiers = new Set<String>();
            
            // Set of Calling Rate Identifiers
            Set<String> set_CallingRateIdentifiers = new Set<String>();

			// iTracks 24752
			// Set of Calling Rate Identifiers for Inbound Calls
            Set<String> set_InboundCallingRateIdentifiers = new Set<String>();
            
            // Set of Tier Set Month Hashes
            Set<String> set_TierSetMonthHashes = new Set<String>();
            
            // Set of Service Identifiers that could not be mapped to Contract Services
            Set<String> set_ServiceIdentifiersNotMapped = new Set<String>();
            
            // Set of Tier Set Ids
            Set<Id> set_TierSetIds = new Set<Id>();
            
            // Map of Rollup Id To Billing Exception :  To be upserted based on parent Roll up record
            Map<Id,Cloud_Billing_Exception__c> map_RollupIdToBillingException = new Map<Id,Cloud_Billing_Exception__c>();
            
            // Map of Rollup records
            Map<Id,Rolled_Up_Usage_Data__c> map_RollupUsageData = new Map<Id,Rolled_Up_Usage_Data__c>();
            
            // Map of GARN Code To Contract record : Assumption each account will have one contract
            Map<String,GCR_Content_Document_Detail__c> map_GARNCodeToContract = new Map<String,GCR_Content_Document_Detail__c>();
            
            // Map of Calling Rate Identifier To Calling Rate (amount)
            Map<String,List<Calling_Rate__c>> map_RateIdentifierToCallingRate = new Map<String,List<Calling_Rate__c>>();

			// iTracks 24752
            // Map of Hairpin Number (Inbound NUmber) To Inbound Calling Rate
            Map<String,List<Inbound_Calling_Rate__c>> map_HairpinToInboundCallingRate = new Map<String,List<Inbound_Calling_Rate__c>>();
            
            // Map of Contract Service Identifier To Contract Service record
            // CRMBILL-85 Now we can match a list of contract services
            Map<String,List<Contract_Service__c>> map_ContServIdentifierToContServ = new Map<String,List<Contract_Service__c>>();
            
            // Map of Contract Tier Set Month Hash To Contract Tier Set Month record id
            Map<String,Id> map_TSMHashToTierSetMonthId = new Map<String,Id>();
            
            // Map of Service Identifier To Service record
            Map<String,Service__c> map_ServicesNotMapped = new Map<String,Service__c>();
            
            // Map of Contract Tier Set Month Hash To Contract Tier Set Period record
            Map<String,Contract_Tier_Set_Period__c> map_TSMHashToPeriodAggregator = new Map<String,Contract_Tier_Set_Period__c>();
            
            // Map of Contract Tier Sets
            Map<Id,Contract_Tier_Set__c> map_ContractTierSets;
            
            // Map of Contract Tier Set Period Hash To Contract Tier Set Period record
            Map<String,Contract_Tier_Set_Period__c> map_PeriodHashToPeriodAggregator = new Map<String,Contract_Tier_Set_Period__c>();
            
            // Removing any existing Service Usage records for unprocessed roll up data
            delete ([SELECT Id FROM Service_Usage__c WHERE Rolled_Up_Usage_Data__c IN :list_RolledUpUsageData]);
            
            // Removing any existing Billing Exceptions for unprocessed roll up data
            delete ([SELECT Id FROM Cloud_Billing_Exception__c WHERE Rolled_Up_Usage_Data__c IN :list_RolledUpUsageData]);

			// This logic assumes the list_RolledUpUsageData is ordered by Start_Time__c
            DateTime earliestDateTime = list_RolledUpUsageData[0].Start_Time__c;
            DateTime latestDateTime = list_RolledUpUsageData[list_RolledUpUsageData.size()-1].Start_Time__c;
			System.debug('earliestDateTime = ' + earliestDateTime + ' AND latestDateTime = ' + latestDateTime);
            Date earliestDate = Date.newinstance(earliestDateTime.year(), earliestDateTime.month(), earliestDateTime.dayGMT());
            Date latestDate = Date.newinstance(latestDateTime.year(), latestDateTime.month(), latestDateTime.dayGMT());
            if (latestDateTime.hour() != 0 || latestDateTime.minute() != 0 || latestDateTime.second() != 0 || latestDateTime.millisecond() != 0) {
				System.debug('latestDateTime not on even day, add one day');
                latestDate = latestDate.addDays(1);
            }
			System.debug('earliestDate = ' + earliestDate + ' AND latestDate = ' + latestDate);

            // Dynamically construct the Contract Id Service Identifier for the Rolled Up Usage Records
            // to look up in the Contract Service Object
            // iTracks 25080
            Set<String> set_PlatformIdHashes = new Set<String>();
            // Iterate through batch of Roll Up records to set up the Carrier Digits to Carrier Name map
            Set<String> set_CarrierDigits = new Set<String>();

            List<Rolled_Up_Usage_Data__c> list_RUUDPopulateGarn = new List<Rolled_Up_Usage_Data__c>();
            for(Rolled_Up_Usage_Data__c objRollUpData : list_RolledUpUsageData)
            {
                if (!set_PlatformIdHashes.contains(objRollUpData.Platform_Id_Hash__c)) {
                    System.debug('PlatformId Push Hash ' + objRollUpData.Platform_Id_Hash__c);
                    set_PlatformIdHashes.add(objRollUpData.Platform_Id_Hash__c);
                }
                if (objRollUpData.GARN_Account_Code__c == null) {
                    list_RUUDPopulateGarn.add(objRollUpData);
                }
                if (!String.isBlank(objRollUpData.Inbound_Device__c)) {
                    System.debug('set_CarrierDigits: add ' + objRollUpData.Inbound_Device__c);
                    set_CarrierDigits.add(objRollUpData.Inbound_Device__c);
                }

            }
            CloudBillingUtil.populateGARNCodesFromCloudDeployment(list_RUUDPopulateGarn);
            
            // iTracks 25080
            Map<String, Cloud_Deployment__c> map_PlatformIdHashToCloudDeployment = CloudBillingUtil.getMapCloudDeploymentfromHashes(set_PlatformIdHashes);
            
            List<Calling_Rate__c> list_CarrierCodes = [select Carrier_Name__c, Destination_Career_Digits__c
                                                       from Calling_Rate__c
                                                       where Destination_Career_Digits__c in :set_CarrierDigits
                                                       and RecordTypeId = :Label.Cloud_Billing_Calling_Rate_Carrier_Map_RecordTypeId];
            Map<String, String> map_CarrierDigitsToCarrierName = new Map<String, String>();
            for(Calling_Rate__c objCallingRate : list_CarrierCodes)
            {
               	System.debug('map_CarrierDigitsToCarrierName: add Destination_Career_Digits__c ' + objCallingRate.Destination_Career_Digits__c +
                             ' value Carrier_Name__c ' + objCallingRate.Carrier_Name__c);
                map_CarrierDigitsToCarrierName.put(objCallingRate.Destination_Career_Digits__c, objCallingRate.Carrier_Name__c);
            }

            // Iterating through batch of Roll Up records to set up rating decision data objects.
            system.debug('#RUUD: ' + list_RolledUpUsageData);
            Map<Id, List<String>> map_RuudIdToListCarrierContractServiceIdentifiers = new Map<Id, List<String>>();
            Map<Id, List<String>> map_RuudIdToListCarrierContractServiceIdentifiersDefault = new Map<Id, List<String>>();
            //Standard
            Map<Id, List<String>> map_RuudIdToListContractServiceIdentifiers = new Map<Id, List<String>>();
            Map<Id, List<String>> map_RuudIdToListContractServiceIdentifierDefaults = new Map<Id, List<String>>();
            for(Rolled_Up_Usage_Data__c objRollUpData : list_RolledUpUsageData)
            {
                if (!String.isBlank(objRollUpData.Inbound_Device__c)) {
                    // Push a hash equal to the Carrier Name and Service into the Rolled Up Record.
                    String strCarrierName = map_CarrierDigitsToCarrierName.get(objRollUpData.Inbound_Device__c);
               		System.debug('strCarrierName: Got ' + strCarrierName);
                }
                
                if(String.isNotBlank(objRollUpData.GARN_Account_Code__c))
                {
                    set_GARNCodes.add(objRollUpData.GARN_Account_Code__c);
	                // iTracks 25080

                    // This is a list of all possible contract/services that this RUUD could match.
                    // Keep Standard separate from Default
                    List<String> listContractServiceIdentifiers = CloudBillingUtil.populateListContractIdServiceId(objRollUpData, map_PlatformIdHashToCloudDeployment, false);
                    map_RuudIdToListContractServiceIdentifiers.put(objRollUpData.Id, listContractServiceIdentifiers);
                    set_ContractServiceIdentifiers.addAll(listContractServiceIdentifiers);

                    // Since these are all similar lists, surround each group of lists with braces to make sure we are adding the right variables based on logic
                    // See Erik for detail
                    {
                        List<String> listContractServiceIdentifiersDefault = CloudBillingUtil.populateListContractIdServiceId(objRollUpData, map_PlatformIdHashToCloudDeployment, true);
                        map_RuudIdToListContractServiceIdentifierDefaults.put(objRollUpData.Id, listContractServiceIdentifiersDefault);
                        if (objRollUpData.Inbound_Device__c != null) {
                            List<String> listCarrierContractServiceIdentifiersDefault = pushCarrierContractServiceIdentifiers(objRollUpData, listContractServiceIdentifiersDefault, map_CarrierDigitsToCarrierName);
                            set_ContractServiceIdentifiers.addAll(listCarrierContractServiceIdentifiersDefault);
                            map_RuudIdToListCarrierContractServiceIdentifiersDefault.put(objRollUpData.Id, listCarrierContractServiceIdentifiersDefault);
                        }
                        set_ContractServiceIdentifiers.addAll(listContractServiceIdentifiersDefault);
                    }
	                // iTracks 25080 Push new dynamic Contract Id Service Identifier
                    if (objRollUpData.Inbound_Device__c != null) {
                        List<String> listCarrierContractServiceIdentifiers = pushCarrierContractServiceIdentifiers(objRollUpData, listContractServiceIdentifiers, map_CarrierDigitsToCarrierName);
                        if (listCarrierContractServiceIdentifiers != null && listCarrierContractServiceIdentifiers.size() > 0) {
                            set_ContractServiceIdentifiers.addAll(listCarrierContractServiceIdentifiers);
                            map_RuudIdToListCarrierContractServiceIdentifiers.put(objRollUpData.Id, listCarrierContractServiceIdentifiers);
                        }
                    }
                    // Addd RUUD to map so we can find the RUUD when assigning Service Usage data
                    map_RollupUsageData.put(objRollUpData.Id,objRollUpData);
                    
                    // if Usage type is outbound calling (Service Type = 1) then collect calling rate identifiers as well default identifier
                    if(objRollUpData.Service_Type__c == SERVICE_TYPE_OUTBOUND_CALLING)
                    {
                        if(String.isNotBlank(objRollUpData.Device_Steering_Digits__c) && objRollUpData.Device_Steering_Digits__c != 'X') {
                            if (!set_CallingRateIdentifiers.contains(objRollUpData.Calling_Rate_Identifier__c)) {
                                System.debug('set_CallingRateIdentifiers add Calling Rate ' + objRollUpData.Calling_Rate_Identifier__c);
                            	set_CallingRateIdentifiers.add(objRollUpData.Calling_Rate_Identifier__c);
                            }
                        } else {
                            if (!set_CallingRateIdentifiers.contains(objRollUpData.Default_Calling_Rate_Identifier__c)) {
                                System.debug('set_CallingRateIdentifiers add Default Calling Rate ' + objRollUpData.Default_Calling_Rate_Identifier__c);
                                set_CallingRateIdentifiers.add(objRollUpData.Default_Calling_Rate_Identifier__c);
                            }
                        }
                        
                    // iTracks 24752
                    } else if (objRollUpData.Service_Type__c == SERVICE_TYPE_INBOUND_CALLING) {
                        System.Debug('Pushing Inbound Calling Rate Identifier ' + objRollUpData.Calling_Rate_Identifier_Inbound__c);
                        set_InboundCallingRateIdentifiers.add(objRollUpData.Calling_Rate_Identifier_Inbound__c);
                    }
                }
            }
			//Debug
            for (String s : set_ContractServiceIdentifiers) System.debug('set_ContractServiceIdentifiers ' + s);
            System.debug('##Garn Codes: ' + set_GARNCodes);
            // Fetching contracts and creating map of GARN Code To Contract record : Only querying Cloud contracts using Quote__c != null
            // SAP_Account_Code__c is the API name for the GARN
            for(GCR_Content_Document_Detail__c objContract : [SELECT Status__c,Account_Name__r.SAP_Account_Code__c 
								FROM GCR_Content_Document_Detail__c 
							    WHERE Account_Name__r.SAP_Account_Code__c IN :set_GARNCodes 
							    AND (Quote__c != null OR Zuora_Quote__c != null) ORDER BY Status__c ASC]) // This will put Approved contracts in hash first
            {
                // Skip multiple contracts of same account which are not approved
                if(map_GARNCodeToContract.containsKey(objContract.Account_Name__r.SAP_Account_Code__c) && objContract.Status__c != 'Approved')
                    continue;
                System.debug('map_GARNCodeToContract put GARN ' + objContract.Account_Name__r.SAP_Account_Code__c);
                map_GARNCodeToContract.put(objContract.Account_Name__r.SAP_Account_Code__c,objContract);
            }
            // iTracks 24752 Add Inbound_Billing_Type__c to query
            // Fetching Contract Services and creating map of Contract Service Identifier To Contract Service record and set of Tier Set ids
            for(Contract_Service__c objContService : [SELECT Id,Contract_Tier_Set__c,Contract_Tier_Set__r.Units_Type__c,
					  Service__r.Use_Calling_Rates__c,Contract_Tier_Set__r.Contract__r.Inbound_Billing_Type__c,
                      Contract_Tier_Set__r.Contract__r.Status__c,
					  Contract_Tier_Set__r.Contract__r.Id,Contract_Tier_Set__r.Contract__r.Quote__r.CurrencyISOCode,Contract_Tier_Set__r.Contract__r.Zuora_Quote__r.zqu__Currency__c,
					  Contract_Tier_Set__r.Contract__r.Pricing_Start_Date__c,Contract_Tier_Set__r.Contract__r.Pricing_End_Date__c,
					  Contract_Service_Identifier__c,Service__r.Name,Service__r.Id,Service__r.Country_Code__c,Contract_Tier_Set__r.Contract__c,
					  Service__r.SureTax_Transaction_Type_Code__c
					  FROM Contract_Service__c WHERE Contract_Service_Identifier__c IN :set_ContractServiceIdentifiers AND Is_Deleted__c = false
					  AND Contract_Tier_Set__r.Contract__r.Status__c = 'Approved'])
            {
                System.Debug('Pushing Contract Service Identifier ' + objContService.Contract_Service_Identifier__c + ' objContService ' + objContService);
                // CRMBILL-85 Now we can match a list of contract services
                if (map_ContServIdentifierToContServ.containsKey(objContService.Contract_Service_Identifier__c)) {
                    System.Debug('Adding to existing contract service list');
                    List<Contract_Service__c> list_ContractService = map_ContServIdentifierToContServ.get(objContService.Contract_Service_Identifier__c);
                    list_ContractService.add(objContService);
                } else {
                    System.Debug('Adding to new contract service list');
                    List<Contract_Service__c> list_ContractService = new List<Contract_Service__c>();
                    list_ContractService.add(objContService);
	                map_ContServIdentifierToContServ.put(objContService.Contract_Service_Identifier__c,list_ContractService);
                }
                set_TierSetIds.add(objContService.Contract_Tier_Set__c);
            }
            
            // Fetching Contract Tier Sets as a map and querying latest Contract Tier Set Period as well for each Contract Tier Set
            map_ContractTierSets = new Map<Id,Contract_Tier_Set__c>([SELECT Id,Name,Period_In_Months__c,Contract__r.Pricing_Start_Date__c,
											 Contract__r.Quote__r.CurrencyISOCode, Contract__r.Zuora_Quote__r.zqu__Currency__c,
											 (SELECT Id, Source_Name__c, Platform_Id__c, Start_Date__c, End_Date__c
                                              FROM Contract_Tier_Set_Periods__r ORDER BY End_Date__c DESC LIMIT 1)				
											 FROM Contract_Tier_Set__c WHERE Id IN :set_TierSetIds]);
            
            // Fetching calling rates and creating a map of the Calling rate identifier and the actual calling rate
            if(!set_CallingRateIdentifiers.isEmpty())
            {
                // iTracks 24986
                System.debug('Outbound Calling Rates Effective_Start_Date__c <= ' + latestDate + ' AND Effective_End_Date__c >= ' + earliestDate);
                for(Calling_Rate__c objRate : [SELECT Id, Rate_Per_Minute__c,Identifier_Hash__c,Effective_Start_Date__c,Effective_End_Date__c FROM Calling_Rate__c 
                                               WHERE Identifier_Hash__c IN :set_CallingRateIdentifiers 
                                               AND Effective_Start_Date__c <= :latestDate AND Effective_End_Date__c >= :earliestDate
                                               AND RecordTypeId = :Label.Cloud_Billing_Calling_Rate_Outbound_RecordTypeId])

                    if (map_RateIdentifierToCallingRate.containsKey(objRate.Identifier_Hash__c)) {
                        List<Calling_Rate__c> list_CallingRate = map_RateIdentifierToCallingRate.get(objRate.Identifier_Hash__c);
                        list_CallingRate.add(objRate);
                    } else {
                        List<Calling_Rate__c> list_CallingRate = new List<Calling_Rate__c>();
                        list_CallingRate.add(objRate);
	                    map_RateIdentifierToCallingRate.put(objRate.Identifier_Hash__c,list_CallingRate);
                    }
            }
            // iTracks 24752
            // Fetching inbound calling rates and creating a map of the Calling rate identifier and the actual calling rate
            if(!set_InboundCallingRateIdentifiers.isEmpty())
            {
                System.debug('Inbound Calling Rates Effective_Start_Date__c <= ' + latestDate + ' AND Effective_End_Date__c >= ' + earliestDate);
                for(Inbound_Calling_Rate__c objInRate : [SELECT Id, Identifier_Hash__c, 
                                                         Region__c, Rate_Wireline__c, Rate_Wireless__c, 
                                                         Effective_Start_Date__c, Effective_End_Date__c
                                                          FROM Inbound_Calling_Rate__c where Identifier_Hash__c in :set_InboundCallingRateIdentifiers
                                                      AND Effective_Start_Date__c <= :latestDate AND Effective_End_Date__c >= :earliestDate]) {
					if (map_HairpinToInboundCallingRate.containsKey(objInRate.Identifier_Hash__c)) {
                        List<Inbound_Calling_Rate__c> list_InboundCallingRate = map_HairpinToInboundCallingRate.get(objInRate.Identifier_Hash__c);
                        list_InboundCallingRate.add(objInRate);
                    } else {
                        List<Inbound_Calling_Rate__c> list_InboundCallingRate = new List<Inbound_Calling_Rate__c>();
                        list_InboundCallingRate.add(objInRate);
	                    map_HairpinToInboundCallingRate.put(objInRate.Identifier_Hash__c,list_InboundCallingRate);
                    }
                }
            }
            
            
            // Clearing out memory by clearing data collections that are not needed any more
            set_GARNCodes.clear();
            set_ContractServiceIdentifiers.clear();
            set_CallingRateIdentifiers.clear();
            // iTracks 24752
            set_InboundCallingRateIdentifiers.clear();
            set_TierSetIds.clear();
            
            System.debug('Delete this debug when finished, map_ContServIdentifierToContServ: ' + map_ContServIdentifierToContServ);
            // Iterating through batch of Roll Up records for Rating
            for(Rolled_Up_Usage_Data__c objRollUpData : list_RolledUpUsageData)
            {
                System.debug('Rate Rollup <<<< ' + objRollUpData);

                List<String> listCarrierContractServiceIdentifiers = map_RuudIdToListCarrierContractServiceIdentifiers.get(objRollUpData.Id);
                System.debug('listCarrierContractServiceIdentifiers: ' + listCarrierContractServiceIdentifiers);
                List<String> listCarrierContractServiceIdentifiersDefault = map_RuudIdToListCarrierContractServiceIdentifiersDefault.get(objRollUpData.Id);
                System.debug('listCarrierContractServiceIdentifiersDefault: ' + listCarrierContractServiceIdentifiersDefault);
                List<String> listContractServiceIdentifiers =  map_RuudIdToListContractServiceIdentifiers.get(objRollUpData.Id);
                System.debug('listContractServiceIdentifiers: ' + listContractServiceIdentifiers);
                List<String> listContractServiceIdentifierDefaults = map_RuudIdToListContractServiceIdentifierDefaults.get(objRollUpData.Id);
                System.debug('listContractServiceIdentifierDefaults: ' + listContractServiceIdentifierDefaults);

                // GARN Code on Rollup is available
                if(String.isNotBlank(objRollUpData.GARN_Account_Code__c) && map_GARNCodeToContract.containsKey(objRollUpData.GARN_Account_Code__c))
                {
                    // Fetching contract based on GARN Code
                    GCR_Content_Document_Detail__c objCheckContract = map_GARNCodeToContract.get(objRollUpData.GARN_Account_Code__c);
                    System.debug('Got contract ' + objCheckContract);
                    // Matching Contract is not approved : creating a suitable exception record
                    if(objCheckContract.Status__c != 'Approved')
                    {
                        String strErrorDescription = 'Contract is not in Approved status';
                        objRollUpData.Exception_Type__c = 'Contract Not Approved';
                        map_RollupIdToBillingException.put(objRollUpData.Id,createNewBillingException(strErrorDescription,objRollUpData,null,objCheckContract.Id));
                        continue;
                    }

                    // Trying to find Contract Service based on standard Identifier. First look for Carrier specific, then generic.
/*
                    System.debug('First looking for objRollUpData.Contract_Id_Carrier_Service_Id__c ' + objRollUpData.Contract_Id_Carrier_Service_Id__c +
                                ' then objRollUpData.Contract_Id_Service_Identifier__c ' + objRollUpData.Contract_Id_Service_Identifier__c);
                    if(!String.isBlank(objRollUpData.Contract_Id_Carrier_Service_Id__c) && map_ContServIdentifierToContServ.containsKey(objRollUpData.Contract_Id_Carrier_Service_Id__c))
                        list_ContractService = map_ContServIdentifierToContServ.get(objRollUpData.Contract_Id_Carrier_Service_Id__c);
                    else if(map_ContServIdentifierToContServ.containsKey(objRollUpData.Contract_Id_Service_Identifier__c))
                        list_ContractService = map_ContServIdentifierToContServ.get(objRollUpData.Contract_Id_Service_Identifier__c);
                    // Trying to find Contract Service for Outbound/Inbound catch all services based on default Identifier (without specific country code)
                    else if(map_ContServIdentifierToContServ.containsKey(objRollUpData.Contract_Id_Service_Identifier_Default__c))
                        list_ContractService = map_ContServIdentifierToContServ.get(objRollUpData.Contract_Id_Service_Identifier_Default__c);
*/

                    // CRMBILL-85 Now Rate a List of Services, not just one
                    List<Contract_Service__c> list_ContractService = new List<Contract_Service__c>();
                    System.debug('First looking for Carrier. If one exists do not push Standard. If none exist push the Standard. Always push the Default services');
                    if (listCarrierContractServiceIdentifiers != null) {
                        for (String strCarrierContractServiceIdentifier : listCarrierContractServiceIdentifiers) {
                            if (map_ContServIdentifierToContServ.containsKey(strCarrierContractServiceIdentifier)) {
                                List<Contract_Service__c> listContractService = map_ContServIdentifierToContServ.get(strCarrierContractServiceIdentifier);
                                System.debug('Rating: Adding list of Carrier Contract Service Identifiers ' + listContractService);
                                list_ContractService.addAll(listContractService);
                            }
                            System.debug('Carrier Services ' + list_ContractService);
                        }
                    }
                    // If we previously found no Carrier services look for Carrier DEfaults
                    if (list_ContractService.size() == 0 && listCarrierContractServiceIdentifiersDefault != null) {
                        for (String strCarrierContractServiceIdentifierDefault : listCarrierContractServiceIdentifiersDefault) {
                            if (map_ContServIdentifierToContServ.containsKey(strCarrierContractServiceIdentifierDefault)) {
                                List<Contract_Service__c> listContractService = map_ContServIdentifierToContServ.get(strCarrierContractServiceIdentifierDefault);
                                System.debug('Rating: Adding list of Carrier Default Contract Service Identifiers ' + listContractService);
                                list_ContractService.addAll(listContractService);
                            }
                            System.debug('Carrier Default Services ' + list_ContractService);
                        }
                    }
                    // If we previously found no Carrier services look for Standard
                    if (list_ContractService.size() == 0 && listContractServiceIdentifiers != null) {
                        for (String strContractServiceIdentifier : listContractServiceIdentifiers) {
                            if (map_ContServIdentifierToContServ.containsKey(strContractServiceIdentifier)) {
                                List<Contract_Service__c> listContractService = map_ContServIdentifierToContServ.get(strContractServiceIdentifier);
                                System.debug('Rating: Adding list of Standard Contract Service Identifiers ' + listContractService);
                                list_ContractService.addAll(listContractService);
                            }
                        }
                        System.debug('Standard Services ' + list_ContractService);
                    }
                    // If we previously found no Carrier or Standard services look for Default
                    if (list_ContractService.size() == 0 && listContractServiceIdentifierDefaults != null) {
                        for (String strContractServiceIdentifier : listContractServiceIdentifierDefaults) {
                            if (map_ContServIdentifierToContServ.containsKey(strContractServiceIdentifier)) {
                                List<Contract_Service__c> listContractService = map_ContServIdentifierToContServ.get(strContractServiceIdentifier);
                                System.debug('Rating: Adding list of Default Contract Service Identifiers ' + listContractService);
                                list_ContractService.addAll(listContractService);
                            }
                        }
                        System.debug('Default Services ' + list_ContractService);
                    } else{
                        System.debug('Found No Services');
                    }
                    
                    System.debug('Found list_ContractService: ' + list_ContractService);
                    
                    // Contract service has been matched
                    // CRMBILL-85 Now we can match a list of contract services
                    if(list_ContractService != null && list_ContractService.size() > 0)
                    {
                        for (Contract_Service__c objContService : list_ContractService) {
                            System.debug('Processing revenue for RUUD objRollUpData.Id ' + objRollUpData.Id);
                            // Fetching contract based on Contract Service
                            GCR_Content_Document_Detail__c objContract = objContService.Contract_Tier_Set__r.Contract__r;
                            
                            // Matching Contract is not yet active (based on Billing Effective Start Date) : creating a suitable exception record
                            if(objContract.Pricing_Start_Date__c > objRollUpData.Start_Time__c)
                            {
                                String strErrorDescription = 'Contract Billing start date is later than usage time';
                                objRollUpData.Exception_Type__c = 'Contract Not Yet Active';
                                map_RollupIdToBillingException.put(objRollUpData.Id,createNewBillingException(strErrorDescription,objRollUpData,null,objContract.Id));
                                continue;
                            }
                            // Matching Contract has expired (based on Billing Effective End Date) : creating a suitable exception record
                            if(objContract.Pricing_End_Date__c != null && objContract.Pricing_End_Date__c < objRollUpData.Start_Time__c)
                            {
                                String strErrorDescription = 'Contract has expired. Contract Billing end date is earlier than usage time';
                                objRollUpData.Exception_Type__c = 'Contract Expired';
                                map_RollupIdToBillingException.put(objRollUpData.Id,createNewBillingException(strErrorDescription,objRollUpData,null,objContract.Id));
                                continue;
                            }
                            
                            Service_Usage__c objServiceUsage = new Service_Usage__c();
                            String ratingNote;
                            // Populating quantity on Service Usage record based on Units Type on Tier Set (choosing from Billing 6,Billing 30, Count etc.)
                            String strResult = populateQuantity(objRollUpData,objServiceUsage,objContService.Contract_Tier_Set__r.Units_Type__c);
                            System.Debug('Quantity__c ' + objServiceUsage.Quantity__c + ' TS ' + objContService.Contract_Tier_Set__c);
                            // if specific Quantity is null
                            if(String.isNotBlank(strResult))
                            {
                                objRollUpData.Exception_Type__c = 'Quantity Unavailable';
                                map_RollupIdToBillingException.put(objRollUpData.Id,createNewBillingException(strResult,objRollUpData,objContService.Service__r,objContService.Contract_Tier_Set__r.Contract__c));
                                continue;
                            }
                            
                            /* if the matching contract service is a catch all outbound service (service type = 1 and use calling rates = true) 
                            then use rate table for rates (else we will use Tier sets) */
                            System.debug('Checking for Use_Calling_Rates__c ' + objContService.Service__r.Use_Calling_Rates__c);
                            if(objRollUpData.Service_Type__c == SERVICE_TYPE_OUTBOUND_CALLING && 
                               objContService.Service__r.Use_Calling_Rates__c == true)
                            {
                                Boolean blnIsRateAvailable = false;
                                // Device Steering Digits present : use exact rate
                                if(String.isNotBlank(objRollUpData.Device_Steering_Digits__c) && objRollUpData.Device_Steering_Digits__c != 'X')
                                {
                                    // Rate is found based on standard calling identifier (Region_Code__c#Destination_Country_Code__c#Destination_Device_Career__c)
                                    if(map_RateIdentifierToCallingRate.containsKey(objRollUpData.Calling_Rate_Identifier__c))
                                    {
                                        System.debug('@@@@ Matching Rate Found');
                                        ratingNote = concatComment(ratingNote, 'Rate: ' + objRollUpData.Calling_Rate_Identifier__c);
                                        
                                        try {
                                            objServiceUsage.Rate_Per_Minute__c = getCallingRateFromHash(map_RateIdentifierToCallingRate, objRollUpData.Calling_Rate_Identifier__c, objRollUpData.Start_Time__c);
                                            objServiceUsage.Cost__c = objServiceUsage.Quantity__c * objServiceUsage.Rate_Per_Minute__c;
                                            System.Debug('After Rate SU ' + objServiceUsage);
                                            blnIsRateAvailable = true;
                                        } catch (CallingRateNotFoundException noData) {
                                            System.debug('@@@@ No Active Rate Found for ' + objRollUpData.Start_Time__c);
                                            String strErrorDescription = 'No active calling rate could be found for date ' + objRollUpData.Start_Time__c;
                                            objRollUpData.Exception_Type__c = 'Calling Rate Unavailable';
                                            map_RollupIdToBillingException.put(objRollUpData.Id,createNewBillingException(strErrorDescription,objRollUpData,objContService.Service__r,objContService.Contract_Tier_Set__r.Contract__c));
                                        }
                                    }
                                }
                                // Device Steering Digits not present : use default rate
                                else
                                {
                                    // Rate is found based on default calling identifier (Region_Code__c#Destination_Country_Code__c#default)
                                    system.debug('@@@@ Rate For Hash ' + objRollUpData.Default_Calling_Rate_Identifier__c);
                                    if(map_RateIdentifierToCallingRate.containsKey(objRollUpData.Default_Calling_Rate_Identifier__c))
                                    {
                                        System.debug('@@@@ Default Rate Found');
                                        ratingNote = concatComment(ratingNote, 'Default Rate# ' + objRollUpData.Default_Calling_Rate_Identifier__c);
                                        
                                        try {
                                            objServiceUsage.Rate_Per_Minute__c = getCallingRateFromHash(map_RateIdentifierToCallingRate, objRollUpData.Default_Calling_Rate_Identifier__c, objRollUpData.Start_Time__c);
                                            objServiceUsage.Cost__c = objServiceUsage.Quantity__c * objServiceUsage.Rate_Per_Minute__c;
                                            objServiceUsage.Default_Rate_Used__c = true;
                                            System.Debug('After Rate SU ' + objServiceUsage);
                                            blnIsRateAvailable = true;
                                        } catch (CallingRateNotFoundException noData) {
                                            System.debug('@@@@ No Active Default Rate Found for ' + objRollUpData.Start_Time__c);
                                            String strErrorDescription = 'No active default rate could be found for date ' + objRollUpData.Start_Time__c;
                                            objRollUpData.Exception_Type__c = 'Calling Rate Unavailable';
                                            map_RollupIdToBillingException.put(objRollUpData.Id,createNewBillingException(strErrorDescription,objRollUpData,objContService.Service__r,objContService.Contract_Tier_Set__r.Contract__c));
                                        }
                                        
                                    }
                                }
                                // Rate is not found : creating a suitable exception record 
                                if(!blnIsRateAvailable)
                                {
                                    System.debug('@@@@ No Rate Found');
                                    String strErrorDescription = 'No calling Rate could be found for this usage';
                                    objRollUpData.Exception_Type__c = 'Calling Rate Unavailable';
                                    map_RollupIdToBillingException.put(objRollUpData.Id,createNewBillingException(strErrorDescription,objRollUpData,objContService.Service__r,objContService.Contract_Tier_Set__r.Contract__c));
                                    continue;
                                }	
                            }
                            // iTrack 24752
                            else if(objRollUpData.Service_Type__c == SERVICE_TYPE_INBOUND_CALLING && 
                                    objContService.Service__r.Use_Calling_Rates__c == true) {
                                        Boolean blnIsRateAvailable = false;
                                        System.Debug('Looking up calling rate inbound identifier ' + objRollUpData.Calling_Rate_Identifier_Inbound__c);
                                        if (map_HairpinToInboundCallingRate.containsKey(objRollUpData.Calling_Rate_Identifier_Inbound__c))
                                        {
                                            try {
                                                System.Debug('Found calling rate inbound identifier');
                                                objServiceUsage.Rate_Per_Minute__c = getInboundCallingRateFromHash(map_HairpinToInboundCallingRate, objRollUpData, objRollUpData.Device_Type__c);
                                                objServiceUsage.Cost__c = objServiceUsage.Quantity__c * objServiceUsage.Rate_Per_Minute__c;
                                            } catch (CallingRateNotFoundException noData) {
                                                String strErrorDescription = 'Inbound Calling Rate found but not with valid dates';
                                                objRollUpData.Exception_Type__c = 'Inbound Calling Rate Unavailable';
                                                map_RollupIdToBillingException.put(objRollUpData.Id,createNewBillingException(strErrorDescription,objRollUpData,objContService.Service__r,objContService.Contract_Tier_Set__r.Contract__c));
                                                continue;
                                            }
                                        } else {
                                            String strErrorDescription = 'No calling rate inbound identifier matched an available rate';
                                            objRollUpData.Exception_Type__c = 'Inbound Calling Rate Unavailable';
                                            map_RollupIdToBillingException.put(objRollUpData.Id,createNewBillingException(strErrorDescription,objRollUpData,objContService.Service__r,objContService.Contract_Tier_Set__r.Contract__c));
                                            continue;
                                        }
                                    }                        
                            
                            //	Populating Service Usage fields
                            objServiceUsage.Usage_Data_UID__c = objRollUpData.Rollup_Id__c;
                            objServiceUsage.Rolled_Up_Usage_Data__c = objRollUpData.Id;
                            objServiceUsage.Service_Type__c = objRollUpData.Service_Type__c;
                            objServiceUsage.Start_Time__c = objRollUpData.Start_Time__c;
                            objServiceUsage.End_Time__c = objRollUpData.End_Time__c;
                            objServiceUsage.Count__c = objRollUpData.Count__c;
                            objServiceUsage.Total_Duration__c = objRollUpData.Total_Duration__c;
                            objServiceUsage.Region_Code__c = objRollUpData.Region_Code__c;
                            objServiceUsage.Usage_Type__c = objRollUpData.Usage_Type__c;
                            objServiceUsage.Contract_Service_Id__c = objContService.Id;
                            objServiceUsage.Contract_Tier_Set_Id__c = objContService.Contract_Tier_Set__c;
                            objServiceUsage.CurrencyISOCode = objContract.Quote__r.CurrencyISOCode != null ? objContract.Quote__r.CurrencyISOCode : objContract.Zuora_Quote__r.zqu__Currency__c;
                            // This code will overwrite any values if the rating logic populated them
                            // previously from a rate table. If RUUD contains rate and rated amount they should
                            // take precedence
                            if(CloudBillingUtil.blnAllowRateOverride(objRollUpData.Source_Name__c, Label.Cloud_Billing_Source_Name_Rate_Override)){
                                System.debug('Checking Rated_Amount__c then Rate__c');
                                // If Rated_Amount__c is sent it overrides Rate__c * Quantity__c calculation
                                // If Rate__c is populated: put it in Rate_Per_Minute__c
                                // If Rate__c is populated but Rated_Amount__c is not: Rate__c * Quantity__c is the calculation
                                if (objRollUpData.Rated_Amount__c != null) {
                                    System.debug('Assigning to objServiceUsage.Cost__c objRollUpData.Rated_Amount__c ' + objRollUpData.Rated_Amount__c);
                                    objServiceUsage.Cost__c = objRollUpData.Rated_Amount__c;
                                }
                                if (objRollUpData.Rate__c != null) {
                                    System.debug('Assigning to objServiceUsage.Rate_Per_Minute__c');
                                    objServiceUsage.Rate_Per_Minute__c = objRollUpData.Rate__c;
                                    // If only Rate__c is sent and not Rated_Amount__c calculate Rate__c * Quantity__c
                                    if (objRollUpData.Rated_Amount__c == null) {
                                        Decimal decCost = objRollUpData.Rate__c * objServiceUsage.Quantity__c;
                                        System.debug('Assigning objRollUpData.Rate__c+objServiceUsage.Quantity__c ' + objRollUpData.Rate__c + '+' + objServiceUsage.Quantity__c +
                                                     ' decCost ' + decCost + ' for Source Name ' + objRollUpData.Source_Name__c);
                                        objServiceUsage.Cost__c = decCost;
                                    }
                                }
                            }
                            objServiceUsage.Rating_Note__c = ratingNote;
                            list_ServiceUsageData.add(objServiceUsage);
                            // CRMBILL-9
                            // Creating the Tier Set Month hash applicable for the Tier Set Month record for this Service Usage record
                            Integer intRuudStartDay = objServiceUsage.Start_Time__c.dayGMT();
                            //DateTime intContractStartDate = objContService.Contract_Tier_Set__r.Contract__r.Pricing_Start_Date__c;
                            //Integer intContractStartDay = intContractStartDate.dayGMT();
                            System.Debug('Contract Start Date ' + objContService.Contract_Tier_Set__r.Contract__r.Pricing_Start_Date__c);
                            Integer intContractStartDay = objContService.Contract_Tier_Set__r.Contract__r.Pricing_Start_Date__c.day();
                            System.debug('flexibleBilling: ruud ' + objRollUpData.Id + ' objServiceUsage.Start_Time__c ' + objServiceUsage.Start_Time__c + ' start day ' + intRuudStartDay + ' contract start day ' + intContractStartDay);
                            Integer intContractTierSetMonth = objServiceUsage.Start_Time__c.monthGMT();
                            Integer intContractTierSetYear  = objServiceUsage.Start_Time__c.yearGMT();
                            if (intRuudStartDay < intContractStartDay) {
                                intContractTierSetMonth--;
                                if (intContractTierSetMonth <= 0) {
                                    intContractTierSetMonth = 12;
                                    intContractTierSetYear--;
                                }
                                System.debug('flexibleBilling: put ruud on previous month ' + intContractTierSetMonth + '/' + intContractTierSetYear);
                            } else {
                                // Can delete this debug when working
                                System.debug('flexibleBilling: keep same month ' + intContractTierSetMonth);
                            }
                            String strHash = objServiceUsage.Contract_Tier_Set_Id__c + '#' + 
                                // iTracks 25080
                                objRollUpData.Platform_Id_Hash__c + '#' +
                                // CRMBILL-9
                                String.valueOf(intContractTierSetMonth) + '#' +
                                String.valueOf(intContractTierSetYear);
                            
                            // CRMBILL-9
                            // CRMBILL-85 Change from storing on the RUUD to the SU now that multiple Tier Sets per RUUD
                            // could be involved
                            // Save the hash for associating the SU record with the correct Tier Set Month
                            objServiceUsage.Contract_Tier_Set_Month_Hash__c = strHash;
                            
                            if (!set_TierSetMonthHashes.contains(strHash)) {
                                System.debug('set_TierSetMonthHashes: add unique strHash ' + strHash);
                                set_TierSetMonthHashes.add(strHash);
                            }
                        }
                    }
                    else {
                        if (CloudBillingUtil.blnIsPureCloudVoice(objRollUpData)) {
                            set_ServiceIdentifiersNotMapped.add(objRollUpData.PCV_Service_Identifier__c);
                            set_ServiceIdentifiersNotMapped.add(objRollUpData.PCV_Service_Identifier_Default__c);
                        } else {
                            set_ServiceIdentifiersNotMapped.add(objRollUpData.Service_Identifier__c);
                            set_ServiceIdentifiersNotMapped.add(objRollUpData.Service_Identifier_Default__c);
                        }
                    }
                }
                // GARN Code on Rollup is not found on any contract : creating a suitable exception record
                else
                {
                    String strErrorDescription = 'Contract/Account with same GARN Code not found';
                    objRollUpData.Exception_Type__c = 'Contract Unavailable';
                    map_RollupIdToBillingException.put(objRollUpData.Id,createNewBillingException(strErrorDescription,objRollUpData,null,null));
                }
            }

            // Fetching existing Tier Set Months and creating map of their hashes and the records			
            for(Contract_Tier_Set_Month__c objTierSetMonth : [SELECT Id,Identifier_Hash__c FROM Contract_Tier_Set_Month__c 
                                                              WHERE Identifier_Hash__c IN :set_TierSetMonthHashes])
                map_TSMHashToTierSetMonthId.put(objTierSetMonth.Identifier_Hash__c,objTierSetMonth.Id);
            
            // Iterating Tier Set Month hashes required for Service Usage records to be created
            for(String strHash : set_TierSetMonthHashes)
            {
                // No existing record for current hash : Tier Set Month needs to be created
                if(!map_TSMHashToTierSetMonthId.containsKey(strHash))
                {
                    List<String> list_ContractTierSetMonthInfo = strHash.split('#');
					System.debug('list_ContractTierSetMonthInfo: strHash ' + strHash);
                    // Splitting the hash to get Tier Set Id, Month and Year
                    Contract_Tier_Set_Month__c objTierSetMonth = new Contract_Tier_Set_Month__c(Contract_Tier_Set__c = list_ContractTierSetMonthInfo[0],
                                                                                                // iTracks 25080
                                                                                                Source_Name__c = list_ContractTierSetMonthInfo[1],
                                                                                                Platform_Id__c = list_ContractTierSetMonthInfo[2],
                                                                                                Month__c = list_ContractTierSetMonthInfo[3],Year__c = list_ContractTierSetMonthInfo[4]);
                    
                    // If a Tier Set is found based on Tier Set Id
                    if(map_ContractTierSets.containsKey(objTierSetMonth.Contract_Tier_Set__c))
                    {
                        System.debug('list_ContractTierSetMonthInfo: contains contract tier set key ' + objTierSetMonth.Contract_Tier_Set__c);
                        list_TierSetMonthsToBeCreated.add(objTierSetMonth);
                        Contract_Tier_Set__c objTierSet = map_ContractTierSets.get(objTierSetMonth.Contract_Tier_Set__c);
                        // Push Existing Periods into the Map so we don't create multiple periods, one for each batch run
                        if (!objTierSet.Contract_Tier_Set_Periods__r.isEmpty()) {
                            for (Contract_Tier_Set_Period__c objPeriod : objTierSet.Contract_Tier_Set_Periods__r) {
                                String strPeriodHash =  objPeriod.Source_Name__c + '#' + objPeriod.Platform_Id__c + '#' + objPeriod.Start_Date__c.format() + '#' + objPeriod.End_Date__c.format() + '#' + objTierSet.Id;
                                System.Debug('Existing strPeriodHash Hash ' + strPeriodHash + ' for Tier Set ' + objTierSet.Name);
                                if(!map_PeriodHashToPeriodAggregator.containsKey(strPeriodHash)) {
                                	System.Debug('Pushing Existing strPeriodHash Hash ' + strPeriodHash + ' for Tier Set ' + objTierSet.Name);
                                    map_PeriodHashToPeriodAggregator.put(strPeriodHash,objPeriod);
                                    map_TSMHashToPeriodAggregator.put(strHash,objPeriod);
                                }
                            }
                        }
                        // Populate currency on Tier Set Month
                        objTierSetMonth.CurrencyISOCode = objTierSet.Contract__r.Quote__r.CurrencyISOCode != null ? objTierSet.Contract__r.Quote__r.CurrencyISOCode : objTierSet.Contract__r.Zuora_Quote__r.zqu__Currency__c;
                        Integer intStartDay = objTierSet.Contract__r.Pricing_Start_Date__c.day();
                        // Start of month date
                        //Date dtStart = Date.newInstance(Integer.valueOf(objTierSetMonth.Year__c),Integer.valueOf(objTierSetMonth.Month__c),1);
                        Date dtStart = Date.newInstance(Integer.valueOf(objTierSetMonth.Year__c),Integer.valueOf(objTierSetMonth.Month__c),intStartDay);
                        // Getting Tier Set period length from Tier Set
                        Integer intPeriod = Integer.valueOf(objTierSet.Period_In_Months__c);
                        if(intPeriod != null)
                        {
                            // iTracks 25080
                            System.Debug('Creating New objPeriod for Tier Set ' + objTierSet.Id + ' Name ' + objTierSet.Name);
                            Contract_Tier_Set_Period__c objPeriod = new Contract_Tier_Set_Period__c(Contract_Tier_Set__c = objTierSet.Id,
                                                                                                    Source_Name__c = objTierSetMonth.Source_Name__c,
                                                                                                    Platform_Id__c = objTierSetMonth.Platform_Id__c);
                            // Populate currency on Tier Set Period
                            objPeriod.CurrencyISOCode = objTierSetMonth.CurrencyISOCode;
                            // If period length = 1 month then start date is 1st of the month and end date is last of the month for Tier Set Period
                            if(intPeriod == 1)
                            {
                                objPeriod.Start_Date__c = dtStart;
                                objPeriod.End_Date__c = objPeriod.Start_Date__c.addMonths(1) - 1;
                            }
                            // If period length is more than a month
                            else
                            {
                                // If there are no Tier Set Periods for this Tier Set or End Date of most recent period is earlier than start of applicable month
                                if(objTierSet.Contract_Tier_Set_Periods__r.isEmpty() || objTierSet.Contract_Tier_Set_Periods__r[0].End_Date__c < dtStart)
                                {
                                    // If there are no Tier Set Periods then start date will be the start date from the Contract
                                    if(objTierSet.Contract_Tier_Set_Periods__r.isEmpty())
                                        // BUG Should actually create the period based on the start date of the activity, not the beginning of the contract.
                                        objPeriod.Start_Date__c = objTierSet.Contract__r.Pricing_Start_Date__c;
                                    
                                    // The start date is the next date of the end date of the last Tier Set Period
                                    else
                                        objPeriod.Start_Date__c = objTierSet.Contract_Tier_Set_Periods__r[0].End_Date__c + 1;
                                    
                                    // End Date is based on Period Length in months
                                    objPeriod.End_Date__c = objPeriod.Start_Date__c.addMonths(intPeriod) - 1;
                                }
                                // iTracks 22978
                                // There are periods and dtStart still within the highest period but need new Contract Tier Set Month
                                else {
                                    objPeriod.Start_Date__c = objTierSet.Contract_Tier_Set_Periods__r[0].Start_Date__c;
                                    objPeriod.End_Date__c = objPeriod.Start_Date__c.addMonths(intPeriod) - 1;
                                }
                            }
                            //objPeriod.Name = objPeriod.Start_Date__c.format() + '-' + objPeriod.End_Date__c.format() + '-' + objTierSet.Name;
                            objPeriod.Name = objPeriod.Start_Date__c.format() + '-' + objPeriod.End_Date__c.format();
                            // Creating a hash for the period
                            String strPeriodHash =  objPeriod.Source_Name__c + '#' + objPeriod.Platform_Id__c + '#' + objPeriod.Start_Date__c.format() + '#' + objPeriod.End_Date__c.format() + '#' + objTierSet.Id;
                            System.debug('Check for strPeriodHash ' + strPeriodHash);
                            // Update Period hash map and Tier Set Month Hash and period map accordingly
                            if(map_PeriodHashToPeriodAggregator.containsKey(strPeriodHash))
                                map_TSMHashToPeriodAggregator.put(strHash,map_PeriodHashToPeriodAggregator.get(strPeriodHash));
                            else
                            {
                                System.Debug('Going to add new period for Tier Set ' + objTierSet.Id + ' Name ' + objTierSet.Name);
                                map_PeriodHashToPeriodAggregator.put(strPeriodHash,objPeriod);
                                map_TSMHashToPeriodAggregator.put(strHash,objPeriod);
                            }	
                        }
                    }	
                }
                else System.debug('Tier Set Month exists map_TSMHashToTierSetMonthId.get(strHash)' + map_TSMHashToTierSetMonthId.containsKey(strHash));
            }

            if(!map_PeriodHashToPeriodAggregator.isEmpty()  && !list_TierSetMonthsToBeCreated.isEmpty())
            {
                // Create Contract Tier Set Periods
                upsert map_PeriodHashToPeriodAggregator.values();
                
                // populate Tier Set Period ids on Tier Set Months based on hashes
                for(Contract_Tier_Set_Month__c objTierSetMonth : list_TierSetMonthsToBeCreated)
                {
                    // iTracks 25080
                    String strHash = objTierSetMonth.Contract_Tier_Set__c + '#' + objTierSetMonth.Source_Name__c + '#' + objTierSetMonth.Platform_Id__c + '#' +
                        objTierSetMonth.Month__c + '#' + objTierSetMonth.Year__c;
                    System.debug('map_TSMHashToPeriodAggregator: search strHash ' + strHash);
                    objTierSetMonth.Contract_Tier_Set_Period__c = map_TSMHashToPeriodAggregator.get(strHash).Id;
                }
                
                // Create Contract Tier Set Months
                insert list_TierSetMonthsToBeCreated;
	            System.debug('NEED TO DELETE TSM!: ' +  list_TierSetMonthsToBeCreated);
                
                // Update map of Tier Set Month Ids to be used for Service Usage records
                for(Contract_Tier_Set_Month__c objTierSetMonth : list_TierSetMonthsToBeCreated)
                {
                    String strHash = objTierSetMonth.Contract_Tier_Set__c + '#' + objTierSetMonth.Source_Name__c + '#' + objTierSetMonth.Platform_Id__c + '#' + objTierSetMonth.Month__c + '#' + objTierSetMonth.Year__c;
                    System.Debug ('map_TSMHashToTierSetMonthId: push strHash ' + strHash);
                    map_TSMHashToTierSetMonthId.put(strHash,objTierSetMonth.Id);
                }	
            }
            
            // Iterate through Service Usage records
            for(Service_Usage__c objServiceUsage : list_ServiceUsageData)
            {
                Rolled_Up_Usage_Data__c objRollUpData = map_RollupUsageData.get(objServiceUsage.Rolled_Up_Usage_Data__c);
                // CRMBILL-9
                // CRMBILL-85
                String strHash =  objServiceUsage.Contract_Tier_Set_Month_Hash__c;
                System.debug('map_TSMHashToTierSetMonthId: looking for strHash ' + strHash);
                // Populate Tier Set Month Id based on the hash and add to list of service usage records to be created
                if(map_TSMHashToTierSetMonthId.containsKey(strHash))
                {
                    System.debug('Delete: map_TSMHashToTierSetMonthId.containsKey');
                    objServiceUsage.Contract_Tier_Set_Month__c = map_TSMHashToTierSetMonthId.get(strHash);
                    list_ServiceUsageDataToBeCreated.add(objServiceUsage);
                } else {
                    System.debug(objServiceUsage + ' does not contain ' + map_TSMHashToTierSetMonthId);
                }
            }
            System.debug('Delete: made it out of SU loop');
            // if there are Service Usage records to be created
            if(!list_ServiceUsageDataToBeCreated.isEmpty())
            {
	            System.debug('Size ' + list_ServiceUsageDataToBeCreated.size() + ' NEED TO DELETE!: SUs' +  list_ServiceUsageDataToBeCreated);
                // Create Service Usage records
                insert list_ServiceUsageDataToBeCreated;
                Map<Id, Service_Usage__c> map_ServiceUsageIdServiceUsage = new Map<Id, Service_Usage__c>();
                for (Service_Usage__c objServiceUsage : list_ServiceUsageDataToBeCreated) {
                    map_ServiceUsageIdServiceUsage.put(objServiceUsage.Id, objServiceUsage);
                }
                List<Service_Usage__c> listServiceUsageRollUpToMonth = new List<Service_Usage__c>();
                Set<Id> setServiceUsageTaxToUpdate = new Set<Id>();
                List<Service_Usage_Tax__c> listServiceUsageTaxToUpdate = new List<Service_Usage_Tax__c>();
                // Update Roll Up records for Service usage records that were successfully created
                for(Service_Usage__c objServiceUsage : list_ServiceUsageDataToBeCreated)
                { 
                    Rolled_Up_Usage_Data__c objRollUpData = map_RollupUsageData.get(objServiceUsage.Rolled_Up_Usage_Data__c);
                    objRollUpData.Processed__c = true;
                    objRollUpData.Last_Processed_Time__c = Datetime.now();
                    objRollUpData.Exception_Type__c = null;
                    if (objRollUpData.Rolled_Up_Usage_Data_Taxes__r.size() > 0) {
                        // Here we are chosing to push the tax from RUUD to only ONE of the Service Usage Records
                        // created. If users put 2 copies of the service, ETL will not handle this scenario.
                        // We must mark the record for rollup to Contract Tier Set Month
                        objServiceUsage.Tax_Status__c = BatchTaxCloudUsageData.TAX_STATUS_ROLLUP_TAX_NEEDED;
                        for (Service_Usage_Tax__c objServiceUsageTax : objRollUpData.Rolled_Up_Usage_Data_Taxes__r) {
                            objServiceUsageTax.Service_Usage__c = objServiceUsage.Id;
                            if (setServiceUsageTaxToUpdate.contains(objServiceUsageTax.Id)) {
                                System.Debug('objServiceUsageTax Id is duplicate for Service Usage ' + objServiceUsage + 
                                             ' with objServiceUsageTax ' + objServiceUsageTax);
                                if (String.isBlank(objJobLog.Exceptions__c)) {
                                    objJobLog.Exceptions__c = 'Dup Svc for Tax ' + objServiceUsageTax.Id;
                                } else {
                                    objJobLog.Exceptions__c = objJobLog.Exceptions__c + ',Dup Svc for Tax ' + objServiceUsageTax.Id;
                                } 
                            } else {
                                setServiceUsageTaxToUpdate.add(objServiceUsageTax.id);
	                            listServiceUsageTaxToUpdate.add(objServiceUsageTax);
                            }
                        }
                        listServiceUsageRollUpToMonth.add(objServiceUsage);
                    }
                }
                if (listServiceUsageTaxToUpdate.size() > 0) {
                    System.Debug('listServiceUsageTaxToUpdate size ' + listServiceUsageTaxToUpdate.size());
                    update listServiceUsageTaxToUpdate;
                    update list_ServiceUsageDataToBeCreated;
                }
            }
            
            // fetching Services for Identifiers that could not be mapped to Contract Services. Ignore non-Active.
            System.debug('DELETE: set_ServiceIdentifiersNotMapped ' + set_ServiceIdentifiersNotMapped);
            for(Service__c objService : [SELECT Id,Name,UID__c,Identifier_Hash__c, PCV_Service_Identifier__c FROM Service__c 
                                         WHERE (Identifier_Hash__c IN :set_ServiceIdentifiersNotMapped or
                                                PCV_Service_Identifier__c IN :set_ServiceIdentifiersNotMapped) 
                                         and Active__c = true and Use_Calling_Rates__c = false]) {
                                             map_ServicesNotMapped.put(objService.Identifier_Hash__c,objService);
                                             map_ServicesNotMapped.put(objService.PCV_Service_Identifier__c,objService);
                                         }
            System.debug('DELETE: map_ServicesNotMapped ' + map_ServicesNotMapped);
            for(Rolled_Up_Usage_Data__c objRollUpData : list_RolledUpUsageData)
            {
                Id idContract;
                
                // Fetch Contract Id if available (based on GARN code)
                if(map_GARNCodeToContract.containsKey(objRollUpData.GARN_Account_Code__c))
                    idContract = map_GARNCodeToContract.get(objRollUpData.GARN_Account_Code__c).Id;
                
                if(!objRollUpData.Processed__c && 
                   (set_ServiceIdentifiersNotMapped.contains(objRollUpData.Service_Identifier__c) ||
                    set_ServiceIdentifiersNotMapped.contains(objRollUpData.PCV_Service_Identifier__c)) && 
                   !map_RollupIdToBillingException.containsKey(objRollUpData.Id))
                {
                    // If Service exists and is not mapped to the Contract : creating a suitable exception record 
                    if(map_ServicesNotMapped.containsKey(objRollUpData.Service_Identifier__c) ||
                       map_ServicesNotMapped.containsKey(objRollUpData.Service_Identifier_Default__c) ||
                       map_ServicesNotMapped.containsKey(objRollUpData.PCV_Service_Identifier__c) ||
                       map_ServicesNotMapped.containsKey(objRollUpData.PCV_Service_Identifier_Default__c))
                    {
                        String strErrorDescription = 'Service used is not contracted for';
                        objRollUpData.Exception_Type__c = 'Service Not Contracted';
                        Service__c objServiceNotContracted;
                        if(map_ServicesNotMapped.containsKey(objRollUpData.Service_Identifier__c)) {
                            System.debug('Attempt retrieve standard Service from map_ServicesNotMapped');
                            objServiceNotContracted = map_ServicesNotMapped.get(objRollUpData.Service_Identifier__c);
                        } else if(map_ServicesNotMapped.containsKey(objRollUpData.PCV_Service_Identifier__c)) {
                            System.debug('Attempt retrieve PCV Service from map_ServicesNotMapped');
                            objServiceNotContracted = map_ServicesNotMapped.get(objRollUpData.PCV_Service_Identifier__c);
                        } else if(map_ServicesNotMapped.containsKey(objRollUpData.Service_Identifier_Default__c)) {
                            System.debug('Attempt retrieve default Service from map_ServicesNotMapped');
                            objServiceNotContracted = map_ServicesNotMapped.get(objRollUpData.Service_Identifier_Default__c);
                        } else {
                            System.debug('Not able to retrieve Service from map_ServicesNotMapped');
                        }
                        System.debug('Got uncontracted service ' + objServiceNotContracted);
                        map_RollupIdToBillingException.put(objRollUpData.Id,createNewBillingException(strErrorDescription,objRollUpData,objServiceNotContracted,idContract));
                    }
                    // If Service does not exist : creating a suitable exception record 	
                    else
                    {
                        String strErrorDescription = 'Service is not available';
                        objRollUpData.Exception_Type__c = 'Service Unavailable';
                        map_RollupIdToBillingException.put(objRollUpData.Id,createNewBillingException(strErrorDescription,objRollUpData,null,idContract));
                    }	
                }
            }
            
            // Updating Roll Up records
            update list_RolledUpUsageData;
            
            // Upserting Roll Up processing exceptions
            if(!map_RollupIdToBillingException.isEmpty())
                insert map_RollupIdToBillingException.values();
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

   
    // iTracks 24986
    public Decimal getCallingRateFromHash(Map<String,List<Calling_Rate__c>> map_RateIdentifierToCallingRate, String callingRateIdentifier, DateTime startTime) {
        List<Calling_Rate__c> list_CallingRate = map_RateIdentifierToCallingRate.get(callingRateIdentifier);
        System.debug('Find rate for Start Time ' + startTime);
        for (Calling_Rate__c callingRate : list_CallingRate) {
        	System.debug('Examine Rate ' + + callingRate.Id + ' with Start ' + callingRate.Effective_Start_Date__c +
        	             ' End ' + callingRate.Effective_End_Date__c);
            if (startTime >= callingRate.Effective_Start_Date__c &&
                startTime < callingRate.Effective_End_Date__c) {
                    return callingRate.Rate_Per_Minute__c;
                }
        }
        throw new CallingRateNotFoundException();
    }
    
    // iTracks 24752
    public Decimal getInboundCallingRateFromHash(Map<String,List<Inbound_Calling_Rate__c>> map_InboundRateIdentifierToCallingRate, Rolled_Up_Usage_Data__c ruud, Decimal intDeviceType) {
        System.debug('Find inbound rate for Start Time ' + ruud.Start_Time__c +
                     ' and calling rate identifier ' + ruud.Calling_Rate_Identifier_Inbound__c);
        List<Inbound_Calling_Rate__c> list_InboundCallingRate = map_InboundRateIdentifierToCallingRate.get(ruud.Calling_Rate_Identifier_Inbound__c);
        for (Inbound_Calling_Rate__c callingRate : list_InboundCallingRate) {
        	System.debug('Examine Rate ' + + callingRate.Id + ' with Start ' + callingRate.Effective_Start_Date__c +
        	             ' End ' + callingRate.Effective_End_Date__c);
            if (ruud.Start_Time__c >= callingRate.Effective_Start_Date__c &&
                ruud.Start_Time__c < callingRate.Effective_End_Date__c) {
                    if (intDeviceType == DEVICE_TYPE_WIRELINE) {
                        return callingRate.Rate_Wireline__c;
                    } else if (intDeviceType == DEVICE_TYPE_WIRELESS) {
                    	return callingRate.Rate_Wireless__c;
                    }
                }
        }
        throw new CallingRateNotFoundException();
    }

    // *** Finish Method : Exception notifications and other final code ***
    global void finish(Database.BatchableContext BC) 
    {
        // Invoke taxing job for any records needing taxing
        if (SureTax_Settings__c.getValues('SureTaxEnabled').Value__c == 'True')
        {
            system.debug('#SureTax Enabled - Proceeding with batch tax with status ' + BatchTaxCloudUsageData.PROCESS_ROLLUP_TAX_NEEDED);
            BatchTaxCloudUsageData objBatchTaxCloudUsageData = new BatchTaxCloudUsageData(BatchTaxCloudUsageData.PROCESS_ROLLUP_TAX_NEEDED);
            objBatchTaxCloudUsageData.objJobLog = objJobLog;
            // *** We can't insert a log and then kick off the tax batch job, This job sits and waits for the tax job to finish - also a potential performance issue
            //Cloud_Billing_Log__c objTaxLog = CloudBillingUtil.createNewCloudBillingLog('SureTax Processing', 'Submitted');
            //insert objTaxLog;
            //objBatchTaxCloudUsageData.objJobLog = objTaxLog;
			Integer intSureTaxBatchSize = 2000;
            if (SureTax_Settings__c.getValues('SureTaxBatchSize') != null) {
                intSureTaxBatchSize = Integer.valueOf(SureTax_Settings__c.getValues('SureTaxBatchSize').Value__c);
                System.debug('SureTax_Settings__c.SureTaxBatchSize using configured batch size ' + intSureTaxBatchSize);
            } else {
                System.debug('SureTax_Settings__c.SureTaxBatchSize using default batch size ' + intSureTaxBatchSize);
            }
            Id idSureTaxJob = Database.executeBatch(objBatchTaxCloudUsageData,intSureTaxBatchSize); 
            
            //objTaxLog.AsyncApexJob_Id__c = idSureTaxJob;
            //objTaxLog.Parent_Cloud_Billing_Log__c = objJobLog.Id;
            //update objTaxLog;
        } else {
            // The Sure Tax will Complete the log. If SureTax is turned off complete the log here.
            // Insert/Update Log record
            if(objJobLog != null) {
                objJobLog.Status__c = 'Completed';
                upsert objJobLog;
            }
        }
    }
    
    // *** Method to return an instance of custom exception object ***
    @TestVisible
    private Cloud_Billing_Exception__c createNewBillingException(String strDescription,Rolled_Up_Usage_Data__c objRollUpData,Service__c objService,Id idContract) 
    {
        Cloud_Billing_Exception__c objBillingException = new Cloud_Billing_Exception__c();
        objBillingException.Exception_Type__c = objRollUpData.Exception_Type__c;
        objBillingException.Description__c = strDescription;
        objBillingException.Rolled_Up_Usage_Data__c = objRollUpData.Id;
        objBillingException.Contract__c = idContract;
        // Storing Service Info if available
        objBillingException.Service__c = objService != null ? objService.Id : null;
        
        return objBillingException;
    }
    
	// *** Method to populate quantity based on units type ***
    public static String populateQuantity(Rolled_Up_Usage_Data__c objRollUpData,Service_Usage__c objServiceUsage,String strUnitsType)
    {
        // Traditional code assumes values in Rolled Up Usage Record are in Seconds.
        // Genesys bills for minutes.
        // Divide seconds by 60 for minutes
        Integer intMinutesDivisor = 60;

        // Activity Type 8 for PCC is sent in minutes. Do not divide by 60 to get totals
        if (objRollUpData.Activity_Type__c == 8) {
            if (objRollUpData.Source_Name__c == 'PCC') {
                intMinutesDivisor = 1;
            }
        }

        if(String.isBlank(strUnitsType))
            return 'Units Type Missing on Tier Set on Contract'; 
        
        objServiceUsage.Cost_Basis__c = 'Duration';
        
        if(strUnitsType == 'Messages/Seats/Ports')
        {
            if(objRollUpData.Count__c == null)
                return 'Count : Info missing';
            
            objServiceUsage.Quantity__c = objRollUpData.Count__c;
            objServiceUsage.Cost_Basis__c = 'Messages';
        }
        
        else if(strUnitsType == 'Minutes(12s/message)')
        {
            if(objRollUpData.Count__c == null)
                return 'Count : Info missing';
            
            objServiceUsage.Quantity__c = (objRollUpData.Count__c * 12)/intMinutesDivisor;
        }
        
        else if(strUnitsType == 'Minutes(6s ceiling)')
        {
            if(objRollUpData.Billable_6__c == null)
                return 'Billing 6 : Info missing';
            
            objServiceUsage.Quantity__c = objRollUpData.Billable_6__c/intMinutesDivisor;
        }    
        
        else if(strUnitsType == 'Minutes(30s ceiling)')
        {
            if(objRollUpData.Billable_30__c == null)
                return 'Billing 30 : Info missing';
            
            objServiceUsage.Quantity__c = objRollUpData.Billable_30__c/intMinutesDivisor;
        }
        
        else if(strUnitsType == 'Minutes(60s ceiling)')
        {
            if(objRollUpData.Billable_60__c == null)
                return 'Billing 60 : Info missing';
            
            objServiceUsage.Quantity__c = objRollUpData.Billable_60__c/intMinutesDivisor;
        }
        
        else if(strUnitsType == 'Minutes(6s/message)')
        {
            if(objRollUpData.Count__c == null)
                return 'Count : Info missing';
            
            objServiceUsage.Quantity__c = (objRollUpData.Count__c * 6)/intMinutesDivisor;
        }
        
        else if(strUnitsType == 'Minutes(Actual)')
        {
            if(objRollUpData.Total_Duration__c == null)
                return 'Total_Duration__c : Info missing';
            
            objServiceUsage.Quantity__c = (objRollUpData.Total_Duration__c)/intMinutesDivisor;
        }
        else if(strUnitsType == 'Gigabytes')
        {
            if(objRollUpData.Gigabyte_Count__c == null)
                return 'Gigabyte Count : Info missing';
            
            objServiceUsage.Quantity__c = objRollUpData.Gigabyte_Count__c;
        }

        return null;
    }
	
	// *** Populate GARN Code on Roll Up Usage Data records in case it's missing ***
	@TestVisible
	private void populateMissingGARNCodes()
	{
        String strQuery = 'SELECT Id,Platform_Id_Hash__c FROM Rolled_Up_Usage_Data__c WHERE GARN_Account_Code__c = null ';
        if (strLimitRating != 'NONE') {
            strQuery = strQuery + strLimitRating;
        }
        strQuery = strQuery + ' LIMIT 9999';
        System.debug('populateMissingGARNCodes: strSOQL ' + strQuery);
        List<Rolled_Up_Usage_Data__c> list_GARNCodeMissingData = (List<Rolled_Up_Usage_Data__c>)Database.query(strQuery);

		if(!list_GARNCodeMissingData.isEmpty())
		{
			//Util.populateGARNCodes(list_GARNCodeMissingData); 
			CloudBillingUtil.populateGARNCodesFromCloudDeployment(list_GARNCodeMissingData);
			update list_GARNCodeMissingData;
		}	
	}
    
    public static set<String> getSetOfStringsByCommaSeperated(String strLabel){
        Set<String> set_Strings = new Set<String>();
        String strCommaSepSourceNames = strLabel;
        if(strCommaSepSourceNames.contains(',')){
            set_Strings.addAll(strCommaSepSourceNames.split(','));
        }else{
            set_Strings.add(strCommaSepSourceNames);
        }
        return set_Strings;
    }
    // Added by Vijay - CRMBILL -166. Oct 18th 2017 - End
}