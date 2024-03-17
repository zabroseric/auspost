
@IsTest
private class CaseServiceTest {

    @IsTest
    static void sendToWorkforcePlanningValidCount()
    {
        Test.setMock(HttpCalloutMock.class, new CaseWorkforcePlanningCalloutTest.WorkforcePlanningHttpSuccessMock());
        SObjectUnitOfWorkNone unitOfWorkNone = new SObjectUnitOfWorkNone();
        CaseService.caseSelector = new CaseSelectorMultiple();
        CaseService.unitOfWork = unitOfWorkNone;

        CaseService.sendToWorkforcePlanning(new Set<Id>());

        System.assertEquals(CaseFactory.getRecords().size(), unitOfWorkNone.records.size());
        System.assertEquals(CaseFactory.getRecords().size(), unitOfWorkNone.recordsCommitted.size());
        System.assertEquals(CaseFactory.getRecords().size(), unitOfWorkNone.countRecordsCommittedWithAgentId());
    }

    @IsTest
    static void sendToWorkforcePlanningOneFailureRestCreated()
    {
        Test.setMock(HttpCalloutMock.class, new WorkforcePlanningHttpOneFailureMock());
        SObjectUnitOfWorkNone unitOfWorkNone = new SObjectUnitOfWorkNone();
        CaseService.caseSelector = new CaseSelectorMultiple();
        CaseService.unitOfWork = unitOfWorkNone;

        CaseService.sendToWorkforcePlanning(new Set<Id>());

        System.assertEquals(CaseFactory.getRecords().size() - 1, unitOfWorkNone.records.size());
        System.assertEquals(CaseFactory.getRecords().size() - 1, unitOfWorkNone.recordsCommitted.size());
        System.assertEquals(CaseFactory.getRecords().size() - 1, unitOfWorkNone.countRecordsCommittedWithAgentId());
    }

    @IsTest
    static void sendToWorkforcePlanningAllFailed()
    {
        Test.setMock(HttpCalloutMock.class, new CaseWorkforcePlanningCalloutTest.WorkforcePlanningHttpServerErrorMock());
        SObjectUnitOfWorkNone unitOfWorkNone = new SObjectUnitOfWorkNone();
        CaseService.caseSelector = new CaseSelectorMultiple();
        CaseService.unitOfWork = unitOfWorkNone;

        CaseService.sendToWorkforcePlanning(new Set<Id>());

        System.assertEquals(0, unitOfWorkNone.records.size());
        System.assertEquals(0, unitOfWorkNone.recordsCommitted.size());
        System.assertEquals(0, unitOfWorkNone.countRecordsCommittedWithAgentId());
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

        public Integer countRecordsCommittedWithAgentId()
        {
            Integer count = 0;
            for (SObject record: records) {
                if (((Case) record).Description == 'secret key') {
                    count++;
                }
            }
            return count;
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

    public class WorkforcePlanningHttpOneFailureMock implements HttpCalloutMock {
        Boolean hasFailed = false;

        public HttpResponse respond(HttpRequest req)
        {
            if (!hasFailed) {
                hasFailed = true;
                return new CaseWorkforcePlanningCalloutTest.WorkforcePlanningHttpServerErrorMock().respond(req);
            }
            return new CaseWorkforcePlanningCalloutTest.WorkforcePlanningHttpSuccessMock().respond(req);
        }
    }
}