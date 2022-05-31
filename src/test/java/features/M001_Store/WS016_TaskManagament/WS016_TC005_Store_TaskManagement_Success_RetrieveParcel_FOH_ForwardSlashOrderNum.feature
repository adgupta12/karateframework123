@All @WS016 @WS016_TC005 @Store @TaskManagement
Feature: WS016_TC005_Store_TaskManagement_Success_RetrieveParcel_FOH_ForwardSlashOrderNum

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS016_TC005_<scenarioId>_Store_TaskManagement_Success_RetrieveParcel_FOH_ForwardSlashOrderNum

* def taskId = currentDateTimeStamp
* def taskDesc = 'Test - ' + currentDateTimeStamp
* def orderId = 'OR/' + currentDateTimeStamp
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
And header source = <source>
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
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].origin == <source>
And match $.response.payload.records[0].taskId == taskId
And match $.response.payload.records[0].clientId == ''
And match $.response.payload.records[0].alertDesc == 'retrieveParcel from FOH'
And match $.response.payload.records[0].businessId == 'SPD'
And match $.response.payload.records[0].receivedDate == '#regex [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}'
And match $.response.payload.records[0].metadataKey == 'orderId'
And match $.response.payload.records[0].metadataVal == orderId
And match $.response.payload.records[0].taskDetails == '#null'
And match $.response.payload.records[0].taskStatus == '13'
And match $.response.error == {}

#AcknowledgeActiveTask

* def reqBody2 = 
"""
{
	"acknowledgeTasks": {
		"taskId": #(taskId),
		"taskType": "retrieveParcel",
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

Given url ws_url + '/Connect/v1/taskmanagement/alert/activetasks'
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
And match $.response.payload.records == []
And match $.response.error == {}

#CloseTask

* def reqBody3 = 
"""
{
    "closeTask": {
        "orderId": #(orderId),
        "taskId": #(taskId),
        "taskType": "retrieveParcel"
    }
}
"""

Given url ws_url + '/Connect/v1/closetask'
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
And match $.response.payload == {}
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |


 
