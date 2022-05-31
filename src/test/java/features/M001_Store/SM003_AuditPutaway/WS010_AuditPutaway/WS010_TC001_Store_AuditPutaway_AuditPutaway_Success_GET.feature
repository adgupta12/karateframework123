@All @WS010 @WS010_TC001 @Store @AuditPutaway @ignore
Feature: WS010_TC001_Store_AuditPutaway_AuditPutaway_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
* print 'runDate -> ', runDate
* print 'runDate1 -> ', runDate1

Scenario Outline: WS010_TC001_<scenarioId>_Store_AuditPutaway_AuditPutaway_Success_GET

#* def zoneId1 = 'D'
#* def slotId1 = <slotId>
#* def storeId1 = <storeId>
#* def source1 = <source>
#* def userId1 = <userId>
#* def clientId1 = <clientId> 
#* def parcelNumber1 = getB2CParcelNumberTNAS(<storeId>,'4','1','TNAS')
#* def parcelNumber1 = getB2CParcelNumber(<storeId>,'4','1','vn0hwvq')

* def clientID1 = 'MIS'
* def parcelType1 = 'B2C' 
* def parcelNumber1 = createRandomParcelNumber(clientID1)
* def externalOrderNumber1 = 'OR' + parcelNumber1
* def storeId1 = <storeId>
* def transactionID1 = 'TRAN' + parcelNumber1
* def headerDate1 = runDate1 + ' 17:45:09'
* def expectedDeliveryDate1 = runDate + ' 15:00:00'
* def dateShipped1 = runDate1 + ' 17:35:28'
* def deliveryDateInjectionPoint1 = runDate1 + ' 04:00:00'
* def zoneId1 = 'D'
* def source1 = <source>
* def userId1 = <userId>
* def clientId1 = <clientId>
* def slotId1 = <slotId>
 
* call read('classpath:UtilityFeatures/CreatePreAdvice_PreCondition.feature') { clientID: '#(clientID1)' , parcelType: '#(parcelType1)' , parcelNumber: '#(parcelNumber1)' , externalOrderNumber: '#(externalOrderNumber1)' , storeId: '#(storeId1)' , transactionID: '#(transactionID1)' , headerDate: '#(headerDate1)' , expectedDeliveryDate: '#(expectedDeliveryDate1)' , dateShipped: '#(dateShipped1)' , deliveryDateInjectionPoint: '#(deliveryDateInjectionPoint1)'  }


* call read('classpath:UtilityFeatures/CreateSlot_PreCondition.feature') { zoneId: '#(zoneId1)' , slotId: '#(slotId1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' }

* call read('classpath:UtilityFeatures/ParcelPutaway_PreCondition.feature') { parcelNumber: '#(parcelNumber1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' , zoneId: '#(zoneId1)' , slotId: '#(slotId1)' }

* call read('classpath:UtilityFeatures/AuditParcel_PreCondition.feature') { zoneId: '#(zoneId1)' , slotId: '#(slotId1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' , parcelNumber: '#(parcelNumber1)' }
 
Given url ws_url + '/Connect/v1/parcelputaway/audit/complete/'
And path zoneId1, zoneId1 + <slotId>
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
And match $.invocationResult.errors.errorDesc == 'Sucessfull'
And match $.invocationResult.result.isAuditComplete == 'true'
And match $.invocationResult.result.parcelCount == 0

* call read('classpath:UtilityFeatures/ParcelPutaway_PreCondition.feature') { parcelNumber: '#(parcelNumber1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' , zoneId: '#(zoneId1)' , slotId: '001' }

* call read('classpath:UtilityFeatures/DeleteSlot_PreCondition.feature') { zoneId: '#(zoneId1)' , slotId: '#(slotId1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' }

Examples:
| scenarioId | userId    | storeId | source  | clientId     | slotId | 
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | '222'  |
 
