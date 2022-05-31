@All @WS035 @WS035_TC002 @Store @IsLPNExisting
Feature: WS035_TC002_Store_IsLPNExisting_True_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS035_TC002_<scenarioId>_Store_IsLPNExisting_True_Success_GET

Given url ws_url + '/Connect/v1/isLpnExisting'
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
And match $.response.payload.records[0].parcelId == <parcelNumber>
And match $.response.payload.records[0].isLpnExisting == true
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     | parcelNumber    |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'ASDP567890135' |

