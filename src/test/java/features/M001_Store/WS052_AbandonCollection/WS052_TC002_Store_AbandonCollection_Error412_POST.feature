@All @WS052 @WS052_TC002 @Store @AbandonCollection
Feature: WS052_TC002_Store_AbandonCollection_Error412_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS052_TC002_<scenarioId>_Store_AbandonCollection_Error412_POST

* def reqBody = 
"""
{
    "taskId":"",
    "orderNumber":"ORMISC011833387",
    "parcelList":["MISC011833387"],
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
#And header clientId = <clientId>
And request reqBody
When method post
Then status 200
And match $.responseCode == '111'
And match $.response.payload == {}
And match $.response.error.errors[0].errorCode == '412'
And match $.response.error.errors[0].description == 'Invalid input parameters' 
And match $.response.error.errors[0].fields.clientId == '#null'

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

