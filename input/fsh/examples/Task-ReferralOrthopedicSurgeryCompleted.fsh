Instance: TaskReferralOrthopedicSurgeryCompleted
InstanceOf: ChUmzhConnectCoordinationTask
Usage: #example
Title: "Task for Referral Orthopedic Surgery (Completed with Results)"
Description: "Completed Task after Fulfiller has performed the knee surgery. Carries forward the smoking-status Questionnaire (output) and the returned QuestionnaireResponse (input), and adds the results: the intermediary pre-surgery consultation Appointment, the discharge report and the discharge medication (blood thinner) in Task.output. Hosted on fulfiller."
* status = #completed
* intent = #order
* priority = #routine
* basedOn = Reference(http://placer.example.org/fhir/ServiceRequest/ReferralOrthopedicSurgery)
* for = Reference(http://placer.example.org/fhir/Patient/PetraMeier)
* requester = Reference(http://registry.example.org/fhir/Organization/Placer)
* owner = Reference(http://registry.example.org/fhir/Organization/Fulfiller)
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:a8b9cb16-dea5-4e5e-bda1-33f0c5858097"
* code = http://hl7.org/fhir/CodeSystem/task-code#fulfill "Fulfill the focal request"
* authoredOn = "2025-12-15"
* lastModified = "2026-01-20"
* focus = Reference(http://placer.example.org/fhir/ServiceRequest/ReferralOrthopedicSurgery)
* input[0].type = $sct#273510007 "Health assessment questionnaire"
* input[0].valueReference = Reference(QuestionnaireResponseSmokingStatus)
* output[0].type = $sct#273510007 "Health assessment questionnaire"
* output[0].valueCanonical = Canonical(QuestionnaireSmokingStatus)
* output[1].type = $sct#11429006 "Consultation"
* output[1].valueReference = Reference(AppointmentOrthopedicConsultation)
* output[2].type = $sct#373942005 "Discharge summary (record artifact)"
* output[2].valueReference = Reference(DocDischargeReportOrthopedics)
* output[3].type = $sct#33633005 "Prescription of drug"
* output[3].valueReference = Reference(MedicationAspirin)
