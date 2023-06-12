public without sharing class AccountHierarchy {

    private final Account acct;
     
     public AccountHierarchy(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
    }
 
    public ApexPages.StandardSetController setCon {
        get {   
             setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [Select a.Name, a.Status__c, a.SAP_Account_Code__c, 
                            a.Recordtype.Name, 
                            a.Country__r.Name, a.City__c 
                     From Account a 
                     Where a.ParentId = :ApexPages.currentPage().getParameters().get('Id')]));
            
            return setCon;
        }
        set;
    }

    public List<Account> getRelAccounts() {
        return (List<Account>) setCon.getRecords();
    }
    
    public Boolean isGroupAccount {
      get {
         Integer ct  = [Select count()
                        From Account a 
                        Where Id = :ApexPages.currentPage().getParameters().get('Id')
                          AND a.Recordtype.Name LIKE 'Group%'];
        
        if ( ct > 0 ) 
            return true;
        else
            return false;
      }
      set;
    }
}