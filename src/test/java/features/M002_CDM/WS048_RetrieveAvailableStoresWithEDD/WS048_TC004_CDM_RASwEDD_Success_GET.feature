@All @WS048 @WS048_TC004 @CDM @RASwEDD
Feature: WS048_TC004_CDM_RASwEDD_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS048_TC004_<scenarioId>_CDM_RASwEDD_Success_GET

#locationKey - post code
Given url ws_cdm_url + '/services/v1/retrieveAvailableStoresWithEDD'
And param locationKey = 'WF10 5UA'
And param isCapacityChkRqrd = true
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].derivedPostCode == 'WF10 5UA'
And match $.response.payload.records[0].radius == 25
* def facilities = $.response.payload.records[0].facilities
* print 'facilities -> ', facilities.length
And match $.response.error == {}
 
Examples:
| scenarioId | clientId |
| S001       | 'GEC'    |
| S002       | 'METAP'  |
| S003       | 'RGE'    |



