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
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[=].documentation = "Search for {type} resources. Returns only resources within the authorized context graph of the token's `fhirContext` claim."
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[=].documentation = "Returns the {type} resource by logical id. The resource is returned only if it is within the authorized context graph of the token's `fhirContext` claim. Requests for resources outside the context graph are rejected with `403 Forbidden`."
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
The Placer creates it via `create`, applies selective updates via `update`, and queries via `read` and `search`."""
* fhirVersion = #4.0.1
* format = #application/fhir+json

* rest.mode = #server

// Read-only resources with _id search
* insert ReadOnlyResource(AllergyIntolerance)
* insert ReadOnlyResource(Appointment)
* insert ReadOnlyResource(Condition)
* insert ReadOnlyResource(Coverage)
* insert ReadOnlyResource(DiagnosticReport)
* rest.resource[=].searchInclude[0] = "DiagnosticReport:result"
* insert ReadOnlyResource(DocumentReference)
* insert ReadOnlyResource(ImagingStudy)
* insert ReadOnlyResource(Immunization)
* insert ReadOnlyResource(Medication)
* insert ReadOnlyResource(MedicationStatement)
* rest.resource[=].searchInclude[0] = "MedicationStatement:medication"
* insert ReadOnlyResource(Observation)
* insert ReadOnlyResource(Organization)
* insert ReadOnlyResource(Patient)
* insert ReadOnlyResource(Practitioner)
* insert ReadOnlyResource(PractitionerRole)
* rest.resource[=].searchInclude[0] = "PractitionerRole:practitioner"
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

// QuestionnaireResponse: hosted on the Placer; in the workflow graph via its basedOn back-reference to the ServiceRequest (see Security — Context-centric authorization)
* insert ReadOnlyResource(QuestionnaireResponse)

// ServiceRequest: search-type, read + searchIncludes
* rest.resource[+].type = #ServiceRequest
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[=].documentation = "Search for ServiceRequests. Returns only ServiceRequests reachable from the token's `fhirContext` claim — in practice, the single ServiceRequest named by the token. `_id` is mandatory; `_include` is supported to materialise the workflow graph in one round-trip, and each included resource is itself subject to the `fhirContext` graph check. `_include:iterate` MAY be supported for the `_include` targets of the included resource types."
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[=].documentation = "Read a ServiceRequest by logical id. Returns the resource only if `{id}` matches the token's `fhirContext` claim."
* insert ResourceDefaults
* rest.resource[=].searchInclude[0] = "ServiceRequest:patient"
* rest.resource[=].searchInclude[+] = "ServiceRequest:subject"
* rest.resource[=].searchInclude[+] = "ServiceRequest:requester"
* rest.resource[=].searchInclude[+] = "ServiceRequest:reason-reference"
* rest.resource[=].searchInclude[+] = "ServiceRequest:supporting-info"
* rest.resource[=].searchInclude[+] = "ServiceRequest:insurance"
* insert MandatoryIdSearchParam

// Task: search-type, update, read, create + multiple searchParams
* rest.resource[+].type = #Task
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[=].documentation = "Search for Tasks. Implicitly scoped to Tasks where the calling identity is `Task.owner` or `Task.requester` — the server SHALL enforce this filter regardless of the parameters supplied by the client. A client cannot widen the result set by omitting `owner`/`requester` parameters. Task is **not** `fhirContext`-gated; it is the entry-point resource on the Fulfiller. `_include:iterate` MAY be supported for the `_include` targets of the included resource types."
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].interaction[=].documentation = "Update of a Task. Allowed if the calling identity is `Task.requester` and `Task.businessStatus` is `awaiting-information`. The submitted Task SHALL differ from the stored Task only by added entries in `Task.input` and a removed `Task.businessStatus` — other updates SHALL be rejected."
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[=].documentation = "Read a Task by logical id. Allowed if the calling identity is `Task.owner` or `Task.requester`."
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[=].documentation = "Create a Task. Used by the Placer to raise a coordination Task on the Fulfiller."
* insert ResourceDefaults
* rest.resource[=].updateCreate = false
* rest.resource[=].searchInclude[0] = "Task:output-value-reference"
* rest.resource[=].searchInclude[+] = "Task:output-value-canonical"
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
* rest.resource[=].searchParam[+].name = "_lastUpdated"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Resource-lastUpdated"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].documentation = "Search by last modification time; the Placer polls this for Task deltas"
* insert IdSearchParam
