public with sharing class AccountTriggerHandler {

    public static void updateAccountActive(List<Account> newAccounts){
        // update the account active field to yes for new accounts inserted
        for(Account acc : newAccounts){
           acc.Active__c = 'Yes';
        }

        //Don't need dml operation here because it is before the record is saved to the database
    }

    public static void updateCustomerPriority(List<Account> newAccounts){
        // update the customer priority field to high when the sla is gold
        for(Account acc : newAccounts){
                
            if(acc.sla__c == 'Gold'){
                acc.CustomerPriority__c = 'High';
            }
        }

        //Don't need dml operation here because it is before the record is saved to the database
    }

    public static void createTaskforAccount(List<Account> newAccounts, Map<Id, Account> oldAccounts){
        // create a task for the account when the account is updated from warm to hot
        List<Task> taskList = new List<Task>();

        for(Account acc : newAccounts){
            if(acc.Rating == 'Hot' && oldAccounts.get(acc.Id).Rating == 'Warm'){
                Task t = new Task();
                t.WhatId = acc.Id;
                t.Subject = 'Account Rating Updated';
                t.Status = 'Not Started';
                t.Priority = 'High';
                taskList.add(t);
            }
        }

        if(!taskList.isEmpty()){
            insert taskList;
        }
    }
}
