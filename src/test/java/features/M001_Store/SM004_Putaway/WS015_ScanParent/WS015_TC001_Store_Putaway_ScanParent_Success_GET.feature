@All @WS015 @WS015_TC001 @Store @ScanParent @ignore
Feature: WS015_TC001_Store_Putaway_ScanParent_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS015_TC001_<scenarioId>_Store_Putaway_ScanParent_Success_GET

* def containerId = '07520007147247'

Given url ws_url + '/Connect/v1/parcelputaway/container/'
And path containerId
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.invocationResult.isSuccessful == 'true'
And match $.invocationResult.errors.errorCode == '000'
And match $.invocationResult.errors.errorDesc == 'Success'
And match $.invocationResult.result.parcelCount == '1'
And match $.invocationResult.result.putawayLevel == 'Parcel'

Examples:
| scenarioId | userId    | storeId | source  | clientId     | 
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

 
