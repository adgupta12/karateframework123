@All @WS038 @WS038_TC001 @Store @ReprintLabel
Feature: WS038_TC001_Store_ReprintLabel_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS038_TC001_<scenarioId>_Store_ReprintLabel_GET

Given url ws_url + '/Connect/v1/reprintLabel'
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
And match $.response.payload.records[0].lpn == <parcelNumber>
And match $.response.payload.records[0].labelImage == '#regex [A-Za-z0-9+=\\/]+'
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     | parcelNumber    |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'ASOE111320615' |

