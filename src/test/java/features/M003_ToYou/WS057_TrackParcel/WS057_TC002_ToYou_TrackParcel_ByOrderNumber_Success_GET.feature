@All @WS057 @WS057_TC002 @ToYou @TrackParcel
Feature: WS057_TC002_ToYou_TrackParcel_ByOrderNumber_Success_GET

Background:
* print 'ws_toyou_url -> ', ws_toyou_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS057_TC002_<scenarioId>_TrackParcel_ByOrderNumber_Success_GET

Given url ws_toyou_url + '/toyou-app/services/rest/toyou/order/track'
And param clientId = <client>
And param orderId = <orderNumber>
And header Content-Type = 'application/json'
And header transactionId = currentDateTimeStamp
And header clientId = <clientId>
When method get
Then status 200
And match $.status == 'OK'
And match $.payload[0].parcelId == <parcelNumber>
And match $.payload[0].orderNumber == '#string'
And match $.payload[0].encOrderId == '#string'
And match $.payload[0].orderType == '#string'
And match $.payload[0].maxDwellTime == '##string'
And match each $.payload[0].visualLegStatuses[*].stepNo == '#string'
And match each $.payload[0].visualLegStatuses[*].description == '#string'
And match each $.payload[0].visualLegStatuses[*].visualState == '#string'
And match each $.payload[0].visualLegStatuses[*].parcelLocation == '#string'
And match $.payload[0].currentStatusDetails.description == '#string'
And match $.payload[0].currentStatusDetails.stepNo == '#number'
And match $.payload[0].currentStatusDetails.statusMessage == '#string'
And match $.payload[0].currentStatusDetails.status == '#string'
And match $.payload[0].storeDetail.facilityId == '#string'
And match $.payload[0].ClientID == <client>
And match $.errors == []

Examples:
| scenarioId | clientId | parcelNumber    | client | orderNumber       |
| S001       | 'GEC'    | 'AUTC091080475' | 'AUT'  | 'ORAUTC101883757' |

