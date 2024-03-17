
public interface ISObjectUnitOfWork {

    void commitInsert(List<SObject> sObjs);
    void commitUpdate(List<SObject> sObjs);

    void doInsert(List<SObject> sObjs);
    void doUpdate(List<SObject> sObjs);
}