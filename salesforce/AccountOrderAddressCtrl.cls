public class AccountOrderAddressCtrl {
    public Address__c accountAdd {get;set;}
    public List<wrapperAcountAddress> accountAddresses {get;set;}  
    public wrapperAcountAddress objAccountAddress {get;set;}
    public List<AddresWrap> addressWrap {get;set;}
    public addressWrapperCls.Results  addressResult {get;set;}
    public List<addressWrapperCls.ResultDataSet> resData {get;set;}
    public string selectedValue {get;set;}
    public Boolean showCreateNewPopupFlag {get;set;}
    public string statusCode {get;set;}
    public String popupTitle {get;set;}
    public Id accId {get;set;}
    public integer index {get;set;}
    
    public AccountOrderAddressCtrl(ApexPages.StandardController stdCtrl){
        accId = ApexPages.currentPage().getParameters().get('ids');
        system.debug('accId****** '+accId);
        set<Id> accIds = new Set<Id>();
        accIds.add(accId);
        accountAdd = new Address__c();
        accountAddresses = new List<wrapperAcountAddress>();
        objAccountAddress = new wrapperAcountAddress();
        addressWrap = new List<AddresWrap>();
        addressResult  = new addressWrapperCls.Results ();
        resData = new List<addressWrapperCls.ResultDataSet>();
        for(Address__c eachAddress :[SELECT Account__c, Address_Line_1__c,Address_line_3__c, Address_Line_2__c, Address_Name__c, Type__c, City__c, Country__c, 
                                     State__c, Account__r.Name, Zipcode__c, Address_Type__c
                                     FROM Address__c WHERE Account__c IN: accIds]){
                                         wrapperAcountAddress accountAddress = new wrapperAcountAddress();
                                         accountAddress.address = eachAddress;
                                         accountAddress.check = false;
                                         accountAddress.recordId = eachAddress.id;
                                         accountAddresses.add(accountAddress);
                                     } 
    }
    public void hideCreateNewPopup(){       
        showCreateNewPopupFlag = false;
    }
    public pageReference createNewAddress(){
        system.debug('createNewAddress ** '+selectedValue);
        if(string.isBlank(selectedValue)){
            showCreateNewPopupFlag = true;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, + ' Please select either End User or Sold To to save the address'));
            return null;
        }else{
            system.debug('createNewAddress ** '+selectedValue);
            system.debug('accountAddresses ** '+accountAddresses);
            boolean isAddressAvailable = false;
            for(wrapperAcountAddress eachAccountAddress : accountAddresses){
                //Address__c objAddress = new Address__c();
                if(accountAdd.Address_Line_1__c  == eachAccountAddress.address.Address_Line_1__c && 
                   accountAdd.Address_Line_2__c  == eachAccountAddress.address.Address_Line_2__c && 
                   accountAdd.City__c  == eachAccountAddress.address.City__c && 
                   accountAdd.State__c  == eachAccountAddress.address.State__c && 
                   accountAdd.Country__c  == eachAccountAddress.address.Country__c && 
                   accountAdd.Zipcode__c  == eachAccountAddress.address.Zipcode__c && 
                   accountAdd.Type__c  == eachAccountAddress.address.Type__c){
                       isAddressAvailable = true;
                       break;
                   }
            }
            system.debug('isAddressAvailable ** '+isAddressAvailable);
            if(isAddressAvailable){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, accountAdd.Type__c + ' address is already added, Please refer to available addresses.'));
            	return null;
            }
            else{            
                
                accountAdd.Account__c=accId;
            }
            system.debug('statusCode*********'+statusCode);
            if(string.isNotBlank(statusCode)){
                if(statusCode =='V4' || statusCode =='C4' || statusCode =='V3' || statusCode =='C3'){
                    accountAdd.Validity_Status__c = 'Valid';
                }
                else{
                    accountAdd.Validity_Status__c = 'Not Valid';
                } 
            }else{
                accountAdd.Validity_Status__c = 'Not Valid';
            }
            INSERT accountAdd;
            if(!isAddressAvailable){
                pagereference pr = new pagereference('/' + accId);
                return pr;
            }
            
            return null;
        }
        //return null;
    }
    public  void getAddress(){
        
        string strAddressLine1 =accountAdd.Address_Line_1__c;
        strAddressLine1 =EncodingUtil.urlEncode(strAddressLine1, 'UTF-8').replace('+', '%20') ;
        
        string strAddressLine2=accountAdd.Address_Line_2__c;
        strAddressLine2 =EncodingUtil.urlEncode(strAddressLine2, 'UTF-8').replace('+', '%20') ;
        
        string strCity=accountAdd.City__c;
        strCity =EncodingUtil.urlEncode(strCity, 'UTF-8').replace('+', '%20') ;
        
        string strState=accountAdd.State__c;
        strState =EncodingUtil.urlEncode(strState, 'UTF-8').replace('+', '%20') ;
        
        string strcountry=accountAdd.Country__c;
        strcountry =EncodingUtil.urlEncode(strcountry, 'UTF-8').replace('+', '%20') ;
        
        string strPostalCode =accountAdd.Zipcode__c;
        
        string endPoint = 'https://rest-adcloud.informaticadaas.com/adcloud/verifyaddress?login=166534&password=Digital504&processmode=FASTCOMPLETION&'
            +'&DeliveryAddressLines='+strAddressLine1+
            +'&SubBuilding='+strAddressLine2+
            +'&Locality='+strCity+
            +'&Province='+strState+
            +'&country='+strcountry+
            +'&PostalCode='+strPostalCode;
        try{
            HttpRequest req1 = new HttpRequest();
            HttpResponse res1 = new HttpResponse();
            Http http1 = new Http();
            req1.setMethod('GET');
            req1.setHeader('Content-Type', 'application/json;');
            req1.setEndpoint(endPoint);
            //req1.setCompressed(true);
            res1 = http1.send(req1);
            system.debug('result*****'+res1.getStatusCode());
            if (res1.getStatusCode() == 200) {
                
                
                addressWrapperCls objAddress = (addressWrapperCls)JSON.deserialize(res1.getbody(), addressWrapperCls.Class);
                system.debug('objAddress** '+objAddress);
                if(objAddress != null){
                    addressResult = objAddress.Results[0];
                    system.debug('addressResult** '+addressResult.ResultDataSet);
                    if(addressResult.ResultDataSet !=null){ 
                        resData = addressResult.ResultDataSet;
                        statusCode = objAddress.Results[0].ProcessStatus;
                        system.debug('statusCode&&&&&& '+statusCode);
                    }else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,+ ' No address found with the given details.Please redefine your search'));
                        return; 
                    }
                    system.debug('resData** '+resData);
                }else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,+ 'No address found with the given details.Please redefine your search'));
                    return;
                }
                
                for(addressWrapperCls.ResultDataSet  AWR : resData ){
                    AddresWrap addWrap = new AddresWrap();                
                    addWrap.isSelect = false;
                    addWrap.Wrapaddress.Address_Line_1__c  = AWR.Address.DeliveryAddressLines[0];
                    addWrap.Wrapaddress.Address_Line_2__c  = AWR.Address.SubBuilding[0];
                    addWrap.Wrapaddress.City__c  = AWR.Address.Province[0];
                    addWrap.Wrapaddress.State__c  = AWR.Address.Locality[0];
                    addWrap.Wrapaddress.Country__c  = AWR.Address.Country[0];
                    addWrap.Wrapaddress.Zipcode__c  = AWR.Address.PostalCode[0];
                    addressWrap.add(addWrap);
                }
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,+ ' An error occured.Please try again later'));
                
            }
        }
        catch(Exception ex){
            system.debug('exce in fetching **'+ex);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,+ ' Please provide valid information to fetch the address details'));
            AddresWrap addWrap = new AddresWrap();
        }
        
    }
    public pageReference reflectSelAddress(){
        //system.debug('index is **'+index);
        integer indexVal = Integer.valueof(system.currentpagereference().getparameters().get('index')); 
        system.debug('index is **'+indexVal);
        for(integer i=0; i < addressWrap.size(); i++){
            if(i == indexVal - 1){
                addressWrap[i].isSelect = true;
                system.debug('addressWrap[i] **'+addressWrap[i]);
            }
            else{
                addressWrap[i].isSelect = false;
            }
        }
        for(AddresWrap   AWs  : addressWrap ){             
            if(Aws.isSelect){
                system.debug('AW****'+Aws.isSelect);
                accountAdd = new Address__c();
                accountAdd.Address_Line_1__c = AWs.Wrapaddress.Address_Line_1__c ;
                accountAdd.Address_Line_2__c =   AWs.Wrapaddress.Address_Line_2__c ;
                accountAdd.City__c = AWs.Wrapaddress.City__c; 
                accountAdd.State__c = AWs.Wrapaddress.State__c ;
                accountAdd.Country__c = AWs.Wrapaddress.Country__c; 
                accountAdd.Zipcode__c  =  AWs.Wrapaddress.Zipcode__c ;
                //accountAdd.Validity_Status__c='Valid';
            }
        }
        system.debug('accountAdd****'+accountAdd);
        return null;
    }
    public class wrapperAcountAddress{
        public Boolean check {get;set;}
        public Id recordId {get;set;}
        public  Address__c address {get;set;} 
        public boolean isSelected {get;set;}
        
        public wrapperAcountAddress(){
            if(address ==null) address = new Address__c(); 
        }
    }
    
    public class AddresWrap{
        public boolean isSelect {get;set;}
        public  Address__c Wrapaddress {get;set;}
        public AddresWrap(){
            if(Wrapaddress ==null) Wrapaddress = new Address__c(); 
        }
        
    }
}