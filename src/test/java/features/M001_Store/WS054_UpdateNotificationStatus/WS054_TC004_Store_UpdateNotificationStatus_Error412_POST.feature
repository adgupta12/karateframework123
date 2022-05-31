@All @WS054 @WS054_TC004 @Store @UpdateNotificationStatus
Feature: WS054_TC004_Store_UpdateNotificationStatus_Error412_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS054_TC004_<scenarioId>_Store_UpdateNotificationStatus_Error412_POST

* def reqBody = 
"""
{
	"taskId":"",
	"statusId":"AC01",
	"parcelList":["MISC011833387"]
	
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
And match $.responseCode == '111'
And match $.response.payload == {}
And match $.response.error.errors[0].errorCode == '412'
And match $.response.error.errors[0].description == 'Invalid input parameters' 
And match $.response.error.errors[0].fields.clientId == ''


Examples:
| scenarioId | userId    | storeId | source  | clientId |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '' 			|

