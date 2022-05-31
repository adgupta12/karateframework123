@All @WS045 @WS045_TC001 @CDM @RetrieveB2CClient
Feature: WS045_TC001_CDM_RetrieveB2CClient_clientId_isImageReq_Y_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS045_TC001_<scenarioId>_CDM_RetrieveB2CClient_clientId_isImageReq_Y_Success_GET

Given url ws_cdm_url + '/services/v1/retrieveB2CClient'
And param isInternalClientRequired = 'Y'
And param isRetrieveAllRef = 'Y'
And param isImageReq = 'Y'
And param clientId = 'MIS'
And header Content-Type = 'application/json'
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].clientId == 'MIS'
And match $.response.payload.records[0].clientName == 'Missguided'
And match $.response.payload.records[0].clientLegalName == '#string'
And match $.response.payload.records[0].isActive == '#boolean'
And match $.response.payload.records[0].clientMessage == '#string'
And match $.response.payload.records[0].clientReturnsMessageSubtitle == '#string'
And match $.response.payload.records[0].clientWebsiteURL == '#string'
And match $.response.payload.records[0].customField1Label == '#string'
And match $.response.payload.records[0].isCustomField1Mandatory == true
And match $.response.payload.records[0].customField1Help == '#string'
And match $.response.payload.records[0].customField2Label == '#string'
And match $.response.payload.records[0].isCustomField2Mandatory == true
And match $.response.payload.records[0].customField2Help == '#string'
And match $.response.payload.records[0].customField3Label == '##string'
And match $.response.payload.records[0].isCustomField3Mandatory == false
And match $.response.payload.records[0].customField3Help == '##string'
And match $.response.payload.records[0].customField4Label == '#string'
And match $.response.payload.records[0].isCustomField4Mandatory == false
And match $.response.payload.records[0].customField4Help == '#string'
And match $.response.payload.records[0].customField5Label == '#string'
And match $.response.payload.records[0].isCustomField5Mandatory == false
And match $.response.payload.records[0].customField5Help == '#string'
And match $.response.payload.records[0].clientType == 'External'
And match $.response.payload.records[0].clientRetFacilityNum == '07520'
And match $.response.payload.records[0].clientRetFacilityName == 'South Elmsall NSC'
And match $.response.payload.records[0].clientRetFacilityAddress == 'Elmsall Way '
And match $.response.payload.records[0].clientCallCentreNum == '#string'
And match $.response.payload.records[0].clientCallCentreEmail == '#string'
And match $.response.payload.records[0].websiteLogoUrl == '#string'
And match $.response.payload.records[0].seokey == '#string'
And match $.response.payload.records[0].base64Logo == '#regex [A-Za-z0-9+=\\/\\r\\n]+'
And match $.response.payload.records[0].isReturnRestricted == '#string'
And match $.response.error == {}

Examples:
| scenarioId | source     | clientId         |
| S001       | 'STORE'    | '1122334455'     |
| S002       | 'KIOSK'    | 'KIOSK55'        |
| S003       | 'KIOSK'    | 'DRIVE55'        |
| S004       | 'ZEBRAKSK' | 'ZEBRAKSK_05731' |




 
