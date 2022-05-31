@All @WS049 @WS049_TC001 @CDM @GetClientNSCMap
Feature: WS049_TC001_CDM_GetClientNSCMap_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS049_TC001_<scenarioId>_CDM_GetClientNSCMap_Success_GET
 
Given url ws_cdm_url + '/services/v1/getClientNSCMap'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
When method get
Then status 200
And match $.responseCode == '000'
And match each $.response.payload.records[*].client == '#regex [A-Z0-9]{3}'
And match each $.response.payload.records[*].nsc == '#regex [0-9]{5}'
* def records = $.response.payload.records
* print 'records -> ', records.length
And match $.response.error == {}
 
Examples:
| scenarioId |
| S001       |



