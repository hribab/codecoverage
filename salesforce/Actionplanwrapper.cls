public class Actionplanwrapper
  {
  
  public ID ActionplanID{get;set;}
         public boolean Complete{get;set;}
         public String Description{get;set;}
         public String Owner{get;set;}
         public String Activity{get;set;}
         public Date target{get;set;}
         public ID sales_aid{get;set;}
         public Integer index{get;set;}
         public Salesaid_Action_Plan__c SAP;
         public Actionplanwrapper(Salesaid_Action_Plan__c SAP)  
         {
         ActionplanID=SAP.id;
         Complete=SAP.Complete__c;
         Description=SAP.Description__c;
         Owner=SAP.Owner__c;
         Activity=SAP.Proposed_Activity__c;
         target=SAP.target_Date__c;
         
         }
      public  Actionplanwrapper(Integer i)
      {
      index=i;
      SAP=new Salesaid_Action_Plan__c();
      SAP.rownumber__c=i+1;
      }   
         
  }