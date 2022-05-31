@All @WS004 @WS004_TC004 @Store @LocationManagement @CreateSlot
Feature: WS004_TC004_Store_LocationManagement_CreateSlot_Success_MultipleSlots_printSlotFlag_N_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS004_TC004_<scenarioId>_Store_LocationManagement_CreateSlot_Success_MultipleSlots_printSlotFlag_N_POST

* def zoneId1 = <zoneId>
* def storeId1 = <storeId>
* def source1 = <source>
* def userId1 = <userId>
* def clientId1 = <clientId>
* def slotId1 = <slotId1>
* call read('classpath:UtilityFeatures/DeleteSlot_PreCondition.feature') { zoneId: '#(zoneId1)' , slotId: '#(slotId1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' }
* def slotId1 = <slotId2>
* call read('classpath:UtilityFeatures/DeleteSlot_PreCondition.feature') { zoneId: '#(zoneId1)' , slotId: '#(slotId1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' }
* def slotId1 = <slotId3>
* call read('classpath:UtilityFeatures/DeleteSlot_PreCondition.feature') { zoneId: '#(zoneId1)' , slotId: '#(slotId1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' }
 
* def reqBody = 
"""
{"printSlotFlag":"N"}

"""
 
Given url ws_url + '/Connect/v1/locmgmt/zones/'
And path <zoneId>, 'slots', <slotIdRange>
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody
When method post
Then status 200
And match $.invocationResult.errors.errorCode == '000'
And match $.invocationResult.isSuccessful == 'true'
And match $.invocationResult.errors.errorDesc == 'All Slots are created'
And match $.invocationResult.result.successSlotList[0] == ' ' + <zoneId> + <slotId1>
And match $.invocationResult.result.successSlotList[1] == ' ' + <zoneId> + <slotId2>
And match $.invocationResult.result.successSlotList[2] == ' ' + <zoneId> + <slotId3>
And match $.invocationResult.result.failedSlotList == []
 
Examples:
| scenarioId | userId    | storeId | source  | clientId     | zoneId | slotIdRange | slotId1 | slotId2 | slotId3 |
| S001       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'D'    | '217-219'   | '217'   | '218'   | '219'   |
| S002       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'R'    | '217-219'   | '217'   | '218'   | '219'   |
| S003       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'O'    | '217-219'   | '217'   | '218'   | '219'   |
| S004       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'D'    | '217-219'   | '217'   | '218'   | '219'   |
| S005       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'R'    | '217-219'   | '217'   | '218'   | '219'   |
| S006       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'O'    | '217-219'   | '217'   | '218'   | '219'   |

