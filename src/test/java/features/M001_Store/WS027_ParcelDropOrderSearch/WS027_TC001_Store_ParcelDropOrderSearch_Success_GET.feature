@All @WS027 @WS027_TC001 @Store @ParcelDropOrderSearch
Feature: WS027_TC001_Store_ParcelDropOrderSearch_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS027_TC001_<scenarioId>_Store_ParcelDropOrderSearch_Success_GET

Given url ws_url + '/Connect/v1/parceldrop/ordersearch'
And param firstname = <firstname>
And param lastname = <lastname>
And param fromdate = '2020-06-10'
And param todate = '2020-09-10'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].customerName == <firstname> + ' ' + <lastname>
And match $.response.payload.records[0].purchaseDate == '#regex [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}' 
And match $.response.payload.records[0].href == '/parceldrop/itemsearch/02354903'
And match $.response.payload.records[0].orderId == '02354903'
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     | firstname | lastname      |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'Meena'   | 'Karunakaran' |
