@All @WS016 @WS016_TC009 @Store @TaskManagement
Feature: WS016_TC009_Store_TaskManagement_Success_RetrieveParcel2_FOH

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS016_TC009_<scenarioId>_Store_TaskManagement_Success_RetrieveParcel2_FOH

* def orderId = 'OR' + currentDateTimeStamp
* def roleName = 'FOH'

* def reqBody1 = 
"""
{
	"sendTaskAlert": {
		"taskType": "retrieveParcel",
		"roleName": #(roleName),
		"taskDetails": [{
			"metadataKey": "orderId",
			"metadataVal": #(orderId)
		}, {
			"metadataKey": "clientId",
			"metadataVal": "SPD"
		}]
	}
}
"""

Given url ws_url + '/Connect/v1/taskmanagement/alert/retrieveparcel'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody1
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload == {}
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |


 
