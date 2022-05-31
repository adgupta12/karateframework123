@All @WS024 @WS024_TC002 @CDM @Facility
Feature: WS024_TC002_CDM_Facility_Error400_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS024_TC002_<scenarioId>_CDM_Facility_Error400_GET
 
Given url ws_cdm_url + '/services/v1/facility/facilityids'
And param comms = 'N'
And param isCleveron = 'N'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
When method get
Then status 200
And match $.responseCode == '111'
And match $.response.payload == {}
And match $.response.error.errors[0].description == 'Bad request'
And match $.response.error.errors[0].errorCode == '400'
And match $.response.error.errors[0].fields.isCleveron == 'N'
 
Examples:
| scenarioId |
| S001       |



