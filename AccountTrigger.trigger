trigger AccountTrigger on Account (before insert, before update, after update) {
    
    if(Trigger.isBefore){

        if(Trigger.isInsert){
            AccountTriggerHandler.updateAccountActive(Trigger.new);
        }

        if(Trigger.isUpdate){
            AccountTriggerHandler.updateCustomerPriority(Trigger.new);
        }
    }
   
    if(Trigger.isAfter){

        if(Trigger.isUpdate){
            AccountTriggerHandler.createTaskforAccount(Trigger.new, Trigger.oldMap);
        }
    }   
}
