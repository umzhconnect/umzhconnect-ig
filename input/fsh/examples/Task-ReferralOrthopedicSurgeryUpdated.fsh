Instance: TaskReferralOrthopedicSurgeryUpdated
InstanceOf: Task
Usage: #example
Title: "Task for Referral Orthopedic Surgery (Updated with Questionnaire)"
Description: "Updated Task after HospitalF (Fulfiller) has accepted the initial Task and added a reference to the Questionnaire to request smoking status from HospitalP (Placer)."
* status = #in-progress
* intent = #order
* priority = #routine
// TODO: define orthopedic knee as service here?
//* code = $sct#306206005 "Referral to service"
* basedOn = Reference(ReferralOrthopedicSurgery)
* for = Reference(PetraMeier)
* requester = Reference(HansMusterRole)
* owner = Reference(HospitalF)
* authoredOn = "2025-12-15"
* lastModified = "2025-12-16"
* focus = Reference(ReferralOrthopedicSurgery)
* input[0].type = $sct#385705008 "Request for information"
* input[0].valueReference = Reference(QuestionnaireSmokingStatus)

