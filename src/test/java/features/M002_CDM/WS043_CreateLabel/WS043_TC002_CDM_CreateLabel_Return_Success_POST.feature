@All @WS043 @WS043_TC002 @CDM @CreateLabel
Feature: WS043_TC002_CDM_CreateLabel_Return_Success_POST

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS043_TC002_<scenarioId>_CDM_CreateLabel_Return_Success_POST

* def reqBody = 
"""
{
  "inputValues": {
    "isImageReq": false,
    "parcelType": <parcelType>,
    "labelCode": <labelCode>,
    "rotate": <rotate>,
    "parcelNo": <lpn>,
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
And match $.response.payload.records[0].lpn == <lpn>
And match $.response.payload.records[0].labelImageCode == '#null'
And match $.response.error == {}
 
Examples:
| scenarioId | labelCode        | lpn             | parcelType | clientId | rotate |
| S001       | 'B2CWebReturn'   | 'A01D567890123' | 'B2C'      | 'A01'    | true   |
| S002       | 'B2CStoreReturn' | 'A01E567890123' | 'B2C'      | 'A01'    | true   |
| S003       | 'B2CKioskReturn' | 'A01F567890123' | 'B2C'      | 'A01'    | true   |
| S004       | 'A2CWebReturn'   | 'ASDD567890123' | 'A2C'      | 'ASD'    | true   |
| S005       | 'A2CStoreReturn' | 'ASDE567890123' | 'A2C'      | 'ASD'    | true   |
| S006       | 'A2CKioskReturn' | 'ASDF567890123' | 'A2C'      | 'ASD'    | true   |
| S007       | 'B2CWebReturn'   | 'A01D567890123' | 'B2C'      | 'A01'    | false  |
| S008       | 'B2CStoreReturn' | 'A01E567890123' | 'B2C'      | 'A01'    | false  |
| S009       | 'B2CKioskReturn' | 'A01F567890123' | 'B2C'      | 'A01'    | false  |
| S010       | 'A2CWebReturn'   | 'ASDD567890123' | 'A2C'      | 'ASD'    | false  |
| S011       | 'A2CStoreReturn' | 'ASDE567890123' | 'A2C'      | 'ASD'    | false  |
| S012       | 'A2CKioskReturn' | 'ASDF567890123' | 'A2C'      | 'ASD'    | false  |

