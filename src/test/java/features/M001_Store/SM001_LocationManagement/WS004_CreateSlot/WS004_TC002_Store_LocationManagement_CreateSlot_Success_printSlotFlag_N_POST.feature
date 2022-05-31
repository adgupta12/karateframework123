@All @WS004 @WS004_TC002 @Store @LocationManagement @CreateSlot
Feature: WS004_TC002_Store_LocationManagement_CreateSlot_Success_printSlotFlag_N_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS004_TC002_<scenarioId>_Store_LocationManagement_CreateSlot_Success_printSlotFlag_N_POST

* def zoneId1 = <zoneId>
* def slotId1 = <slotId>
* def storeId1 = <storeId>
* def source1 = <source>
* def userId1 = <userId>
* def clientId1 = <clientId>
* call read('classpath:UtilityFeatures/DeleteSlot_PreCondition.feature') { zoneId: '#(zoneId1)' , slotId: '#(slotId1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' }
 
* def reqBody = 
"""
{"printSlotFlag":"N"}

"""
 
Given url ws_url + '/Connect/v1/locmgmt/zones/'
And path <zoneId>, 'slots', <slotId>
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
And match $.invocationResult.result.successSlotList[0] == ' ' + <zoneId> + <slotId>
And match $.invocationResult.result.failedSlotList == [] 

Examples:
| scenarioId | userId    | storeId | source  | clientId     | zoneId | slotId |
| S001       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'D'    | '113'  |
| S002       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'R'    | '113'  |
| S003       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'O'    | '113'  |
| S004       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'D'    | '113'  |
| S005       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'R'    | '113'  |
| S006       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'O'    | '113'  |

