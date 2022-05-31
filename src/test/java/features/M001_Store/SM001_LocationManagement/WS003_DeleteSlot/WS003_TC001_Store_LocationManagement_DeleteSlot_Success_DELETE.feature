@All @WS003 @WS003_TC001 @Store @LocationManagement @DeleteSlot
Feature: WS003_TC001_Store_LocationManagement_DeleteSlot_Success_DELETE

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS003_TC001_<scenarioId>_Store_LocationManagement_DeleteSlot_Success_DELETE

* def zoneId1 = <zoneId>
* def slotId1 = <slotId>
* def storeId1 = <storeId>
* def source1 = <source>
* def userId1 = <userId>
* def clientId1 = <clientId>
* call read('classpath:UtilityFeatures/CreateSlot_PreCondition.feature') { zoneId: '#(zoneId1)' , slotId: '#(slotId1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' }
  
Given url ws_url + '/Connect/v1/locmgmt/zones/'
And path <zoneId>, 'slots', <zoneId> + <slotId>
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method delete
Then status 200
And match $.invocationResult.errors.errorCode == '000'
And match $.invocationResult.isSuccessful == 'true'
And match $.invocationResult.errors.errorDesc == 'Slot Deleted'
And match $.invocationResult.result == ' ' + <zoneId> + <slotId>

Examples:
| scenarioId | userId    | storeId | source  | clientId     | zoneId | slotId |
| S001       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'D'    | '210'  |
| S002       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'R'    | '210'  |
| S003       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'O'    | '210'  |
| S004       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'D'    | '210'  |
| S005       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'R'    | '210'  |
| S006       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'O'    | '210'  |


