@All @WS016 @WS016_TC008 @Store @TaskManagement
Feature: WS016_TC008_Store_TaskManagement_Success_RequiredAssistance_ZEBRAKSK_ForwardSlashOrderNum

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS016_TC008_<scenarioId>_Store_TaskManagement_Success_RequiredAssistance_ZEBRAKSK_ForwardSlashOrderNum

* def taskId = currentDateTimeStamp
* def taskDesc = 'Test - ' + currentDateTimeStamp
* def roleName = 'ZEBRAKSK'
* def orderId = 'OR/' + currentDateTimeStamp

* def reqBody1 = 
"""
{
	"sendTaskAlert": {
		"taskType": "requiredAssistance",
		"roleName": #(roleName),
		"taskDetails": [{
			"metadataKey": "orderId",
			"metadataVal": #(orderId)
		}, {
			"metadataKey": "clientId",
			"metadataVal": "SPD"
		},{
			"metadataKey": "taskId",
			"metadataVal": #(taskId)
		},{
			"metadataKey": "taskDesc",
			"metadataVal": #(taskDesc)
		}]
	}
}
"""

Given url ws_url + '/Connect/v1/taskmanagement/alert/sendtask'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = 'ZEBRAKSK'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody1
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload == {}
And match $.response.error == {}

#CheckActiveTask
Given url ws_url + '/Connect/v1/taskmanagement/alert/activetasks'
And path roleName
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = 'STORE'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].origin == 'ZEBRAKSK'
And match $.response.payload.records[0].taskId == taskId
And match $.response.payload.records[0].clientId == ''
And match $.response.payload.records[0].alertDesc == 'requiredAssistance from ZEBRAKSK'
And match $.response.payload.records[0].businessId == 'SPD'
And match $.response.payload.records[0].receivedDate == '#regex [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}'
And match $.response.payload.records[0].taskDetails == taskDesc
And match $.response.payload.records[0].taskStatus == '13'
And match $.response.error == {}

#AcknowledgeActiveTask

* def reqBody2 = 
"""
{
	"acknowledgeTasks": {
		"taskId": #(taskId),
		"taskType": "requiredAssistance",
		"taskDetails": [{
			"metadataKey": "orderId",
			"metadataVal": "SPD310819004"
		}, {
			"metadataKey": "clientId",
			"metadataVal": "SPD"
		}]
	}
}
"""

Given url ws_url + '/Connect/v1/taskmanagement/alert/activetasks'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = 'STORE'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody2
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records == []
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | clientId     |
| S001       | 'vn0hwvq' | '05731' | '1122334455' |


 
