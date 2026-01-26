Instance: ReferralTumorboard
InstanceOf: ChUmzhConnectServiceRequest
Usage: #example
Title: "Referral Sarcoma Tumor Board"
Description: "Example ServiceRequest for a referral to tumor board for sarcoma."
//* identifier[placerOrderIdentifier].system = "urn:oid:1.3.4.5.6.7"
* identifier[placerOrderIdentifier].value = "REF-2025-002"
* status = #active
* intent = #order
* category = $sct#720006006 "Cancer care review (procedure)"
* subject = Reference(PetraMeier)
* requester = Reference(HansMusterRole)
* authoredOn = "2026-01-26"
* reasonReference = Reference(SarcomaKnee)
* supportingInfo[0] = Reference(AllergyGado)
* supportingInfo[1] = Reference(ImagingCT)
* supportingInfo[2] = Reference(ImagingPET)
* note.text = "Review therapy recommendations."


Instance: SarcomaKnee
InstanceOf: ChEtocPrimaryDiagnosisCondition
Usage: #example
Title: "Synovial sarcoma of the right knee"
* category = http://fhir.ch/ig/ch-etoc/CodeSystem/ch-etoc-conditioncategory#primary-diagnosis
* code.text = "Synovial sarcoma of the right knee"
* note[0].text = "- Histologically confirmed synovial sarcoma."
* subject = Reference(PetraMeier)


Instance: AllergyGado
InstanceOf: CHCoreAllergyIntolerance
Usage: #example
* clinicalStatus = http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical#active "Active"
* type = #allergy
* category = #medication
* code.text = "Komplexbildner-Allergie (Gadotersäure-Typ)"
* patient = Reference(PetraMeier)


Instance: ImagingCT
InstanceOf: ImagingStudy
Usage: #example
Title: "CT Scan Right Knee"
* identifier[0].use = #official
* identifier[0].system = "urn:dicom:uid"
* identifier[0].value = "urn:oid:1.2.4.7.6.1.35921.32671128.2255.7333"
* status = #available
* modality = $dcm#CT
* subject = Reference(PetraMeier)
* started = "2025-12-18"
* numberOfSeries = 1
* description = "CT Scan Right Knee"

Instance: ImagingPET
InstanceOf: ImagingStudy
Usage: #example
Title: "PET Scan Whole Body (external)"
* identifier[0].use = #official
* identifier[0].system = "urn:dicom:uid"
* identifier[0].value = "urn:oid:1.3.6.1.7.1.34920.32661028.1144.8635"
* status = #available
* modality = $dcm#PET
* subject = Reference(PetraMeier)
* started = "2026-01-18"
* numberOfSeries = 3
* description = "While Body PET (external)"