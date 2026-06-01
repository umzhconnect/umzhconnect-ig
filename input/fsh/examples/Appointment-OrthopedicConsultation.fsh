Instance: AppointmentOrthopedicConsultation
InstanceOf: Appointment
Usage: #example
Title: "Appointment Orthopedic Pre-Surgery Consultation"
Description: "Pre-operative orthopedic consultation scheduled before the planned knee surgery. Intermediary result referenced in the completed Coordination Task output. Hosted on fulfiller."
* status = #fulfilled
* description = "Pre-operative orthopedic consultation prior to ACL reconstruction surgery"
* start = "2026-01-08T09:00:00+01:00"
* end = "2026-01-08T09:30:00+01:00"
* participant[0].type = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#SBJ "subject"
* participant[0].status = #accepted
* participant[1].actor = Reference(http://registry.example.org/fhir/HealthcareService/HealthcareServiceOrthopedicsFulfiller)
* participant[1].status = #accepted
