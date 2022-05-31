@CreatePreAdvice_2Parcels
Feature: CreatePreAdvice_2Parcels

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
* print 'runDate -> ', runDate
* print 'runDate1 -> ', runDate1

Scenario Outline: CreatePreAdvice_2Parcels

* def clientID1 = 'MIS'
* def parcelType1 = 'B2C' 
* def parcelNumber1 = createRandomParcelNumber(clientID1)
* def parcelNumber2 = createRandomParcelNumber(clientID1)
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
 
* call read('classpath:UtilityFeatures/CreatePreAdvice_2Parcels_PreCondition.feature') { clientID: '#(clientID1)' , parcelType: '#(parcelType1)' , parcelNum1: '#(parcelNumber1)' , parcelNum2: '#(parcelNumber2)' , externalOrderNumber: '#(externalOrderNumber1)' , storeId: '#(storeId1)' , transactionID: '#(transactionID1)' , headerDate: '#(headerDate1)' , expectedDeliveryDate: '#(expectedDeliveryDate1)' , dateShipped: '#(dateShipped1)' , deliveryDateInjectionPoint: '#(deliveryDateInjectionPoint1)'  }

Examples:
| scenarioId | userId    | storeId | source  | clientId     | slotId | 
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | '001'  |

 

