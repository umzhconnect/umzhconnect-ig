All significant changes to this FHIR implementation guide are documented on this page.

### STU 1 (2025-12-15)
* [#52](https://github.com/umzhconnect/umzhconnect-ig/issues/52): Add a completed Task example for the orthopedic referral with results in `Task.output` — an intermediary pre-surgery consultation Appointment plus a discharge report (DocumentReference) and discharge medication
* [#42](https://github.com/umzhconnect/umzhconnect-ig/issues/42): Align Task.status and Task.businessStatus with COW — drop local `ChUmzhConnectTaskBusinessStatus` value set, bind `Task.businessStatus` to the COW `business-status` value set, switch the initial Task.status from `ready` to `requested`, add a Workflow States page, and require that Placer PATCHes are only valid when `Task.owner` is the Placer
* [#50](https://github.com/umzhconnect/umzhconnect-ig/issues/50): Show changelog note on the IG home page
* [#46](https://github.com/umzhconnect/umzhconnect-ig/issues/46): Task.code — remove clinical service category binding; align examples with COW Task.code using `fulfill` from the standard TaskCode CodeSystem
* [#37](https://github.com/umzhconnect/umzhconnect-ig/issues/37): Task updates via JSON Patch (PATCH method added to CapabilityStatement)
* [#40](https://github.com/umzhconnect/umzhconnect-ig/issues/40): mCSD-based registry — profile Task to require requestor/owner as absolute URL, add Registry section to core concepts
* [#35](https://github.com/umzhconnect/umzhconnect-ig/issues/35): Link to organization as an absolute url to the registry (e.g. mCSD directory)
* [#31](https://github.com/umzhconnect/umzhconnect-ig/issues/31): Rename hospitalp to placer and hospitalf to fulfiller, add host descriptions to example resources
* [#10](https://github.com/umzhconnect/umzhconnect-ig/issues/10): Add ValueSet for ServiceRequest.category
