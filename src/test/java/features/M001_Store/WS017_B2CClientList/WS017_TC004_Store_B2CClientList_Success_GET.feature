@All @WS017 @WS017_TC004 @Store @B2CClientList
Feature: WS017_TC004_Store_B2CClientList_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS017_TC004_<scenarioId>_Store_B2CClientList_Success_GET

Given url ws_url + '/Connect/v1/clientlist'
And param isInternalClientRequired = 'Y'
And param isRetrieveAllRef = 'Y'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
* def recordsList = $.response.payload.records
* print 'recordsList -> ', recordsList.length
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

