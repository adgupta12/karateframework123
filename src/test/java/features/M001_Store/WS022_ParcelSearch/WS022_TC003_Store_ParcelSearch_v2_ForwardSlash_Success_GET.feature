@All @WS022 @WS022_TC003 @Store @ParcelSearch
Feature: WS022_TC003_Store_ParcelSearch_v2_ForwardSlash_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS022_TC003_<scenarioId>_Store_ParcelSearch_v2_ForwardSlash_Success_GET

Given url ws_url + '/Connect/v2/parcelsearch'
And param orderId = <orderId>
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
And match $.response.payload.records[0].customerName == '#string'
And match $.response.payload.records[0].postCode == '#string'
And match $.response.payload.records[0].addr == '#string'
And match $.response.payload.records[0].email == '#string'
And match $.response.payload.records[0].orderType == 'B2C'
And match $.response.payload.records[0].expectedDate == '#string'
And match $.response.payload.records[0].destinationId == <storeId>
And match $.response.payload.records[0].destinationName == 'Cave'
And match $.response.payload.records[0].parcel[0].id == <parcelId>
#And match $.response.payload.records[0].parcel[0].locn == '#string'
And match $.response.payload.records[0].parcel[0].description == '#string'
And match $.response.payload.records[0].parcel[0].stCode == '#string'
And match $.response.payload.records[0].parcel[0].stText == '#string'
And match $.response.payload.records[0].parcel[0].sCode == '#array'
And match $.response.payload.records[0].parcel[0].stReasonCode == '#string'
#And match $.response.payload.records[0].parcel[0].parcelCollectionDate == '#string'
And match $.response.payload.records[0].parcel[0].parcelCollectedDate == '#string'
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     | orderId            | businessId | parcelId        |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'OR/MISC053160976' | 'MIS'      | 'MISC053160976' |


