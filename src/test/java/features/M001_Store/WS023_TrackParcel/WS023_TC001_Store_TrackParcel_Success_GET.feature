@All @WS023 @WS023_TC001 @Store @TrackParcel
Feature: WS023_TC001_Store_TrackParcel_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS023_TC001_<scenarioId>_Store_TrackParcel_Success_GET

Given url ws_url + '/Connect/v1/parcelsearch/trackparcel'
And path <parcelId>
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].parcelId == <parcelId>
And match $.response.payload.records[0].date == '#regex [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' 
And match $.response.payload.records[0].status == 'This parcel is now ready to collect'
And match $.response.error.errors == []

Examples:
| scenarioId | userId    | storeId | source  | clientId     | parcelId        |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'AUTC101883757' |

