/**
 * Created by shaun on 15/03/24.
 */

trigger CaseTrigger on Case (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    new CaseTriggerHandler(Trigger.new, Trigger.oldMap).execute(Trigger.operationType);
}