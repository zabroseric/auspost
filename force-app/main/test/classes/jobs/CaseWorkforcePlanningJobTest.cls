
@IsTest
private class CaseWorkforcePlanningJobTest {

    @IsTest
    static void shouldStartWithAValidNumberOfRecords()
    {
        CaseWorkforcePlanningJob planningJob = new CaseWorkforcePlanningJob(new CaseSelectorMultiple());
        System.assertEquals(CaseFactory.getRecords().size(), planningJob.start(null).size());
    }

    @IsTest
    static void shouldExecuteBatchCorrectlyAndUpdateRecords()
    {
        Test.setMock(HttpCalloutMock.class, new CaseWorkforcePlanningCalloutTest.WorkforcePlanningHttpSuccessMock());
        SObjectUnitOfWorkNone unitOfWorkNone = new SObjectUnitOfWorkNone();
        CaseService.caseSelector = new CaseSelectorMultiple();
        CaseService.unitOfWork = unitOfWorkNone;

        Test.startTest();
        new CaseWorkforcePlanningJob(new CaseSelectorMultiple()).execute(null);
        Test.stopTest();

        System.assertEquals(CaseFactory.getRecords().size(), unitOfWorkNone.records.size());
        System.assertEquals(CaseFactory.getRecords().size(), unitOfWorkNone.recordsCommitted.size());
    }

    private class SObjectUnitOfWorkNone implements ISObjectUnitOfWork {

        public List<SObject> records = new List<SObject>();
        public List<SObject> recordsCommitted = new List<SObject>();

        public ISObjectUnitOfWork newInstance()
        {
            return null;
        }

        public void doStage(SObject record)
        {
            records.add(record);
        }

        public void doStage(List<SObject> records)
        {
            records.addAll(records);
        }

        public void doCommit()
        {
            recordsCommitted.addAll(records);
        }
    }

    private class CaseSelectorMultiple implements ISObjectSelector {

        public SObjectType getSObjectType()
        {
            return Case.SObjectType;
        }

        public List<SObjectField> getSObjectFields()
        {
            return new List<SObjectField>();
        }

        public List<SObject> selectByIds(Set<Id> caseIds)
        {
            return CaseFactory.getRecords();
        }
    }
}