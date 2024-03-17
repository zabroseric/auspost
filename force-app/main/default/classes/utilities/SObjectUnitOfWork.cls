
public class SObjectUnitOfWork implements ISObjectUnitOfWork {

    public static void doInsert(List<SObject> sObjs)
    {
        Database.insert(sObjs);
    }

    public static void doUpdate(List<SObject> sObjs)
    {
        Database.update(sObjs);
    }
}