
public with sharing class CaseWorkforcePlanningJob implements Database.Batchable<Case>, Database.AllowsCallouts {

    private final Set<Id> recordIds;

    public static void executeBatch(Set<Id> recordIds)
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
        for (Case record : records) {
            new CaseWorkforcePlanningCallout(case).sync();
        }

    }

    public void finish(Database.BatchableContext param1)
    {
    }
}