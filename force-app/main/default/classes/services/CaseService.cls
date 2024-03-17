
public with sharing class CaseService {

    @TestVisible
    private static ISObjectUnitOfWork unitOfWork = SObjectUnitOfWork.newInstance();

    @TestVisible
    private static ISObjectSelector caseSelector = new CaseSelector();

    public static void sendToWorkforcePlanning(Set<Id> recordIds)
    {
        CaseDomain caseDomain = CaseDomain.newInstance(caseSelector.selectByIds(recordIds), unitOfWork);
        for (CaseDomain.CaseModel model : caseDomain.getModels()) {
            try {
                CaseWorkforcePlanningCallout workforcePlanningCallout = new CaseWorkforcePlanningCallout(model);
                workforcePlanningCallout.send();
                model.updateSecretKey(workforcePlanningCallout.getResponseSecretKey());
                unitOfWork.doStage(model.record);
            } catch (Exception e) {
                System.debug(LoggingLevel.ERROR, e.getMessage());
            }
        }
        unitOfWork.doCommit();
    }
}