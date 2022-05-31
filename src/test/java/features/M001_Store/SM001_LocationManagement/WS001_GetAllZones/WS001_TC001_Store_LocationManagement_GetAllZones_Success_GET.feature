@All @WS001 @WS001_TC001 @Store @LocationManagement @GetAllZones
Feature: WS001_TC001_Store_LocationManagement_GetAllZones_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS001_TC001_<scenarioId>_Store_LocationManagement_GetAllZones_Success_GET
  
Given url ws_url + '/Connect/v1/locmgmt/zones'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.invocationResult.errors.errorCode == '000'
And match $.invocationResult.isSuccessful == 'true'
And match $.invocationResult.errors.errorDesc == 'Sucessfully Retreived Details'
And match $.invocationResult.result.originId == '[' + <storeId> + ']'
And match $.invocationResult.result.zone[0].zoneId == 'D'
And match $.invocationResult.result.zone[0].zoneName == 'Click and Collect'
And match $.invocationResult.result.zone[1].zoneId == 'R' 
And match $.invocationResult.result.zone[1].zoneName == 'Return' 
And match $.invocationResult.result.zone[2].zoneId == 'O' 
And match $.invocationResult.result.zone[2].zoneName == 'Overflow' 

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' |
| S002       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

