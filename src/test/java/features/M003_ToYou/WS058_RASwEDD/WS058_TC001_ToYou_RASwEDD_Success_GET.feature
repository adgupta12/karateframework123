@All @WS058 @WS058_TC001 @ToYou @RASwEDD
Feature: WS058_TC001_ToYou_RASwEDD_Success_GET

Background:
* print 'ws_toyou_widget_url -> ', ws_toyou_widget_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS058_TC001_<scenarioId>_ToYou_RASwEDD_Success_GET

Given url ws_toyou_widget_url + '/toyou-app/services/rest/widget/eddfacilities/locationkey'
And path <location>
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.status == 'OK'
And match $.payload[0].city == '#string'
And match $.payload[0].postCode == '#string'
And match each $.payload[0].facilities[*].facilityType == '#string'
And match each $.payload[0].facilities[*].facilityId == '#string'
And match each $.payload[0].facilities[*].facilityName == '#string'
And match each $.payload[0].facilities[*].phoneNo == '#string'
And match each $.payload[0].facilities[*].address == '#string'
And match each $.payload[0].facilities[*].postCode == '#string'
And match each $.payload[0].facilities[*].city == '#string'
And match each $.payload[0].facilities[*].county == '#string'
And match each $.payload[0].facilities[*].countryCode == '#string'
And match each $.payload[0].facilities[*].latitude == '#number'
And match each $.payload[0].facilities[*].longitude == '#number'
And match each $.payload[0].facilities[*].isCapacityAvailable == '#boolean'
And match each $.payload[0].facilities[*].facilityManager == '#string'
And match each $.payload[0].facilities[*].distance == '#number'
And match each $.payload[0].facilities[*].distanceMetric == '#string'
And match each $.payload[0].facilities[*].dwellTime == '#number'
And match each $.payload[0].facilities[*].services[*].name == '#string'
And match each $.payload[0].facilities[*].LOGD_val == '#number'
And match each $.payload[0].facilities[*].SUNA_val == '#string'
And match each $.payload[0].facilities[*].facilityisOperational == '#boolean'
And match each $.payload[0].facilities[*].depts[*].name == '#string'
And match each $.payload[0].facilities[*].depts[*].collectionTimings.Mon == '#string'
And match each $.payload[0].facilities[*].depts[*].collectionTimings.Tue == '#string'
And match each $.payload[0].facilities[*].depts[*].collectionTimings.Wed == '#string'
And match each $.payload[0].facilities[*].depts[*].collectionTimings.Thu == '#string'
And match each $.payload[0].facilities[*].depts[*].collectionTimings.Fri == '#string'
And match each $.payload[0].facilities[*].depts[*].collectionTimings.Sat == '#string'
And match each $.payload[0].facilities[*].depts[*].collectionTimings.Sun == '#string'
And match each $.payload[0].facilities[*].depts[*].returnTimings.Mon == '#string'
And match each $.payload[0].facilities[*].depts[*].returnTimings.Tue == '#string'
And match each $.payload[0].facilities[*].depts[*].returnTimings.Wed == '#string'
And match each $.payload[0].facilities[*].depts[*].returnTimings.Thu == '#string'
And match each $.payload[0].facilities[*].depts[*].returnTimings.Fri == '#string'
And match each $.payload[0].facilities[*].depts[*].returnTimings.Sat == '#string'
And match each $.payload[0].facilities[*].depts[*].returnTimings.Sun == '#string'
And match $.errors == []

Examples:
| scenarioId | clientId | location  |
| S001       | 'GEC'    | 'SO172HQ' |

