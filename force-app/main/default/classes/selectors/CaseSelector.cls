
public class CaseSelector extends SObjectSelector {

    public override Schema.SObjectType getSObjectType()
    {
        return Case.SObjectType;
    }

    public override List<Schema.SObjectField> getSObjectFields()
    {
        return new List<Schema.SObjectField> {
            Case.Id,
            Case.Account_Name__c,
            Case.OwnerId
        };
    }

    public List<Case> selectByIds(Set<Id> recordIds)
    {
        return (List<Case>) internalSelectByIds(recordIds);
    }
}