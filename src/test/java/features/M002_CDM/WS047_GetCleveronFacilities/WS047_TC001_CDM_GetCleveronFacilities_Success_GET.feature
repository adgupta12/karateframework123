#decommissioned 

@ignore @decommissioned
Feature: WS047_TC001_CDM_GetCleveronFacilities_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS047_TC001_<scenarioId>_CDM_GetCleveronFacilities_Success_GET
 
Given url ws_cdm_url + '/services/v1/getCleveronFacilities'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
When method get
Then status 200
And match $.responseCode == '000'
And match each $.response.payload.records[*].facilityId == '#regex [0-9]{5}'
* def records = $.response.payload.records
* print 'records -> ', records.length
And match $.response.error == {}
 
Examples:
| scenarioId |
| S001       |



