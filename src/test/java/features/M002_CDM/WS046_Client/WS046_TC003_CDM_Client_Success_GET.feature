@All @WS046 @WS046_TC003 @CDM @Client
Feature: WS046_TC003_CDM_Client_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS046_TC003_<scenarioId>_CDM_Client_GET
 
Given url ws_cdm_url + '/services/v1/client'
And param props = 'nscmap,collectionsla'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
When method get
Then status 200
And match $.responseCode == '000'
* def nscmaprecords = $.response.payload.records
* print 'nscmaprecords -> ', nscmaprecords.length
* def collectionslarecords = $.response.payload.collectionslarecords
* print 'collectionslarecords -> ', collectionslarecords.length
And match $.response.error == {}
 
Examples:
| scenarioId |
| S001       |



