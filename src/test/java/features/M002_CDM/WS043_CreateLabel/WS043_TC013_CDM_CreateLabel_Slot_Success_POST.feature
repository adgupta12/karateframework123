@All @WS043 @WS043_TC013 @CDM @CreateLabel
Feature: WS043_TC013_CDM_CreateLabel_Slot_Success_POST

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS043_TC013_<scenarioId>_CDM_CreateLabel_Slot_Success_POST

* def reqBody = 
"""
{
  "inputValues": {
    "labelCode": <labelCode>,
    "rotate": <rotate>,
    "zone": <zone>,
    "slotNumber": <slotNumber>
  }
}

"""
 
Given url ws_cdm_url + '/services/v1/createLabel'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = '1122334455'
And request reqBody
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].lpn == <zone> + <slotNumber>
And match $.response.payload.records[0].labelImageCode == '#regex [A-Za-z0-9+=\\/]+'
And match $.response.error == {}
 
Examples:
| scenarioId | labelCode | zone | slotNumber | rotate |
| S001       | 'Slot'    | 'D'  | '012'      | true   |
| S001       | 'Slot'    | 'D'  | '012'      | false  |


