@All @WS036 @WS036_TC001 @Store @CheckServiceStatus
Feature: WS036_TC001_Store_CheckServiceStatus_LoadBalancer_Success_GET

Background:
* print 'ws_url -> ', ws_url

Scenario Outline: WS036_TC001_<scenarioId>_Store_CheckServiceStatus_LoadBalancer_Success_GET

Given url ws_url + '/Connect/v1/checkservicestatus'
When method get
Then status 200
And match $.message == 'success'

Examples:
| scenarioId |
| S001       |

