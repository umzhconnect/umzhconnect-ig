Instance: TaskReferralOrthopedicSurgery
InstanceOf: ChUmzhConnectCoordinationTask
Usage: #example
Title: "Task for Referral Orthopedic Surgery (Initial)"
Description: "Initial Task created by Placer based on the ServiceRequest and sent to Fulfiller. Hosted on fulfiller."
* status = #ready
* intent = #order
* priority = #routine
* basedOn = Reference(http://placer.example.org/fhir/ServiceRequest/ReferralOrthopedicSurgery)
* for = Reference(http://placer.example.org/fhir/Patient/PetraMeier)
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:a8b9cb16-dea5-4e5e-bda1-33f0c5858097"
* code = $sct#183545006 "Referral to orthopedic service (procedure)"
* requester = Reference(http://placer.example.org/fhir/PractitionerRole/HansMusterRole)
* owner = Reference(Organization/Fulfiller)
* authoredOn = "2025-12-15"
* focus = Reference(http://placer.example.org/fhir/ServiceRequest/ReferralOrthopedicSurgery)

