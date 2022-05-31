@All @WS030 @WS030_TC002 @Store @CreateLabel
Feature: WS030_TC002_Store_CreateLabel_Shipping_Success_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS030_TC002_<scenarioId>_Store_CreateLabel_Shipping_Success_POST

#ParcelDrop

* def reqBody1 = 
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
And request reqBody1
When method post
Then status 200
And match $.responseCode == '000'
* def parcelId = $.response.payload.records[0].receiptDetails[2].metadataVal

#MoveParcel

* def reqBody2 = 
"""
{}
"""

Given url ws_url + '/Connect/v1/parceldrop/moveparcel'
And path parcelId, 'R001'
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
And match $.response.payload.records[0].newSlot == 'R001'
And match $.response.payload.records[0].oldSlot == ''
And match $.response.error == {}

#CreateLabel

* def reqBody3 = 
"""
{}
"""

Given url ws_url + '/Connect/v1/createlabel/shipping/R001'
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
And match $.response.payload.records[0].id == '#regex 05731[0-9]{9}'
And match $.response.payload.records[0].labelImage == '#regex [A-Za-z0-9+=\\/]+'
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |
