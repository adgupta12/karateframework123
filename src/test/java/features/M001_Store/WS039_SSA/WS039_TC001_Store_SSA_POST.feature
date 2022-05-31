@All @WS039 @WS039_TC001 @Store @SSA
Feature: WS039_TC001_Store_SSA_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS039_TC001_<scenarioId>_Store_SSA_POST

* def reqBody1 = 
"""
{
	"message": "Validate Mesage SSA Data",
	"storeIdList": <storeId>
}
"""

Given url ws_url + '/Connect/v1/ssa/alerts'
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
And match $.response.payload.msgId == '#regex [0-9]{16}'
* def msgId = $.response.payload.msgId
And match $.response.payload.responseCode == '000'
And match $.response.error == {}


* def reqBody2 = 
"""
{}
"""

Given url ws_url + '/Connect/v1/ssa/alerts'
And path msgId, 'notify'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody2
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload.result == 'Success'
And match $.response.error == {}

#AcknowledgeActiveTask

* def reqBody3 = 
"""
{
	"acknowledgeTasks": {
		"taskId": #(msgId),
		"taskType": "retrieveAlert",
		"taskDetails": [{
			"metadataKey": "orderId",
			"metadataVal": null
		}, {
			"metadataKey": "clientId",
			"metadataVal": <clientId>
		}]
	}
}
"""

Given url ws_url + '/Connect/v1/taskmanagement/alert/activetasks'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody3
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records == []
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |
