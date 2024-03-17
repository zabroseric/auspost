/**
 * Created by shaun on 15/03/24.
 */

public with sharing class CaseDomain {

    private final List<Case> sObjs;
    private final ISObjectUnitOfWork unitOfWork;

    public static CaseDomain newInstance(List<Case> sObjs, ISObjectUnitOfWork unitOfWork)
    {
        return new CaseDomain(sObjs, unitOfWork);
    }

    private CaseDomain(List<Case> sObjs, ISObjectUnitOfWork unitOfWork)
    {
        this.sObjs = sObjs;
        this.unitOfWork = unitOfWork;
    }

    public void updateSecretKey(String secretKey)
    {
        for (Case sObj : this.sObjs) {
            // TODO: Create field to store the secret key.
            sObj.Description = secretKey;
        }

        this.unitOfWork
    }

    public void doUpdate() {
        this.unitOfWork.doUpdate(this.sObjs);
    }
}