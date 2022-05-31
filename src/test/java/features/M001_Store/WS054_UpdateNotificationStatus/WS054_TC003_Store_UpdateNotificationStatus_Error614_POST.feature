@All @WS054 @WS054_TC003 @Store @UpdateNotificationStatus
Feature: WS054_TC003_Store_UpdateNotificationStatus_Error614_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS054_TC003_<scenarioId>_Store_UpdateNotificationStatus_Error614_POST

* def reqBody = 
"""
{
	"taskId":"",
	"statusId":"19",
	"parcelList":[""]
	
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
And match $.response.error.errors[0].errorCode == '611'
And match $.response.error.errors[0].description == 'Partial Success' 
And match $.response.error.errors[0].fields.ERROR_PARCEL[0].responseCode == '204'
And match $.response.error.errors[0].fields.ERROR_PARCEL[0].responseMsg == 'Invalid Parcel Number'


Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

