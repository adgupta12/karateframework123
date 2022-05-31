@All @WS017 @WS017_TC001 @Store @B2CClientList
Feature: WS017_TC001_Store_B2CClientList_ASD_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS017_TC001_<scenarioId>_Store_B2CClientList_ASD_Success_GET

Given url ws_url + '/Connect/v1/clientlist'
And param isInternalClientRequired = 'Y'
And param isRetrieveAllRef = 'Y'
And param orderId = 'ORASDJ011144678' 
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].clientId == 'ASD'
And match $.response.payload.records[0].clientName == 'George'
And match $.response.payload.records[0].isActive == true
* def b2cDetailsList = $.response.payload.records[0].b2cDetails
And match b2cDetailsList == '#[3]'
And match $.response.payload.records[0].b2cDetails[0].referenceFieldLabel == 'Order Number'
And match $.response.payload.records[0].b2cDetails[0].isReferenceFieldMandatory == true
And match $.response.payload.records[0].b2cDetails[0].referenceFieldHelp == 'Please enter your order number above'
And match $.response.payload.records[0].b2cDetails[0].referenceFieldIndex == 'customField1'
And match $.response.payload.records[0].b2cDetails[1].referenceFieldLabel == 'Email Address'
And match $.response.payload.records[0].b2cDetails[1].isReferenceFieldMandatory == false
And match $.response.payload.records[0].b2cDetails[1].referenceFieldHelp == 'Enter Email Address'
And match $.response.payload.records[0].b2cDetails[1].referenceFieldIndex == 'customField4'
And match $.response.payload.records[0].b2cDetails[2].referenceFieldLabel == 'Phone Number'
And match $.response.payload.records[0].b2cDetails[2].isReferenceFieldMandatory == false
And match $.response.payload.records[0].b2cDetails[2].referenceFieldHelp == 'Please enter your phone number'
And match $.response.payload.records[0].b2cDetails[2].referenceFieldIndex == 'customField5'
And match $.response.payload.records[0].clientType == 'External'
And match $.response.payload.records[0].isReturnRestricted == 'N'
And match $.response.payload.records[0].clientReturnWebURL == 'https://development-direct.asda.com/on/demandware.store/Sites-ASDA-Site/default/Order-Track/'
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |



 
