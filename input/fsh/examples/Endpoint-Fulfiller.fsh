Instance: EndpointFulfiller
InstanceOf: Endpoint
Usage: #example
Title: "Endpoint Fulfiller"
Description: "FHIR REST API endpoint for Fulfiller. Hosted on registry."
* status = #active
* connectionType = http://terminology.hl7.org/CodeSystem/endpoint-connection-type#hl7-fhir-rest
* name = "Fulfiller FHIR API"
* managingOrganization = Reference(http://registry.example.org/fhir/Organization/Fulfiller)
* payloadType = http://terminology.hl7.org/CodeSystem/endpoint-payload-type#any
* address = "https://fulfiller.example.org/fhir"
