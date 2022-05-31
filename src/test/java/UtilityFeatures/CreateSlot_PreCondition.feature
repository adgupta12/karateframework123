
Feature: CreateSlot_PreCondition  

Background:
* def zoneId_PC = zoneId
* print 'zoneId -> ', zoneId_PC
* def slotId_PC = slotId
* print 'slotId -> ', slotId_PC
* def storeId_PC = storeId
* print 'storeId -> ', storeId_PC
* def source_PC = source
* print 'source -> ', source_PC
* def userId_PC = userId
* print 'userId -> ', userId_PC
* def clientId_PC = clientId
* print 'clientId -> ', clientId_PC

* print 'ws_url -> ', ws_url
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

Scenario: CreateSlot_PreCondition
 
* def reqBody = 
"""
{"printSlotFlag":"N"}

"""
 
Given url ws_url + '/Connect/v1/locmgmt/zones/'
And path zoneId_PC, 'slots', slotId_PC
And header Content-Type = 'application/json'
And header userId = userId_PC
And header storeId = storeId_PC
And header source = source_PC
And header transactionId = currentDateTimeStamp
And header clientId = clientId_PC
And request reqBody
When method post
Then status 200
 


