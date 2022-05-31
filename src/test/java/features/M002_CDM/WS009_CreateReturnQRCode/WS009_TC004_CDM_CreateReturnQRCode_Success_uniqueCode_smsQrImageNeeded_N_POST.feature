@All @WS009 @WS009_TC004 @CDM @CreateReturnQRCode @ignore
Feature: WS009_TC004_CDM_CreateReturnQRCode_Success_uniqueCode_smsQrImageNeeded_N_POST

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS009_TC004_<scenarioId>_CreateReturnQRCode_Success_uniqueCode_smsQrImageNeeded_N_POST
 
#* def parcelNumber1 = getB2CParcelNumberTNAS(<storeId>,'4','1','TNAS')
* def parcelNumber1 = getB2CParcelNumber(<storeId>,'4','1','vn0hwvq')
* print 'parcelNumber -> ', parcelNumber1
* def cdmQRLinkDetailsList = getParcelDetailsFromCDM_QR_LINKTable(parcelNumber1)
* def uniqueCode = cdmQRLinkDetailsList[0]
* def orderNumber = cdmQRLinkDetailsList[1]
* def location = cdmQRLinkDetailsList[3]
* def dwellTimeExpiryDate = cdmQRLinkDetailsList[4]
* def dwellTimeExpiryDate1 = subString(dwellTimeExpiryDate,0,9)
* def dwellTimeExpiryDate2 = formatDate(dwellTimeExpiryDate1, 'yyyy-MM-dd', 'E, MMM dd yyyy')

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
And header smsQrImageNeeded = 'N'
And request reqBody
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].location == location
And match $.response.payload.records[0].dwellTimeExpiryDate == dwellTimeExpiryDate2
And match $.response.payload.records[0].orderNum == orderNumber
And match $.response.payload.records[0].lpn == parcelNumber1
And match $.response.error == {}

Examples:
| scenarioId | storeId | 
| S001       | '05731' |

