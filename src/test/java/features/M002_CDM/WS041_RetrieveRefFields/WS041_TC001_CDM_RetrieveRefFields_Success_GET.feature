@All @WS041 @WS041_TC001 @CDM @RetrieveRefFields
Feature: WS041_TC001_CDM_RetrieveRefFields_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS041_TC001_<scenarioId>_CDM_RetrieveRefFields_GET
 
Given url ws_cdm_url + '/services/v1/retrievereffields'
And path <parcelNumber>
And header Content-Type = 'application/json'
And header clientId = <clientId>
And header transactionId = currentDateTimeStamp
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].parcelNo == <parcelNumber>
And match $.response.payload.records[0].isCustomField1Mandatory == 'Y'
And match $.response.payload.records[0].customField1Label == 'Order Number'
And match $.response.payload.records[0].customField1value == 'OR123456'
And match $.response.payload.records[0].isCustomField2Mandatory == 'Y'
And match $.response.payload.records[0].customField2Label == 'Customer Name'
And match $.response.payload.records[0].customField2value == 'Neo Anderson'
And match $.response.payload.records[0].isCustomField3Mandatory == 'N'
And match $.response.payload.records[0].customField3Label == '#null'
And match $.response.payload.records[0].customField3value == '#null'
And match $.response.payload.records[0].isCustomField4Mandatory == 'N'
And match $.response.payload.records[0].customField4Label == 'Email Address'
And match $.response.payload.records[0].customField4value == 'test@test.com'
And match $.response.payload.records[0].isCustomField5Mandatory == 'N'
And match $.response.payload.records[0].customField5Label == 'Phone Number'
And match $.response.payload.records[0].customField5value == '#null'
And match $.response.payload.V_28_DAYS_OLD_FLAG == '#regex (Y|N)'
And match $.response.error == {}
 
Examples:
| scenarioId | clientId         | parcelNumber    |
| S001       | '1122334455'     | 'ASOD111531759' |
| S002       | 'ZEBRAKSK_05731' | 'ASOD111531759' |

