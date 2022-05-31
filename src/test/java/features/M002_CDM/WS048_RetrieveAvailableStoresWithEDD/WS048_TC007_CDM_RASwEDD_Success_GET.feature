@All @WS048 @WS048_TC007 @CDM @RASwEDD
Feature: WS048_TC007_CDM_RASwEDD_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS048_TC007_<scenarioId>_CDM_RASwEDD_Success_GET

#allFacilities
Given url ws_cdm_url + '/services/v1/retrieveAvailableStoresWithEDD'
And param allFacilities = true
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].derivedPostCode == '#null'
And match $.response.payload.records[0].radius == '#null'
* def facilities = $.response.payload.records[0].facilities
* print 'facilities -> ', facilities.length
And match $.response.error == {}
 
Examples:
| scenarioId | clientId |
| S001       | 'GEC'    |
| S002       | 'METAP'  |
| S003       | 'RGE'    |



