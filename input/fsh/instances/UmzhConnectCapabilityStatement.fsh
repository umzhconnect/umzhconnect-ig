// RuleSets for CapabilityStatement resource definitions

RuleSet: ResourceDefaults
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false

RuleSet: IdSearchParam
* rest.resource[=].searchParam.name = "_id"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam.type = #token
* rest.resource[=].searchParam.documentation = "Logical id of this artifact"

RuleSet: ReadOnlyResource(type)
* rest.resource[+].type = #{type}
* rest.resource[=].interaction.code = #read
* insert ResourceDefaults
* insert IdSearchParam


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

// Read-only resources with _id search
* insert ReadOnlyResource(AllergyIntolerance)
* insert ReadOnlyResource(Condition)
* insert ReadOnlyResource(Consent)
* insert ReadOnlyResource(Coverage)
* insert ReadOnlyResource(DiagnosticReport)
* insert ReadOnlyResource(Immunization)
* insert ReadOnlyResource(MedicationStatement)
* insert ReadOnlyResource(Observation)
* insert ReadOnlyResource(Organization)
* insert ReadOnlyResource(Patient)
* insert ReadOnlyResource(Practitioner)
* insert ReadOnlyResource(PractitionerRole)
* insert ReadOnlyResource(Procedure)

// Questionnaire: read + search-type
* rest.resource[+].type = #Questionnaire
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[+].code = #read
* insert ResourceDefaults
* insert IdSearchParam

// QuestionnaireResponse: search-type, update, read, create
* rest.resource[+].type = #QuestionnaireResponse
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #create
* insert ResourceDefaults
* rest.resource[=].searchParam.name = "based-on"
* rest.resource[=].searchParam.definition = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-based-on"
* rest.resource[=].searchParam.type = #reference
* rest.resource[=].searchParam.documentation = "Plan/proposal/order fulfilled by this questionnaire response"

// ServiceRequest: search-type, read + searchIncludes
* rest.resource[+].type = #ServiceRequest
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[+].code = #read
* insert ResourceDefaults
* rest.resource[=].searchInclude[0] = "ServiceRequest:patient"
* rest.resource[=].searchInclude[+] = "ServiceRequest:requester"
* rest.resource[=].searchInclude[+] = "ServiceRequest:subject"
* insert IdSearchParam

// Task: search-type, update, read, create + multiple searchParams
* rest.resource[+].type = #Task
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[+].code = #create
* insert ResourceDefaults
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
