
public class CaseWorkforcePlanningCallout {

    private final Case record;
    private HttpResponse response;

    public CaseWorkforcePlanningCallout(Case record)
    {
        this.record = record;
    }

    public void send()
    {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://quiet-ridge-13235-3b829f8a42e5.herokuapp.com/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(JSON.serialize(new Map<String, Object>{
            'id' => this.record.Id,
            'business_name' => this.record.Account_Name__c,
            'agentid' => this.record.OwnerId
        }));

        this.response = new Http().send(request);

        if (Integer.valueOf(response.getStatusCode() / 100) == 5) {
            throw new HttpException('An server error occurred with response of: ' + response.getBody());
        }
    }

    public Map<String, Object> getResponseObject()
    {
        if (response == null) {
            return null;
        }
        return (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
    }

    public Object getResponseObjectValue(String key)
    {
        if (response == null) {
            return null;
        }
        return getResponseObject().get(key);
    }

    public String getResponseSecretKey()
    {
        return String.valueOf(getResponseObjectValue('secretKey'));
    }
}