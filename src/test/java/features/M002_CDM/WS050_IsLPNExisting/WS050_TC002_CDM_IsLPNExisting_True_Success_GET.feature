@All @WS050 @WS050_TC002 @CDM @IsLPNExisting
Feature: WS050_TC002_CDM_IsLPNExisting_True_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS050_TC002_<scenarioId>_CDM_IsLPNExisting_True_Success_GET

Given url ws_cdm_url + '/services/v1/isLpnExisting'
And path <parcelNumber>
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].parcelId == <parcelNumber>
And match $.response.payload.records[0].isLpnExisting == true
And match $.response.error == {}

Examples:
| scenarioId | clientId     | parcelNumber    |
| S001       | '1122334455' | 'ASDP567890135' |

