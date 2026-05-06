Instance: HealthcareServiceOrthopedicsFulfiller
InstanceOf: HealthcareService
Usage: #example
Title: "HealthcareService Orthopedics Fulfiller"
Description: "Example HealthcareService for orthopedic referrals provided by Fulfiller. Hosted on registry."
* active = true
* providedBy = Reference(http://registry.example.org/fhir/Organization/Fulfiller)
* type = $sct#183545006 "Referral to orthopedic service (procedure)"
* name = "Orthopedic Surgery"

Instance: HealthcareServiceTumorboardFulfiller
InstanceOf: HealthcareService
Usage: #example
Title: "HealthcareService Sarcoma Tumor Board Fulfiller"
Description: "Example HealthcareService for sarcoma tumor board provided by Fulfiller. Hosted on registry."
* active = true
* providedBy = Reference(http://registry.example.org/fhir/Organization/Fulfiller)
* type = $sct#720006006 "Cancer care review (procedure)"
* name = "Sarcoma Tumor Board"
