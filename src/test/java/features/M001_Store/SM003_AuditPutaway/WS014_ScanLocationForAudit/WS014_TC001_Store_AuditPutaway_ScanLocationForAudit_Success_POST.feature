@All @WS014 @WS014_TC001 @Store @ScanLocationForAudit
Feature: WS014_TC001_Store_AuditPutaway_ScanLocationForAudit_Success_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS014_TC001_<scenarioId>_Store_AuditPutaway_ScanLocationForAudit_Success_POST

* def zoneId1 = 'D'
* def slotId1 = <slotId>
* def storeId1 = <storeId>
* def source1 = <source>
* def userId1 = <userId>
* def clientId1 = <clientId> 

* call read('classpath:UtilityFeatures/CreateSlot_PreCondition.feature') { zoneId: '#(zoneId1)' , slotId: '#(slotId1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' }
 
* def reqBody = 
"""
{}

"""

Given url ws_url + '/Connect/v1/parcelputaway/audit/start/'
And path zoneId1, zoneId1 + <slotId>
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
And match $.invocationResult.errors.errorDesc == 'Slot recognized'
And match $.invocationResult.result == {}

* call read('classpath:UtilityFeatures/DeleteSlot_PreCondition.feature') { zoneId: '#(zoneId1)' , slotId: '#(slotId1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' }

Examples:
| scenarioId | userId    | storeId | source  | clientId     | slotId | 
| S001       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | '222'  |
| S002       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | '222'  |
 
