
public abstract class SObjectSelector implements ISObjectSelector {

    abstract public SObjectType getSObjectType();
    abstract public List<SObjectField> getSObjectFields();

    protected List<SObject> internalSelectByIds(Set<Id> recordIds)
    {
        return Database.query(
            'SELECT ' + String.join(getSObjectFields(), ', ') + ' FROM ' + getSObjectType().toString() + ' WHERE Id IN :recordIds'
        );
    }
}