Instance: HeartFailureHFrEF
InstanceOf: ChEtocSecondaryDiagnosisCondition
Usage: #example
Title: "Heart Failure HFrEF"
Description: "Chronic heart failure with reduced ejection fraction (HFrEF), NYHA class II."
* category = http://fhir.ch/ig/ch-etoc/CodeSystem/ch-etoc-conditioncategory#secondary-diagnosis
* code.coding[0] = $icd10#I50.22 "Chronic systolic (congestive) heart failure"
* code.text = "Chronic heart failure with reduced left ventricular ejection fraction (HFrEF) with moderately limited exercise tolerance, NYHA class II, LVEF <35%."
* subject = Reference(PetraMeier)

