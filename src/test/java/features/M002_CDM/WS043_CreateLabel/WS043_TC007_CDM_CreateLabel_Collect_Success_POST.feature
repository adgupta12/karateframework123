@All @WS043 @WS043_TC007 @CDM @CreateLabel
Feature: WS043_TC007_CDM_CreateLabel_Collect_Success_POST

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS043_TC007_<scenarioId>_CDM_CreateLabel_Collect_Success_POST

* def reqBody = 
"""
{
  "inputValues": {
    "isImageReq": true,
    "labelCode": <labelCode>,
    "rotate": <rotate>,
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
* def lpn = $.response.payload.records[0].lpn
* def lpn1 = subString(lpn,0,2)
* def lpn2 = subString(lpn,3,3)
* def lpn3 = subString(lpn,4,12)
And match lpn1 == <clientId>
And match lpn2 == <serviceId>
And match lpn3 == '#regex [0-9]{9}'
And match $.response.payload.records[0].labelImageCode == '#regex [A-Za-z0-9+=\\/]+'
And match $.response.error == {}
 
Examples:
| scenarioId | labelCode    | serviceId | clientId | rotate |
| S001       | 'B2CCollect' | 'B'       | 'A01'    | true   |
| S002       | 'B2CCollect' | 'B'       | 'A01'    | false  |


