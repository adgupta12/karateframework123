@All @WS042 @WS042_TC004 @CDM @ConfigItems
Feature: WS042_TC004_CDM_ConfigItems_Strtabptrmap_ZEBRAKSK_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS042_TC004_<scenarioId>_CDM_ConfigItems_Strtabptrmap_ZEBRAKSK_Success_GET
 
Given url ws_cdm_url + '/services/v1/configitems/strtabptrmap'
And header Content-Type = 'application/json'
And header clientId = <clientId>
And header transactionId = currentDateTimeStamp
And header source = <source>
And header tabletId = <tabletId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records.strTabPtrMap[0].storeId == '#string'
And match $.response.payload.records.strTabPtrMap[0].storeName == '#string'
And match $.response.payload.records.strTabPtrMap[0].tablet == <tabletId>
And match $.response.payload.records.strTabPtrMap[0].printer == '#string'
 
Examples:
| scenarioId | clientId         | source     | tabletId                |
| S001       | 'ZEBRAKSK_05731' | 'ZEBRAKSK' | 'EMULATOR1593433299553' |

