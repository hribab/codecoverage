global class BatchTaxCloudUsageData implements Database.Batchable<SObject>, Database.Stateful, Database.AllowsCallouts
{
    public static final String PROCESS_ROLLUP_TAX_NEEDED = 'Process Rollup Tax';
    public static final String PROCESS_ORDER_LINE_SURETAX = 'Process Order Line Tax';

    public static final String TAX_STATUS_ROLLUP_TAX_NEEDED = 'Rollup Tax Needed';
    public static final String TAX_STATUS_ORDER_LINE_SURETAX_NEEDED = 'SureTax Needed';

    // Log Record for this job
    public Cloud_Billing_Log__c objJobLog;
    private String strTaxProcessType;
    private CloudBillingData objCloudBillingData;
    public final String strMonth;
    public final String strYear;
    public final String strContractId;
    public final String strSubsidiary;
    public String strRegion {get; set;}
    public String strEdition {get; set;}


    private void BatchTaxCloudUsageDataMain(String strTaxProcessType) {
        System.debug('BatchTaxCloudUsageData ctor strTaxProcessType ' + strTaxProcessType);
        this.strTaxProcessType = strTaxProcessType;
    }    

    // Main ctor
    public BatchTaxCloudUsageData(String strTaxProcessType) {
		BatchTaxCloudUsageDataMain(strTaxProcessType);
    }

    public BatchTaxCloudUsageData(String strTaxProcessType, CloudBillingData objCloudBillingData) {
		BatchTaxCloudUsageDataMain(strTaxProcessType);
        this.objCloudBillingData = objCloudBillingData;
        strMonth = objCloudBillingData.month;
        strYear = objCloudBillingData.year;
        strSubsidiary = objCloudBillingData.subsidiary;
        strContractId = objCloudBillingData.contractId;
        strRegion = objCloudBillingData.region;
        strEdition = objCloudBillingData.edition;
    }

    global Database.QueryLocator start(Database.BatchableContext BC)
    {              
        System.debug(objJobLog);
        if (objJobLog == null) 
        {
            System.debug('Need to Create new Job Log');
            objJobLog = CloudBillingUtil.createNewCloudBillingLog('Rating','Submitted');
        } 
        else 
        {
            System.debug('objJobLog Exists ' + objJobLog);
        }

        objJobLog.Options__c = CloudBillingUtil.populateJobLogOptions(objCloudBillingData);
        
        objJobLog.Exceptions__c = (objJobLog.Exceptions__c == null) ? '':objJobLog.Exceptions__c;

        if (strTaxProcessType == PROCESS_ROLLUP_TAX_NEEDED) {
            String strSOQL = 'SELECT Id'
                                + ', Name'
                                + ', Rolled_Up_Usage_Data__c'
                                + ', Rolled_Up_Usage_Data__r.Service_Identifier__c'
                                + ', Rolled_Up_Usage_Data__r.ZIP_Postal_Code__c'
                                + ', Rolled_Up_Usage_Data__r.Exception_Type__c'
                                + ', Contract_Tier_Set_Month__r.Contract_Tier_Set__r.Contract__c'
                                + ', Start_Time__c'
                                + ', Tax_Status__c'
                                + ', Count__c'
                                + ', Cost__c'
                                + ', Total_Duration__c'
                                + ', (SELECT Service_Usage__c, Tax_Type_Code__c, Tax_Amount__c FROM Service_Usage_Taxes__r)'
                                + ' FROM Service_Usage__c'
                                + ' WHERE Tax_Status__c = \'' + TAX_STATUS_ROLLUP_TAX_NEEDED + '\'';
            System.debug('strSOQL ' + strSOQL);
            return Database.getQueryLocator(strSOQL);
        } else if (strTaxProcessType == PROCESS_ORDER_LINE_SURETAX) {

            String strSOQL =
                'SELECT Id, ' +
                'Maintenance_Start__c, Maintenance_End__c, ' +
                'Contract_Lookup__r.Postal_Code_Override__c, ' +
                'Offering_Type__c ' +
                'FROM Order__c ' +
                'WHERE Tax_Needed__c = true ' +
                'AND Year__c = \'' + objJobLog.Year__c + '\' ' +
                'AND Month__c = \'' + objJobLog.Month__c + '\'';

            if(String.isNotBlank(strContractId))
                strSOQL += ' AND Contract_Lookup__c = \'' + strContractId + '\'';
            
            if(String.isNotBlank(strSubsidiary) && strSubsidiary != 'All')
                strSOQL += ' AND Subsidaries__r.Name = \'' + strSubsidiary + '\'';
    
            if(String.isNotBlank(strRegion) && strRegion != 'All')
                strSOQL += ' AND End_User_Name__r.Country__r.Region__c = \'' + strRegion + '\'';
    
            if(String.isNotBlank(strEdition) && strEdition != 'All')
            {
                strSOQL += ' AND (Contract_Lookup__r.Product_Group__c = \'' + strEdition + '\'';

                if(strEdition == 'PureCloud' || strEdition == 'PureConnect')
                    strSOQL += ' OR Sales_Org__c = \'' + strEdition + '\')';
                else
                    strSOQL += ')';
            }           

            System.debug('Order Tax strSOQL ' + strSOQL);
            return Database.getQueryLocator(strSOQL);
        }

        System.debug('Unrecognized Taxing Process Type ' + strTaxProcessType);
        return null;
    }
    
    global void execute(Database.BatchableContext BC, List<SObject> sObjects) 
    {
        // DB Save-point
        //Savepoint objSP = Database.setSavepoint();
        TaxCalculator objTaxCalculator = new TaxCalculator();
        objTaxCalculator.objJobLog = objJobLog;

        if (strTaxProcessType == PROCESS_ROLLUP_TAX_NEEDED) {
            List<Service_Usage__c> list_ServiceUsage = (List<Service_Usage__c>)sObjects;
            for (Service_Usage__c objServiceUsage : list_ServiceUsage) 
            {
                System.debug('BatchTaxCloudUsageData: objServiceUsage ' + objServiceUsage);
            }
    
            objTaxCalculator.rollupServiceUsageTaxes(list_ServiceUsage);
        } else if (strTaxProcessType == PROCESS_ORDER_LINE_SURETAX) {
            //List<Order_Line_Item__c> listOLI = (List<Order_Line_Item__c>)sObjects;
		    //objTaxCalculator.processSureTaxRequestTopLevel(listOLI);
            List<Order__c> listOrders = (List<Order__c>)sObjects;
		    objTaxCalculator.processSureTaxRequestTopLevel(listOrders);
        } else {
            System.debug('Option ' + strTaxProcessType + ' not recognized, taking no tax action');
        }
    }

    // *** Finish Method : Exception notifications and other final code ***
    global void finish(Database.BatchableContext BC) 
    {
        // Insert/Update Log record
        if(objJobLog != null) {
            objJobLog.Status__c = 'Completed';
            upsert objJobLog;
        }
    }
}