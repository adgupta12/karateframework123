@All @WS054 @WS054_TC006 @Store @UpdateNotificationStatus
Feature: WS054_TC006_Store_UpdateNotificationStatus_Error404_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS054_TC006_<scenarioId>_Store_UpdateNotificationStatus_Error404_POST

* def reqBody = 
"""
{
	"taskId":"",
	"statusId":"AC01",
	"parcelList":["MISC011833387"]
	
}
"""

Given url ws_url + '/Connect/v1/taskStatus1'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header clientId = <clientId>
And header transactionId = currentDateTimeStamp
And request reqBody
When method post
Then status 404


Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

