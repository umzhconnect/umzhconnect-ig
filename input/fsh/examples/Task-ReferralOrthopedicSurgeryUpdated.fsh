Instance: TaskReferralOrthopedicSurgeryUpdated
InstanceOf: ChUmzhConnectCoordinationTask
Usage: #example
Title: "Task for Referral Orthopedic Surgery (Updated with Questionnaire)"
Description: "Updated Task after HospitalF (Fulfiller) has accepted the initial Task and added a reference to the Questionnaire to request smoking status from HospitalP (Placer)."
* status = #in-progress
* intent = #order
* priority = #routine
* basedOn = Reference(ReferralOrthopedicSurgery)
* for = Reference(PetraMeier)
* requester = Reference(HansMusterRole)
* owner = Reference(HospitalF)
* authoredOn = "2025-12-15"
* lastModified = "2025-12-16"
* focus = Reference(ReferralOrthopedicSurgery)
* input[0].type = $sct#273510007 "Health assessment questionnaire"
* input[0].valueReference = Reference(QuestionnaireSmokingStatus)

