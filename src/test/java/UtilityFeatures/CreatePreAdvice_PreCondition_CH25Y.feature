
Feature: CreatePreAdvice_PreCondition_Feature 

Background:
* configure ssl = ssl
* configure proxy = proxy
* def clientID_PC = clientID
* print 'clientID -> ', clientID_PC
* def parcelType_PC = parcelType
* print 'parcelType -> ', parcelType_PC
* def parcelNumber_PC = parcelNumber
* print 'parcelNumber -> ', parcelNumber_PC
* def externalOrderNumber_PC = externalOrderNumber
* print 'externalOrderNumber -> ', externalOrderNumber_PC
* def storeId_PC = storeId
* print 'storeId -> ', storeId_PC
* def transactionID_PC = transactionID
* print 'transactionID -> ', transactionID_PC
* def headerDate_PC = headerDate
* print 'headerDate -> ', headerDate_PC
* def expectedDeliveryDate_PC = expectedDeliveryDate
* print 'expectedDeliveryDate -> ', expectedDeliveryDate_PC
* def dateShipped_PC = dateShipped
* print 'dateShipped -> ', dateShipped_PC
* def deliveryDateInjectionPoint_PC = deliveryDateInjectionPoint
* print 'deliveryDateInjectionPoint_PC -> ', deliveryDateInjectionPoint_PC

* print 'url_xg45 -> ', url_xg45
* print 'currentDateTimeStamp -> ', currentDateTimeStamp

 
Scenario: CreatePreAdvice_PreCondition_Scenario

