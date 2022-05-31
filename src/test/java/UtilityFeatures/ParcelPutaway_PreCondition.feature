Feature: ParcelPutaway_PreCondition_Feature  
 
Background:
* configure proxy = proxy1
* def parcelNumber_PC = parcelNumber
* print 'parcelNumber -> ', parcelNumber_PC
* def storeId_PC = storeId
* print 'storeId -> ', storeId_PC
* def source_PC = source
* print 'source -> ', source_PC
* def userId_PC = userId
* print 'userId -> ', userId_PC
* def clientId_PC = clientId
* print 'clientId -> ', clientId_PC
* def zoneId_PC = zoneId
* print 'zoneId -> ', zoneId_PC
* def slotId_PC = slotId
* print 'slotId -> ', slotId_PC

* print 'currentDateTimeStamp -> ', currentDateTimeStamp
 
Scenario: ParcelPutaway_PreCondition_Scenario

* def reqBody = {}

Given url 'http://161.163.89.59:9080/Connect/v1/parcelputaway/'
And path zoneId_PC, zoneId_PC + slotId_PC, parcelNumber_PC
And header userId = userId_PC
And header storeId = storeId_PC
And header source = source_PC
And header clientId = clientId_PC
And header transactionId = currentDateTimeStamp
And request reqBody
When method post
Then status 200
And match $.responseCode == '000'


