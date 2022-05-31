@All @WS046 @WS046_TC002 @CDM @Client
Feature: WS046_TC002_CDM_Client_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS046_TC002_<scenarioId>_CDM_Client_GET
 
Given url ws_cdm_url + '/services/v1/client'
And param props = 'nscmap'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
When method get
Then status 200
And match $.responseCode == '000'
* def nscmaprecords = $.response.payload.records
* print 'nscmaprecords -> ', nscmaprecords.length
And match $.response.error == {}
 
Examples:
| scenarioId |
| S001       |



