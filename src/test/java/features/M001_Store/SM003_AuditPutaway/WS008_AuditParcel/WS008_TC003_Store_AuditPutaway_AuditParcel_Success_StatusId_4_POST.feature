@All @WS008 @WS008_TC003 @Store @AuditPutaway @AuditParcel @ignore
Feature: WS008_TC003_Store_AuditPutaway_AuditParcel_Success_StatusId_4_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS008_TC003_<scenarioId>_Store_AuditPutaway_AuditParcel_Success_StatusId_4_POST
 
#* def parcelNumber1 = getB2CParcelNumberTNAS(<storeId>,'4','1','TNAS')
* def parcelNumber1 = getB2CParcelNumber(<storeId>,'4','1','vn0hwvq')
* print 'parcelNumber -> ', parcelNumber1
* def zoneId1 = 'D'
* def slotId1 = '001'
* def storeId1 = <storeId>
* def source1 = <source>
* def userId1 = <userId>
* def clientId1 = <clientId>
* call read('classpath:UtilityFeatures/ParcelPutaway_PreCondition.feature') { parcelNumber: '#(parcelNumber1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' , zoneId: '#(zoneId1)' , slotId: '#(slotId1)' }
#* def slotId1 = getSlotId(<storeId>,parcelNumber1)  

* def reqBody = 
"""
{}

"""
 
Given url ws_url + '/Connect/v1/parcelputaway/audit/'
And path zoneId1, zoneId1 + slotId1, parcelNumber1
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
And match $.invocationResult.errors.errorDesc == 'Undamaged Parcel In Expected Location'
And match $.invocationResult.result.isCorrectLocation == 'true'
And match $.invocationResult.result.expectedMasterContainer == ''
And match $.invocationResult.result.expectedContainer == ''

Examples:
| scenarioId | userId    | storeId | source  | clientId     | 
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |
 
