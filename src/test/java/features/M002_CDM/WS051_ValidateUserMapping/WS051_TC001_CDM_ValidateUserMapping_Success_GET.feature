@All @WS051 @WS051_TC001 @CDM @ValidateUserMapping
Feature: WS051_TC001_CDM_ValidateUserMapping_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS051_TC001_<scenarioId>_CDM_ValidateUserMapping_Success_GET

Given url ws_cdm_url + '/services/v1/validateUserMapping'
And param userId = <userId>
And param storeId = <storeId>
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].userId == <userId>
And match $.response.payload.records[0].storeId == <storeId>
And match $.response.payload.records[0].fName == '#null'
And match $.response.payload.records[0].lName == '#null'
And match $.response.payload.records[0].active == true
And match $.response.error == {}

Examples:
| scenarioId | clientId     | userId    | storeId |
| S001       | '1122334455' | 'tkumarp' | '04137' |

