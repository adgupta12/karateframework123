@All @WS013 @WS013_TC002 @Store @ScanConsignment @ignore
Feature: WS013_TC002_Store_Receipt_ScanConsignment_Success_Type_Cage_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS013_TC002_<scenarioId>_Store_Receipt_ScanConsignment_Success_Type_Cage_POST

* def storeId = <storeId>
* def getParcelDetailsForNotReceivedContainers = getParcelDetailsForNotReceivedContainers(storeId)
* def containerId = getParcelDetailsForNotReceivedContainers[1]
* def cageId = getCageNumber(containerId)

* def reqBody = 
"""
{}

"""

Given url ws_url + '/Connect/v1/receiptconsignment/'
And path cageId
And param type = 'Cage'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody
When method post
Then status 200
And match $.invocationResult.isSuccessful == 'true'
And match $.invocationResult.errors.errorCode == '000'
And match $.invocationResult.errors.errorDesc == 'Success'
And match $.invocationResult.result.cageID == cageId
And match $.invocationResult.result.cageNoScanned == '1'
And match $.invocationResult.result.totalCage == '1'

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

 
