@All @WS012 @WS012_TC001 @Store @GetAllASNsDetails
Feature: WS012_TC001_Store_Putaway_GetAllASNsDetails_Success_GET

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS012_TC001_<scenarioId>_Store_Putaway_GetAllASNsDetails_Success_GET

* def consignmentId = '001151067'

Given url ws_url + '/Connect/v1/parcelputaway/consignment'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.invocationResult.isSuccessful == 'true'
And match $.invocationResult.errors.errorCode == '000'
And match $.invocationResult.errors.errorDesc == 'Success'
* def resultList = $.invocationResult.result
* print 'Result count is ', resultList.length
* def hrefList = $.invocationResult.result[*].href
* def asnList = $.invocationResult.result[*].asn
* def timeList = $.invocationResult.result[*].time
* match each hrefList == '#regex \\/parcelputaway\\/consignment\\/[0-9]{9}'
* match each asnList == '#regex [0-9]{9}'
* match each timeList == '#regex [0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}'


Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' |
| S002       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |
 
