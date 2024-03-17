
@IsTest
public class CaseWorkforcePlanningCalloutTest {

    @IsTest
    static void shouldReturnValidResponseObject()
    {
        Test.setMock(HttpCalloutMock.class, new WorkforcePlanningHttpSuccessMock());
        CaseWorkforcePlanningCallout workforcePlanningCallout = new CaseWorkforcePlanningCallout(CaseFactory.getModel());
        workforcePlanningCallout.send();

        System.assertEquals(workforcePlanningCallout.getResponseObject(), new Map<String, Object>{
            'success' => true,
            'secretKey' => 'secret key'
        });
    }

    @IsTest
    static void shouldReturnValidResponseValues()
    {
        Test.setMock(HttpCalloutMock.class, new WorkforcePlanningHttpSuccessMock());
        CaseWorkforcePlanningCallout workforcePlanningCallout = new CaseWorkforcePlanningCallout(CaseFactory.getModel());
        workforcePlanningCallout.send();

        System.assertEquals(workforcePlanningCallout.getResponseObjectValue('success'), true);
        System.assertEquals(workforcePlanningCallout.getResponseObjectValue('secretKey'), 'secret key');
    }

    @IsTest
    static void shouldReturnValidResponseSecretKey()
    {
        Test.setMock(HttpCalloutMock.class, new WorkforcePlanningHttpSuccessMock());
        CaseWorkforcePlanningCallout workforcePlanningCallout = new CaseWorkforcePlanningCallout(CaseFactory.getModel());
        workforcePlanningCallout.send();

        System.assertEquals(workforcePlanningCallout.getResponseSecretKey(), 'secret key');
    }

    @IsTest
    static void shouldThrowAnExceptionWithServer500()
    {
        Test.setMock(HttpCalloutMock.class, new WorkforcePlanningHttpServerErrorMock());
        CaseWorkforcePlanningCallout workforcePlanningCallout = new CaseWorkforcePlanningCallout(CaseFactory.getModel());

        try {
            workforcePlanningCallout.send();
            System.assert(false, 'Excepted to receive an exception to be thrown.');
        } catch (HttpException e) {
            // This is a valid response.
        } catch (Exception e) {
            System.assert(false, 'Excepted to receive an exception of type HttpException to be thrown.');
        }
    }

    @IsTest
    static void shouldReturnValidResponseObjectWithServer500()
    {
        Test.setMock(HttpCalloutMock.class, new WorkforcePlanningHttpServerErrorMock());
        CaseWorkforcePlanningCallout workforcePlanningCallout = new CaseWorkforcePlanningCallout(CaseFactory.getModel());

        try {
            workforcePlanningCallout.send();
            System.assert(false, 'Excepted to receive an exception to be thrown.');
        } catch (Exception e) {
            System.assertEquals(workforcePlanningCallout.getResponseObject(), new Map<String, Object>{
                'success' => false,
                'error' => 'error message'
            });
        }
    }

    @IsTest
    static void shouldReturnValidResponseObjectValuesWithServer500()
    {
        Test.setMock(HttpCalloutMock.class, new WorkforcePlanningHttpServerErrorMock());
        CaseWorkforcePlanningCallout workforcePlanningCallout = new CaseWorkforcePlanningCallout(CaseFactory.getModel());

        try {
            workforcePlanningCallout.send();
            System.assert(false, 'Excepted to receive an exception to be thrown.');
        } catch (Exception e) {
            System.assertEquals(workforcePlanningCallout.getResponseObjectValue('success'), false);
            System.assertEquals(workforcePlanningCallout.getResponseObjectValue('error'), 'error message');
        }
    }

    @IsTest
    static void shouldReturnValidResponseSecretKeyWithServer500()
    {
        Test.setMock(HttpCalloutMock.class, new WorkforcePlanningHttpServerErrorMock());
        CaseWorkforcePlanningCallout workforcePlanningCallout = new CaseWorkforcePlanningCallout(CaseFactory.getModel());

        try {
            workforcePlanningCallout.send();
            System.assert(false, 'Excepted to receive an exception to be thrown.');
        } catch (Exception e) {
            System.assertEquals(workforcePlanningCallout.getResponseSecretKey(), null);
        }
    }

    @IsTest
    static void shouldReturnValidResponseWithoutSend()
    {
        CaseWorkforcePlanningCallout workforcePlanningCallout = new CaseWorkforcePlanningCallout(CaseFactory.getModel());
        System.assertEquals(workforcePlanningCallout.getResponseObject(), null);
    }

    @IsTest
    static void shouldReturnValidResponseSecretKeyWithoutSend()
    {
        CaseWorkforcePlanningCallout workforcePlanningCallout = new CaseWorkforcePlanningCallout(CaseFactory.getModel());
        System.assertEquals(workforcePlanningCallout.getResponseSecretKey(), null);
    }

    public class WorkforcePlanningHttpSuccessMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req)
        {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"success":true,"secretKey":"secret key"}');
            res.setStatusCode(200);
            return res;
        }
    }

    public class WorkforcePlanningHttpServerErrorMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req)
        {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"success":false,"error":"error message"}');
            res.setStatusCode(500);
            return res;
        }
    }
}