@All @WS055 @WS055_TC001 @ToYou @OrderCollection
Feature: WS055_TC001_ToYou_OrderCollection_Success_GET

Background:
* print 'ws_toyou_url -> ', ws_toyou_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS055_TC001_<scenarioId>_ToYou_OrderCollection_Success_GET

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

* def wait1 = wait(2000)

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
    "size": "S"
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
* def uniqueCode = $.response.payload.records[0].uniqueCode
And match $.response.payload.records[0].clientName == 'Missguided'
And match $.response.payload.records[0].qrImageCode == '#regex [A-Za-z0-9+=\\/]+'
And match $.response.error == {}

Given url ws_toyou_url + '/toyou-app/services/rest/toyou/order'
And param uniqueCode = uniqueCode
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
When method get
Then status 200
And match $.status == 'OK'
And match $.payload[0].lpn == parcelNumber1
And match $.payload[0].qrImageCode == '#regex [A-Za-z0-9+=\\/]+'
And match $.payload[0].dwellTimeExpiryDate == '#string'
And match $.payload[0].orderNum == externalOrderNumber1
And match $.payload[0].responseCode == '000'
And match $.payload[0].facilityDetails.facilityType == '#string'
And match $.payload[0].facilityDetails.facilityId == <storeId>
And match $.payload[0].facilityDetails.facilityName == 'Cave'
And match $.payload[0].facilityDetails.phoneNumber == '#string'
And match $.payload[0].facilityDetails.addressLine1 == '#string'
And match $.payload[0].facilityDetails.addressLine2 == '#string'
And match $.payload[0].facilityDetails.postCode == '#string'
And match $.payload[0].facilityDetails.city == '#string'
And match $.payload[0].facilityDetails.county == '#string'
And match $.payload[0].facilityDetails.countryCode == '#string'
And match $.payload[0].facilityDetails.latitude == '#number'
And match $.payload[0].facilityDetails.longitude == '#number'
And match $.payload[0].facilityDetails.dwellTime == '#number'
And match $.payload[0].facilityDetails.isMCIEnabled == '#string'
And match $.payload[0].facilityDetails.mciProximity == '#number'
And match $.payload[0].facilityDetails.primaryColDept[0].name == '#string'
And match $.payload[0].facilityDetails.primaryColDept[0].collectionTimings.Monday == '#string'
And match $.payload[0].facilityDetails.primaryColDept[0].collectionTimings.Tuesday == '#string'
And match $.payload[0].facilityDetails.primaryColDept[0].collectionTimings.Wednesday == '#string'
And match $.payload[0].facilityDetails.primaryColDept[0].collectionTimings.Thursday == '#string'
And match $.payload[0].facilityDetails.primaryColDept[0].collectionTimings.Friday == '#string'
And match $.payload[0].facilityDetails.primaryColDept[0].collectionTimings.Saturday == '#string'
And match $.payload[0].facilityDetails.primaryColDept[0].collectionTimings.Sunday == '#string'
And match $.errors == []

Examples:
| scenarioId | userId    | storeId | source  | clientId     | slotId |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | '001'  |

