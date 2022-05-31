@All @WS045 @WS045_TC010 @CDM @RetrieveB2CClient
Feature: WS045_TC010_CDM_RetrieveB2CClient_All_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS045_TC010_<scenarioId>_CDM_RetrieveB2CClient_All_Success_GET

Given url ws_cdm_url + '/services/v1/retrieveB2CClient'
And param isInternalClientRequired = 'Y'
And param isRetrieveAllRef = 'Y'
And param isImageReq = 'Y'
And header Content-Type = 'application/json'
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
* def count = $.response.payload.records
* print 'Records count -> ', count.length
And match $.response.error == {}

Examples:
| scenarioId | source  | clientId     |
| S001       | 'STORE' | '1122334455' |





 
