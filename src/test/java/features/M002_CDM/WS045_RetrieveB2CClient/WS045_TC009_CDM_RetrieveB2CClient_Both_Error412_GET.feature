@All @WS045 @WS045_TC009 @CDM @RetrieveB2CClient
Feature: WS045_TC009_CDM_RetrieveB2CClient_Both_Error412_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS045_TC009_<scenarioId>_CDM_RetrieveB2CClient_Both_Error412_Success_GET

Given url ws_cdm_url + '/services/v1/retrieveB2CClient'
And param isInternalClientRequired = 'Y'
And param isRetrieveAllRef = 'Y'
And param isImageReq = 'Y'
And param clientId = 'MIS'
And param seokey = 'missguided'
And header Content-Type = 'application/json'
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '111'
And match $.response.payload == {}
And match $.response.error.errors[0].description == 'Invalid Parameter-More than one of the following input parameter recieved'
And match $.response.error.errors[0].errorCode == '412'
And match $.response.error.errors[0].fields.seokey == 'missguided'
And match $.response.error.errors[0].fields.clientId == 'MIS'

Examples:
| scenarioId | source     | clientId         |
| S001       | 'STORE'    | '1122334455'     |
| S002       | 'KIOSK'    | 'KIOSK55'        |
| S003       | 'KIOSK'    | 'DRIVE55'        |
| S004       | 'ZEBRAKSK' | 'ZEBRAKSK_05731' |
| S005       | 'GEC'      | 'GEC'            |




 
