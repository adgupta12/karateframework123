@All @WS043 @WS043_TC012 @CDM @CreateLabel
Feature: WS043_TC012_CDM_CreateLabel_StoreShipping_Success_POST

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS043_TC012_<scenarioId>_CDM_CreateLabel_StoreShipping_Success_POST

* def reqBody = 
"""
{
  "inputValues": {
  	"isImageReq": false,
    "labelCode": <labelCode>,
    "rotate": <rotate>,
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
* def lpn = $.response.payload.records[0].lpn
* def lpn1 = subString(lpn,0,4)
* def lpn2 = subString(lpn,5,13)
And match lpn1 == <originFacilityId>
And match lpn2 == '#regex [0-9]{9}'
And match $.response.payload.records[0].labelImageCode == '#null'
And match $.response.error == {}
 
Examples:
| scenarioId | labelCode        | originFacilityId | rotate |
| S001       | 'StoreContainer' | '05731'          | true   |
| S001       | 'StoreContainer' | '05731'          | false  |


