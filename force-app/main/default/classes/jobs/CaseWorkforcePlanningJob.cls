
public with sharing class CaseWorkforcePlanningJob implements Schedulable, Database.Batchable<Case>, Database.AllowsCallouts {

    private final ISObjectSelector sObjectSelector;

    public void execute(SchedulableContext schedulableContext)
    {
        Database.executeBatch(new CaseWorkforcePlanningJob(sObjectSelector != null ? sObjectSelector : new CaseSelector()), 10);
    }

    @TestVisible
    private CaseWorkforcePlanningJob(ISObjectSelector sObjectSelector)
    {
        this.sObjectSelector = sObjectSelector;
    }

    public List<Case> start(Database.BatchableContext batchableContext)
    {
        // TODO: Should be replaced with a query that selects records that should be queried.
        return this.sObjectSelector.selectByIds(new Set<Id>());
    }

    public void execute(Database.BatchableContext batchableContext, List<Case> records)
    {
        CaseService.sendToWorkforcePlanning(new Map<Id, Case>(records).keySet());
    }

    public void finish(Database.BatchableContext param1)
    {
    }
}