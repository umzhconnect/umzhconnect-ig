Profile: ChUmzhConnectServiceRequest
Parent: ChEtocServiceRequest
Id: ch-umzh-connect-servicerequest
Title: "CH UMZH Connect ServiceRequest"
Description: "CH UMZH Connect ServiceRequest is derived from CH eTOC"
* . ^short = "CH UMZH Connect ServiceRequest"
* category from ChUmzhConnectServiceRequestCategoryVS (extensible)
* reasonReference 1..1
* reasonReference only Reference(ChEtocPrimaryDiagnosisCondition)
* supportingInfo[secondarydiagnosis] only Reference(ChEtocSecondaryDiagnosisCondition) 

* insurance only Reference(ChOrfCoverage)

// * supportingInfo[organization] only Reference(Organization) 

* supportingInfo[bodyHeight] only Reference(ChEtocBodyHeightObservation)
* supportingInfo[bodyWeight] only Reference(ChEtocBodyWeightObservation)
* supportingInfo[pregnancy] only Reference(ChEtocPregnancyStatusObservation)
* supportingInfo[historyofIllnesses] only Reference(ChEtocPastHistoryofIllnessesCondition)
// * supportingInfo[procedure] only Reference(ChEtocProcedure) 
* supportingInfo[historyofProcedures] only Reference(ChEtocProcedure)
* supportingInfo[devices] only Reference(ChEtocDevice)
* supportingInfo[socialHistory] only Reference(ChEtocSocialHistoryCondition)
* supportingInfo[functionalStatus] only Reference(ChEtocFunctionalStatusCondition)
* supportingInfo[medicationstatement] only Reference(ChEmedMedicationStatement)
* supportingInfo[allergiesIntolerances] only Reference(ChEtocAllergyIntolerance)
* supportingInfo[immunizations] only Reference(ChEtocImmunization)
// * supportingInfo[observation] only Reference(Observation) are the below four sufficient?
* supportingInfo[labresults] only Reference(ChEtocLabObservation)
* supportingInfo[pathologyresults] only Reference(ChEtocPathologyObservation)
* supportingInfo[imagingresults] only Reference(ChEtocRadiologyObservation)
* supportingInfo[cardiologyresults] only Reference(ChEtocCardiologyObservation)