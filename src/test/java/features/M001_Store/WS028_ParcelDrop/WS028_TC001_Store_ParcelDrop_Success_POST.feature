@All @WS028 @WS028_TC001 @Store @ParcelDrop
Feature: WS028_TC001_Store_ParcelDrop_Success_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS028_TC001_<scenarioId>_Store_ParcelDrop_Success_POST

* def reqBody = 
"""
{
	"inputValues": {
	}
}
"""

Given url ws_url + '/Connect/v1/parceldrop'
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
And match $.response.payload.records[0].labelImage == '#regex [A-Za-z0-9+=\\/]+'
And match $.response.payload.records[0].receiptDetails[0].metadataKey == 'returnDate'
And match $.response.payload.records[0].receiptDetails[0].metadataVal == '#regex [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}'
And match $.response.payload.records[0].receiptDetails[1].metadataKey == 'ItemsReturned'
And match $.response.payload.records[0].receiptDetails[1].metadataVal == ''
And match $.response.payload.records[0].receiptDetails[2].metadataKey == 'trackingId'
And match $.response.payload.records[0].receiptDetails[2].metadataVal == '#regex ASDE[0-9]{9}'
* def parcelId = $.response.payload.records[0].receiptDetails[2].metadataVal
And match $.response.payload.records[0].receiptDetails[3].metadataKey == 'b2cClientName'
And match $.response.payload.records[0].receiptDetails[3].metadataVal == 'ASD'
And match $.response.payload.records[0].receiptImage == '#regex [A-Za-z0-9+=\\/]+'
And match $.response.payload.records[0].parcelDestined == 'RETURN'
And match $.response.payload.records[0].parcelId == parcelId
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |
