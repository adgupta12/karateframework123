@All @WS017 @WS017_TC006 @Store @B2CClientList
Feature: WS017_TC006_Store_B2CClientList_BLK_isInternalClientRequired_N_Error702_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS017_TC006_<scenarioId>_Store_B2CClientList_BLK_isInternalClientRequired_N_Error702_GET

Given url ws_url + '/Connect/v1/clientlist'
And param isInternalClientRequired = 'N'
And param isRetrieveAllRef = 'Y'
And param orderId = 'ORBLKC100837142' 
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '111'
And match $.response.payload == {}
And match $.response.error.errors[0].errorCode == '702'
And match $.response.error.errors[0].description == 'No client found in CDM correponding to order'

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

