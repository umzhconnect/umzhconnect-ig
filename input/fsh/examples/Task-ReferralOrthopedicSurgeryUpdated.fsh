Instance: TaskReferralOrthopedicSurgeryUpdated
InstanceOf: ChUmzhConnectCoordinationTask
Usage: #example
Title: "Task for Referral Orthopedic Surgery (Updated with Questionnaire)"
Description: "Updated Task after Fulfiller has accepted the initial Task and added a reference to the Questionnaire to request smoking status from Placer. Hosted on fulfiller."
* status = #in-progress
* intent = #order
* priority = #routine
* basedOn = Reference(http://placer.example.org/fhir/ServiceRequest/ReferralOrthopedicSurgery)
* for = Reference(http://placer.example.org/fhir/Patient/PetraMeier)
* requester = Reference(http://placer.example.org/fhir/PractitionerRole/HansMusterRole)
* owner = Reference(http://placer.example.org/fhir/Organization/Placer)
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:a8b9cb16-dea5-4e5e-bda1-33f0c5858097"
* code = $sct#183545006 "Referral to orthopedic service (procedure)"
* authoredOn = "2025-12-15"
* lastModified = "2025-12-16"
* focus = Reference(http://placer.example.org/fhir/ServiceRequest/ReferralOrthopedicSurgery)
* output[0].type = $sct#273510007 "Health assessment questionnaire"
* output[0].valueCanonical = Canonical(QuestionnaireSmokingStatus)

