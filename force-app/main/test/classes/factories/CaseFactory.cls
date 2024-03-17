
@IsTest
public class CaseFactory {

    public static Case getRecord()
    {
        return getRecords().get(0);
    }

    public static List<Case> getRecords()
    {
        return new List<Case>{
            new Case(Id = '500000000000000001', Account_Name__c = 'Acc 1', OwnerId = '005000000000000001'),
            new Case(Id = '500000000000000002', Account_Name__c = 'Acc 2', OwnerId = '005000000000000002'),
            new Case(Id = '500000000000000003', Account_Name__c = 'Acc 3', OwnerId = '005000000000000003')
        };
    }
}