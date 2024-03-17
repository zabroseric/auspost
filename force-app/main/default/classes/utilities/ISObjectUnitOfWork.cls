
public interface ISObjectUnitOfWork {

    ISObjectUnitOfWork newInstance();

    void doStage(SObject record);
    void doStage(List<SObject> records);
    void doCommit();
}