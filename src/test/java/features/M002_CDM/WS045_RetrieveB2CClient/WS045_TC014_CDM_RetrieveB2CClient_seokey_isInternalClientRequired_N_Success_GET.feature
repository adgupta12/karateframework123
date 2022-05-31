@All @WS045 @WS045_TC014 @CDM @RetrieveB2CClient
Feature: WS045_TC014_CDM_RetrieveB2CClient_seokey_isInternalClientRequired_N_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS045_TC014_<scenarioId>_CDM_RetrieveB2CClient_seokey_isInternalClientRequired_N_Success_GET

Given url ws_cdm_url + '/services/v1/retrieveB2CClient'
And param isInternalClientRequired = 'N'
And param isRetrieveAllRef = 'Y'
And param isImageReq = 'Y'
#Internal Client - seokey
And param seokey = 'Brandmax' 
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
| scenarioId | source  | clientId     |
| S001       | 'STORE' | '1122334455' |




 
