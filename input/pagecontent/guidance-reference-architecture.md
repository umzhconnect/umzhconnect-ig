<div markdown="1" class="impl-note">

This page is **informative** — optional guidance that adds no conformance requirements. It illustrates one possible architecture (realized in the sandbox) for building a conforming system; the normative rules are defined on the [Security](security.html) and core-concept pages.

</div>

### Overview

The [UMZH Connect Sandbox](https://github.com/umzhconnect/umzhconnect-sandbox) is a runnable reference implementation of this IG, and the architecture it follows is intended as a starting point for building a conforming system. It simulates two independent healthcare organizations — a [Placer](ActorDefinition-ch-umzh-connect-placer.html) and a [Fulfiller](ActorDefinition-ch-umzh-connect-fulfiller.html) — exchanging referral data through FHIR R4 APIs secured with OAuth 2.0 / SMART on FHIR.

The sandbox serves two purposes: a learning tool to see how the IG's concepts translate into a working system, and a validation target that implementers can develop and test their own system against.

### Reference Architecture

A conforming implementation can be decomposed into a small set of components with clearly separated responsibilities. The guiding principle is to **authenticate at the perimeter, delegate fine-grained authorization to a dedicated policy engine, and keep the FHIR server free of access-control logic**.

The end-to-end request and enforcement flow across these components is illustrated on the [Security](security.html#authorization-enforcement) page. The components and their responsibilities are:

**API Gateway** — the security perimeter and policy *enforcement* point. Every incoming request is authenticated here: the gateway validates the access token and the client's authentication (per the staged [client-authentication model](security-implementation.html#staged-client-authentication-model), from Level 1 shared secret through Level 2 `private_key_jwt`). It forwards only permitted requests to the FHIR server, but makes no fine-grained access decision itself — it asks the policy engine.

**Policy Engine** — the policy *decision* point, where context-centric authorization is delegated. For each request it evaluates whether the requested resource lies within the authorized workflow graph and whether the requesting organization is entitled to it. To decide, it queries the FHIR server: for the active FHIR Consent matching the workflow context carried in the token (`fhirContext`) — confirming the requesting organization is an authorized actor — and for the context root itself (the ServiceRequest and/or Task) and its referenced resources, to determine whether the requested resource (e.g. a `Condition`) is part of that graph (see [Consent-based context enforcement](security-implementation.html)). Externalizing this keeps the authorization rules centralized and independently testable.

**FHIR Server (Resource Server)** — pure storage and retrieval of FHIR resources, carrying no authorization logic. Because access control is handled upstream, this can be a stock, off-the-shelf FHIR server.

**Registry** — a directory of `Organization` and `Endpoint` resources. Endpoint addresses point to each party's external API; cross-party references (e.g. `Task.owner`, `Task.basedOn`) use absolute URLs rooted at the registry, matching the [inter-linked systems](https://hl7.org/fhir/managing.html#using) pattern required by this IG.

**Authorization Server** — issues OAuth 2.0 / OIDC tokens and carries the workflow context and organization identity into the token claims that the policy engine later evaluates.

#### Workflow in action

The sandbox drives the [Task at Fulfiller](core-concept-workflow-api.html) lifecycle end-to-end through these components: the Placer creates a ServiceRequest and POSTs a Task to the Fulfiller, the Fulfiller reads the referenced clinical data from the Placer, and writes results back into `Task.output`. A concrete use case with pre-loaded, IG-profiled seed data is included, explorable step-by-step through a web application and an API collection.

### Validation — Fine-grained Authorization

The sandbox ships an automated test suite that exercises the access-control rules explicitly and runs on every change via continuous integration. The fine-grained authorization cases include:

- **Context-graph membership** — with a context-scoped token, a party can read exactly the resources within the authorized ServiceRequest graph; a resource outside that graph (e.g. a `Condition` or `ImagingStudy` belonging to a *different* referral) is denied. Both the positive and negative paths are asserted.
- **Token and isolation enforcement** — missing, malformed, or tampered tokens are rejected, and neither party can reach the other's data directly — only through the context-gated cross-party path.
- **Client-authentication levels** — the Level 2 `private_key_jwt` path is exercised alongside the Level 1 baseline.

### Scope and Limitations

The sandbox runs via Docker Compose with no external dependencies; see the [README](https://github.com/umzhconnect/umzhconnect-sandbox#readme) for setup. Configuration is tuned for local development and demonstration purposes; it is not intended for production deployment as-is, but may serve as a starting point for custom implementations.
