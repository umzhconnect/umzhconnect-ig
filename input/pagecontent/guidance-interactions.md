In this article:

- [Overview](#overview)
- [Authorization at a glance](#authorization-at-a-glance)
- [Task search scoping](#task-search-scoping)
- [Read-only resources](#read-only-resources)
- [ServiceRequest](#servicerequest)
- [Task](#task)
- [Questionnaire](#questionnaire)
- [QuestionnaireResponse](#questionnaireresponse)
- [Versioning and conditional operations](#versioning-and-conditional-operations)

### Overview

The [CapabilityStatement](CapabilityStatement-ChUmzhConnectCapabilityStatement.html) is the normative source for the interactions exposed by a UMZH-Connect REST server. This page complements it with usage guidance: which search parameters are mandatory vs. optional, how SMART scopes map to each interaction, and how the per-request `fhirContext` claim restricts the resources a caller may reach.

Both server roles — [Placer](ActorDefinition-ch-umzh-connect-placer.html) and [Fulfiller](ActorDefinition-ch-umzh-connect-fulfiller.html) — implement the same `CapabilityStatement`; the applicable subset depends on the role. The Placer hosts the `ServiceRequest` graph; the Fulfiller hosts the `Task` graph.

### Authorization at a glance

Every request SHALL carry a bearer JWT access token. Two orthogonal checks apply on every interaction:

1. **SMART scope check** — the token's `scope` claim SHALL contain a SMART system scope sufficient for the requested operation (e.g. `system/ServiceRequest.rs` for ServiceRequest `read` + `search-type`, `system/Task.crus` for the full Task interaction set). See [Security — Health specifics](security.html#health-specifics---smartonfhir).

2. **`fhirContext` graph check** — for every resource type **other than `Task` and `Questionnaire`**, the requested resource SHALL be reachable from the workflow root named in the token's `fhirContext` claim (a `ServiceRequest/{id}` on the Placer, a `Task/{id}` on the Fulfiller). Requests for resources outside the context graph SHALL be rejected with `403 Forbidden`. See [Security — Context-centric authorization](security.html#context-centric-authorization).

`Task`   and `Questionnaire` are **not** `fhirContext`-gated:

- **`Task`** is the entry-point resource on the Fulfiller — it is searched and read by the requesting identity directly. Access is constrained by [Task search scoping](#task-search-scoping) (below), not by `fhirContext`.
- **`Questionnaire`** is a definitional artefact shared across workflows; it carries no patient data and is reachable independent of any specific workflow context.

### Task search scoping

`GET /Task` and `GET /Task?...` SHALL return only those Tasks for which the authenticated identity is either the **requester** (`Task.requester`) or the **owner** (`Task.owner`). The server enforces this implicit filter on every Task search regardless of the parameters supplied by the client; a client cannot widen the result set by omitting `owner`/`requester` parameters. This makes `Task` the safe entry point on the Fulfiller: the Placer organisation polls for Tasks it raised, the Fulfiller organisation polls for Tasks assigned to it, and neither sees the other's unrelated workflows.

### Read-only resources

Applies to: `AllergyIntolerance`, `Appointment`, `Condition`, `Coverage`, `DiagnosticReport`, `DocumentReference`, `ImagingStudy`, `Immunization`, `Medication`, `MedicationStatement`, `Observation`, `Organization`, `Patient`, `Practitioner`, `PractitionerRole`, `Procedure`, `QuestionnaireResponse` (see [QuestionnaireResponse](#questionnaireresponse)).

| Interaction | Path | Notes |
|---|---|---|
| `read` | `GET /{Type}/{id}` | Returns the resource only if `{Type}/{id}` is reachable from the token's `fhirContext` graph. |
{: .table .table-bordered }

Search parameters:

| Name | Type | Cardinality | Notes |
|---|---|---|---|
| `_id` | token | **mandatory** | Logical id of the resource. Searches without `_id` are not supported. |
{: .table .table-bordered }

These resources are reached transitively from the workflow root (e.g. `ServiceRequest.subject → Patient`, `ServiceRequest.reasonReference → Condition`). They are typically retrieved either via direct `read` on a known id or implicitly through `_include` on the workflow root.

### ServiceRequest

| Interaction | Path | Notes |
|---|---|---|
| `search-type` | `GET /ServiceRequest?_id={id}&...` | Returns only ServiceRequests reachable from `fhirContext` (in practice, the single ServiceRequest named by the token). |
| `read` | `GET /ServiceRequest/{id}` | Returns the ServiceRequest only if `{id}` matches `fhirContext`. |
{: .table .table-bordered }

Search parameters:

| Name | Type | Cardinality | Notes |
|---|---|---|---|
| `_id` | token | **mandatory** | Logical id. Searches without `_id` are not supported. |
| `_include` | — | optional | Supported targets: `ServiceRequest:patient`, `ServiceRequest:subject`, `ServiceRequest:requester`, `ServiceRequest:reason-reference`, `ServiceRequest:supporting-info`, `ServiceRequest:insurance`. Each included resource is itself subject to the `fhirContext` graph check. |
{: .table .table-bordered }

The Fulfiller typically issues a single `GET /ServiceRequest?_id={id}&_include=...` (or the equivalent `read` with `_include`) to materialise the workflow graph in one round-trip.

### Task

| Interaction | Path | Notes |
|---|---|---|
| `search-type` | `GET /Task?...` | Implicitly scoped to Tasks where the calling identity is `Task.owner` or `Task.requester` (see [Task search scoping](#task-search-scoping)). Not `fhirContext`-gated. |
| `read` | `GET /Task/{id}` | Allowed if the calling identity is `owner` or `requester` of the Task. |
| `create` | `POST /Task` | Used by the Placer to raise a coordination Task on the Fulfiller. |
| `patch` | `PATCH /Task/{id}` | JSON Patch (`application/json-patch+json`). **Only `Task.input`, `Task.owner`, `Task.focus`, and `Task.businessStatus` may be patched** — other paths SHALL be rejected. |
{: .table .table-bordered }

Search parameters:

| Name | Type | Cardinality | Notes |
|---|---|---|---|
| `_id` | token | optional | Logical id. |
| `owner` | reference | optional | Filter by `Task.owner`. |
| `requester` | reference | optional | Filter by `Task.requester`. |
| `status` | token | optional | Filter by `Task.status`. |
| `_include` | — | optional | Supported targets: `Task:output-value-reference`, `Task:output-value-canonical`. `Task.input` is not an `_include` target — the QuestionnaireResponse it carries is a cross-server absolute URL, resolved by a direct `read` against the Placer. |
{: .table .table-bordered }

A search with no parameters returns all Tasks visible to the calling identity (i.e. owned or requested by it).

### Questionnaire

| Interaction | Path | Notes |
|---|---|---|
| `search-type` | `GET /Questionnaire?...` | Definitional content — not `fhirContext`-gated. |
| `read` | `GET /Questionnaire/{id}` | Definitional content — not `fhirContext`-gated. |
{: .table .table-bordered }

Search parameters:

| Name | Type | Cardinality | Notes |
|---|---|---|---|
| `_id` | token | optional | Logical id. |
{: .table .table-bordered }

### QuestionnaireResponse

The QuestionnaireResponse is created and hosted by the **Placer** — following the principle of not posting sensitive data, it is not POSTed to the Fulfiller. The Placer references it from `Task.input` by **absolute URL**; the Fulfiller resolves that URL with a direct `read` against the Placer under the [Read-only resources](#read-only-resources) rules.

The QuestionnaireResponse's `basedOn` (1..1, [ChUmzhConnectQuestionnaireResponse](StructureDefinition-ch-umzh-connect-questionnaireresponse.html)) SHALL reference the workflow-root ServiceRequest. That back-reference is a specifically listed exception to the forward-only graph rule (see [Security — Context-centric authorization](security.html#context-centric-authorization)); a policy engine SHALL admit the QuestionnaireResponse on that basis alone. A Placer MAY additionally list it in `ServiceRequest.supportingInfo` for forward-only enforcement — optional, and not an order amendment.

The back-reference is safe only because the QuestionnaireResponse is authored **exclusively by the Placer** — the CapabilityStatement declares no `create`/`update`/`patch` for it. A Placer creates its own QuestionnaireResponses internally, not through this API, and **SHALL NOT** add a writable QuestionnaireResponse interaction to its cross-organizational surface — that would let a counter-party plant one with `basedOn` pointing at an arbitrary ServiceRequest and inject it into that order's context graph.

### Versioning and conditional operations

For every resource in the CapabilityStatement: `versioning = versioned-update`, `conditionalCreate = false`, `conditionalUpdate = false`. Clients performing `update` or `patch` SHALL supply the current version via `If-Match` and SHALL NOT rely on conditional create/update semantics.
