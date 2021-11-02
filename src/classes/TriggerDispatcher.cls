public class TriggerDispatcher {
    public static void run(TriggerInterface handler, String triggerName){
        if(handler.isDisabled()){
            return;
        }
        Boolean isActive = true;
        if(isActive){
            switch on Trigger.operationType{
                when BEFORE_INSERT {
                    handler.beforeInsert(Trigger.new);
                }
                when AFTER_INSERT {
                    handler.afterInsert(Trigger.new, Trigger.newMap);
                }
                when BEFORE_UPDATE {
                    handler.beforeUpdate(Trigger.newMap, Trigger.oldMap);
                }
                when AFTER_UPDATE {
                    handler.afterUpdate(Trigger.newMap, Trigger.oldMap);
                }
                when BEFORE_DELETE {
                    handler.beforeDelete(Trigger.old, Trigger.oldMap);
                }
                when AFTER_DELETE {
                    handler.afterDelete(Trigger.oldMap);
                }
                when AFTER_UNDELETE {
                    handler.afterUnDelete(Trigger.new, Trigger.newMap);
                }
            }       
        }
    }
}