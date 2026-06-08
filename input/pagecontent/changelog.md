All significant changes to this FHIR implementation guide are documented on this page.

### Unreleased
* [#60](https://github.com/umzhconnect/umzhconnect-ig/issues/60): Add Guidance - Interactions page documenting all CapabilityStatement interactions, SMART scopes, `fhirContext` gating, and Task search scoping; mark `_id` as mandatory in the CapabilityStatement search params for clinical resources and ServiceRequest

### STU 1 (2025-12-15)
* [#69](https://github.com/umzhconnect/umzhconnect-ig/issues/69): Relax the ServiceRequest `supportingInfo[medicationstatement]` slice from CH EMED to CH Core MedicationStatement (CH EMED mandates a contained Medication; CH Core also allows a non-contained one). Also adjust the orthopedic discharge-medication example to reference a standalone (non-contained) `Medication` resource as a demonstration
* [#71](https://github.com/umzhconnect/umzhconnect-ig/issues/71): Relax `ServiceRequest.reasonReference` cardinality from 1..1 to 0..1
* [#52](https://github.com/umzhconnect/umzhconnect-ig/issues/52): Add a completed Task example for the orthopedic referral with results in `Task.output` — an intermediary pre-surgery consultation Appointment plus a discharge report (DocumentReference) and discharge medication
* [#42](https://github.com/umzhconnect/umzhconnect-ig/issues/42): Align Task.status and Task.businessStatus with COW — drop local `ChUmzhConnectTaskBusinessStatus` value set, bind `Task.businessStatus` to the COW `business-status` value set, switch the initial Task.status from `ready` to `requested`, add a Workflow States page, and require that Placer PATCHes are only valid when `Task.owner` is the Placer
* [#45](https://github.com/umzhconnect/umzhconnect-ig/issues/45): JWT structure — carry caller-organization identity as `extensions.umzhconnect.organization_reference` (IHE IUA `extensions` container) and document the client-assertion JWT claims
* [#45](https://github.com/umzhconnect/umzhconnect-ig/issues/45): JWT structure — carry caller-organization identity as `extensions.umzhconnect.organization_reference` (IHE IUA `extensions` container), document the client-assertion JWT claims, and focus the Security page on `private_key_jwt` (staged client-authentication levels moved to Implementation Notes)
* [#50](https://github.com/umzhconnect/umzhconnect-ig/issues/50): Show changelog note on the IG home page
* [#46](https://github.com/umzhconnect/umzhconnect-ig/issues/46): Task.code — remove clinical service category binding; align examples with COW Task.code using `fulfill` from the standard TaskCode CodeSystem
* [#37](https://github.com/umzhconnect/umzhconnect-ig/issues/37): Task updates via JSON Patch (PATCH method added to CapabilityStatement)
* [#40](https://github.com/umzhconnect/umzhconnect-ig/issues/40): mCSD-based registry — profile Task to require requestor/owner as absolute URL, add Registry section to core concepts
* [#35](https://github.com/umzhconnect/umzhconnect-ig/issues/35): Link to organization as an absolute url to the registry (e.g. mCSD directory)
* [#31](https://github.com/umzhconnect/umzhconnect-ig/issues/31): Rename hospitalp to placer and hospitalf to fulfiller, add host descriptions to example resources
* [#10](https://github.com/umzhconnect/umzhconnect-ig/issues/10): Add ValueSet for ServiceRequest.category
