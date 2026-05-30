### Consent-based context enforcement

The [Security](security.html) page defines the UMZH-Connect authorization model: workflow context is communicated via `authorization_details` at the token endpoint and reflected as a `fhirContext` claim in the issued JWT. The actual enforcement of that context — verifying that requested resources fall within the authorized graph — is left to each party's implementation.

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

<hr style="margin-top:2em"/>

[^consent-fields]: The example shows only the fields relevant to context enforcement. FHIR mandates additional elements — `Consent.scope` and `Consent.category` in R4, and a `role` on each `provision.actor` — which must be populated for a valid resource; how they are coded is a local concern left to each implementor.
