@All @WS052 @WS052_TC004 @Store @AbandonCollection
Feature: WS052_TC004_Store_AbandonCollection_Error400_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS052_TC004_<scenarioId>_Store_AbandonCollection_Error400_POST

* def reqBody = 
"""
{
    "taskId":"",
    "orderNumber":"ORMISC011833387",
    "parcelList":["MISC011833387"],
    "reasonCode1":"AC01"
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
Then status 400


Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

