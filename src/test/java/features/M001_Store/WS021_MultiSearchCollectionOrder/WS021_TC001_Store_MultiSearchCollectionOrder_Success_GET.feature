@All @WS021 @WS021_TC001 @Store @MultiSearchCollectionOrder
Feature: WS021_TC001_Store_MultiSearchCollectionOrder_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS021_TC001_<scenarioId>_Store_MultiSearchCollectionOrder_Success_GET

Given url ws_url + '/Connect/v1/parcelsearch/orders'
And param trackingid = 'MISC100917346'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].customerName == 'Anderson Smith'
And match $.response.payload.records[0].orderDetails[0].orderId == 'ORMISC100917346'
And match $.response.payload.records[0].orderDetails[0].orderType == 'B2C'
And match $.response.payload.records[0].orderDetails[0].deliveryDate == '2020-10-09 03:00:00 PM'
And match $.response.payload.records[0].orderDetails[0].clientName == 'Ollerton Dot Com'
And match $.response.payload.records[0].orderDetails[0].href == 'parcelsearch/order/ORMISC100917346?businessid=MIS&epodrequired=true'
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

