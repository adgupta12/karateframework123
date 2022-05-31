@All @WS017 @WS017_TC003 @Store @B2CClientList
Feature: WS017_TC003_Store_B2CClientList_BLK_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS017_TC003_<scenarioId>_Store_B2CClientList_BLK_Success_GET

Given url ws_url + '/Connect/v1/clientlist'
And param isInternalClientRequired = 'Y'
And param isRetrieveAllRef = 'Y'
And param orderId = 'ORBLKC100837142' 
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].clientId == 'BLK'
And match $.response.payload.records[0].clientName == 'Blacks'
And match $.response.payload.records[0].isActive == true
* def b2cDetailsList = $.response.payload.records[0].b2cDetails
And match b2cDetailsList == '#[4]'
And match $.response.payload.records[0].b2cDetails[0].referenceFieldLabel == 'Order Number'
And match $.response.payload.records[0].b2cDetails[0].isReferenceFieldMandatory == true
And match $.response.payload.records[0].b2cDetails[0].referenceFieldHelp == 'Please enter your order number'
And match $.response.payload.records[0].b2cDetails[0].referenceFieldIndex == 'customField1'
And match $.response.payload.records[0].b2cDetails[1].referenceFieldLabel == 'Full Name'
And match $.response.payload.records[0].b2cDetails[1].isReferenceFieldMandatory == true
And match $.response.payload.records[0].b2cDetails[1].referenceFieldHelp == 'Please enter your full name'
And match $.response.payload.records[0].b2cDetails[1].referenceFieldIndex == 'customField2'
And match $.response.payload.records[0].b2cDetails[2].referenceFieldLabel == 'Email Address'
And match $.response.payload.records[0].b2cDetails[2].isReferenceFieldMandatory == true
And match $.response.payload.records[0].b2cDetails[2].referenceFieldHelp == 'Please enter your email address'
And match $.response.payload.records[0].b2cDetails[2].referenceFieldIndex == 'customField4'
And match $.response.payload.records[0].b2cDetails[3].referenceFieldLabel == 'Phone Number'
And match $.response.payload.records[0].b2cDetails[3].isReferenceFieldMandatory == true
And match $.response.payload.records[0].b2cDetails[3].referenceFieldHelp == 'Please enter your phone number'
And match $.response.payload.records[0].b2cDetails[3].referenceFieldIndex == 'customField5'
And match $.response.payload.records[0].clientType == 'Internal'
And match $.response.payload.records[0].isReturnRestricted == 'N'
And match $.response.payload.records[0].clientReturnWebURL == ''
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

