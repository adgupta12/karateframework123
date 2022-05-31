@All @WS056 @WS056_TC002 @ToYou @DwellTime
Feature: WS056_TC002_ToYou_DwellTime_Success_POST

Background:
* print 'ws_toyou_url -> ', ws_toyou_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS056_TC002_<scenarioId>_ToYou_DwellTime_Success_POST


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

* call read('classpath:UtilityFeatures/ParcelPutaway_PreCondition.feature') { parcelNumber: '#(parcelNumber1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' , zoneId: '#(zoneId1)' , slotId: '#(slotId1)' }

* def wait1 = wait(10000)

Given url ws_toyou_url + '/toyou-app/services/rest/toyou/parcel'
And path parcelNumber1
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = 'GEC'
When method get
Then status 200
And match $.status == 'OK'
And match $.payload[0].parcelId == parcelNumber1
* def encOrderId = $.payload[0].encOrderId

* def reqBody = 
"""
{
	"encOrderId": #(encOrderId),
	"businessId": #(clientID1)
}

"""

Given url ws_toyou_url + '/toyou-app/services/rest/toyou/order/dwellTime'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = 'GEC'
And header source = 'GEC'
And request reqBody
When method post
Then status 200
And match $.status == 'OK'
And match $.payload[0].parcelId == parcelNumber1
And match $.payload[0].extendedDate == '#string'
And match $.errors == []

Examples:
| scenarioId | userId    | storeId | source  | clientId     | slotId |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | '001'  |

