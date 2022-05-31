@All @WS022 @WS022_TC001 @Store @ParcelSearch
Feature: WS022_TC001_Store_ParcelSearch_v1_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS022_TC001_<scenarioId>_Store_ParcelSearch_v1_Success_GET

Given url ws_url + '/Connect/v1/parcelsearch/order'
And path <orderId>
And param businessid = <businessId>
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].businessId == <businessId>
And match $.response.payload.records[0].orderId == <orderId>
And match $.response.payload.records[0].colleague == ''
And match $.response.payload.records[0].customerName == 'Test Automation'
And match $.response.payload.records[0].postCode == 'Default'
And match $.response.payload.records[0].addr == 'Default Default'
And match $.response.payload.records[0].email == 'test@test.com'
And match $.response.payload.records[0].orderType == 'B2C'
And match $.response.payload.records[0].cardNo == ''
And match $.response.payload.records[0].expectedDate == '2020-09-29 07:36:52'
And match $.response.payload.records[0].destinationId == <storeId>
And match $.response.payload.records[0].destinationName == 'Cave'
And match $.response.payload.records[0].parcel[0].id == <parcelId>
And match $.response.payload.records[0].parcel[0].locn == 'D001'
And match $.response.payload.records[0].parcel[0].stCode == '#ignore'
And match $.response.payload.records[0].parcel[0].stText == '#string'
And match $.response.payload.records[0].parcel[0].sCode == ['Click and Collect', 'EPOD', 'Standard', 'test@test.com', 'Standard', 'Next Day']
And match $.response.payload.records[0].parcel[0].stReasonCode == '#string'
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     | orderId           | businessId | parcelId        |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'ORMISC092946540' | 'MIS'      | 'MISC092946540' |
