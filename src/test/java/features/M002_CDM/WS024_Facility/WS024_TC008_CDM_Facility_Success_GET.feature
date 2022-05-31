@All @WS024 @WS024_TC008 @CDM @Facility
Feature: WS024_TC008_CDM_Facility_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS024_TC008_<scenarioId>_CDM_Facility_GET
 
Given url ws_cdm_url + '/services/v1/facility/facilityids'
And param comms = 'N'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records == '#array'
And match $.response.error == {}
 
Examples:
| scenarioId |
| S001       |



