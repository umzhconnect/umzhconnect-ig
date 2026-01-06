Instance: TaskReferralOrthopedicSurgery
InstanceOf: Task
Usage: #example
Title: "Task for Referral Orthopedic Surgery (Initial)"
Description: "Initial Task created by HospitalP (Placer) based on the ServiceRequest and sent to HospitalF (Fulfiller)."
* status = #ready
* intent = #order
* priority = #routine
// TODO: define orthopedic knee as service here?
//* code = $sct#306206005 "Referral to service"
* basedOn = Reference(ReferralOrthopedicSurgery)
* for = Reference(PetraMeier)
* requester = Reference(HansMusterRole)
* owner = Reference(HospitalF)
* authoredOn = "2025-12-15"
* focus = Reference(ReferralOrthopedicSurgery)

