@All @WS048 @WS048_TC009 @CDM @RASwEDD
Feature: WS048_TC009_CDM_RASwEDD_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS048_TC009_<scenarioId>_CDM_RASwEDD_Success_GET

#remotestores = N
Given url ws_cdm_url + '/services/v1/retrieveAvailableStoresWithEDD'
And param locationKey = 'Liverpool'
And param remotestores = 'N'
And param isCapacityChkRqrd = true
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
* def facilities = $.response.payload.records[0].facilities
* print 'facilities_count -> ', facilities.length
* def facilityIdArr = $.response.payload.records[0].facilities[*].facilityId
* print 'facilityIdArr -> ', facilityIdArr
#And match facilities == '#[13]'
And match facilityIdArr contains ['04736', '04580']
And match each $.response.payload.records[0].facilities[*].LOGD_val == 1
And match $.response.error == {}
 
Examples:
| scenarioId | clientId |
| S001       | 'GEC'    |




