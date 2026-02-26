Instance: TaskReferralOrthopedicSurgery
InstanceOf: ChUmzhConnectCoordinationTask
Usage: #example
Title: "Task for Referral Orthopedic Surgery (Initial)"
Description: "Initial Task created by HospitalP (Placer) based on the ServiceRequest and sent to HospitalF (Fulfiller)."
* status = #ready
* intent = #order
* priority = #routine
* basedOn = Reference(http://hospitalp.example.org/fhir/ServiceRequest/ReferralOrthopedicSurgery)
* for = Reference(http://hospitalp.example.org/fhir/Patient/PetraMeier)
* requester = Reference(http://hospitalp.example.org/fhir/PractitionerRole/HansMusterRole)
* owner = Reference(Organization/HospitalF)
* authoredOn = "2025-12-15"
* focus = Reference(http:///hospitalp.example.org/fhir/ServiceRequest/ReferralOrthopedicSurgery)

