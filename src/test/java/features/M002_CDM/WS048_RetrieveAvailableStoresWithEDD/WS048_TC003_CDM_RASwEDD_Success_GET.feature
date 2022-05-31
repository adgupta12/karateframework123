@All @WS048 @WS048_TC003 @CDM @RASwEDD
Feature: WS048_TC003_CDM_RASwEDD_Success_GET

Background:
* print 'ws_cdm_url -> ', ws_cdm_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario Outline: WS048_TC003_<scenarioId>_CDM_RASwEDD_Success_GET

#prefFacilityId - radius query parameter added
Given url ws_cdm_url + '/services/v1/retrieveAvailableStoresWithEDD'
And param prefFacilityId = '05731'
And param isCapacityChkRqrd = false
And param radius = 30
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.responseCode == '000'
And match $.response.payload.records[0].derivedPostCode == 'WF10 5UA'
And match $.response.payload.records[0].radius == 30
And match $.response.payload.records[0].facilities[0].facilityType == 'Supermarket'
And match $.response.payload.records[0].facilities[0].facilityId == '05731'
And match $.response.payload.records[0].facilities[0].EDD == '#null'
And match $.response.payload.records[0].facilities[0].EDT_MonSat == '#null'
And match $.response.payload.records[0].facilities[0].EDT_Sun == '#null'
And match $.response.payload.records[0].facilities[0].LOGD_val == 2
And match $.response.payload.records[0].facilities[0].LOGD_msg == 'Please allow an additional day for deliveries to this store.'
And match $.response.payload.records[0].facilities[0].SUNA_val == 'Y'
And match $.response.payload.records[0].facilities[0].SUNA_msg == '#null'
And match $.response.payload.records[0].facilities[0].facilityName == 'Cave'
And match $.response.payload.records[0].facilities[0].facilityisOperational == true
And match $.response.payload.records[0].facilities[0].isToYouEnabled == true
And match $.response.payload.records[0].facilities[0].phoneNo == '00441138268200'
And match $.response.payload.records[0].facilities[0].addressLine1 == 'Express Way'
And match $.response.payload.records[0].facilities[0].addressLine2 == 'Wakefield Europort'
And match $.response.payload.records[0].facilities[0].postCode == 'WF10 5UA'
And match $.response.payload.records[0].facilities[0].city == 'Castleford'
And match $.response.payload.records[0].facilities[0].county == 'West Yorkshire'
And match $.response.payload.records[0].facilities[0].countryCode == 'GB'
And match $.response.payload.records[0].facilities[0].latitude == '#number'
And match $.response.payload.records[0].facilities[0].longitude == '#number'
And match $.response.payload.records[0].facilities[0].facilityManager == '#string'
And match $.response.payload.records[0].facilities[0].distance == 0.0
And match $.response.payload.records[0].facilities[0].dwellTime == '#number'
And match $.response.payload.records[0].facilities[0].isCapacityAvailable == '#null'
And match each $.response.payload.records[0].facilities[0].depts[*].name == '#regex (TO_YOU_MANNED_COLLECTION|TO_YOU_MANNED_RETURN|TO_YOU_ZEBRA_KIOSK_COLLECTION|TO_YOU_ZEBRA_KIOSK_RETURN|TO_YOU_CLEVERON_TOWER|TO_YOU_CLEVERON_FLEX|TO_YOU_KIOSK_COLLECTION|TO_YOU_KIOSK_RETURN|TO_YOU_LOCKERBOX_COLLECTION|TO_YOU_LOCKERBOX_RETURN)'
And match each $.response.payload.records[0].facilities[0].depts[*].monHours == '#ignore'
And match each $.response.payload.records[0].facilities[0].depts[*].tueHours == '#ignore'
And match each $.response.payload.records[0].facilities[0].depts[*].wedHours == '#ignore'
And match each $.response.payload.records[0].facilities[0].depts[*].thuHours == '#ignore'
And match each $.response.payload.records[0].facilities[0].depts[*].friHours == '#ignore'
And match each $.response.payload.records[0].facilities[0].depts[*].satHours == '#ignore'
And match each $.response.payload.records[0].facilities[0].depts[*].sunHours == '#ignore'
#And match each $.response.payload.records[0].facilities[0].depts[*].sunHours == '#regex [0-2][0-9]:[0-6][0-9]-[0-2][0-9]:[0-6][0-9]'
And match each $.response.payload.records[0].facilities[0].services[*].name == '#string'
And match $.response.error == {}
 
Examples:
| scenarioId | clientId |
| S001       | 'GEC'    |
| S002       | 'METAP'  |
| S003       | 'RGE'    |



