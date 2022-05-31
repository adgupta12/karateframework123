@All @WS030 @WS030_TC001 @Store @CreateLabel @ignore
Feature: WS030_TC001_Store_CreateLabel_Return_Success_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS030_TC001_<scenarioId>_Store_CreateLabel_Return_Success_POST

* def reqBody = 
"""
{}
"""

Given url ws_url + '/Connect/v1/createlabel/return/ASD'
And param parcelNumber = 'MISD123456789' 
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
And match $.response.payload.records[0].id == '#null'
* def labelImage = $.response.payload.records[0].labelImage
And match labelImage == '#regex [A-Za-z0-9+=\\/]+'
* def decodedLabelImage = decodeBase64Barcode(labelImage)
* print decodedLabelImage
And match decodedLabelImage == '#regex ASDE[0-9]{9}' 
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |
