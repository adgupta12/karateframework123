@All @WS048 @WS048_TC008 @CDM @RASwEDD
Feature: WS048_TC008_CDM_RASwEDD_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS048_TC008_<scenarioId>_CDM_RASwEDD_Success_GET

#remotestores = Y
Given url ws_cdm_url + '/services/v1/retrieveAvailableStoresWithEDD'
And param locationKey = 'Liverpool'
And param remotestores = 'Y'
And param isCapacityChkRqrd = true
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
* def facilities = $.response.payload.records[0].facilities
* print 'facilities -> ', facilities.length
And match facilities == '#[15]'
And match $.response.error == {}
 
Examples:
| scenarioId | clientId |
| S001       | 'GEC'    |




