@All @WS054 @WS054_TC001 @Store @UpdateNotificationStatus
Feature: WS054_TC001_Store_UpdateNotificationStatus_Success_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS054_TC001_<scenarioId>_Store_UpdateNotificationStatus_Success_POST

* def reqBody = 
"""
{
	"taskId":"057312299295",
	"statusId":"13",
	"parcelList":[]
	
}
"""

Given url ws_url + '/Connect/v1/taskStatus'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload == {}
And match $.response.error == {}

#close task

* def reqBody = 
"""
{
	"taskId":"057312299295",
	"statusId":"18",
	"parcelList":[]
	
}
"""

Given url ws_url + '/Connect/v1/taskStatus'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload == {}
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

