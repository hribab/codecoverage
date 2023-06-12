// 
// Test coverage for this class is in BatchInvoicePDFAttachTest class
// Comment added by Vijay - 31st Jul 2017

global class BatchSendInvoices implements Database.Batchable<SObject>, Database.Stateful {
    
    private Boolean blnInvoicesProcessed;
    // Data needed for this job    
    public CloudBillingData objCloudBillingData;
    // Log Record for this job
    public Cloud_Billing_Log__c objJobLog;
    
    public BatchSendInvoices(CloudBillingData objCloudBillingData, Cloud_Billing_Log__c objJobLog) {
		blnInvoicesProcessed = false;
        this.objCloudBillingData = objCloudBillingData;
        this.objJobLog = objJobLog;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        System.debug(objCloudBillingData);
        System.debug(objJobLog);
        if (objJobLog == null) {
            System.debug('Need to Create new Job Log');
            objJobLog = CloudBillingUtil.createNewCloudBillingLog('Invoice Email Distribution','Submitted');
            insert objJobLog;
        } else {
            System.debug('objJobLog Exists ' + objJobLog);
        }
        upsert objJobLog;
        
        
        String strQuery = 'SELECT Id FROM Invoice__c WHERE (Status__c = \'Invoice Attached\') AND ' +
            '(Order__r.Contract_Lookup__r.Invoice_Delivery_Type__c = \'Email\' OR Order__r.Contract_Lookup__r.Invoice_Delivery_Type__c = \'Both Email and Paper\' OR Order__r.Sales_Org__c = \'PureCloud\' OR Order__r.Sales_Org__c = \'PureConnect\') ' +
            'AND Order__r.Month__c = \'' + objJobLog.Month__c + '\' AND Order__r.Year__c = \'' + objJobLog.Year__c + '\' ' +
            'AND Order__r.Status__c = \'Completed\' AND Order__r.RecordType.Name = \'Cloud Monthly Billing Order\'';
        
        if(objJobLog.Contract__c != null)
            strQuery += ' AND Order__r.Contract_Lookup__c = \'' + objJobLog.Contract__c + '\'';
        
        else {
            if(String.isNotBlank(objCloudBillingData.subsidiary) && objCloudBillingData.subsidiary != 'All')
                strQuery += ' AND Order__r.End_User_Name__r.Subsidary__r.Name = \'' + objCloudBillingData.subsidiary + '\'';
            
            if(String.isNotBlank(objCloudBillingData.region) && objCloudBillingData.region != 'All')
                strQuery += ' AND Order__r.Contract_Lookup__r.Account_Name__r.Country__r.Region__c = \'' + objCloudBillingData.region + '\'';
            
            if(String.isNotBlank(objCloudBillingData.edition) && objCloudBillingData.edition != 'All')
            {
                strQuery += ' AND (Order__r.Contract_Lookup__r.Product_Group__c = \'' + objCloudBillingData.edition + '\'';
                if(objCloudBillingData.edition == 'PureCloud')
                    strQuery += ' OR Order__r.Sales_Org__c = \'PureCloud\')';
                else if(objCloudBillingData.edition == 'PureConnect')
                    strQuery += ' OR Order__r.Sales_Org__c = \'PureConnect\')';
                else
                    strQuery += ')';
            } 
        }
        
        System.Debug('BatchSendInvoices: strQuery: ' + strQuery);
        return Database.getQueryLocator(strQuery);
    }
    
    global void execute(Database.BatchableContext BC,List<SObject> sObjects) {

		blnInvoicesProcessed = true;
        List<Invoice__c> list_Invoices = (List<Invoice__c>)sObjects;
        // Update invoice status to send out invoices
        SavePoint objSP = Database.setSavePoint();
        try
        {
            for(Invoice__c objInvoice : list_Invoices) {
                objInvoice.Status__c = 'Send Email';
            }
            update list_Invoices;
        }
        catch(Exception ex)
        {
            Database.rollBack(objSP);
        }
    }
    
    
    global void finish(Database.BatchableContext BC) {
        
        // There were no invoices to process, indicate in the log
        if (!blnInvoicesProcessed) {
            if (objJobLog.Exceptions__c == null) {
                objJobLog.Exceptions__c = 'No Invoices Matched';
            } else {
                objJobLog.Exceptions__c += ', No Invoices Matched';
            }
        }
        objJobLog.Status__c = 'Completed';
        upsert objJobLog;
    }
}