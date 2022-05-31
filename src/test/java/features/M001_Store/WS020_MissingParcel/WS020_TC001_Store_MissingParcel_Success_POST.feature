@All @WS020 @WS020_TC001 @Store @MissingParcel
Feature: WS020_TC001_Store_MissingParcel_Success_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS020_TC001_<scenarioId>_Store_MissingParcel_Success_POST

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
* def slotId1 = '001'
 
* call read('classpath:UtilityFeatures/CreatePreAdvice_PreCondition.feature') { clientID: '#(clientID1)' , parcelType: '#(parcelType1)' , parcelNumber: '#(parcelNumber1)' , externalOrderNumber: '#(externalOrderNumber1)' , storeId: '#(storeId1)' , transactionID: '#(transactionID1)' , headerDate: '#(headerDate1)' , expectedDeliveryDate: '#(expectedDeliveryDate1)' , dateShipped: '#(dateShipped1)' , deliveryDateInjectionPoint: '#(deliveryDateInjectionPoint1)'  }

* call read('classpath:UtilityFeatures/ParcelPutaway_PreCondition.feature') { parcelNumber: '#(parcelNumber1)' , storeId: '#(storeId1)' , source: '#(source1)' , userId: '#(userId1)' , clientId: '#(clientId1)' , zoneId: '#(zoneId1)' , slotId: '#(slotId1)' }


* def reqBody = 
"""
{
	"missingParcel":{
		"orderId":"",
		"moduleName":"Return",
		"parcelList":[#(parcelNumber1)]
	}
}
"""

Given url ws_url + '/Connect/v1/missingparcel'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload == {}
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

