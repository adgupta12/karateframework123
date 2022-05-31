@All @WS011 @WS011_TC003 @Store @AuditPutaway
Feature: WS011_TC003_Store_Putaway_ConfirmPutaway_Success_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS011_TC003_<scenarioId>_Store_Putaway_ConfirmPutaway_Success_POST

* def consignmentId = '000023680'

* def reqBody = 
"""
{}

"""

Given url ws_url + '/Connect/v1/parcelputaway/consignment/'
And path consignmentId
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody
When method post
Then status 200
And match $.invocationResult.isSuccessful == 'true'
And match $.invocationResult.errors.errorCode == '000'
And match $.invocationResult.errors.errorDesc == 'Success'
And match $.invocationResult.result == {}


Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' |
| S002       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |
 
