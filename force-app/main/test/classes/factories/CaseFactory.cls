
@IsTest
public class CaseFactory {

    public static Case getRecord()
    {
        return getRecords().get(0);
    }

    public static List<Case> getRecords()
    {
        return new List<Case>{
            new Case(Account_Name__c = 'Acc 1', OwnerId = '005000000000000001'),
            new Case(Account_Name__c = 'Acc 2', OwnerId = '005000000000000002'),
            new Case(Account_Name__c = 'Acc 3', OwnerId = '005000000000000003')
        };
    }

    public static CaseDomain.CaseModel getModel()
    {
        return getModels().get(0);
    }

    public static List<CaseDomain.CaseModel> getModels()
    {
        List<CaseDomain.CaseModel> models = new List<CaseDomain.CaseModel>();
        for (Case record : getRecords()) {
            models.add(new CaseDomain.CaseModel(record));
        }
        return models;
    }
}