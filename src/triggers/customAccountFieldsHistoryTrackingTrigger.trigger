trigger customAccountFieldsHistoryTrackingTrigger on Account (after update) {
      List<Schema.FieldSetMember> trackedFields = 
        SObjectType.Account.FieldSets.HistoryTracking.getFields(); 
     
	if (trackedFields.isEmpty()) return;
    
      List<Custom_Account_Track__c> fieldChanges = new List<Custom_Account_Track__c>();

    if(!trigger.isUpdate)
        return;

    
    Map<String, Object> testMap = new Map<String, Object>();
    for(Account newAccount : Trigger.new){
        Account oldAccount = trigger.oldMap.get(newAccount.id);
        
        for(Schema.FieldSetMember fsm : trackedFields){
            String fieldName  = fsm.getFieldPath();
            String fieldLabel = fsm.getLabel();
            
            if (newAccount.get(fieldName) == oldAccount.get(fieldName))
                continue;
            
            Object oldAccountFildsObj = oldAccount.get(fieldName);
            
            if(oldAccount.id == newAccount.id){
                testMap.put(fieldLabel, oldAccountFildsObj);
                
            }
        }
         
        Integer randomNumber = Integer.valueof((Math.random() * 10));
        
         Custom_Account_Track__c customAccountTrack = new Custom_Account_Track__c();
            customAccountTrack.Name = randomNumber + ' account history';
            customAccountTrack.Custom_Fields_History_Tracking__c = JSON.serialize(testMap);
            fieldChanges.add(customAccountTrack);
       
    }
    
      if (!fieldChanges.isEmpty()) {
        insert fieldChanges;
    }
}