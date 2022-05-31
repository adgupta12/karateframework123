@All @WS004 @WS004_TC001 @Store @LocationManagement @CreateSlot
Feature: WS004_TC001_Store_LocationManagement_CreateSlot_Success_printSlotFlag_Y_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS004_TC001_<scenarioId>_Store_LocationManagement_CreateSlot_Success_printSlotFlag_Y_POST
  
* def zoneId1 = <zoneId>
* def slotId1 = <slotId>
* def storeId1 = <storeId>
* def source1 = <source>
* def userId1 = <userId>
* def clientId1 = <clientId>
* call read('classpath:UtilityFeatures/DeleteSlot_PreCondition.feature') { zoneId: '#(zoneId1)' , slotId: '#(slotId1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' }

* def reqBody = 
"""
{"printSlotFlag":"Y"}

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
And match $.invocationResult.errors.errorDesc == 'Sucessfull'
And match $.invocationResult.result.successSlotList[0].labelNumber == <zoneId> + <slotId>
* def labelImageCode = $.invocationResult.result.successSlotList[0].labelImageCode
And match labelImageCode == '#regex [A-Za-z0-9+=\\/]+'
* def decodedLabelImageCode = decodeBase64Barcode(labelImageCode)
And match decodedLabelImageCode == <zoneId> + <slotId>
And match $.invocationResult.result.failedSlotList == []
 
Examples:
| scenarioId | userId    | storeId | source  | clientId     | zoneId | slotId |
| S001       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'D'    | '112'  |
| S002       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'R'    | '112'  |
| S003       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'O'    | '112'  |
| S004       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'D'    | '112'  |
| S005       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'R'    | '112'  |
| S006       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'O'    | '112'  |

