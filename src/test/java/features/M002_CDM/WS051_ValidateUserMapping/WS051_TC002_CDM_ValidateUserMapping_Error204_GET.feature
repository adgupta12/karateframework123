@All @WS051 @WS051_TC002 @CDM @ValidateUserMapping
Feature: WS051_TC002_CDM_ValidateUserMapping_Error204_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS051_TC002_<scenarioId>_CDM_ValidateUserMapping_Error204_GET

Given url ws_cdm_url + '/services/v1/validateUserMapping'
And param userId = <userId>
And param storeId = <storeId>
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '111'
And match $.response.payload == {}
And match $.response.error.errors[0].description == 'User and Store Mapping is not present'
And match $.response.error.errors[0].errorCode == '204'
And match $.response.error.errors[0].fields.userId == <userId>
And match $.response.error.errors[0].fields.storeId == <storeId>

Examples:
| scenarioId | clientId     | userId    | storeId |
| S001       | '1122334455' | 'vn0hwvq' | '05731' |

