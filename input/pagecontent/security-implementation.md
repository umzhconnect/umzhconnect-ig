### Consent-based context enforcement

The [Security](security.html) page defines the UMZH-Connect authorization model: workflow context is communicated via `authorization_details` at the token endpoint and reflected as a `fhirContext` claim in the issued JWT. The actual enforcement of that context — verifying that requested resources fall within the authorized graph — is left to each party's implementation.

In general it should be mentioned that fine-grained authorization may be a very complex task to perform on the standard FHIR API due to a variety of factors, such as a broad range of search parameters covered by standard FHIR APIs. This is quite well covered in the [Google FHIR Info Gateway](https://developers.google.com/open-health-stack/fhir-info-gateway) project. Our general approach is to whitelist only the necessary endpoints and parameters required to enable our use case. The complexity of the authorization enforcement is therefore essentially reduced.

This page describes one recommended implementation pattern using a FHIR **Consent** resource as a local access-control record.

#### Consent-based enforcement

When a workflow object is created — a ServiceRequest on the Placer's side, or a Task on the Fulfiller's side — the hosting party creates a corresponding FHIR Consent resource on their own FHIR server. The Consent:

- References the workflow root object via `Consent.provision.data` with `meaning = "related"`, capturing the full resource graph in scope
- Identifies the authorized counter-organization via `Consent.provision.actor`
- Carries an optional expiration date via `Consent.provision.period.end`
- Can be revoked at any time by setting `Consent.status = inactive`

**Example — Placer creates a Consent authorizing the Fulfiller to access the ServiceRequest graph:**[^consent-fields]

```json
{
  "resourceType": "Consent",
  "status": "active",
  "provision": {
    "period": {"end": "2026-12-31"},
    "actor": [
      {
        "reference": {"reference": "https://registry.example.org/fhir/Organization/fulfiller-org"}
      }
    ],
    "data": [
      {
        "meaning": "related",
        "reference": {"reference": "ServiceRequest/sr-123"}
      }
    ]
  }
}
```

The `meaning = "related"` value means the Consent covers the referenced ServiceRequest and all resources it transitively references — exactly the graph the policy engine must enforce.

#### Policy engine query

When the Resource Server receives an API request carrying a JWT with a `fhirContext` claim, the policy engine resolves the context reference to the corresponding Consent:

```http
GET /Consent?data=ServiceRequest/sr-123&status=active
```

If an active Consent is found and `token.extensions.umzhconnect.organization_reference` matches `Consent.provision.actor.reference`, the request is permitted for any resource within the ServiceRequest graph. If no active Consent exists — because it was never created, has expired, or has been revoked — the request is denied.

#### Expiration

Set `Consent.provision.period.end` to the date after which access should no longer be granted. The policy engine checks the period as part of its evaluation. No token invalidation is required — expired Consents simply return no results on the query.

#### Revocation

To revoke access immediately, set `Consent.status = inactive`. The next policy engine query for that context will find no active Consent and deny the request.

Parties using short-lived token caches should ensure cache TTLs are short enough to propagate revocation in a timely manner.

#### Scope notes

FHIR Consent is designed primarily for patient consent to data use. Its application here as a local inter-system access-control record is pragmatic: the semantics of `provision.data.meaning = "related"` align naturally with the graph-based enforcement model, and the lifecycle fields (expiration, status) map cleanly onto standard Consent elements. Parties are free to adopt alternative enforcement mechanisms as long as they honour the `fhirContext` claim from the access token as the authoritative context identifier.

### Staged client-authentication model

The [Security](security.html#client-authentication) page defines `private_key_jwt` as the production baseline for client authentication. UMZH-Connect additionally supports a staged model: a lighter rung below the baseline to lower the barrier for early pilots, and a higher-assurance rung above it for high-risk scenarios. The **authorization model and APIs are identical across all rungs** — only the client-authentication method changes. This section describes the full ladder and the governance rules for choosing a rung; it is deployment guidance, not a change to the wire protocol.

#### Why a staged model

As the basic client credentials flow is subject to a number of security weaknesses, we define a stepwise security up-leveling approach for client authentication. Initial integrations may start with basic client credentials to enable rapid onboarding and piloting. As participants move to production and access higher-risk scopes, authentication is upgraded to `private_key_jwt`, replacing shared secrets with asymmetric keys registered during onboarding — without requiring a central PKI. For the highest-assurance scenarios, the ecosystem supports mutual TLS (mTLS), strengthening client identity binding and reducing token replay risks. This staged model preserves a consistent authorization flow while providing a clear, operationally manageable path to stronger security: partners can join quickly with minimal operational overhead, and then adopt stronger mechanisms when justified by risk, regulatory requirements, or production needs.

#### Level 1 — Basic client credentials (shared secret)

- **Goal:** fastest onboarding; simplest implementation for pilots.
- **Mechanism:** `client_id` + shared secret used for token endpoint authentication.
- **Main trade-offs:** shared secret distribution and rotation burden; higher impact if secrets leak; weaker non-repudiation.
- **Best fit:** sandbox environments, limited scopes, early partner testing.

> **Note:** Level 1 is intentionally **not SMART Backend Services conformant** — Backend Services mandates `private_key_jwt`. Shared-secret authentication is offered only as a pilot rung to lower the barrier to first integration; SMART Backend Services conformance is reached at Level 2.

#### Level 2 — `private_key_jwt` (baseline)

The production baseline, defined normatively on the [Security](security.html#client-authentication) page: the client registers its public key / JWKS with the Authorization Server at onboarding and authenticates to the token endpoint by signing a JWT assertion with the private key. No shared secrets; cleaner key rotation; improved proof-of-possession; SMART Backend Services conformant. Operationally it requires JWKS registration, a rotation procedure, and key rollover support.

#### Level 3 — mTLS (mutual TLS)

- **Goal:** highest assurance for client identity binding and stronger replay resistance.
- **Mechanism:** client presents an X.509 certificate at the TLS layer; the authorization server (and optionally the resource server) validates it. Optionally, tokens can be sender-constrained to the client certificate.
- **Key benefits:** strong client authentication; reduced token replay risk; high confidence in client identity.
- **Operational needs:** certificate lifecycle management (issuance, rotation, revocation), trust anchors (internal CA or managed PKI), and monitoring.

#### Level comparison

{:class="table table-bordered"}
| Level | Client authentication                             | When to use                                                  | Security benefits                                            | Operational footprint                                        |
| :---- | :------------------------------------------------ | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| **1** | Basic client credentials (shared secret)          | Sandbox, PoC, low-risk scopes, early pilots                  | Quick start; baseline access control                         | Secret distribution + rotation; higher blast radius if leaked |
| **2** | `private_key_jwt` (JWKS registered at onboarding) | Production default; medium/high-risk scopes; external partners | No shared secrets; stronger client proof; easier key rotation | Manage JWKS + key rollover; validate signed assertions       |
| **3** | mTLS (optionally sender-constrained tokens)       | Highest-risk scopes; regulated workflows; large-scale ecosystem | Strong client identity binding; replay resistance            | Certificate lifecycle + trust model; revocation/rotation processes |

#### Governance triggers for up-leveling

Use policy triggers to make the ladder actionable and predictable. The goal is to avoid "security by negotiation" and keep onboarding consistent.

**Mandate Level 2 (`private_key_jwt`)** when **any** of the following applies:

- **Production access** (non-sandbox environment).
- Client requests **write access** (create/update) or privileged scopes.
- Partner is **cross-organization** (external vendor/provider) and not under the same administrative domain.
- Integration handles **sensitive clinical content** beyond minimal administrative data.
- **Audit requirements** demand stronger attribution than shared secrets can provide.

**Mandate Level 3 (mTLS)** when **any** of the following applies:

- Access to **high-impact scopes** (e.g., broad patient search, bulk data export, or highly sensitive categories).
- **High-volume / high-automation** clients (service-to-service) where replay risk and credential theft impact is elevated.
- Regulatory, contractual, or security policy requires **certificate-based authentication**.
- The ecosystem reaches a scale where centralized governance needs **stronger identity binding** and standardized system trust.
- A partner shows elevated risk indicators (e.g., repeated security incidents, weak security posture, or inability to manage key material safely).

**Scope-based mapping** — a possible mapping:

- **Read-only, low-risk scopes** → Level 1 in sandbox; Level 2 in production.
- **Write / workflow-triggering scopes** → Level 2 minimum.
- **Bulk/export/high-risk scopes** → Level 3.

#### High assurance: mTLS and FAPI 2.0

The generic client credentials flow has potential security weaknesses. The main risks are:

- **Static client secrets** → reusable if compromised
- **Static trust model** → hard to scale or federate (one auth server, trust anchor and issuer)
- **Replay and automation abuse** → compromised access tokens lead to automated attacks

At Level 3 (high-risk), employing mTLS cryptographically binds the token (or at least the session) to the client's TLS certificate, so the token is only usable when presented over a TLS connection that proves possession of the matching private key.

mTLS and other additional security enhancements are included in the definition of [OpenID FAPI 2.0](https://openid.net/specs/fapi-security-profile-2_0-final.html) in order to mitigate these risks by adding standardized measures defined by RFCs (RFC 5280, RFC 8705, RFC 6749, RFC 7519). In essence it defines how to

- add mTLS transport security to all connections
- populate tokens with cryptographic information
- pass cryptographic information between transport and application layer

FAPI 2.0 enforcement adds requirements to classical certificate management with PKI infrastructure. Reference implementations (like Denmark) make use of a central PKI infrastructure and certificate issuance and signing, which reduces client-side complexity (trust store etc.) but requires central trust and carries single-point-of-failure risk.

### Relationship to other security profiles

This section positions the UMZH-Connect security concept against three reference profiles that target overlapping problem spaces. The single architectural choice that distinguishes UMZH-Connect from all three is **context-bound tokens**: every access token is issued for one specific workflow object (a `ServiceRequest` or `Task`) carried in the JWT as a `fhirContext` claim, derived from an [RFC 9396](https://www.rfc-editor.org/rfc/rfc9396) `authorization_details` request. None of the reference profiles standardize this per-request binding.

**References:**

- [SMART App Launch v2 — Backend Services](https://hl7.org/fhir/smart-app-launch/backend-services.html)
- [HL7 FAST UDAP Security for Scalable Registration, Authentication, and Authorization](https://hl7.org/fhir/us/udap-security/)
- [CH EPR FHIR — Get Access Token [ITI-71]](https://www.fhir.ch/ig/ch-epr-fhir/iti-71.html), the Swiss national profile of the [IHE IUA](https://profiles.ihe.net/ITI/IUA/index.html) Get Access Token transaction.

{:class="table table-bordered"}
| Aspect | UMZH-Connect | [SMART Backend Services v2](https://hl7.org/fhir/smart-app-launch/backend-services.html) | [HL7 FAST UDAP](https://hl7.org/fhir/us/udap-security/) | [CH EPR ITI-71 (IUA)](https://www.fhir.ch/ig/ch-epr-fhir/iti-71.html) |
|---|---|---|---|---|
| Primary scope | M2M, per-workflow context | M2M, pre-authorized scopes | M2M + user via Tiered OAuth | M2M + healthcare professional / assistant |
| Trust onboarding | Bilateral JWKS at onboarding; mTLS w/ open CA for high assurance | Out-of-band pre-registration | UDAP Dynamic Client Reg + community X.509 CA | Per-CH-EPR policy; registered actors |
| Client auth | `private_key_jwt` (JWKS at onboarding); mTLS option for high assurance | `private_key_jwt` mandatory | `private_key_jwt` w/ UDAP cert; mTLS option | `private_key_jwt` + HTTP Message Signatures ([RFC 9421](https://datatracker.ietf.org/doc/html/rfc9421)) |
| Scope vocabulary | SMART `system/*` in `scope` | SMART `system/*` in `scope` | SMART-compatible + UDAP extensions | Profile-specific (`launch`, EPR scopes) |
| Per-request workflow context | **[RFC 9396](https://www.rfc-editor.org/rfc/rfc9396) + `fhirContext` JWT claim** | Not addressed | Not addressed | Not addressed |
| Caller-organization identity | `extensions.umzhconnect.organization_reference` (registry URL) — follows [IHE IUA](https://profiles.ihe.net/ITI/IUA/index.html) `extensions` container pattern | Not standardized | UDAP B2B `hl7-b2b` extension (`organization_id`, `organization_name`, `purpose_of_use`) | `extensions.ihe_iua` + `extensions.ch_epr` |
| User identity in M2M | Not in scope | Out-of-band for `user/`/`patient/` | Tiered OAuth → user's OIDC IdP | Mandatory `subject_name`, `subject_role`, `purpose_of_use` |
| Token format | JWT | JWT | JWT | JWT only (JWE forbidden) |
| Hardening reference | [FAPI 2.0](https://openid.net/specs/fapi-security-profile-2_0-final.html) (high-assurance option) | OAuth 2.0 BCP | UDAP profiles + cert policies | OAuth 2.1 + [RFC 9421](https://datatracker.ietf.org/doc/html/rfc9421) |

<hr style="margin-top:2em"/>

[^consent-fields]: The example shows only the fields relevant to context enforcement. FHIR mandates additional elements — `Consent.scope` and `Consent.category` in R4, and a `role` on each `provision.actor` — which must be populated for a valid resource; how they are coded is a local concern left to each implementor.
