@All @WS043 @WS043_TC003 @CDM @CreateLabel
Feature: WS043_TC003_CDM_CreateLabel_Return_Success_POST

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS043_TC003_<scenarioId>_CDM_CreateLabel_Return_Success_POST

* def reqBody = 
"""
{
  "inputValues": {
    "isImageReq": false,
    "parcelType": <parcelType>,
    "labelCode": <labelCode>,
    "rotate": <rotate>,
    "clientId": <clientId>,
    "refField1": "XYZ",
    "refField1Value": "ABC",
    "refField2": "XYZ",
    "refField2Value": "ABC",
    "refField3": "XYZ",
    "refField3Value": "ABC"
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
And match $.response.payload.records[0].labelImageCode == '#null'
And match $.response.error == {}
 
Examples:
| scenarioId | labelCode        | serviceId | parcelType | clientId | rotate |
| S001       | 'B2CWebReturn'   | 'D'       | 'B2C'      | 'A01'    | true   |
| S002       | 'B2CStoreReturn' | 'E'       | 'B2C'      | 'A01'    | true   |
| S003       | 'B2CKioskReturn' | 'F'       | 'B2C'      | 'A01'    | true   |
| S004       | 'A2CWebReturn'   | 'D'       | 'A2C'      | 'ASD'    | true   |
| S005       | 'A2CStoreReturn' | 'E'       | 'A2C'      | 'ASD'    | true   |
| S006       | 'A2CKioskReturn' | 'F'       | 'A2C'      | 'ASD'    | true   |

