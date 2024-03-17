
public class CaseWorkforcePlanningCallout {

    private final Case sObj;

    public CaseWorkforcePlanningCallout(Case sObj) {
        this.sObj = sObj;
    }

    public String sync() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://quiet-ridge-13235-3b829f8a42e5.herokuapp.com/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(JSON.serialize(new Map<String, Object>{
            'id' => this.sObj.Id,
            // TODO: Replace with the account name when the selector supports relationships.
            'business_name' => this.sObj.AccountId,
            'agentid' => this.sObj.LastModifiedById
        }));


        HttpResponse response = new Http().send(request);

        if (Integer.valueOf(response.getStatusCode()/100) == 4) {
            throw new HttpException('An client error occurred with response of: ' + response.getBody());
        }
        if (Integer.valueOf(response.getStatusCode()/100) == 5) {
            throw new HttpException('An server error occurred with response of: ' + response.getBody());
        }

        Map<String, Object> responseObject = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        return String.valueOf(responseObject.get('secretKey'));
    }
}