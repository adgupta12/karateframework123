@All @WS043 @WS043_TC006 @CDM @CreateLabel
Feature: WS043_TC006_CDM_CreateLabel_Collect_Success_POST

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS043_TC006_<scenarioId>_CDM_CreateLabel_Collect_Success_POST

* def reqBody = 
"""
{
  "inputValues": {
    "isImageReq": false,
    "labelCode": <labelCode>,
    "rotate": <rotate>,
    "parcelNo": <lpn>,
    "clientId": <clientId>,
    "custName": "P. George",
    "destFacility": "Bradford",
    "destFacilityId": "04501",
    "orderNumber": "12345",
    "serviceType": "Express",
    "EDD": "22/12/2020"
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
| scenarioId | labelCode    | lpn             | clientId | rotate |
| S001       | 'B2CCollect' | 'A01D567890123' | 'A01'    | true   |
| S002       | 'B2CCollect' | 'A01D567890123' | 'A01'    | false  |


