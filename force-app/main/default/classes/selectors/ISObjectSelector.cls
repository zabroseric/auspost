
public interface ISObjectSelector {

    Schema.SObjectType getSObjectType();
    List<Schema.SObjectField> getSObjectFields();

    List<SObject> selectByIds(Set<Id> caseIds);
}