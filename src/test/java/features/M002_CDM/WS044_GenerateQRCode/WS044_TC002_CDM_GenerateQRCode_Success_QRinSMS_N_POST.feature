@All @WS044 @WS044_TC002 @CDM @GenerateQRCode
Feature: WS044_TC002_CDM_GenerateQRCode_Success_QRinSMS_N_POST

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS044_TC002_<scenarioId>_CDM_GenerateQRCode_Success_QRinSMS_N_POST

* def reqBody = 
"""
{
  "inputValues": {
    "qrData": {
      "orderNumber": "ORMISC102716034",
      "clientId": "MIS"
    },
    "size": <size>
  }
}

"""
 
Given url ws_cdm_url + '/services/v1/generateQRCode'
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = '1122334455'
And header QRinSMS = 'N'
And request reqBody
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].qrImageCode == '#regex [A-Za-z0-9+=\\/]+'
And match $.response.error == {}
 
Examples:
| scenarioId | size |
| S001       | 'S'  |
| S002       | 'M'  |
| S003       | 'L'  |


