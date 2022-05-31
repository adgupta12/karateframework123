@All @WS034 @WS034_TC001 @Store @RetrieveEPOD
Feature: WS034_TC001_Store_RetrieveEPOD_A2C_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS034_TC001_<scenarioId>_Store_RetrieveEPOD_A2C_Success_GET

Given url ws_url + '/Connect/v1/parcelsearch/retrievesignature'
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
And match $.response.payload.records[0].collectedDate == '#regex [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}'
And match $.response.payload.records[0].image == '#null'
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     | parcelNumber    |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'ASDC080593047' |

