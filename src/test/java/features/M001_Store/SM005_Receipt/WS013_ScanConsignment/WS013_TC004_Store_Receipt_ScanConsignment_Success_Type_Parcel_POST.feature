@All @WS013 @WS013_TC004 @Store @ScanConsignment @ignore
Feature: WS013_TC004_Store_Receipt_ScanConsignment_Success_Type_Parcel_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS013_TC004_<scenarioId>_Store_Receipt_ScanConsignment_Success_Type_Parcel_POST

* def storeId = <storeId>
* def getParcelDetailsForNotReceivedContainers = getParcelDetailsForNotReceivedContainers(storeId)
* def parcelNumber = getParcelDetailsForNotReceivedContainers[0]
* def containerId = getParcelDetailsForNotReceivedContainers[1]
* def cageId = getCageNumber(containerId)

* def reqBody = 
"""
{}

"""

Given url ws_url + '/Connect/v1/receiptconsignment/'
And path parcelNumber
And param type = 'Parcel'
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

 
