@All @WS045 @WS045_TC015 @CDM @RetrieveB2CClient
Feature: WS045_TC015_CDM_RetrieveB2CClient_seokey_returnRestricted_Y_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS045_TC015_<scenarioId>_CDM_RetrieveB2CClient_seokey_returnRestricted_Y_Success_GET

Given url ws_cdm_url + '/services/v1/retrieveB2CClient'
And param isInternalClientRequired = 'Y'
And param isRetrieveAllRef = 'Y'
And param isImageReq = 'Y'
#Boohoo is used - return_restricted = Y in ORA_CERT_CDM.cdm_client_ref table
And param seokey = 'Boohoo'  
And header Content-Type = 'application/json'
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records == []
And match $.response.error == {}

Examples:
| scenarioId | source     | clientId         |
| S001       | 'STORE'    | '1122334455'     |
| S002       | 'KIOSK'    | 'KIOSK55'        |
| S003       | 'KIOSK'    | 'DRIVE55'        |
| S004       | 'ZEBRAKSK' | 'ZEBRAKSK_05731' |
| S005       | 'GEC'      | 'GEC'            |




 
