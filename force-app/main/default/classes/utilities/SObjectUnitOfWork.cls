
public class SObjectUnitOfWork implements ISObjectUnitOfWork {

    final List<SObject> records = new List<SObject>();

    private SObjectUnitOfWork()
    {

    }

    public static ISObjectUnitOfWork newInstance()
    {
        return new SObjectUnitOfWork();
    }

    public void doStage(List<SObject> records)
    {
        records.addAll(records);
    }

    public void doStage(SObject record)
    {
        records.add(record);
    }

    public void doCommit()
    {
        List<SObject> recordsInsert = new List<SObject>();
        List<SObject> recordsUpdate = new List<SObject>();

        for (SObject record : this.records) {
            if (record.Id == null) {
                recordsInsert.add(record);
            } else {
                recordsUpdate.add(record);
            }
        }

        Savepoint savepoint = Database.setSavepoint();
        try {
            Database.insert(recordsInsert);
            Database.update(recordsUpdate);
        } catch (Exception e) {
            Database.rollback(savepoint);
            throw e;
        }
    }
}