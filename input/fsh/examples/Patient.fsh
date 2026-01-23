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
