
public with sharing class CaseWorkforcePlanningJob implements Schedulable, Database.Batchable<Case>, Database.AllowsCallouts {

    private final Set<Id> recordIds;

    public void execute(SchedulableContext schedulableContext)
    {
        Database.executeBatch(new CaseWorkforcePlanningJob(recordIds), 10);
    }

    private CaseWorkforcePlanningJob(Set<Id> recordIds)
    {
        this.recordIds = recordIds;
    }

    public List<Case> start(Database.BatchableContext batchableContext)
    {
        return new CaseSelector().selectByIds(recordIds);
    }

    public void execute(Database.BatchableContext batchableContext, List<Case> records)
    {
        CaseService.sendToWorkforcePlanning(new Map<Id, Case>(records).keySet());
    }

    public void finish(Database.BatchableContext param1)
    {
    }
}