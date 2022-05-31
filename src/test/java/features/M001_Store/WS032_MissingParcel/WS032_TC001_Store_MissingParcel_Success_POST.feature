@All @WS032 @WS032_TC001 @Store @MissingParcel
Feature: WS032_TC001_Store_MissingParcel_Success_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS032_TC001_<scenarioId>_Store_MissingParcel_Success_POST

* def reqBody = 
"""
{
	"missingParcel":{
		"orderId":"",
		"moduleName":"Return",
		"parcelList":["ASDA100586585"]
	}
}
"""

Given url ws_url + '/Connect/v1/missingparcel'
And header Content-Type = 'application/json'
And header userId = <userId>
And header storeId = <storeId>
And header source = <source>
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
And request reqBody
When method post
Then status 200
And match $.responseCode == '000'
And match $.response.payload == {}
And match $.response.error == {}

Examples:
| scenarioId | userId    | storeId | source  | clientId     |
| S001       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' |