* def reqBody = 
"""
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:cre="http://www.asda.com/CreatePreadvice/" xmlns:pre="http://www.asda.com/PreadviceRequest">
	<soapenv:Header/>
	<soapenv:Body>
		<cre:createPreadvice>
			<CreatePreadviceRequest>
				<pre:Header>
					<pre:ClientID>#(clientID_PC)</pre:ClientID>
					<pre:ClientName><![CDATA[Ollerton Dot com]]></pre:ClientName>
					<pre:MessageType>Pre-Advice</pre:MessageType>
					<pre:OriginID>04821</pre:OriginID>
					<pre:Version>1.0       </pre:Version>
					<pre:Date>#(headerDate_PC)</pre:Date>
					<pre:TransactionID>#(transactionID_PC)</pre:TransactionID>
					<pre:ExternalReferenceID>EXR11223244</pre:ExternalReferenceID>
				</pre:Header>
				<pre:Message>
					<pre:Consignments>
						<pre:Consignment>
							<pre:ParcelAttributes>
								<pre:ParcelNumber>#(parcelNumber_PC)</pre:ParcelNumber>
								<pre:ParcelType>#(parcelType_PC)</pre:ParcelType>
								<pre:ExternalOrderNumber>#(externalOrderNumber_PC)</pre:ExternalOrderNumber>
								<pre:InjectionFacility>07520</pre:InjectionFacility>
								<pre:InjectionFacilityType>NSC</pre:InjectionFacilityType>
								<pre:FinalDestFacility>#(storeId_PC)</pre:FinalDestFacility>
								<pre:ExpectedDeliveryDate>#(expectedDeliveryDate_PC)</pre:ExpectedDeliveryDate>
								<pre:DateShipped>#(dateShipped_PC)</pre:DateShipped>
								<pre:TotalValue>24.00</pre:TotalValue>
								<pre:DeliveryDateInjectionPoint>#(deliveryDateInjectionPoint_PC)</pre:DeliveryDateInjectionPoint>
								<pre:SizeUOM>CM</pre:SizeUOM>
								<pre:Height>30.00</pre:Height>
								<pre:Length>40.00</pre:Length>
								<pre:Width>30.00</pre:Width>
								<pre:Weight>2.40</pre:Weight>
								<pre:WeightUOM>KGs</pre:WeightUOM>
								<pre:NumberOfUnits>2</pre:NumberOfUnits>
								<pre:Volume>20160</pre:Volume>
								<pre:VolumeUOM>Cu CM</pre:VolumeUOM>
							</pre:ParcelAttributes>
							<pre:Contents>
								<pre:Description><![CDATA[GH BATH SHEET DUCKEG EACH]]></pre:Description>
								<pre:Quantity>2</pre:Quantity>
								<pre:QuantityUOM>Unit</pre:QuantityUOM>
								<pre:NetWeight>2.16</pre:NetWeight>
								<pre:NetWeightUOM>KGs</pre:NetWeightUOM>
								<pre:Value>24.00</pre:Value>
								<pre:ValueUOM>GBP</pre:ValueUOM>
								<pre:ItemNumber>01234567890123456</pre:ItemNumber>
								<pre:BundleRef></pre:BundleRef>
							</pre:Contents>
							<pre:Services>
								<pre:ServiceName>Email Notification</pre:ServiceName>
								<pre:ServiceValue><![CDATA[neo@testmatrix.com]]></pre:ServiceValue>
							</pre:Services>
							<pre:Services>
								<pre:ServiceName>SMS Notification</pre:ServiceName>
								<pre:ServiceValue><![CDATA[01111111111]]></pre:ServiceValue>
							</pre:Services>
							<pre:Services>
								<pre:ServiceName>Delivery Type</pre:ServiceName>
								<pre:ServiceValue>Click and Collect</pre:ServiceValue>
							</pre:Services>
							<pre:Services>
								<pre:ServiceName>EPOD</pre:ServiceName>
								<pre:ServiceValue>N</pre:ServiceValue>
							</pre:Services>
							<pre:Services>
								<pre:ServiceName>Challenge 25</pre:ServiceName>
								<pre:ServiceValue>Y</pre:ServiceValue>
							</pre:Services>
							<pre:Services>
								<pre:ServiceName>Segregation</pre:ServiceName>
								<pre:ServiceValue>Standard</pre:ServiceValue>
							</pre:Services>
							<pre:Services>
								<pre:ServiceName>HandlingFlag</pre:ServiceName>
								<pre:ServiceValue>Standard</pre:ServiceValue>
							</pre:Services>
							<pre:Consignor>
								<pre:Client>
									<pre:ClientID>#(clientID_PC)</pre:ClientID>
									<pre:ClientName><![CDATA[Ollerton Dot Com]]></pre:ClientName>
									<pre:FacilityID>04821</pre:FacilityID>
									<pre:Address>
										<pre:AddressLine1><![CDATA[Unit 1]]></pre:AddressLine1>
										<pre:AddressLine2><![CDATA[Boughton Industrial Estate]]></pre:AddressLine2>
										<pre:City><![CDATA[Newark]]></pre:City>
										<pre:County><![CDATA[]]></pre:County>
										<pre:PostalCode><![CDATA[NG22 9LD]]></pre:PostalCode>
										<pre:Country><![CDATA[UK]]></pre:Country>
									</pre:Address>
								</pre:Client>
							</pre:Consignor>
							<pre:Consignee>
								<pre:Consumer>
									<pre:Title><![CDATA[]]></pre:Title>
									<pre:FirstName><![CDATA[Anderson]]></pre:FirstName>
									<pre:LastName><![CDATA[Smith]]></pre:LastName>
									<pre:FacilityID>#(storeId_PC)</pre:FacilityID>
									<pre:Address>
										<pre:AddressLine1><![CDATA[111-127 Front Street]]></pre:AddressLine1>
										<pre:AddressLine2><![CDATA[Arnold]]></pre:AddressLine2>
										<pre:City><![CDATA[Arnold - Nottingham]]></pre:City>
										<pre:County><![CDATA[5731]]></pre:County>
										<pre:PostalCode><![CDATA[NG5 7ED]]></pre:PostalCode>
										<pre:Country><![CDATA[UK]]></pre:Country>
									</pre:Address>
						<pre:Contact>
                            <pre:ContactType>Email</pre:ContactType>
                            <pre:ContactValue><![CDATA[neo@testmatrix.com]]></pre:ContactValue>
                        </pre:Contact>
                        <pre:Contact>
                            <pre:ContactType>Mobile</pre:ContactType>
                            <pre:ContactValue><![CDATA[01111111111]]></pre:ContactValue>
                        </pre:Contact>
								</pre:Consumer>
							</pre:Consignee>
						</pre:Consignment>
					</pre:Consignments>
				</pre:Message>
			</CreatePreadviceRequest>
		</cre:createPreadvice>
	</soapenv:Body>
</soapenv:Envelope>
"""

Given url url_xg45 + ':2014/CreatePreadvice'
And header transactionId = currentDateTimeStamp 
#And header clientId = 'KIOSK'   
And header clientId = 'GEC'
And header Content-Type = 'application/xml'
And request reqBody
When method post
Then status 200
And match //ResponseCode == '000'


 

