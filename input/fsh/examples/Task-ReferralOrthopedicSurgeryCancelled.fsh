Instance: TaskReferralOrthopedicSurgeryCancelled
InstanceOf: ChUmzhConnectCoordinationTask
Usage: #example
Title: "Task for Referral Orthopedic Surgery (Cancelled by Placer)"
Description: "Task as submitted by the Placer to cancel the Initial Task before the Fulfiller has started work. Identical to the Initial Task except for status cancelled and the added statusReason; the Fulfiller's server sets lastModified. Hosted on fulfiller."
* status = #cancelled
* statusReason.text = "Referral entered in error"
* intent = #order
* priority = #routine
* basedOn = Reference(http://placer.example.org/fhir/ServiceRequest/ReferralOrthopedicSurgery)
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:a8b9cb16-dea5-4e5e-bda1-33f0c5858097"
* code = http://hl7.org/fhir/CodeSystem/task-code#fulfill "Fulfill the focal request"
* requester = Reference(http://registry.example.org/fhir/Organization/Placer)
* owner = Reference(http://registry.example.org/fhir/Organization/Fulfiller)
* authoredOn = "2025-12-15"
* focus = Reference(http://placer.example.org/fhir/ServiceRequest/ReferralOrthopedicSurgery)
