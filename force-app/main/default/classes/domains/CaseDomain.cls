
public with sharing class CaseDomain {

    private final List<Case> records;
    private final ISObjectUnitOfWork unitOfWork;

    private CaseDomain(List<Case> records, ISObjectUnitOfWork unitOfWork)
    {
        this.records = records;
        this.unitOfWork = unitOfWork;
    }

    public static CaseDomain newInstance(List<Case> records, ISObjectUnitOfWork unitOfWork)
    {
        return new CaseDomain(records, unitOfWork);
    }

    public List<Case> getRecords()
    {
        return records;
    }

    public void updateSecretKey(Id recordId, String secretKey)
    {
        for (Case record : getRecords()) {
            if (record.Id == recordId) {
                record.Description = secretKey;
                unitOfWork.doStage(record);
                return;
            }
        }
    }
}