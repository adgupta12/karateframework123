@All @WS002 @WS002_TC001 @Store @LocationManagement @GetAllSlots
Feature: WS002_TC001_Store_LocationManagement_GetAllSlots_Success_ZoneId_D_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS002_TC001_<scenarioId>_Store_LocationManagement_GetAllSlots_Success_ZoneId_D_GET
  
Given url ws_url + '/Connect/v1/locmgmt/zones/D/slots'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.invocationResult.errors.errorCode == '000'
And match $.invocationResult.isSuccessful == 'true'
And match $.invocationResult.errors.errorDesc == 'Sucessfull'
And match $.invocationResult.result.zone == 'D'
* def slotList = $.invocationResult.result.slotList
* print 'No. of slots in zone -> D is ', slotList.length
* match each slotList == '#regex D[0-9]{3}'

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' |
| S002       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |


