@All @WS005 @WS005_TC001 @Store @LocationManagement @PrintSlotLabel
Feature: WS005_TC001_Store_LocationManagement_PrintSlotLabel_Success_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS005_TC001_<scenarioId>_Store_LocationManagement_PrintSlotLabel_Success_POST
   
* def reqBody = 
"""
{}

"""
 
Given url ws_url + '/Connect/v1/locmgmt/zones/'
And path <zoneId>, 'printslot', <slotId>
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody
When method post
Then status 200
And match $.invocationResult.errors.errorCode == '000'
And match $.invocationResult.isSuccessful == 'true'
And match $.invocationResult.errors.errorDesc == 'Sucessfull'
And match $.invocationResult.result[0].labelNumber == <slotId>
* def labelImageCode = $.invocationResult.result[0].labelImageCode
And match labelImageCode == '#regex [A-Za-z0-9+=\\/]+'
* def decodedLabelImageCode = decodeBase64Barcode(labelImageCode)
And match decodedLabelImageCode == <zoneId> + <slotId>
 
Examples:
| scenarioId | userId    | storeId | source  | clientId     | zoneId | slotId |
| S001       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'D'    | '111'  | 
| S002       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'R'    | '111'  |
| S003       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | 'O'    | '111'  |
| S004       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'D'    | '111'  | 
| S005       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'R'    | '111'  | 
| S006       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | 'O'    | '111'  | 

