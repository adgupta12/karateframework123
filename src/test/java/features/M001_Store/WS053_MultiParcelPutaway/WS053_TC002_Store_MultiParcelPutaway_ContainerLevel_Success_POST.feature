@All @WS053 @WS053_TC002 @Store @MultiParcelPutaway @ignore
Feature: WS053_TC002_Store_MultiParcelPutaway_ContainerLevel_Success_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS053_TC002_<scenarioId>_Store_MultiParcelPutaway_ContainerLevel_Success_POST

* def reqBody = 
"""
{
  "zone": "D",
  "slot": "D001",
  "level": "container",
  "itemList": ["07520007147247"]
}
"""

Given url ws_url + '/Connect/v1/parcel'
And param action = 'putaway'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload == {}
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

