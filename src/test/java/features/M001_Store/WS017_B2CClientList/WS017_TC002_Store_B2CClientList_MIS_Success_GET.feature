@All @WS017 @WS017_TC002 @Store @B2CClientList
Feature: WS017_TC002_Store_B2CClientList_MIS_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS017_TC002_<scenarioId>_Store_B2CClientList_MIS_Success_GET

Given url ws_url + '/Connect/v1/clientlist'
And param isInternalClientRequired = 'Y'
And param isRetrieveAllRef = 'Y'
And param orderId = 'ORMISC010558159' 
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].clientId == 'MIS'
And match $.response.payload.records[0].clientName == 'Missguided'
And match $.response.payload.records[0].isActive == true
* def b2cDetailsList = $.response.payload.records[0].b2cDetails
And match b2cDetailsList == '#[4]'
And match $.response.payload.records[0].b2cDetails[0].referenceFieldLabel == '#string'
And match $.response.payload.records[0].b2cDetails[0].isReferenceFieldMandatory == true
And match $.response.payload.records[0].b2cDetails[0].referenceFieldHelp == '#string'
And match $.response.payload.records[0].b2cDetails[0].referenceFieldIndex == 'customField1'
And match $.response.payload.records[0].b2cDetails[1].referenceFieldLabel == '#string'
And match $.response.payload.records[0].b2cDetails[1].isReferenceFieldMandatory == true
And match $.response.payload.records[0].b2cDetails[1].referenceFieldHelp == '#string'
And match $.response.payload.records[0].b2cDetails[1].referenceFieldIndex == 'customField2'
And match $.response.payload.records[0].b2cDetails[2].referenceFieldLabel == '#string'
And match $.response.payload.records[0].b2cDetails[2].isReferenceFieldMandatory == false
And match $.response.payload.records[0].b2cDetails[2].referenceFieldHelp == '#string'
And match $.response.payload.records[0].b2cDetails[2].referenceFieldIndex == 'customField4'
And match $.response.payload.records[0].b2cDetails[3].referenceFieldLabel == '#string'
And match $.response.payload.records[0].b2cDetails[3].isReferenceFieldMandatory == false
And match $.response.payload.records[0].b2cDetails[3].referenceFieldHelp == '#string'
And match $.response.payload.records[0].b2cDetails[3].referenceFieldIndex == 'customField5'
And match $.response.payload.records[0].clientType == 'External'
And match $.response.payload.records[0].isReturnRestricted == '#string'
And match $.response.payload.records[0].clientReturnWebURL == '#string'
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

