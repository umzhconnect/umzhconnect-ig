Instance: ChUmzhConnectCapabilityStatement
InstanceOf: CapabilityStatement
Usage: #definition
* name = "UMZHconnectRestServer"
* status = #active
* date = "2026-01-27T16:12:05.435+01:00"
* kind = #requirements
* description = "UMZH Connect API requirements"
* fhirVersion = #4.0.1
* format = #application/fhir+json

* rest.mode = #server

* rest.resource[0].type = #AllergyIntolerance
* rest.resource[=].interaction.code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #Condition
* rest.resource[=].interaction.code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #Consent
* rest.resource[=].interaction.code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #Coverage
* rest.resource[=].interaction.code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #DiagnosticReport
* rest.resource[=].interaction.code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #Immunization
* rest.resource[=].interaction.code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #MedicationStatement
* rest.resource[=].interaction.code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #Observation
* rest.resource[=].interaction.code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #Organization
* rest.resource[=].interaction.code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #Patient
* rest.resource[=].interaction.code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #Practitioner
* rest.resource[=].interaction.code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #PractitionerRole
* rest.resource[=].interaction.code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #Procedure
* rest.resource[=].interaction.code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #Questionnaire
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #QuestionnaireResponse
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam.name = "based-on"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-based-on"
* rest.resource[=].searchParam.type = #reference
* rest.resource[=].searchParam.documentation = "Plan/proposal/order fulfilled by this questionnaire response"

* rest.resource[+].type = #ServiceRequest
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchInclude[0] = "ServiceRequest:patient"
* rest.resource[=].searchInclude[+] = "ServiceRequest:requester"
* rest.resource[=].searchInclude[+] = "ServiceRequest:subject"
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

* rest.resource[+].type = #Task
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false
* rest.resource[=].searchParam[0].name = "owner"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Task-owner"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "Search by task owner"
* rest.resource[=].searchParam[+].name = "requester"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Task-requester"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "Search by task requester"
* rest.resource[=].searchParam[+].name = "_id"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Logical id of this artifact"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Task-status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Search by task status"