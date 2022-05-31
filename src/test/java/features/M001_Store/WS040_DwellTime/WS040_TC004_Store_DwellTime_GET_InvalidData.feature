@All @WS040 @WS040_TC004 @Store @DwellTime
Feature: WS040_TC004_Store_DwellTime_GET_InvalidData

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS040_TC004_<scenarioId>_Store_DwellTime_GET_InvalidData

Given url ws_url + '/Connect/v1/order/dwellTime'
And param client = 'MIS'
And param order = 'ORINVALID12345'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '111'
And match $.response.payload == {}
And match $.response.error.errors[0].errorCode == '204'
And match $.response.error.errors[0].description == 'NO DATA FOUND'


Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

