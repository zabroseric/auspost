/**
 * Created by shaun on 15/03/24.
 */

public with sharing class CaseDomain {

    private final List<CaseModel> models = new List<CaseModel>();
    private final ISObjectUnitOfWork unitOfWork;

    private CaseDomain(List<Case> models, ISObjectUnitOfWork unitOfWork)
    {
        for (Case record : models) {
            this.models.add(new CaseModel(record));
        }
        this.unitOfWork = unitOfWork;
    }

    public static CaseDomain newInstance(List<Case> records, ISObjectUnitOfWork unitOfWork)
    {
        return new CaseDomain(records, unitOfWork);
    }

    public List<CaseModel> getModels()
    {
        return models;
    }

    public class CaseModel {
        public final Case record { get; private set; }

        public CaseModel(Case record)
        {
            this.record = record;
        }

        public void updateSecretKey(String secretKey)
        {
            this.record.Description = secretKey;
        }
    }
}