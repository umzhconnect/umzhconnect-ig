Profile: ChUmzhConnectServiceRequest
Parent: ChEtocServiceRequest
Id: ch-umzh-connect-servicerequest
Title: "CH UMZH Connect ServiceRequest"
Description: "CH UMZH Connect ServiceRequest profile is just an example!"
* . ^short = "CH UMZH Connect ServiceRequest"
* category from ChUmzhConnectServiceRequestCategoryVS (extensible)
* reasonReference only Reference(ChEtocPrimaryDiagnosisCondition) 

* supportingInfo[secondarydiagnosis] only Reference(ChEtocSecondaryDiagnosisCondition) 
* supportingInfo[medicationstatement] only Reference(ChEmedMedicationStatement)
* supportingInfo[immunizations] only Reference(ChEtocImmunization)