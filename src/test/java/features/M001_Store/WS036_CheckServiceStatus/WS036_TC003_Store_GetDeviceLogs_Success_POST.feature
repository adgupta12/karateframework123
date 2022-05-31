@All @WS036 @WS036_TC003 @Store @CheckServiceStatus
Feature: WS036_TC003_Store_GetDeviceLogs_Success_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS036_TC003_<scenarioId>_Store_GetDeviceLogs_Success_POST

* def reqBody = 
"""
{
	"storeIdList":["05731", "05755"]
}
"""

Given url ws_url + '/Connect/v1/getDeviceLogs'
And header Content-Type = 'application/json'
And header userId = <userId>
And header transactionId = currentDateTimeStamp
And request reqBody
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload == 'Success'
And match $.response.error == {}

Examples:
| scenarioId | userId    |
| S001       | 'vn0hwvq' |

