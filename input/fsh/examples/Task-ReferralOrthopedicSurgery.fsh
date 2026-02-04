Instance: TaskReferralOrthopedicSurgery
InstanceOf: ChUmzhConnectCoordinationTask
Usage: #example
Title: "Task for Referral Orthopedic Surgery (Initial)"
Description: "Initial Task created by HospitalP (Placer) based on the ServiceRequest and sent to HospitalF (Fulfiller)."
* status = #ready
* intent = #order
* priority = #routine
* basedOn = Reference(ReferralOrthopedicSurgery)
* for = Reference(PetraMeier)
* requester = Reference(HansMusterRole)
* owner = Reference(HospitalF)
* authoredOn = "2025-12-15"
* focus = Reference(ReferralOrthopedicSurgery)

