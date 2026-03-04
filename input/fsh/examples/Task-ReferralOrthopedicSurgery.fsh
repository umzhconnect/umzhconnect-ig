Instance: TaskReferralOrthopedicSurgery
InstanceOf: Task
Usage: #example
Title: "Task for Referral Orthopedic Surgery (Initial)"
Description: "Initial Task created by Placer based on the ServiceRequest and sent to Fulfiller. Hosted on fulfiller."
* status = #ready
* intent = #order
* priority = #routine
* basedOn = Reference(http://placer.example.org/fhir/ServiceRequest/ReferralOrthopedicSurgery)
* for = Reference(http://placer.example.org/fhir/Patient/PetraMeier)
* requester = Reference(http://placer.example.org/fhir/PractitionerRole/HansMusterRole)
* owner = Reference(Organization/Fulfiller)
* authoredOn = "2025-12-15"
* focus = Reference(http://placer.example.org/fhir/ServiceRequest/ReferralOrthopedicSurgery)

