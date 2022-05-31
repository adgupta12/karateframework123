@All @WS046 @WS046_TC005 @CDM @Client
Feature: WS046_TC005_CDM_Client_MIS_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS046_TC005_<scenarioId>_CDM_Client_MIS_GET
 
Given url ws_cdm_url + '/services/v1/client/MIS'
And param props = 'nscmap'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].client == 'MIS'
And match $.response.payload.records[0].nsc == '07520'
And match $.response.error == {}
 
Examples:
| scenarioId |
| S001       |



