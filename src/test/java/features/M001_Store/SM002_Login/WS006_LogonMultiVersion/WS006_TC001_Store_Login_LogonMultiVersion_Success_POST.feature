@All @WS006 @WS006_TC001 @Store @Login @LogonMultiVersion
Feature: WS006_TC001_Store_Login_LogonMultiVersion_Success_POST

Background:
* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS006_TC001_<scenarioId>_Store_Login_LogonMultiVersion_Success_POST
 
* def reqBody = 
"""
{
    "userId": <userId>,
    "storeId": <storeId>,
    "token": <token>,
    "loginAs": "SMART",
    "primaryJobCode": "",
    "secondaryJobCode": "",
    "appVersion": "2.3.49.049",
    "clientType": "Browser"
}

"""
 
Given url ws_url + '/Connect/v1/logonmultiversion'
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
And match $.response.payload.records[0].role == 'ASDAhouse_Team'
And match $.response.payload.records[0].functionalityList[0] == 'Receive Shipment' 
And match $.response.payload.records[0].functionalityList[1] == 'Putaway' 
And match $.response.payload.records[0].functionalityList[2] == 'Confirm Delivery Complete' 
And match $.response.payload.records[0].functionalityList[3] == 'Drop Off/Return' 
And match $.response.payload.records[0].functionalityList[4] == 'Parcel Collection' 
And match $.response.payload.records[0].functionalityList[5] == 'Parcel Movement'
And match $.response.payload.records[0].functionalityList[6] == 'Audit Putaway'
And match $.response.payload.records[0].functionalityList[7] == 'Location Management'
And match $.response.error == {} 
 
Examples:
| scenarioId | userId    | storeId | source  | clientId     | token                                                                                                                              |
| S001       | 'vn0hwvq' | '05755' | 'STORE' | '1122334455' | '5b07d9617d1f100ab2b42c588daf0ce0cacad59b9ee3e8b1df0ea794de435b0e180309de7ee14552004876f815e0d83f3e2ee74bef0b3e6721ca7c7913384397' |
| S002       | 'vn0hwvq' | '05731' | 'STORE' | '1122334455' | '5b07d9617d1f100ab2b42c588daf0ce0cacad59b9ee3e8b1df0ea794de435b0e180309de7ee14552004876f815e0d83f3e2ee74bef0b3e6721ca7c7913384397' |
 

