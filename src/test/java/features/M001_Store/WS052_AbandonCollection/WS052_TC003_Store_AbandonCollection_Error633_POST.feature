@All @WS052 @WS052_TC003 @Store @AbandonCollection
Feature: WS052_TC003_Store_AbandonCollection_Error633_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS052_TC003_<scenarioId>_Store_AbandonCollection_Error633_POST

* def reqBody = 
"""
{
    "taskId":"",
    "orderNumber":"ORMISC011833387",
    "parcelList":[""],
    "reasonCode":"AC01"
}
"""

Given url ws_url + '/Connect/v1/order'
And param action = 'abandon_collection'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody
When method post
Then status 200
And match $.responseCode == '111'
And match $.response.payload == {}
And match $.response.error.errors[0].errorCode == '633'
And match $.response.error.errors[0].description == 'DB Internal Error' 
And match $.response.error.errors[0].fields == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

