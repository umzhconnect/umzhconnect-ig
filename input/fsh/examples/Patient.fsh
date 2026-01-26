Instance: PetraMeier
InstanceOf: CHCorePatient
Usage: #example
Title: "Petra Meier"
Description: "Example for CH Core Patient."
// Local PID
* identifier[LocalPid].type = $v2-0203#MR
* identifier[LocalPid].system = "urn:oid:2.999.1.2.3.4"
* identifier[LocalPid].value = "P06543"
// AHVN13Identifier
* identifier[AHVN13].system = "urn:oid:2.16.756.5.32"
* identifier[AHVN13].value = "7562295883070"
* name
  * family = "Meier"
  * given = "Petra"
* gender = #female
* birthDate = "1992-03-26"
* telecom[phone][0].system = #phone
* telecom[phone][=].use = #home
* telecom[phone][=].value = "+41 33 333 33 33"
* address.line = "Musterstrasse 1"
* address.postalCode = "8000"
* address.city = "Zürich"
* address.country = "Schweiz"


Instance: CoverageMeier
InstanceOf: ChOrfCoverage
Usage: #example
Title: "Coverage P. Meier"
Description: "Coverage (Garant) with Mrs. Meier as beneficiary and the health insurance Krankenkasse as issuer of the policy (represented as contained resource)"
* contained = OrganizationKrankenkasse
// VEKAIdentifier
* identifier[insuranceCardNumber][0].system = "urn:oid:2.16.756.5.30.1.123.100.1.1.1"
* identifier[insuranceCardNumber][=].value = "80756015090002647590"
* identifier[insuranceCardNumber][=].type = http://fhir.ch/ig/ch-orf/CodeSystem/ch-orf-cs-coverageidentifiertype#VeKa
* status = #active
* beneficiary = Reference(PetraMeier)
* payor = Reference(OrganizationKrankenkasse)


Instance: OrganizationKrankenkasse
InstanceOf: CHCoreOrganization
Usage: #inline
// GLN/EAN
* identifier[GLN].system = "urn:oid:2.51.1.3"
* identifier[GLN].value = "7601002331470"
* name = "Krankenkasse AG"
* address
  * line = "Kassengraben 222"
  * city = "Basel"
