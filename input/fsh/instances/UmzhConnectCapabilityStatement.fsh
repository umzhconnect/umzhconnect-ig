// RuleSets for CapabilityStatement resource definitions

RuleSet: ResourceDefaults
* rest.resource[=].versioning = #versioned-update
* rest.resource[=].conditionalCreate = false
* rest.resource[=].conditionalUpdate = false

RuleSet: IdSearchParam
* rest.resource[=].searchParam[+].name = "_id"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Logical id of this artifact"

RuleSet: MandatoryIdSearchParam
* rest.resource[=].searchParam[+].name = "_id"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Resource-id"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Logical id of this artifact. **Mandatory** — searches without `_id` are not supported on this resource."

RuleSet: ReadOnlyResource(type)
* rest.resource[+].type = #{type}
* rest.resource[=].interaction.code = #read
* rest.resource[=].interaction.documentation = "Returns the {type} resource by logical id. The resource is returned only if it is reachable from the workflow root named in the token's `fhirContext` claim. Requests for resources outside the context graph are rejected with `403 Forbidden`."
* insert ResourceDefaults
* insert MandatoryIdSearchParam

RuleSet: UrlSearchParam
* rest.resource[=].searchParam[+].name = "url"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Questionnaire-url"
* rest.resource[=].searchParam[=].type = #uri
* rest.resource[=].searchParam[=].documentation = "Canonical URL of the Questionnaire. Used to resolve a Questionnaire referenced by canonical."


Instance: ChUmzhConnectCapabilityStatement
InstanceOf: CapabilityStatement
Usage: #definition
* name = "UMZHconnectRestServer"
* status = #active
* date = "2026-01-27T16:12:05.435+01:00"
* kind = #requirements
* description = """UMZH Connect API requirements. This CapabilityStatement applies to both the [Placer](ActorDefinition-ch-umzh-connect-placer.html) and [Fulfiller](ActorDefinition-ch-umzh-connect-fulfiller.html) server roles. The required interactions overlap significantly; the applicable subset depends on the actor role:
- **Placer server** — hosts the ServiceRequest and all referenced clinical resources. \
The Fulfiller queries these via `read` and `search`.
- **Fulfiller server** — hosts the Coordination Task and related output resources. \
The Placer creates it via `create`, applies selective updates via `patch`, and queries via `read` and `search`."""
* fhirVersion = #4.0.1
* format = #application/fhir+json
* patchFormat = #application/json-patch+json

* rest.mode = #server

// Read-only resources with _id search
* insert ReadOnlyResource(AllergyIntolerance)
* insert ReadOnlyResource(Appointment)
* insert ReadOnlyResource(Condition)
* insert ReadOnlyResource(Coverage)
* insert ReadOnlyResource(DiagnosticReport)
* insert ReadOnlyResource(DocumentReference)
* insert ReadOnlyResource(ImagingStudy)
* insert ReadOnlyResource(Immunization)
* insert ReadOnlyResource(Medication)
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
* rest.resource[=].interaction[=].documentation = "Search for Questionnaire definitions. Questionnaire is a definitional artefact shared across workflows; it carries no patient data and is **not** `fhirContext`-gated."
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[=].documentation = "Read a Questionnaire by logical id or by canonical URL (url). Definitional content — **not** `fhirContext`-gated."
* insert ResourceDefaults
* insert IdSearchParam
* insert UrlSearchParam

// QuestionnaireResponse: create, read
* rest.resource[+].type = #QuestionnaireResponse
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[=].documentation = "Search for QuestionnaireResponses. Implicitly scoped to QuestionnaireResponses accessible to the calling identity."
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[=].documentation = "Read a QuestionnaireResponse by logical id. Allowed if the linked parent ServiceRequest is accessible to the calling identity."
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[=].documentation = "Create a QuestionnaireResponse. The created resource SHALL reference an accessible ServiceRequest via `basedOn`."
* insert ResourceDefaults

// ServiceRequest: search-type, read + searchIncludes
* rest.resource[+].type = #ServiceRequest
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[=].documentation = "Search for ServiceRequests. Returns only ServiceRequests reachable from the token's `fhirContext` claim — in practice, the single ServiceRequest named by the token. `_id` is mandatory; `_include` is supported to materialise the workflow graph in one round-trip, and each included resource is itself subject to the `fhirContext` graph check."
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[=].documentation = "Read a ServiceRequest by logical id. Returns the resource only if `{id}` matches the token's `fhirContext` claim."
* insert ResourceDefaults
* rest.resource[=].searchInclude[0] = "ServiceRequest:patient"
* rest.resource[=].searchInclude[+] = "ServiceRequest:subject"
* rest.resource[=].searchInclude[+] = "ServiceRequest:ch-umzhconnectig-servicerequest-reasonreference"
* rest.resource[=].searchInclude[+] = "ServiceRequest:ch-umzhconnectig-servicerequest-supportinginfo"
* rest.resource[=].searchInclude[+] = "ServiceRequest:ch-umzhconnectig-servicerequest-insurance"
* insert MandatoryIdSearchParam

// Task: search-type, patch, read, create + multiple searchParams
* rest.resource[+].type = #Task
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[=].documentation = "Search for Tasks. Implicitly scoped to Tasks where the calling identity is `Task.owner` or `Task.requester` — the server SHALL enforce this filter regardless of the parameters supplied by the client. A client cannot widen the result set by omitting `owner`/`requester` parameters. Task is **not** `fhirContext`-gated; it is the entry-point resource on the Fulfiller."
* rest.resource[=].interaction[+].code = #patch
* rest.resource[=].interaction[=].documentation = "JSON Patch (`application/json-patch+json`) update of a Task. Only `Task.input`, `Task.owner`, `Task.focus`, and `Task.businessStatus` may be patched — other paths SHALL be rejected."
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[=].documentation = "Read a Task by logical id. Allowed if the calling identity is `Task.owner` or `Task.requester`."
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[=].documentation = "Create a Task. Used by the Placer to raise a coordination Task on the Fulfiller."
* insert ResourceDefaults
* rest.resource[=].searchInclude[0] = "Task:ch-umzhconnectig-task-inputreference"
* rest.resource[=].searchInclude[+] = "Task:ch-umzhconnectig-task-outputreference"
* rest.resource[=].searchInclude[+] = "Task:ch-umzhconnectig-task-outputcanonical"
* rest.resource[=].searchParam[0].name = "owner"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Task-owner"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "Search by task owner"
* rest.resource[=].searchParam[+].name = "requester"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Task-requester"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "Search by task requester"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Task-status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "Search by task status"
* insert IdSearchParam
