@All @WS042 @WS042_TC003 @CDM @ConfigItems
Feature: WS042_TC003_CDM_ConfigItems_Config_ZEBRAKSK_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS042_TC003_<scenarioId>_CDM_ConfigItems_Config_ZEBRAKSK_Success_GET
 
Given url ws_cdm_url + '/services/v1/configitems/config'
And header Content-Type = 'application/json'
And header clientId = <clientId>
And header transactionId = currentDateTimeStamp
And header source = <source>
And header tabletId = <tabletId>
When method get
Then status 200
And match $.responseCode == '000'
And match each $.response.payload.records.config[*].id == '#string'
And match each $.response.payload.records.config[*].key == '#string'
And match each $.response.payload.records.config[*].value == '#string'
And match each $.response.payload.records.config[*].desc == '#string'
* def config = $.response.payload.records.config
* print 'config_count -> ', config.length
And match $.response.error == {}
 
Examples:
| scenarioId | clientId         | source     | tabletId                |
| S001       | 'ZEBRAKSK_05731' | 'ZEBRAKSK' | 'EMULATOR1593433299553' |

