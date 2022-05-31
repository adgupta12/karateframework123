@All @WS037 @WS037_TC001 @Store @ValidateReturnParcel
Feature: WS037_TC001_Store_ValidateReturnParcel_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS037_TC001_<scenarioId>_Store_ValidateReturnParcel_GET

Given url ws_url + '/Connect/v1/validatereturnparcel'
And path <parcelNumber>
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].facilityType == '#string'
And match $.response.payload.records[0].isRefundable == '#string'
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     | parcelNumber    |
| S001       | 'vn0hwvq' | '04135' | 'STORE' | '1122334455' | 'ASDH234567876' |

