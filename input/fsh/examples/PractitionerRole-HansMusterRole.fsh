Instance: HansMusterRole
InstanceOf: CHCorePractitionerRole
Usage: #example
Title: "Hans Muster Role"
Description: "Example PractitionerRole for Hans Muster as referring physician at USZ."
* practitioner = Reference(HansMuster)
* organization = Reference(USZ)

