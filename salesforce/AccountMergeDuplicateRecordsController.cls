public with sharing class AccountMergeDuplicateRecordsController{
    public Account accountRecord{get;set;}
    private List<Account> accountList{get;set;}
    public List<AccountWrapper> searchResults {get;set;} 
    public String accountName{get;set;}
    public List<Account> selectedAccountList{get;set;}
    public List<String> fieldList{get;set;}
    public Map<String,String> fieldAPINameMap{get;set;}
    Map<Id,Account> accountIdRecordMap{get;set;}
    public Account SelectedAccountRecordValues{get;set;}
    public String masterColumnName {get {return 'Master';}}
    public Id accountId {get; set;}
    public boolean isAssyncMode {get; set;}
    public String RecordType{get; set;}
    
    //For record type validation
    List<RecordType> recordTypeList;
    Id PartyAccountRecordTypeId;
    Id GroupAccountCustomerRecordTypeId;
    Id EMGCustomerRecordTypeId;
   
    List <RecordType> mergeRecType;
    Id mergeRecTypeId;
    List <User> ownerType;
    Id mergeOwnerId;
    
    public AccountMergeDuplicateRecordsController(ApexPages.StandardController controller) {
        if(!test.isRunningTest())controller.addFields(new List<String>{'name'});
        
        
        //this.accountRecord = (Account)controller.getRecord();
       
       
        mergeRecType = [select id,name from RecordType where name =: 'Merge Record Type'];
        if( mergeRecType !=null &&  mergeRecType.size()>0){
         mergeRecTypeId = mergeRecType[0].id;
        }
        
        ownerType = [select id from User where  alias ='csale'];
        if( ownerType !=null &&  ownerType.size()>0){
         mergeOwnerId = ownerType[0].id;
        }
       
       
        
        accountRecord = [select id,name from Account where id =: controller.getId()];
        
        this.accountName = accountRecord.name;
        RecordType='All';
        searchAccounts();
        fieldList = new List<String>();
        fieldAPINameMap = new Map<String,String>();
        SelectedAccountRecordValues = new Account();
        isAssyncMode =false;
        for(Schema.FieldSetMember f : SObjectType.Account.FieldSets.MergeAccountFields.getFields()){
            System.debug(f.getFieldPath());
            fieldList.add(f.getFieldPath());
            fieldAPINameMap.put(f.getFieldPath(), f.getLabel());
        }
        
        accountIdRecordMap = new Map<Id,Account>();
        
        //For record type validation
        recordTypeList = [select id,name from RecordType where SobjectType = 'Account'];
        if(recordTypeList!=null && recordTypeList.size()>0){
            for(RecordType rt : recordTypeList){
                if(rt.name == 'Party Account'){
                    PartyAccountRecordTypeId = rt.id;
                }
                if(rt.name == 'Group Account - Customer'){
                    GroupAccountCustomerRecordTypeId = rt.id;
                }
                if(rt.name == 'EMG - Customer Record Type'){
                    EMGCustomerRecordTypeId = rt.id;
                }
            }
        }

       

        //System.debug('****PartyAccountRecordTypeId'+PartyAccountRecordTypeId);
        //System.debug('****GroupAccountCustomerRecordTypeId'+GroupAccountCustomerRecordTypeId);
        //System.debug('****EMGCustomerRecordTypeId'+EMGCustomerRecordTypeId);
    }
    
    public List<selectOption> RecordTypeOptions {get {

        List<selectOption> myRecordTypes = new List<selectOption>();
        myRecordTypes.add(new selectOption('All', 'All')); 

        for (RecordType rt : [select Id, Name from RecordType where RecordType.SobjectType = 'Account'])
             myRecordTypes.add(new selectOption(rt.id, rt.name));

        return myRecordTypes;

        }

        private set;

    }

    public void searchAccounts(){
            Set<String> uniqueFields = new Set<String>();
            searchResults = new List<AccountWrapper>();
            
            String queryString = 'SELECT ';
            for(Schema.FieldSetMember f : SObjectType.Account.FieldSets.MergeAccountFields.getFields()) {
                uniqueFields.add(f.getFieldPath());
                
            }
            
           Set<String> requiredFields = new Set<String>{'Id', 'Name', 'Country__c','RecordType.Name','SAP_Account_Code__c','City__c','Subsidary__c', 'IsCustomerPortal','IsPartner','Owner.name'};
            uniqueFields.addAll(requiredFields);
         
            for(String fieldAPIname : uniqueFields){
                queryString += fieldAPIname + ', ';
            }
            
            queryString = queryString.subString(0,queryString.lastIndexOf(','));
            
            queryString += ' from Account ' ;
            queryString += 'where (Status__c= \'Active\' OR Status__c= \'Inactive\' OR Status__c= \'Expired Maintenance\'  OR Status__c= null)'; 
            system.debug('RecordType'+RecordType);
            if(RecordType!='All')queryString +='  AND RecordTypeId=:RecordType';
            queryString +=' AND name LIKE \'%'+String.escapeSingleQuotes(accountName)+'%\' order by name Limit 500';
              
              
            accountList = Database.query(queryString);
            
            accountList = formatAccount(accountList);
            
            if(accountList.size() == 0){
                apexpages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'No account records found with this name:');
                apexpages.addmessage(msg);
            }
            if(accountList.size() <= 3){
                for(Account acc : accountList){
                    searchResults.add(new AccountWrapper(true, acc));
                }    
            }
            else{
               for(Account acc : accountList){
                    if(acc.id == accountRecord.id){
                        searchResults.add(new AccountWrapper(true, acc));
                    }
                    else{
                        searchResults.add(new AccountWrapper(false, acc));
                    }
                } 
            }      
            
    }
    public PageReference doNext(){
        selectedAccountList = new List<Account>();
        
        for(AccountWrapper wrapAccountObj : searchResults) {
            if(wrapAccountObj.selected == true) {
                selectedAccountList.add(wrapAccountObj.accRecord);
            }
        }
        
        if(selectedAccountList.size() > 0)
        accountId = selectedAccountList[0].id;
        /*
        set<Id> recIDRestricted=new Set<Id>();
        recIDRestricted.add('012U0000000M7mLIAS');
        boolean parttyAccount=false;
        boolean otherAccount=false;
        for(Account acct :selectedAccountList){
            if(recIDRestricted.contains(acct.RecordTypeId)){
              parttyAccount=true;
            }
            if(recIDRestricted.contains(acct.RecordTypeId)){
              otherAccount=true;
            }
        }
        if(parttyAccount & otherAccount){
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You must select same Account Record Types for Party Account to merge.'));
                return null;
        }
        */
        boolean partyAccount=false;
        boolean otherAccountForParty=false;
        boolean groupCustomerAccount = false;
        boolean emgCustomerAcoount = false;
        for(Account acct :selectedAccountList){
            if(PartyAccountRecordTypeId == acct.RecordTypeId){
              partyAccount=true;
            }
            if(PartyAccountRecordTypeId != acct.RecordTypeId){
              otherAccountForParty=true;
            }
            if(GroupAccountCustomerRecordTypeId == acct.RecordTypeId){
              groupCustomerAccount=true;
            }
            if(EMGCustomerRecordTypeId == acct.RecordTypeId){
              emgCustomerAcoount=true;
            }
        }
        if(partyAccount && groupCustomerAccount){
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Group Account Record Types  can not be merged with Party  Account Types'));
                return null;
        }
        if(emgCustomerAcoount && (groupCustomerAccount || partyAccount)){
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'EMG - Customer Record Type cannot/should not be merged with Group Accounts or Party Accounts'));
                return null;
        }
        if(partyAccount && otherAccountForParty){
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You must select same Account Record Types for Party Account to merge.'));
                return null;
        }
        if(selectedAccountList.size() < 2){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You must select two or three records to merge.'));
            return null;
        }
        
        if(selectedAccountList.size() < 2){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You must select two or three records to merge.'));
            return null;
        }
        /*else if(selectedAccountList.size() > 3){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You may only select up to three records to merge.'));
            return null;
        }
       */
        accountIdRecordMap = new Map<Id,Account>(selectedAccountList);
        PageReference step2= Page.AccountMergeDuplicateRecords2;
        
        return step2;
    }
    public PageReference doMerge(){
       String jsonString = ApexPages.currentPage().getParameters().get('jsonData');
       System.debug('******jsonString'+jsonString);
        Account masterAccount = new Account();
        System.debug('isAssyncMode:'+isAssyncMode);
        Map<Id, Account> idToAccountMapTemp = new Map<Id, Account>();
        for(Account acc : selectedAccountList){
             idToAccountMapTemp.put(acc.id, acc);
        }
        
     try{
         
        JSONToApex jsonApex = JSONToApex.parse(jsonString);
        
        for(JSONToApex.Entries data : jsonApex.Entries){
           if(data.fieldValue != null){
           System.debug('*****1'+data.fieldName);
           System.debug('*****2'+data.fieldValue);
           System.debug('*****3'+idToAccountMapTemp);
           System.debug('*****4'+idToAccountMapTemp.get(data.fieldValue));
           System.debug('*****5'+idToAccountMapTemp.get(data.fieldValue).get(data.fieldName));
           System.debug('*****6'+masterAccount);
           masterAccount.put(data.fieldName, idToAccountMapTemp.get(data.fieldValue).get(data.fieldName)); 
           }   
        }
        system.debug('++++++masterAccount++++  '+masterAccount);
        //Added by Swastika on may-3-2017 to prevent merging for specific profiles <start>
        //Naresh Kumar 11/06/2017 - We do not need to set merge flag on master account.
        //if(masterAccount!=null)
        //   masterAccount.IsMerge__c = true;
        //Added by Swastika on may-3-2017 to prevent merging for specific profiles <end>     
        if(!test.isrunningtest())
        update masterAccount;
        
        system.debug('+++++7++++++');
        
        List<Account> duplicates = new List<Account>();
        set<Id> duplicateIds=new set<Id>();
        for(Account acc : selectedAccountList){
            
            if(acc.id != masterAccount.id){
                duplicates.add(acc);
                duplicateIds.add(acc.Id);
            }
        }
        if(duplicates.size()<=2 && !isAssyncMode) {
            SMLHelperWTS.deleteEngagementDataForDuplicateAccount(duplicateIds);
            
           Database.MergeResult[] results = Database.merge(masterAccount, duplicates, false);
            //undelete records
            undelete duplicates;
            for(Account dupAccount : duplicates){
                dupAccount.Status__c = 'Merged';
                 dupAccount.Merge_to__c = masterAccount.id;
                 dupAccount.RecordTypeId=  mergeRecTypeId;  
                 dupAccount.Account_Segmentation__c = null;
                 dupAccount.OwnerId = mergeOwnerId;
            }
            update duplicates;
            //check results in any errors
            for(Database.MergeResult res : results) {
                if (!res.isSuccess()) {
                    for(Database.Error err : res.getErrors()) {
                         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ''+err.getMessage());
                         ApexPages.addMessage(myMsg);
                     }
                     return null;
                 }
           }
            PageReference pageRef = new PageReference('/'+masterAccount.Id);
            return pageRef; 
       }else{
            SMLHelperWTS.deleteEngagementDataForDuplicateAccount(duplicateIds);
            processAccountRecordsMerge(masterAccount.Id,duplicateIds);
       }
    }catch(exception ex){
   
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ''+ex.getMessage());
        ApexPages.addMessage(myMsg);
        return null;
   } 
       
       
       PageReference pageRef = new PageReference('/home/home.jsp');
       return pageRef; 
    }
   
   @Future
    public static void processAccountRecordsMerge(Id masterAccountId, set<Id> duplicateIds){
        Account masterAccount=[select Id, Name From Account WHERE ID=:masterAccountId];
        List<Account> duplicateRecs=[select Id, Name From Account WHERE ID In :duplicateIds];
      
      List <RecordType> mergeRecType;
       Id mergeRecTypeId;
    
        mergeRecType = [select id from RecordType where name = 'Merge Record Type'];
        if( mergeRecType !=null &&  mergeRecType.size()>0){
         mergeRecTypeId = mergeRecType[0].id;
        }
    
       List <User> ownerType;
       Id mergeOwnerId;
    
       ownerType = [select id from User where  alias ='csale'];
        if( ownerType !=null &&  ownerType.size()>0){
         mergeOwnerId = ownerType[0].id;
        }
      
        
        try{
            List<Account> duplicates;
            //loops increamenting 2 records at a time
            for(Integer i=0; i<duplicateRecs.size();i+=2){
                duplicates=new List<Account> ();
                duplicates.add(duplicateRecs[i]);
                if(duplicateRecs.size()>1 &&i+1!=duplicateRecs.size())duplicates.add(duplicateRecs[i+1]);
                Database.MergeResult[] results = Database.merge(masterAccount, duplicates, false);
            
            }
            
            if(Math.mod(duplicateRecs.size(),2)==0 && duplicateRecs.size()>2){
                Integer intIndex=duplicateRecs.size()-1;
                duplicates=new List<Account> ();
                duplicates.add(duplicateRecs[intIndex]);
                Database.MergeResult[] results1 = Database.merge(masterAccount,duplicates , false);
            
            }
           
            //undelete records
            List<Account> undeltRecs=[select Id, Name,Status__c From Account WHERE ID In :duplicateIds and isDeleted=true ALL ROWS];
            system.debug('@@@@@@@@@@@'+undeltRecs);
            if(undeltRecs.size()>0){
                undelete undeltRecs;
                List<Account> accRecs=[select Id, Name,Status__c From Account WHERE ID In :duplicateIds ];
               
                for(Account dupAccount : accRecs){
                        dupAccount.Status__c = 'Merged';
                        dupAccount.Merge_to__c = masterAccountId;
                        dupAccount.RecordTypeId=  mergeRecTypeId; 
                        dupAccount.OwnerId = mergeOwnerId;
                
                }
                update accRecs;
                //send success message to the user
                sendEmail(masterAccount, duplicateRecs,'');
                
           }
       }catch(exception ex){
       
            sendEmail(masterAccount, duplicateRecs,ex.getMessage());
           
       } 
     
            
  }
  
  @TestVisible
   private static void sendEmail(Account masterAccount,List<Account> duplicateRecs,
                                           string sError){
               // Create the email message body and distribute
        String emailBody = '';
        String strSubject='';
        If (sError==''|| sError==null){
        emailBody += 'Account Merge Processed for :' + masterAccount.name + '\n\n';
        
        emailBody += 'No. of Accounts Merged: ' + duplicateRecs.size() + '\n';
        
        strSubject='Account Merge Process Completed';
        }else{
             emailBody += sError+'Error on merge. please contact Support services.' + '\n';
        
             strSubject='Account Merge Process failed';
        }
        // Create a single email to send to distribution list
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        // Strings to hold the email addresses to which you are sending the email.
        List<String> toAddresses = new List<String>(); 
        List<String> ccAddresses= new List<String>(); 
        
        String emailAddress = [SELECT Email FROM User where Id=: userInfo.getUserId()].Email;
        toAddresses.add(emailAddress);
         If (sError!=''|| sError==null)ccAddresses.add('apps-crm-support@genesys.com');
        // Assign the addresses for the To recipients
        email.setToAddresses(toAddresses);


        // Specify the subject line
        email.setSubject(strSubject);
        
        email.setCcAddresses(ccAddresses);


        // Specify the plain text email body
        email.setPlainTextBody(emailBody);

        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
   
   
   }     
    
    
    public PageReference doPrevious(){
        PageReference step1 = Page.AccountMergeDuplicateRecords;
        return step1;
    }
   
   public List<Account> formatAccount(List<Account> aList){
        List<Account> newAccountList = new List<Account>();
        if(aList!=null && aList.size()>0){
            for(Account a: aList){
                if(accountRecord.id == a.id){
                    newAccountList.add(a);
                }
            }
            for(Account a: aList){
                if(accountRecord.id != a.id){
                    newAccountList.add(a);
                }
            }
        }
        return newAccountList;
    }
    
    public class AccountWrapper{
        public boolean selected{get;set;}
        public Account accRecord{get;set;}
        
        public AccountWrapper(boolean selected, Account acc){
                this.selected = selected;
                this.accRecord = acc;
        }
    }
    
          

}