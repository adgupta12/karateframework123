@All @WS033 @WS033_TC001 @Store @StoreReturn
Feature: WS033_TC001_Store_StoreReturn_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS033_TC001_<scenarioId>_Store_StoreReturn_Success_GET

Given url ws_url + '/Connect/v1/parceldrop/returnparcels'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
* def records = $.response.payload.records[0].items
* print 'Records count -> ', records.length
And match $.response.payload.records[0].isRefundable == false
And match each $.response.payload.records[0].items[*].firstName == '#string'
And match each $.response.payload.records[0].items[*].lastName == '#string'
#And match each $.response.payload.records[0].items[*].parcelId == '#regex [A-Z]{4}[0-9]{9}'
And match each $.response.payload.records[0].items[*].parcelId == '#string'
And match each $.response.payload.records[0].items[*].date == '#string'
And match each $.response.payload.records[0].items[*].slotId == '#string'
And match each $.response.payload.records[0].items[*].returnIdentifier == 'RETURN'
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

