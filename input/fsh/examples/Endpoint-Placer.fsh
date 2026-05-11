Instance: EndpointPlacer
InstanceOf: Endpoint
Usage: #example
Title: "Endpoint Placer"
Description: "FHIR REST API endpoint for Placer. Hosted on registry."
* status = #active
* connectionType = http://terminology.hl7.org/CodeSystem/endpoint-connection-type#hl7-fhir-rest
* name = "Placer FHIR API"
* managingOrganization = Reference(http://registry.example.org/fhir/Organization/Placer)
* payloadType = http://terminology.hl7.org/CodeSystem/endpoint-payload-type#any
* address = "https://placer.example.org/fhir"
