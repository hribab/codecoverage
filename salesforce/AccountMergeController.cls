public class AccountMergeController{
    public Account fromAccount {get
                                { if(fromAccount!=null && fromAccount.Name!=''){
                                    List<Account> accts = [Select Id, Name from Account where Name Like :fromAccount.Name];
                                    if(accts.size() == 1)
                                        fromAccount = accts[0];
                                  }
                                 return fromAccount;
                                }
                                set;}
    public Account toAccount {get
                                { if(fromAccount!=null && fromAccount.Name!=''){
                                    List<Account> accts = [Select Id, Name from Account where Name Like :toAccount.Name];
                                    if(accts.size() == 1)
                                        toAccount = accts[0];
                                  }
                                 return toAccount;
                                }
                                set;}
	public string fields {get{
    							return 'id,name,billingstreet,billingcity,billingpostalcode' ;}set;}
    public List<Util.Wrappers> opportunityWrappers {get; set;}
    public List<Util.Wrappers> caseWrappers {get; set;}
    public List<Util.Wrappers> ContactWrappers {get; set;}
    
    public AccountMergeController(){
        system.debug(fromAccount);
        fromAccount = new Account();
        toAccount = new Account();
        init();
    }
    
    public PageReference findRelatedRecords(){
        init();
        for(Opportunity opp : [Select Id, Name, StageName from Opportunity where accountId =: fromAccount.Id limit 10]){
            opportunityWrappers.add( new Util.Wrappers(opp));
        }
        
        for(Contact con : [Select Id, Name from Contact where accountId =: fromAccount.Id limit 10]){
            contactWrappers.add( new Util.Wrappers(con) );
        }
        
        for(Case c : [Select Id from Case where accountId =: fromAccount.Id limit 10]){
            caseWrappers.add( new Util.Wrappers(c) );
        }
        return null;
    }
    
    public PageReference moveLeft(){
        for(Util.Wrappers w : opportunityWrappers){
            if(w.isSelected){
                w.isMoved=true;
            }
        }
        
        return null;    
    }
    
    public PageReference moveRight(){
        for(Util.Wrappers w : opportunityWrappers){
            if(w.isSelected){
                w.isMoved=false;
            }
        }
        
        return null;    
    }
    public PageReference mergeSelected() {
        return null;
    }
    
    public void init(){
        opportunityWrappers = new List<Util.Wrappers>();
        caseWrappers = new List<Util.Wrappers>();
        contactWrappers = new List<Util.Wrappers>();
    }
}