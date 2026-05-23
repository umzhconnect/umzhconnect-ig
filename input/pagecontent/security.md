In this article:

- [Introduction](#introduction)
- [Genaral approach - OAuth](#general-approach---oauth)
- [Health specifics - SMARTonFHIR](#health-specifics---smartonfhir)
- [Context-centric authorization](#context-centric-authorization)
- [Authorization enforcement](#authorization-enforcement)
- [Security enhancement](#security-enhancement)
- [Relationship to other security profiles](#relationship-to-other-security-profiles)


### Introduction

In this article we address security, authorization, and trust frameworks suitable for an open yet controlled healthcare API ecosystem. Out of the perspective of our pilot-project with two participants exposing data to each other through open but secured APIs, we show a hands on guide how each participant can/must secure his APIs based on industry standards, and examine how these approaches are expandable as ecosystems grows in terms of participants, software vendors, and regulatory expectations.

The use case considered is one where the placer creates a task at the fulfiller referencing a service request on placer’s side, the fulfiller based on the task proceeds to fetch the corresponding service request, and proceeds with an API based to query and fetch further resources referenced.

OAuth 2.0 and OpenID Connect–based architectures are the de-facto standard today for securing APIs, Security profiles such as SMART on FHIR define standards for health-specific use-cases and the OpenID Foundation’s FAPI 2.0 sharpens security awareness by enforcing measures to mitigate particular risk scenarios. In this article we explore to what extent these standards are applicable for our problem and where additional measures may be suitable.

Special attention is given to machine-to-machine interactions, which are central to referral and order workflows, and to design decisions around client authentication, including private key–based mechanisms, mutual TLS (mTLS), and layered combinations of both. The concept however should be extensible to user/human centric authentication and authorization and particularly compatible with the future E-ID initiative, identifying Swiss registered users.

### General approach - OAuth

Todays de-facto standard for securing Web-APIs is **OAuth & OpenID Connect**. In general OAuth is quite loosely defined and allows various ways of implementation. On a very high-level you could think of it like the following:

> *An application (possibly in combination with a logged in user) would like to access data from an external service. It therefore requests a security token from an authorization authority by providing credentials and uses this token in the request to the data service to provide proof of access rights and hence being allowed to access the data.*

**We follow industry standards with the use of OAuth/OIDC to segregate duties between identity management, token issuance, authentication & authorization enforcement.**

**OAuth glossary**

**Authorization Server (AS) -** The system that issues tokens after validating identity, credentials, or policies.<br />
**Resource Server (RS) -** The API or service that receives and validates tokens before granting access.<br />
**Client -** The application requesting access on behalf of a user or system.<br />
**Access Token -** A short‑lived credential the client uses to call APIs.<br />
**Scopes -** Fine‑grained permissions describing what the client is allowed to access.<br />
**Claims -** Attributes embedded in a token (e.g., user ID, roles, tenant, expiry).<br />
**Client Authentication -** How a client proves its identity to the authorization server (e.g., client secret, mTLS, private key JWT).<br />
**Grant Type -** The method a client uses to obtain tokens (e.g., Authorization Code, Client Credentials).<br />
**Policy engine** - system that evaluates rules (“policies”) to decide whether a specific action is allowed.<br />

```mermaid
flowchart LR
    Client <-->|Client Authentication & Token Issue| AS[Authorization Server]
    Client <-->|Presents Token<br>Grants or Denies Access| RS[Resource Server]
    RS -->|Validates Token| AS
```

**Machine-To-Machine communication**

Our principal focus will be on machine-to-machine communication: an organization allowing access to a set of data records to another organization without knowing which person is actually sending the request. It is likely that in later scenarios this option should also be considered an can be achieved by using alternative OAuth flows.

The **client-credentials OAuth flow** is the common way to approach this, where the client presents credentials and information about the action is it about to execute (scopes) to the resource server and in exchange receives an **access token.**

The access token again the client injects in the request to the **resource server** (the organization holding the sensitive patient data) and the latter can validate the token and grant or deny access.

### Health specifics - SMARTonFHIR

SMART on FHIR defines a **standard way for apps to securely connect to healthcare data** by combining:

- **OAuth 2.0–based authorization**
- **FHIR as the data API**
- **A consistent launch protocol** for apps inside or outside an EHR
- **A unified way to request permissions** using SMART scopes (i.e. **system/Patient.r** - read patient data etc..)

In practice, it gives app developers a predictable, interoperable method to authenticate, obtain tokens, and read/write clinical data across different EHR systems without custom integrations.

In our particular case we use SMART in the context of our use cases, for example:

- Ask permission to create a task resource at party X - scope: system/Task.w
- Ask permission to read service request data from party Y - scope: system/ServiceRequest.rs

### Context-centric authorization

Our use-cases of referrals and external service requests strongly suggest to dynamically authorize the audience (the counter party) to a very limited data set. Think of establishing a context when the service request is created:

> *For a given time I authorize party X (represented by client X) to read all data referenced by my given service request.*

Rather than minting a separate consent record and communicating its identifier through the authorization flow, UMZH-Connect binds the access token directly to the workflow object that triggered the interaction. Each cross-organizational API request is executed in the context of a specific FHIR resource. This context determines which resources the requester is permitted to access — all resources reachable from the workflow root in the FHIR reference graph:

{:class="table table-bordered"}
| Direction | Initiator | Context resource |
|-----------|-----------|-----------------|
| Fulfiller → Placer | Fulfiller fetches ServiceRequest and referenced resources | **ServiceRequest ID** (on Placer’s FHIR server) |
| Placer → Fulfiller | Placer reads Task status and result references | **Task ID** (on Fulfiller’s FHIR server) |

Context as part of the authorization flow may logically not be necessary — the restricting party may check all its workflow objects and verify whether one matches the current API request. However, defining the context identification as part of the authorization flow and access token may significantly simplify the authorization enforcement. The API consumer in essence tells the API provider in which **context** the API request is executed.

#### Communicating context at the token endpoint

The client communicates the workflow context to the Authorization Server using the **`authorization_details`** parameter defined in [RFC 9396 (Rich Authorization Requests)](https://www.rfc-editor.org/rfc/rfc9396). This is the standard OAuth extension point for structured, instance-specific authorization requests — purpose-built for cases where resource-type scopes alone are insufficient.

> **Note:** `authorization_details` is the same extension point used by [OpenID for Verifiable Credential Issuance (OID4VCI)](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0.html) to carry credential requests (`type: "openid_credential"`). UMZH-Connect follows the identical pattern with a custom type (`"umzh-connect-context"`), making the approach consistent with emerging identity standards and leveraging the same AS infrastructure — for example Keycloak's RAR support — that OID4VCI relies on.

The `scope` parameter continues to carry the SMART resource-type permission; `authorization_details` carries the instance-level context. The `type` URI identifies this as a UMZH-Connect extension; `identifier` follows RFC 9396 semantics — a plain string identifying a specific resource at the API:

```http
POST /token HTTP/1.1
Host: auth.umzhconnect.ch
Content-Type: application/x-www-form-urlencoded

grant_type=client_credentials
&client_id=fulfiller-app
&client_assertion_type=urn:ietf:params:oauth:client-assertion-type:jwt-bearer
&client_assertion=<signed JWT>
&scope=system/ServiceRequest.rs system/Patient.r system/Condition.r
&authorization_details=[{
  "type": "umzh-connect-context",
  "identifier": "ServiceRequest/sr-123"
}]
```

The `<signed JWT>` placeholder above is the **client-authentication assertion** ([RFC 7523](https://datatracker.ietf.org/doc/html/rfc7523), inherited by [SMART Backend Services](https://hl7.org/fhir/smart-app-launch/backend-services.html#protocol-details)) — the client constructs it itself and signs it with the private key whose public counterpart was registered with the Authorization Server at onboarding (Level 2 JWKS). It is short-lived, single-use, and pins the request to one specific token endpoint:

```json
{
  "iss": "fulfiller-app",
  "sub": "fulfiller-app",
  "aud": "https://auth.umzhconnect.ch/token",
  "exp": 1716470500,
  "jti": "9f4c-unique-nonce"
}
```

The Authorization Server validates this assertion (signature against the registered JWKS, `aud` equals its token endpoint, `exp` not expired, `jti` not previously seen) before proceeding to issue the access token described below. Note that this assertion JWT is distinct from the access token: the **client** signs the assertion to prove its identity to the AS; the **AS** signs the access token for the Resource Server to consume.

#### Issued access token — `fhirContext` claim

The Authorization Server maps the `authorization_details` context into a `fhirContext` claim in the issued JWT access token. The `fhirContext` structure follows [SMART App Launch v2](https://hl7.org/fhir/smart-app-launch/scopes-and-launch-context.html#fhircontext-exp). Note that SMART defines `fhirContext` only as a token-response parameter; UMZH-Connect extends that usage by additionally carrying the same structure as a claim inside the JWT access token, so that resource servers can enforce context without an extra introspection call:

```json
{
  "iss": "https://auth.umzhconnect.ch",
  "sub": "fulfiller-app",
  "aud": "https://fhir.placer.example",
  "exp": 1234567890,
  "scope": "system/ServiceRequest.rs system/Patient.r system/Condition.r",
  "party_id": "https://registry.example.org/fhir/Organization/fulfiller-org",
  "fhirContext": [
    {
      "reference": "ServiceRequest/sr-123"
    }
  ]
}
```

Below is an example of the full token-request and resource-access sequence:

```mermaid
sequenceDiagram
  title Context-bound token flow (Fulfiller fetching ServiceRequest)

  participant C as Client (Fulfiller)
  participant AS as Authorization Server
  participant AG as API Gateway (Placer)
  participant PE as Policy Engine
  participant FHIR as FHIR Server (Placer)

  Note over C,AS: Machine-to-machine: Client Credentials flow
  C->>AS: Token request (client auth) + scope<br/>+ authorization_details [{type, identifier: ServiceRequest/sr-123}]
  AS-->>C: JWT { smart_scopes, party_id, fhirContext: [{reference: "ServiceRequest/sr-123"}] }<br/>(optional: sender-constrained)

  C->>AG: API request + Authorization: Bearer <token>
  AG->>AG: Validate token (sig, iss, aud, exp, scope)<br/>(+ sender-constraint if FAPI)
  AG->>PE: AuthZ request: client, operation, resource, fhirContext
  PE->>FHIR: Evaluate whether requested resource(s)<br/>are within ServiceRequest/sr-123 graph
  PE-->>AG: Permit / Deny
  alt Permit
    AG->>FHIR: Forward request
    FHIR-->>C: Response: return permitted resources
  else Deny
    AG-->>C: 403 Forbidden
  end
```

How a party enforces this context internally — for example by maintaining a local FHIR Consent resource keyed to the workflow object — is a local implementation concern, described in [Implementation Notes](guidance-implementation-notes.html#consent-based-context-enforcement).

### Authorization enforcement

An enterprise grade web-service architecture, involves a number of steps for processing an HTTP request - DMZ / Firewall, TLS (HTTPS) termination, authentication, request routing, request processing and fine-grained authorization on resource server, etc.

```mermaid
flowchart TB
    Client -->|HTTP Request| API
    API -->|grant?| PE[Policy engine]
    PE -->|Yes/No| API
    API[API gateway] --->|Route request| RS[Resource Server]
```

We can think of a 3 step process to enforce security:

- Authentication - token extraction and validation -> we know the identity
- Scope Authorization - ensure that scope parameters match the requested parameters
- Context enforcement & fine-grained authorization, comprising two distinct checks:
  - **Counter-party entitlement** — is the calling party allowed to invoke this workflow context at all?
  - **Graph membership** — is each requested resource reachable from the workflow context root?

A common approach would be to handle the first (and optionally the second) step in the API gateway and the second and third step by the policy engine. In our case it would mean to ensure that all requested resources are part of the 'child graph' of the service request, which is the authorized workflow context (the `fhirContext` reference from the access token).

#### Counter-party entitlement is a Resource Server obligation

The `authorization_details` parameter is a **client-asserted** statement of context. The Authorization Server validates client authentication and scope syntax, but it does not by itself prove that the calling party is the legitimate counter-party of the workflow object named in the request — that knowledge lives in the Resource Server's workflow state, not at the AS. Requiring the AS to consult cross-organizational workflow data on every token request would force a tight AS↔RS coupling that the staged trust model of this guide deliberately avoids.

UMZH-Connect therefore places the counter-party entitlement check **on the Resource Server's policy engine**, alongside the graph-walk. For every incoming request the RS MUST:

1. Validate the token (signature, issuer, audience, expiry, and sender-constraint where applicable).
2. Verify that the authenticated `party_id` (and/or `client_id`) is the legitimate counter-party named by the workflow object referenced in the token's `fhirContext` — for example, that this organization is the fulfiller recorded on the `Task` derived from `ServiceRequest/sr-123`, or the placer of the `Task` whose status is being read.
3. Verify that every requested resource is reachable from `fhirContext` in the FHIR reference graph.

Tokens whose `fhirContext` resolves to a workflow object that does not name the calling party MUST be rejected with `403 Forbidden`, regardless of whether the AS issued a syntactically valid token for that context. The AS issues context-bound assertions; the Resource Server remains the sole arbiter of whether a given party is entitled to act within that context. How this check is realized internally — e.g. by inspecting the workflow object directly or via a local `Consent` resource keyed to it — is a local implementation concern, described in [Implementation Notes](guidance-implementation-notes.html#consent-based-context-enforcement).

In general it should be mentioned that fine-grained authorization may be a very complex task to perform on the standard FHIR API due to a variety of factors, such es a broad range of search parameters covered by standard FHIR APIs. This is quite well covered in this project:

[Google FHIR Info Gateway](https://developers.google.com/open-health-stack/fhir-info-gateway)

Our general approach is to whitelist only the neccessary endpoints and parameters required to enable our use case. The complexity of the authorization enforcement is therefore essentially reduced.

### Security enhancement

As the basic client credentials flow is subject to a number of security weaknesses, we define a stepwise security up-leveling approach for client authentication. Initial integrations may start with basic client credentials to enable rapid onboarding and piloting. As participants move to production and access higher-risk scopes, authentication is upgraded to private_key_jwt, replacing shared secrets with asymmetric keys registered during onboarding—without requiring a central PKI. For the highest assurance scenarios, the ecosystem supports mutual TLS (mTLS), strengthening client identity binding and reducing token replay risks. This staged model preserves a consistent authorization flow while providing a clear, operationally manageable path to stronger security.

The **authorization model and APIs remain stable**, while the **client authentication method** is strengthened over time. This makes the ecosystem scalable: partners can join quickly with minimal operational overhead, and then adopt stronger mechanisms when justified by risk, regulatory requirements, or production needs.

### Level 1 — Basic client credentials (shared secret)

- **Goal:** fastest onboarding; simplest implementation for pilots.
- **Mechanism:** `client_id` + shared secret used for token endpoint authentication.
- **Main trade-offs:** shared secret distribution and rotation burden; higher impact if secrets leak; weaker non-repudiation.
- **Best fit:** sandbox environments, limited scopes, early partner testing.

> **Note:** Level 1 is intentionally **not SMART Backend Services conformant** — Backend Services mandates `private_key_jwt`. Shared-secret authentication is offered only as a pilot rung to lower the barrier to first integration; SMART Backend Services conformance is reached at Level 2.

### Level 2 — `private_key_jwt` (asymmetric proof, no central PKI required)

- **Goal:** remove shared secrets and increase assurance while keeping onboarding practical.
- **Mechanism:** the client generates its own key pair and registers the **public key / JWKS** with the authorization server during onboarding. The client authenticates to the token endpoint by signing a JWT assertion with the private key.
- **Key benefits:** no shared secrets; cleaner key rotation; improved proof-of-possession characteristics; compatible with central client registration.
- **Operational needs:** JWKS registration, rotation procedure, and key rollover support.

At Level 2, UMZH-Connect aligns with **[SMART App Launch v2 — Backend Services](https://hl7.org/fhir/smart-app-launch/backend-services.html)**: clients authenticate to the token endpoint with `private_key_jwt` against a JWKS registered at onboarding, and SMART system scopes (`system/<Resource>.<perms>`) are carried in the standard `scope` parameter — not in a custom claim. No `openid` scope is requested, since these are pure machine-to-machine exchanges with no user identity. The single deliberate divergence from Backend Services is the per-request **`fhirContext` claim** embedded in the issued JWT access token (see [Context-centric authorization](#context-centric-authorization)), which binds each token to a specific workflow object. SMART defines `fhirContext` only as a token-response parameter; promoting it into the access token is what makes context enforceable at the Resource Server without an extra introspection call.

### Level 3 — mTLS (mutual TLS)

- **Goal:** highest assurance for client identity binding and stronger replay resistance.
- **Mechanism:** client presents an X.509 certificate at the TLS layer; the authorization server (and optionally the resource server) validates it. Optionally, tokens can be sender-constrained to the client certificate.
- **Key benefits:** strong client authentication; reduced token replay risk; high confidence in client identity.
- **Operational needs:** certificate lifecycle management (issuance, rotation, revocation), trust anchors (internal CA or managed PKI), and monitoring.

{:class="table table-bordered"}
| Level | Client authentication                             | When to use                                                  | Security benefits                                            | Operational footprint                                        |
| :---- | :------------------------------------------------ | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| **1** | Basic client credentials (shared secret)          | Sandbox, PoC, low-risk scopes, early pilots                  | Quick start; baseline access control                         | Secret distribution + rotation; higher blast radius if leaked |
| **2** | `private_key_jwt` (JWKS registered at onboarding) | Production default; medium/high-risk scopes; external partners | No shared secrets; stronger client proof; easier key rotation | Manage JWKS + key rollover; validate signed assertions       |
| **3** | mTLS (optionally sender-constrained tokens)       | Highest-risk scopes; regulated workflows; large-scale ecosystem | Strong client identity binding; replay resistance            | Certificate lifecycle + trust model; revocation/rotation processes |

## Policy triggers - governance rules for up-leveling

Use policy triggers to make the ladder actionable and predictable. The goal is to avoid “security by negotiation” and keep onboarding consistent.

### Suggested triggers for **mandating Level 2 (**`private_key_jwt`**)**

Mandate Level 2 when **any** of the following applies:

- **Production access** (non-sandbox environment).
- Client requests **write access** (create/update) or privileged scopes.
- Partner is **cross-organization** (external vendor/provider) and not under the same administrative domain.
- Integration handles **sensitive clinical content** beyond minimal administrative data.
- **Audit requirements** demand stronger attribution than shared secrets can provide.

### Suggested triggers for **mandating Level 3 (mTLS)**

Mandate Level 3 when **any** of the following applies:

- Access to **high-impact scopes** (e.g., broad patient search, bulk data export, or highly sensitive categories).
- **High-volume / high-automation** clients (service-to-service) where replay risk and credential theft impact is elevated.
- Regulatory, contractual, or security policy requires **certificate-based authentication**.
- The ecosystem reaches a scale where centralized governance needs **stronger identity binding** and standardized system trust.
- A partner shows elevated risk indicators (e.g., repeated security incidents, weak security posture, or inability to manage key material safely).

### Scope-based policy mapping

A possible scope mapping may look like:

- **Read-only, low-risk scopes** → Level 1 in sandbox; Level 2 in production.
- **Write / workflow-triggering scopes** → Level 2 minimum.
- **Bulk/export/high-risk scopes** → Level 3.

## High risk, level 3 and the applicability of the FAPI2.0 profile

The generic client credentials flow has potential security weaknesses. The main risks are:

- **Static client secrets** → reusable if compromised
- **Static trust model** → Hard to scale or federate (one auth server, trust anchor and issuer)
- **Replay and automation abuse** → Compromised access tokens lead to automated attacks

Following the policies reaching level 3, high-risk, employing mTLS, which cryptographically binds the token (or at least the session) to the client’s TLS certificate, so the token is only usable when presented over a TLS connection that proves possession of the matching private key. 

mTLS and other additional security enhancements are included in the definition of [OpenID FAPI2.0](https://openid.net/specs/fapi-security-profile-2_0-final.html) in order to mitigate these risks by adding standardized measurements defined by RFCs (RFC 5280, RFC 8705, RFC 6749, RFC 7519). In essence it defines how to

- add mTLS transport security to all connections
- populate tokens with cryptographic information
- how to pass cryptographic information between transport and application layer

FAPI2.0 enforcement adds requirements to classical certification management with PKI-infrastructure. Reference implementations (like Denmark) make use of a central PKI-infrastructure and certificate issuance and signing which reduces client side complexity (trust store etc) however requires central trust and single point of failure risk.

## Relationship to other security profiles

This section positions the UMZH-Connect security concept against three reference profiles that target overlapping problem spaces. The single architectural choice that distinguishes UMZH-Connect from all three is **context-bound tokens**: every access token is issued for one specific workflow object (a `ServiceRequest` or `Task`) carried in the JWT as a `fhirContext` claim, derived from an [RFC 9396](https://www.rfc-editor.org/rfc/rfc9396) `authorization_details` request. None of the reference profiles standardize this per-request binding.

**References:**

- [SMART App Launch v2 — Backend Services](https://hl7.org/fhir/smart-app-launch/backend-services.html)
- [HL7 FAST UDAP Security for Scalable Registration, Authentication, and Authorization](https://hl7.org/fhir/us/udap-security/)
- [CH EPR FHIR — Get Access Token [ITI-71]](https://www.fhir.ch/ig/ch-epr-fhir/iti-71.html), the Swiss national profile of the [IHE IUA](https://profiles.ihe.net/ITI/IUA/index.html) Get Access Token transaction.

{:class="table table-bordered"}
| Aspect | UMZH-Connect | [SMART Backend Services v2](https://hl7.org/fhir/smart-app-launch/backend-services.html) | [HL7 FAST UDAP](https://hl7.org/fhir/us/udap-security/) | [CH EPR ITI-71 (IUA)](https://www.fhir.ch/ig/ch-epr-fhir/iti-71.html) |
|---|---|---|---|---|
| Primary scope | M2M, per-workflow context | M2M, pre-authorized scopes | M2M + user via Tiered OAuth | M2M + healthcare professional / assistant |
| Trust onboarding | Bilateral JWKS (L2); mTLS w/ open CA (L3) | Out-of-band pre-registration | UDAP Dynamic Client Reg + community X.509 CA | Per-CH-EPR policy; registered actors |
| Client auth | secret (L1, non-conformant) → `private_key_jwt` (L2) → mTLS (L3) | `private_key_jwt` mandatory | `private_key_jwt` w/ UDAP cert; mTLS option | `private_key_jwt` + HTTP Message Signatures ([RFC 9421](https://datatracker.ietf.org/doc/html/rfc9421)) |
| Scope vocabulary | SMART `system/*` in `scope` | SMART `system/*` in `scope` | SMART-compatible + UDAP extensions | Profile-specific (`launch`, EPR scopes) |
| Per-request workflow context | **[RFC 9396](https://www.rfc-editor.org/rfc/rfc9396) + `fhirContext` JWT claim** | Not addressed | Not addressed | Not addressed |
| Caller-organization identity | `party_id` claim (registry URL) | Not standardized | UDAP B2B extension (org, role, PoU) | `home_community_id` + `ch_epr` extensions |
| User identity in M2M | Not in scope | Out-of-band for `user/`/`patient/` | Tiered OAuth → user's OIDC IdP | Mandatory `subject_name`, `subject_role`, `purpose_of_use` |
| Token format | JWT | JWT | JWT | JWT only (JWE forbidden) |
| Hardening reference | [FAPI 2.0](https://openid.net/specs/fapi-security-profile-2_0-final.html) (Level 3) | OAuth 2.0 BCP | UDAP profiles + cert policies | OAuth 2.1 + [RFC 9421](https://datatracker.ietf.org/doc/html/rfc9421) |
