@All @WS009 @WS009_TC001 @CDM @CreateReturnQRCode
Feature: WS009_TC001_CDM_CreateReturnQRCode_Success_inputValues_POST

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS009_TC001_<scenarioId>_CDM_CreateReturnQRCode_Success_inputValues_POST

* def reqBody = 
"""
{
    "inputValues": {
        "labelCode": <labelCode>,
        "rotate": false,
        "clientId": <clientId>,
        "refField1": "OrderNumber",
        "refField1Value": "ORDER678901234567890",
        "refField2": "Name",
        "refField2Value": "John Alexander Smith",
        "refField3": "Joker",
        "refField3Value": "RETURN78901234567890",
        "refField4": "Email",
        "refField4Value": "john.smith@somedomain.com",
        "refField5": "Phone",
        "refField5Value": "07001001000"
    }
}

"""
 
Given url ws_cdm_url + '/services/v1/createReturnQRCode'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = 'GEC'
And request reqBody
When method post
Then status 200
And match $.responseCode == '000'
* def lpn = $.response.payload.records[0].lpn
* def lpn1 = subString(lpn,0,3)
* def lpn2 = subString(lpn,4,12)
And match lpn1 == <clientId> + <serviceId>
And match lpn2 == '#regex [0-9]{9}'
* def qrImageCode = $.response.payload.records[0].qrImageCode
And match qrImageCode == '#regex [A-Za-z0-9+=\\/]+'
* def decodedQRImageCode = decodeBase64QRCode(qrImageCode)
And match decodedQRImageCode == 'LPN=' + lpn
And match $.response.error == {}
 
Examples:
| scenarioId | labelCode         | clientId | serviceId |
| S001       | 'B2CWebReturn'    | 'ASO'    | 'P'       |
| S002       | 'A2CWebReturn'    | 'ASD'    | 'P'       |
| S003       | 'B2CWidgetReturn' | 'MIS'    | 'Q'       |
| S004       | 'A2CWidgetReturn' | 'ASD'    | 'Q'       |

