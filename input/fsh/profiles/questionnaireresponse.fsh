Profile: ChUmzhConnectQuestionnaireResponse
Parent: QuestionnaireResponse
Id: ch-umzh-connect-questionnaireresponse
Title: "CH UMZH Connect QuestionnaireResponse"
Description: "QuestionnaireResponse authored and hosted by the Placer during a UMZH Connect workflow."
* basedOn 1..1
* basedOn only Reference(ChUmzhConnectServiceRequest)
* basedOn ^short = "Workflow-root ServiceRequest — authorization anchor (see Security — Context-centric authorization)"
