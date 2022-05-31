@All @WS044 @WS044_TC001 @CDM @GenerateQRCode
Feature: WS044_TC001_CDM_GenerateQRCode_Success_QRinSMS_Y_POST

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS044_TC001_<scenarioId>_CDM_GenerateQRCode_Success_QRinSMS_Y_POST

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

* def reqBody = 
"""
{
  "inputValues": {
    "qrData": {
      "orderNumber": #(externalOrderNumber1),
      "clientId": #(clientID1)
    },
    "lpn": #(parcelNumber1),
    "facilityId": <storeId>,
    "size": <size>
  }
}

"""
 
Given url ws_cdm_url + '/services/v1/generateQRCode'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = '1122334455'
And header QRinSMS = 'Y'
And request reqBody
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].uniqueCode == '#string'
And match $.response.payload.records[0].clientName == 'Missguided'
And match $.response.payload.records[0].qrImageCode == '#regex [A-Za-z0-9+=\\/]+'
And match $.response.error == {}
 
Examples:
| scenarioId | size | userId    | storeId | source  | clientId     | slotId |
| S001       | 'S'  | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | '001'  |
| S002       | 'M'  | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | '001'  |
| S003       | 'L'  | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | '001'  |


