@All @WS009 @WS009_TC002 @CDM @CreateReturnQRCode @ignore
Feature: WS009_TC002_CDM_CreateReturnQRCode_Success_uniqueCode_POST

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS009_TC002_<scenarioId>_CDM_CreateReturnQRCode_Success_uniqueCode_POST

#* def parcelNumber1 = getB2CParcelNumberTNAS(<storeId>,'4','1','TNAS')
* def parcelNumber1 = getB2CParcelNumber(<storeId>,'4','1','vn0hwvq')
* print 'parcelNumber -> ', parcelNumber1  
* def cdmQRLinkDetailsList = getParcelDetailsFromCDM_QR_LINKTable(parcelNumber1)
* def uniqueCode = cdmQRLinkDetailsList[0]
* def orderNumber = cdmQRLinkDetailsList[1]
* def clientName = cdmQRLinkDetailsList[2]
* def location = cdmQRLinkDetailsList[3]
* def dwellTimeExpiryDate = cdmQRLinkDetailsList[4]
* def dwellTimeExpiryDate1 = subString(dwellTimeExpiryDate,0,9)
* def dwellTimeExpiryDate2 = formatDate(dwellTimeExpiryDate1, 'yyyy-MM-dd', 'E, MMM dd yyyy')

* def client_id = getClientDetailsFromCdm_client_refTable(clientName)
 
* def reqBody = 
"""
{
    "uniqueCode": #(uniqueCode)
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
And match $.response.payload.records[0].location == location
And match $.response.payload.records[0].dwellTimeExpiryDate == dwellTimeExpiryDate2
And match $.response.payload.records[0].orderNum == orderNumber
And match $.response.payload.records[0].lpn == parcelNumber1
* def qrImageCode = $.response.payload.records[0].qrImageCode
And match qrImageCode == '#regex [A-Za-z0-9+=\\/]+'
* def decodedQRImageCode = decodeBase64QRCode(qrImageCode)
#And match decodedQRImageCode == '{"orderNumber":"' + orderNumber + '","clientId":"TNA"}'
And match decodedQRImageCode == '{"orderNumber":"' + orderNumber + '","clientId":"' + client_id + '"}'
And match $.response.error == {}

Examples:
| scenarioId |  userId    | storeId | source  | clientId     | slotId | 
| S001       | 'vn0hwvq'  | '05731' | 'STORE' | '1122334455' | '001'  |

