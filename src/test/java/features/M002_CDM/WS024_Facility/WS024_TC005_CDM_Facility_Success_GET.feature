@All @WS024 @WS024_TC005 @CDM @Facility
Feature: WS024_TC005_CDM_Facility_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS024_TC005_<scenarioId>_CDM_Facility_GET
 
Given url ws_cdm_url + '/services/v1/facility/'
And path <facilityId>
And param props = 'comms_details'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].derivedPostCode == 'WF10 5UA'
And match $.response.payload.records[0].facilities[0].facilityType == 'Supermarket'
And match $.response.payload.records[0].facilities[0].facilityId == <facilityId>
And match $.response.payload.records[0].facilities[0].facilityName == 'Cave'
And match $.response.payload.records[0].facilities[0].addressLine1 == 'Express Way'
And match $.response.payload.records[0].facilities[0].addressLine2 == 'Wakefield Europort'
And match $.response.payload.records[0].facilities[0].postCode == 'WF10 5UA'
And match $.response.payload.records[0].facilities[0].city == 'Castleford'
And match $.response.payload.records[0].facilities[0].county == 'West Yorkshire'
And match $.response.payload.records[0].facilities[0].countryCode == 'GB'
And match $.response.payload.records[0].facilities[0].dwellTime == '#number'
And match each $.response.payload.records[0].facilities[0].depts[*] == '#string'
And match $.response.error == {}
 
Examples:
| scenarioId | facilityId |
| S001       | '05731'    |

