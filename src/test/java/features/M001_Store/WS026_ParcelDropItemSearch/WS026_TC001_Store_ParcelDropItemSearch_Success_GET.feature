@All @WS026 @WS026_TC001 @Store @ParcelDropItemSearch
Feature: WS026_TC001_Store_ParcelDropItemSearch_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS026_TC001_<scenarioId>_Store_ParcelDropItemSearch_Success_GET

Given url ws_url + '/Connect/v1/parceldrop/itemsearch'
And path <orderId>
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].orderId == <orderId>
And match $.response.payload.records[0].firstName == 'Meena'
And match $.response.payload.records[0].lastName == 'Karunakaran'
And match $.response.payload.records[0].phone == '07459447177'
And match $.response.payload.records[0].purchaseDate == '#regex [0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\\.000\\+0000' 
And match $.response.payload.records[0].currency == 'GBP'
And match $.response.payload.records[0].emailId == 'meena.nakaran@asda.co.uk' 
And match $.response.payload.records[0].items[0].name == 'Baby Bath Tub - White' 
And match $.response.payload.records[0].items[0].isSelected == 'true' 
And match $.response.payload.records[0].items[0].quantity == '1' 
And match $.response.payload.records[0].items[0].price == '11.0' 
And match $.response.payload.records[0].items[0].primeLineNo == '1' 
And match $.response.payload.records[0].items[0].isRefundable == false 
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     | orderId    |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | '02130843' |

