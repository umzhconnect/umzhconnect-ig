Instance: ReferralOrthopedicSurgery
InstanceOf: ChUmzhConnectServiceRequest
Usage: #example
Title: "Referral Orthopedic Surgery"
Description: "Example ServiceRequest for a referral to orthopedic surgery for knee replacement evaluation using the CH eTOC profile."
//* identifier[placerOrderIdentifier].system = "urn:oid:1.3.4.5.6.7"
* identifier[placerOrderIdentifier].value = "REF-2025-001"
* status = #active
* intent = #order
* category = $sct#183545006 "Referral to orthopedic service (procedure)"
* subject = Reference(PetraMeier)
* requester = Reference(HansMusterRole)
* authoredOn = "2025-12-15"
* reasonReference = Reference(SuspectedACLRupture)
* insurance = Reference(CoverageMeier)
* supportingInfo[0] = Reference(HeartFailureHFrEF)
* supportingInfo[1] = Reference(MedicationEntresto)
* supportingInfo[2] = Reference(MedicationConcor)
* note.text = "Suspected rupture of the left ACL."

