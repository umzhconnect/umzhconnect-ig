Instance: QuestionnaireResponseSmokingStatus
InstanceOf: QuestionnaireResponse
Usage: #example
Title: "Smoking Status Questionnaire Response"
Description: "QuestionnaireResponse sent by HospitalP (Placer) to HospitalF (Fulfiller) providing the patient's smoking status."
* status = #completed
* questionnaire = Canonical(QuestionnaireSmokingStatus)
* subject = Reference(PetraMeier)
* authored = "2025-12-16"
* author = Reference(HansMusterRole)
* item[0].linkId = "smoking-status"
* item[0].text = "What is the patient's smoking status?"
* item[0].answer[0].valueCoding = $sct#8517006 "Ex-smoker"
* item[1].linkId = "pack-years"
* item[1].text = "What is the patient's pack years?"
* item[1].answer[0].valueDecimal = 50

