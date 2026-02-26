Instance: QuestionnaireSmokingStatus
InstanceOf: Questionnaire
Usage: #example
Title: "Smoking Status Questionnaire"
Description: "Questionnaire sent by HospitalF (Fulfiller) to HospitalP (Placer) to inquire about the patient's smoking status."
// Canonical (we intentionally use NOT the resolvable FHIR URL which would be http://hospitalf.example.org/fhir/Questionnaire/QuestionnaireSmokingStatus)
* url = "http://hospitalf.example.org/ch-umzh-connect/QuestionnaireSmokingStatus"
* version = "Qv1.0"
* status = #active
* title = "Smoking Status Inquiry"
* description = "Please provide the patient's current smoking status."
* subjectType = #Patient
* item[0].linkId = "smoking-status"
* item[0].text = "What is the patient's smoking status?"
* item[0].type = #choice
* item[0].required = true
* item[0].answerOption[0].valueCoding = $sct#266919005 "Never smoked tobacco"
* item[0].answerOption[1].valueCoding = $sct#8517006 "Ex-smoker"
* item[0].answerOption[2].valueCoding = $sct#77176002 "Smoker"
* item[1].linkId = "pack-years"
* item[1].text = "What is the patient's pack years?"
* item[1].type = #decimal
* item[1].required = false

