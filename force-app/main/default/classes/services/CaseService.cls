
public with sharing class CaseService {

    @TestVisible
    private static ISObjectUnitOfWork unitOfWork = SObjectUnitOfWork.newInstance();

    @TestVisible
    private static ISObjectSelector caseSelector = new CaseSelector();

    public static void sendToWorkforcePlanning(Set<Id> recordIds)
    {
        CaseDomain caseDomain = CaseDomain.newInstance(caseSelector.selectByIds(recordIds), unitOfWork);

        for (Case record : caseDomain.getRecords()) {
            try {
                CaseWorkforcePlanningCallout workforcePlanningCallout = new CaseWorkforcePlanningCallout(record);
                workforcePlanningCallout.send();
                caseDomain.updateSecretKey(record.Id, workforcePlanningCallout.getResponseSecretKey());
            } catch (Exception e) {
                System.debug(LoggingLevel.ERROR, e.getMessage());
            }
        }

        unitOfWork.doCommit();
    }
}