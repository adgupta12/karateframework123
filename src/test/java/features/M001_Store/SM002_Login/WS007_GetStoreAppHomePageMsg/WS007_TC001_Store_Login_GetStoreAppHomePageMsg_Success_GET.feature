@All @WS007 @WS007_TC001 @Store @Login @GetStoreAppHomePageMsg
Feature: WS007_TC001_Store_Login_GetStoreAppHomePageMsg_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS007_TC001_<scenarioId>_Store_Login_GetStoreAppHomePageMsg_Success_GET
 
Given url ws_url + '/Connect/v1/getStoreAppHomePageMsg'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.messageId == '1'
#And match $.response.payload.messageText == ' * Welcome to ASDA Retail store!' 
And match $.response.payload.messageText contains ' * Welcome to ASDA Stores!' 
And match $.response.error == {} 
 
Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' |
| S002       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |
 

