@All @WS043 @WS043_TC011 @CDM @CreateLabel
Feature: WS043_TC011_CDM_CreateLabel_StoreShipping_Success_POST

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS043_TC011_<scenarioId>_CDM_CreateLabel_StoreShipping_Success_POST

* def reqBody = 
"""
{
  "inputValues": {
 		"isImageReq": false,
    "labelCode": <labelCode>,
    "rotate": <rotate>,
    "containerId": <lpn>,
    "originFacilityId": <originFacilityId>,
    "destFacilityId": "07789",
    "destFacility": "National Sort Center"
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
And match $.response.payload.records[0].lpn == <lpn>
And match $.response.payload.records[0].labelImageCode == '#null'
And match $.response.error == {}
 
Examples:
| scenarioId | labelCode        | lpn               | originFacilityId | rotate |
| S001       | 'StoreContainer' | 'S05731678901234' | '05731'          | true   |
| S001       | 'StoreContainer' | 'S05731678901234' | '05731'          | false  |


