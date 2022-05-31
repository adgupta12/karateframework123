@All @WS011 @WS011_TC002 @Store @ConfirmPutaway
Feature: WS011_TC002_Store_Putaway_ConfirmPutaway_Success_PendingPutaway_True_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS011_TC002_<scenarioId>_Store_Putaway_ConfirmPutaway_Success_PendingPutaway_True_GET

* def consignmentId = '001154563'
Given url ws_url + '/Connect/v1/parcelputaway/consignment/'
And path consignmentId
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.invocationResult.isSuccessful == 'true'
And match $.invocationResult.errors.errorCode == '000'
And match $.invocationResult.errors.errorDesc == 'Success'
And match $.invocationResult.result.pendingPutaway == 'true'
And match $.invocationResult.result.parcelList[0].parcelNumber == 'MISC093025907'
And match $.invocationResult.result.parcelList[0].clientName == 'Missguided'
And match $.invocationResult.result.parcelList[0].customerName == 'Test Automation'

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' |
| S002       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |
 
