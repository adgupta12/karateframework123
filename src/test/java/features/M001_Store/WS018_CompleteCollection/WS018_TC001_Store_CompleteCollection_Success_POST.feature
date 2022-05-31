@All @WS018 @WS018_TC001 @Store @CompleteCollection @ignore
Feature: WS018_TC001_Store_CompleteCollection_Success_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS018_TC001_<scenarioId>_Store_CompleteCollection_Success_POST

#* def parcelNumber = getB2CParcelNumberTNAS(<storeId>,'4','1','TNAS')
* def parcelNumber = getB2CParcelNumber(<storeId>,'4','1','vn0hwvq')
* def orderNumber = getOrderNumberFromParcelNumber(parcelNumber)

* def reqBody = 
"""
{
    "completeCollection": {
        "orderId": #(orderNumber),
        "parcelList": [#(parcelNumber)]
    }
}
"""

Given url ws_url + '/Connect/v1/parcelcollection/complete'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].parcelId == parcelNumber
And match $.response.payload.records[0].status == 'Success'
And match $.response.error.errors == []

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |


