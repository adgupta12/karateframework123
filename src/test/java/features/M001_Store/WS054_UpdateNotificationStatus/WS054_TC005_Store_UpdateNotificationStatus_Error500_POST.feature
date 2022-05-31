@All @WS054 @WS054_TC005 @Store @UpdateNotificationStatus
Feature: WS054_TC005_Store_UpdateNotificationStatus_Error500_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS054_TC005_<scenarioId>_Store_UpdateNotificationStatus_Error500_POST

* def reqBody = 
"""
{
	"taskId":"",
	"statusId1":"AC01",
	"parcelList":["MISC011833387"]
	
}
"""

Given url ws_url + '/Connect/v1/taskStatus'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header clientId = <clientId>
And header transactionId = currentDateTimeStamp
And request reqBody
When method post
Then status 200
And match $.responseCode == '111'
And match $.response.payload == {}
And match $.response.error.errors[0].errorCode == '500'
And match $.response.error.errors[0].description == 'Application Internal Error' 
And match $.response.error.errors[0].fields == {}


Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

