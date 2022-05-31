@All @WS057 @WS057_TC001 @ToYou @TrackParcel
Feature: WS057_TC001_ToYou_TrackParcel_ByParcelNumber_Success_GET

Background:
* print 'ws_toyou_url -> ', ws_toyou_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario Outline: WS057_TC001_<scenarioId>_TrackParcel_ByParcelNumber_Success_GET

Given url ws_toyou_url + '/toyou-app/services/rest/toyou/parcel'
And path <parcelNumber>
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
| scenarioId | clientId | parcelNumber    | client |
| S001       | 'GEC'    | 'AUTC101883757' | 'AUT'  |

