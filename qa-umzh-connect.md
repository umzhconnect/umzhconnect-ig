# Q&A zu UMZH Connect — Antwortentwurf

Arbeitsdokument zur Beantwortung der Fragen aus `q_a_UMZH Connect-v20.pdf` (v20, 2025-08-14).

- **Kenntnisstand**: übernommen aus dem Q&A-Dokument (Spalte «heutiger Kenntnisstand»), leicht gekürzt.
- **Antwort**: von uns zu formulieren.
- **IG-Auswirkung**: falls die Antwort eine Anpassung an IG-Seiten, Profilen oder Beispielen nach sich zieht.
- **Status**: `offen` → `Entwurf` → `beantwortet`.

## Übersicht

Spalte **Issue / PR**: `#NN` = bestehendes Issue/PR · `TODO` = Issue zu eröffnen (Massnahme entschieden) · `TBD` = beantwortet, Issue-Bedarf noch zu entscheiden · `deferred` = bekannte Lücke, wird bei Bedarf (Use Case) gelöst · `–` = keine IG-Änderung · leeres Feld = noch nicht bewertet.

| ID | Thema | Status | Issue / PR |
|------|-------|--------|------------|
| [ON-1](#on-1-initiales-onboarding-eines-le-placers) | Initiales Onboarding eines LE Placers | Entwurf | – |
| [SEC-1](#sec-1-security-sicht-anbindung-erster-externer-partner) | Security-Sicht: Anbindung erster externer Partner | Entwurf | – |
| [SEC-2](#sec-2-authentifikation-eines-placers-einmalig-oder-pro-task) | Authentifikation eines Placers: einmalig oder pro Task | Entwurf | – |
| [SEC-3](#sec-3-zugriffslifecycle-auf-den-klinischen-graphen) | Zugriffslifecycle auf den klinischen Graphen | Entwurf | TBD (CR) |
| [SEC-4](#sec-4-dynamischer-resource-graph-supportinginfo) | Dynamischer Resource-Graph (`supportingInfo`) | Entwurf | – |
| [SEC-5](#sec-5-mtls-oder-dpop) | mTLS oder DPoP | Entwurf | – |
| [WF-1](#wf-1-technisch-zugestellt-vs-fachlich-angenommen) | Technisch zugestellt vs. fachlich angenommen | Entwurf | – |
| [WF-2](#wf-2-synchronisation-servicerequeststatus-mit-task) | Synchronisation `ServiceRequest.status` mit Task | Entwurf | TBD |
| [WF-3](#wf-3-source-of-truth-bei-änderungen-am-laufenden-servicerequest) | Source of Truth bei Änderungen am laufenden ServiceRequest | offen |  |
| [WF-4](#wf-4-rückfragen-questionnaire--questionnaireresponse-normativ) | Rückfragen: Questionnaire → QuestionnaireResponse normativ? | Entwurf | [#87](https://github.com/umzhconnect/umzhconnect-ig/pull/87), TBD |
| [WF-5](#wf-5-rückfragen-vom-placer-nach-abschluss) | Rückfragen vom Placer nach Abschluss | Entwurf | – |
| [WF-6](#wf-6-warum-task-at-fulfiller) | Warum Task-at-Fulfiller? | Entwurf | – |
| [WF-7](#wf-7-zentraler-orchestrator-vs-task-at-fulfiller) | Zentraler Orchestrator vs. Task-at-Fulfiller | Entwurf | – |
| [WF-8](#wf-8-rejected--anderer-fulfiller) | `rejected` → anderer Fulfiller | Entwurf | TBD (mit WF-9) |
| [WF-9](#wf-9-failed--erneute-zuweisung) | `failed` → erneute Zuweisung | Entwurf | TBD (mit WF-8) |
| [WF-10](#wf-10-termin--terminänderung--no-show) | Termin / Terminänderung / No-show | Entwurf | TBD |
| [WF-11](#wf-11-bedeutung-von-taskowner) | Bedeutung von `Task.owner` | Entwurf | – |
| [WF-12](#wf-12-task-identifier--korrelation) | Task-Identifier / Korrelation | Entwurf | TODO |
| [WF-13](#wf-13-storno--cancellation-durch-den-placer) | Storno / Cancellation durch den Placer | Entwurf | deferred |
| [WF-14](#wf-14-sla--keine-reaktion-timeouts) | SLA / keine Reaktion (Timeouts) | offen |  |
| [WF-15](#wf-15-prozessgrafik-fälle-ah-vollständig-abbildbar) | Prozessgrafik-Fälle A–H vollständig abbildbar? | offen |  |
| [TK-1](#tk-1-concurrent-updates--etag--if-match) | Concurrent Updates / ETag / If-Match | offen |  |
| [TK-2](#tk-2-subscription-vs-polling) | Subscription vs. Polling | Entwurf | [#92](https://github.com/umzhconnect/umzhconnect-ig/issues/92), [#99](https://github.com/umzhconnect/umzhconnect-ig/issues/99) |
| [TK-3](#tk-3-lost-notifications--reconciliation) | Lost Notifications / Reconciliation | Entwurf | [#99](https://github.com/umzhconnect/umzhconnect-ig/issues/99) |
| [TK-4](#tk-4-technischer-fehler-vs-fachliches-failed) | Technischer Fehler vs. fachliches `failed` | offen |  |
| [GEN-1](#gen-1-naming-warum-umzh-connect) | Naming: warum «UMZH Connect»? | Entwurf | – |
| [GEN-2](#gen-2-owner-sichtbarkeitsregel-fulfiller-verliert-zugriff-auf-eigenen-task) | `owner`-Sichtbarkeitsregel: Fulfiller verliert Zugriff auf eigenen Task | Entwurf | [#87](https://github.com/umzhconnect/umzhconnect-ig/pull/87) |
| [GEN-3](#gen-3-businessstatus-binding-über-ein-example-codesystem) | `businessStatus`-Binding über ein Example-CodeSystem | Entwurf | TBD |

---

## Onboarding

### ON-1: Initiales Onboarding eines LE Placers

**Frage:** Wie läuft das initiale Onboarding eines neuen LE Placers? Was muss beim Fulfiller für einen ersten Task freigegeben sein? (Anmerkung: In der Prozessgrafik ist der Patient/Kunde nur minimal abgebildet.)

**Kenntnisstand:** Ableitbare Onboarding-Reihenfolge:

| # | Schritt | Wo |
|---|---------|----|
| 0 | Geschäftsvereinbarung, GLN vorhanden | bilateral |
| 1 | `Organization` anlegen → kanonische URL entsteht | Registry |
| 2 | `Endpoint` (FHIR-Base-URL) + `Organization.endpoint` | Registry |
| 3 | `HealthcareService` je Leistungsart – nur Fulfiller-Rolle | Registry |
| 4 | `client_id` + JWKS registrieren, an Org-Record aus (1) binden, Scopes + RAR freigeben | AS |
| 5 | AS-Issuer + Signaturschlüssel eintragen | jede Gegenpartei |
| 6 | Placer für `POST /Task` zulassen | Fulfiller |
| 7 | Consent-/Policy-Pfad und Read-API produktiv | neuer Placer selbst |
| 8 | Smoke-Test | |

Schritte 1→4 sind hart sequenziell (die Org-URL ist Vorbedingung der AS-Bindung). 5–6 sind pro Gegenpartei zu wiederholen, also O(n) bilaterale Vorgänge — genau das, was eine Registry eigentlich vermeiden soll.

**Antwort (Entwurf):** Onboarding is a centrally run, staged process — not O(n) bilateral. Source: `umzhconnect-governance/governance-blueprint.md` §8 "Onboarding Pipeline", owned by the *Onboarding & Conformance WG*, executed by the *Technical Office*: apply → participation agreement → sandbox → conformance suite → security & data-protection review → **Technical Office creates `Organization`/`Endpoint`/`HealthcareService` and provisions the auth client in the shared Keycloak realm** → go-live → ongoing conformance.

This addresses the Kenntnisstand concerns: registry records and auth clients are provisioned centrally against the shared realm, so there is no pairwise exchange of AS issuers / signing keys — trust anchors on the shared conformance suite plus the shared realm. A Fulfiller opens `POST /Task` to authenticated realm clients (CapabilityStatement) and runs its consent/policy path and read API in production; onboarding a further Placer adds no new per-pair configuration. Patient-scoped access is not an onboarding concern — it is governed per workflow via consent / `fhirContext` (see [SEC-3](#sec-3-zugriffslifecycle-auf-den-klinischen-graphen)).

**IG-Auswirkung:** Onboarding is governance material, not IG-normative — a short pointer to `governance-blueprint.md` §8 plus the technical preconditions (`POST /Task`, client registration, consent path) is enough.

---

## Security

### SEC-1: Security-Sicht: Anbindung erster externer Partner

**Frage:** Wie stellt ihr euch die Anbindung eines ersten externen Partners aus Security-Sicht vor? Intern wurde dazu bereits etwas umgesetzt.

**Kenntnisstand:** _(im Q&A-Dokument nicht ausgefüllt)_

**Antwort (Entwurf):** From a security standpoint the first connection follows the onboarding process (see [ON-1](#on-1-initiales-onboarding-eines-le-placers)), with the security core in stage 5 (review against the reference architecture + DSFA/consent blueprints, Security WG risk sign-off). Target state per `umzhconnect-governance/reference-architecture.md` §4–7 (a **non-normative** single-hospital reference deployment) and `data-security.md`:
- **AuthN/AuthZ:** OAuth 2.0 / OIDC with SMART system scopes, FAPI 2.0, `private_key_jwt` for production clients; one shared UMZH-operated Keycloak realm issues OIDC and M2M tokens (no hospital-run auth server).
- **Transport:** mTLS mandatory partner-to-partner; partner certificates registered in the mCSD `Endpoint` resource (`tls-client-certificate` extension). Browser→WAF uses plain TLS.
- **Enforcement chain:** WAF (mTLS, OWASP CRS, rate limiting) → external gateway (JWT + role check) → OPA (consent check: requester = consent performer + required resource authorisation) → FHIR server (read-only on the cross-party path).
- **Consent:** the referring provider grants the technical release via a FHIR `Consent`; authorisation is workflow-specific, not blanket.

**IG-Auswirkung:** aligns with `security.md` / `security-implementation.md`; add a cross-reference to `reference-architecture.md`. mTLS vs. DPoP fine-tuning: see [SEC-5](#sec-5-mtls-oder-dpop).

---

### SEC-2: Authentifikation eines Placers: einmalig oder pro Task

**Frage:** Werden Placer einmalig authorisiert und müssen sich beim Erstellen eines Task nicht neu authorisieren? Oder passiert das bei jedem Task neu und gilt nur für den einen Task?

**Kenntnisstand:** Einmalig beim Onboarding.

**Antwort (Entwurf):** Once at onboarding — confirmed. The client (`client_id` + JWKS) is registered once in the shared Keycloak realm at onboarding stage 6 and bound to the `Organization` record; scopes/RAR are granted there. Per Task the Placer does not re-authenticate — it obtains a short-lived M2M access token (FAPI 2.0, `private_key_jwt`) and calls `POST /Task` with it. The grant applies to the role/organisation, not to a single Task — this is inherent to the OAuth2 client-credentials model; the workflow-/patient-scoped restriction is applied afterwards via consent / `fhirContext` (see [SEC-3](#sec-3-zugriffslifecycle-auf-den-klinischen-graphen)), not via client authentication. (The reference deployment sets access-token lifetime ~5 min.)

**IG-Auswirkung:** in `security.md` / `security-implementation.md` state explicitly: client registration is one-time, each request uses a short-lived M2M token, no per-Task authorisation.

---

### SEC-3: Zugriffslifecycle auf den klinischen Graphen

**Frage:** Wann erhält und verliert eine Gegenpartei Zugriff auf den klinischen Graphen – insbesondere bei `rejected`, `failed`, `completed` oder künftig `cancelled`?

**Kenntnisstand:** Das UMZH-Modell bindet Zugriff an Workflow-Kontext, Gegenpartei und referenzierte Datengraphen. Ein lokaler FHIR `Consent` kann zusätzlich als Policy-Datensatz dienen, ist aber nicht zwingend die normative Grundlage. **Offen:** exakter Zugriffslifecycle und Retention nach Abschluss / Fehler / Ablehnung.

**Antwort (Entwurf):** Partly answered — and part of it is deliberately left to the parties.

*Defined centrally (ecosystem):* access is workflow-specific and enforced by OPA on the cross-party path. A counterparty can reach the clinical graph while (a) it is named as performer / consent performer in the workflow context and (b) the target resource is reachable from the workflow root (`ServiceRequest` at the Placer, `Task` at the Fulfiller) via `fhirContext`. If either condition drops — e.g. the workflow context is closed or the `Consent` no longer lists the performer — cross-party read access ends at that point. Basis: `data-security.md`, `reference-architecture.md` §4.4; in the IG `guidance-interactions.md` (`fhirContext` graph check) and `security.html#context-centric-authorization`.

*Party's own decision (each participant is controller of its own clinical data):* the exact trigger for closing the context / narrowing the `Consent` on a terminal Task state (`rejected` / `failed` / `completed` / future `cancelled`), and retention/purge of data a counterparty already pulled, are set by each party in its own DSFA/BRA. The ecosystem gates live access; it cannot reach into a counterparty's retained copies.

*Genuine open gap:* whether the ecosystem should impose a *minimum* normative rule — e.g. "context SHALL be closed within X of a terminal Task state" — so the lifecycle is predictable across parties. Candidate Change Request to the Security & Data-Protection WG.

**IG-Auswirkung:** `security.md` — state which part of the access lifecycle is ecosystem-enforced vs. controller-defined; a minimum "close context on terminal state" rule is a CR, not a given. Retention stays in `datenschutz/` (BRA/DSFA). Couples to [SEC-4](#sec-4-dynamischer-resource-graph-supportinginfo).

---

### SEC-4: Dynamischer Resource-Graph (`supportingInfo`)

**Frage:** Wenn der Placer während des laufenden Auftrags neue `supportingInfo` hinzufügt oder entfernt: ändert sich der Fulfiller-Zugriff automatisch?

**Kenntnisstand:** Logisch würde eine graphbasierte Policy den aktuell erreichbaren Graphen auswerten; eine neue Referenz könnte auch neue Berechtigung bedeuten. **Aber:** dieses konkrete Lifecycle-Verhalten sollte mit den Spezialisten bestätigt werden; es ist eine sicherheitsrelevante Detailfrage.

**Antwort (Entwurf):** Yes — access follows the current graph. The policy engine evaluates graph membership **per request** (`guidance-reference-architecture.md` "Policy Engine"): it walks the context root (`ServiceRequest` / `Task` named in the token's `fhirContext`) and its references at decision time. When the Placer adds a `supportingInfo` reference, that resource becomes reachable and the Fulfiller can read it on the next request; when the Placer removes it, it falls out of the graph and is denied. No token re-issue or re-consent is needed — the same context token resolves against the updated graph. (Caveat: this is the forward-graph rule as written, plus the one listed back-reference exception from PR [#87](https://github.com/umzhconnect/umzhconnect-ig/pull/87); worth a sandbox test to pin the exact behaviour.)

**IG-Auswirkung:** none — per-request graph evaluation is already how the policy engine is described.

---

### SEC-5: mTLS oder DPoP

**Frage:** Beide sind im IG als höchste Stufe für Client Authentication (Level 3) vorgesehen — mTLS (RFC 8705) und DPoP (RFC 9449). Welches Verfahren wird bevorzugt / als besser erachtet? Was setzt ihr UMZH-intern ein?

**Kenntnisstand:**
- **mTLS (RFC 8705):** Client präsentiert ein X.509-Zertifikat auf TLS-Layer; der Authorization Server (und optional der Resource Server) validiert es und injiziert den Client-Kontext von der Transport- in die Applikationsschicht. Tokens sind sender-constrained an das Client-Zertifikat.
- **DPoP (RFC 9449):** Client beweist Schlüsselbesitz pro Request über einen signierten `DPoP`-HTTP-Header und bindet das Token an diesen Schlüssel, ohne TLS-Client-Zertifikate zu erfordern.

**Antwort (Entwurf):** The IG deliberately offers **both** at Level 3 and mandates neither (`security-implementation.md`, "Level 3 — Sender-constrained tokens (mTLS or DPoP)"). They are equivalent sender-constraining mechanisms; the choice is deployment-driven — mTLS where a central PKI / trust anchor already exists (cf. the Denmark model), DPoP where maintaining an X.509 trust store is impractical. **No Level-3 mandate today:** the baseline is Level 2 `private_key_jwt`, which is what the sandbox exercises; Level 3 is a governance-triggered up-level for the highest-risk scopes (`security-implementation.md`, "Governance triggers for up-leveling"). So "what UMZH uses internally" is not a Level-3 choice yet.

**IG-Auswirkung:** none — `security-implementation.md` already presents both without preference. Any future preference goes in the "Governance triggers" section.

---

## Workflow

### WF-1: Technisch zugestellt vs. fachlich angenommen

**Frage:** Wie unterscheiden wir technisch zugestellt, empfangen/gesehen und fachlich angenommen? Wann ist `accepted` zwingend bzw. sinnvoll und wann darf `requested` → `in-progress` direkt erfolgen?

**Kenntnisstand:** UMZH lässt den COW-State `received` bewusst weg. Nach Erstellung steht der Task auf `requested`; die fachliche Annahme erfolgt über `accepted` bzw. danach `in-progress`. Ein separater UMZH-Task-State für «zugestellt» existiert nicht. `accepted` bedeutet explizite Übernahme, `in-progress` gestartete Bearbeitung. **Offen:** SLA und gewünschte Interpretation von HTTP-Erfolg / Task-Erstellung als Zustellnachweis; ob UMZH für bestimmte Prozesse eine explizite Acceptance verlangt oder ob sie übersprungen werden darf.

**Antwort (Entwurf):** The current IG already resolves this.
- *Technically delivered* = the `201 Created` response to `POST /Task` (standard FHIR `create`). The resulting workflow state is `Task.status = requested`. No application-level delivery ack beyond the 201, and none is needed.
- *Received / seen* is **not** a distinct state — COW's `received` is intentionally omitted (`workflow-states.md`). "Seen / triaged" only becomes visible once the Fulfiller sets `accepted` or `in-progress`.
- *Business acceptance* = an explicit state the Fulfiller sets: `accepted` (explicit take-over) or straight to `in-progress` (work started).
- `accepted` is **optional** — the transition table says "may be skipped in pre-agreed flows"; `requested → in-progress` directly is conformant. Use `accepted` when the Placer needs an explicit take-over signal before work starts (request-with-acceptance pattern).

*Adjacent open points (not about the 201 itself):* how long a Task may dwell in `requested` before the Fulfiller must act (→ [WF-14](#wf-14-sla--keine-reaktion-timeouts)); what a Placer does when it does **not** receive the 201, given `conditionalCreate = false` (→ [TK-4](#tk-4-technischer-fehler-vs-fachliches-failed)).

**IG-Auswirkung:** none — `workflow-states.md` already covers it.

---

### WF-2: Synchronisation `ServiceRequest.status` mit Task

**Frage:** Wie und wann soll `ServiceRequest.status` mit dem Lifecycle des Coordination Task synchronisiert werden? Wenn der Task `completed`, `rejected` oder `failed` wird: wer setzt wann `ServiceRequest.status`, und auf welchen Wert?

**Kenntnisstand:** _(im Q&A-Dokument nicht ausgefüllt)_

**Antwort (Entwurf):** Partly answered by COW. The COW [Workflow State Overview](https://hl7.org/fhir/uv/cow/2025May/workflow-state-overview.html) has a "Request resource representation" column: across the whole happy-path Task lifecycle (request placed → performer selected → accepted → in-progress → partial/preliminary) the request stays **`ServiceRequest.status = active`, `intent = order`**, and becomes **`completed`** only at *Complete* (Task `completed`). COW states this is "independent of the chosen FHIR exchange mechanism" and does not narrate who writes it or exactly when.

Applied to UMZH:
- The `ServiceRequest` stays at the Placer and is written only by the Placer (the Fulfiller has read-only ServiceRequest access). So the **Placer** sets `ServiceRequest.status`, driven by the Task state it observes (poll / `_lastUpdated`).
- Happy path: `active` from `requested` through `in-progress` / `awaiting-information`; → `completed` when the Task is `completed`.
- **Unhappy paths — not covered by COW:** FHIR RequestStatus has no "failed". On Task `rejected` / `failed` the Placer chooses `revoked` (abandoning the order) or keeps `active` (re-routing to another Fulfiller — see [WF-8](#wf-8-rejected--anderer-fulfiller)). Placer cancellation → `revoked` (see [WF-13](#wf-13-storno--cancellation-durch-den-placer)); mistaken order → `entered-in-error`.

**IG-Auswirkung:** small. Adopt COW's happy-path mapping by reference in `workflow-states.md`, add the unhappy-path rows (`rejected` / `failed` / `cancelled` → `revoked` vs. `active`), and state that the Placer is the sole writer and syncs from observed Task state.

---

### WF-3: Source of Truth bei Änderungen am laufenden ServiceRequest

**Frage:** Was passiert, wenn der Placer einen bereits laufenden `ServiceRequest` verändert (z. B. Dringlichkeit, Fragestellung, ergänzte Dokumente)?

**Kenntnisstand:** Der `ServiceRequest` bleibt beim Placer und `Task.focus`/`basedOn` verweist absolut darauf. Damit sieht der Fulfiller grundsätzlich den dort aktuellen Graphen. **Offen:** wie Änderungen signalisiert, versioniert und fachlich akzeptiert werden sollen, und wann stattdessen ein neuer Request notwendig ist.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(Guidance zu Change-Signalisierung, ggf. Bezug zu WF-4)_

---

### WF-4: Rückfragen: Questionnaire → QuestionnaireResponse normativ?

**Frage:** Ist `Questionnaire` → `QuestionnaireResponse` für Rückfragen normativ vorgeschrieben, oder nur das UMZH-Beispiel? Sind andere Mechanismen denkbar (z. B. spezifische Ressourcen oder Profile)?

**Kenntnisstand:** Kurz: ja. UMZH zeigt einen sehr konkreten Flow: Der Fulfiller setzt `awaiting-information`, `owner` → Placer, `Questionnaire` in `Task.output`; der Placer erstellt die `QuestionnaireResponse`, referenziert sie in `Task.input`, entfernt `businessStatus` und gibt `owner` zurück. **Zu klären:** wie verbindlich genau dieser Mechanismus für Interoperabilität ist.

**Antwort (Entwurf):** Normative, not just an example. The round-trip is fixed by the State Transition Table (`workflow-states.md`) and the interaction rules (`guidance-interactions.md`); PR [#87](https://github.com/umzhconnect/umzhconnect-ig/pull/87) adds a dedicated `ChUmzhConnectQuestionnaireResponse` profile (`basedOn` 1..1 → workflow-root `ServiceRequest`). Steps: Fulfiller sets `businessStatus = awaiting-information`, puts the `Questionnaire` canonical in `Task.output`, `owner` → Placer; Placer creates the `QuestionnaireResponse` on its own server, links it from `Task.input` by absolute URL, clears `businessStatus`, `owner` → Fulfiller.

No alternative mechanism is defined — `Questionnaire` / `QuestionnaireResponse` is the only structured back-query channel in this version. `Communication`, free text, or extra `Task.input` slots are not profiled for it; a different mechanism would be a Change Request. Whether a Placer *system* must render arbitrary `Questionnaire` items (vs. an agreed set) is not constrained — to confirm.

**Open — is the Placer obliged to answer?** The IG defines the state (`awaiting-information`, `owner` = Placer) and the response path, but no obligation, SLA, or no-answer path. A Task can sit in `awaiting-information` indefinitely (same gap as [WF-14](#wf-14-sla--keine-reaktion-timeouts)). To settle with the workflow specialists: may the Placer decline, and how is that signalled (a `cancelled`/`rejected`-like signal, or silence)? May the Fulfiller `completed` / `failed` the Task without the answer after some time? → left open; couples to WF-14 and [WF-9](#wf-9-failed--erneute-zuweisung).

**IG-Auswirkung:** `workflow-states.md` / `guidance-interactions.md` — state that the `Questionnaire` round-trip is the sole back-query mechanism; the Placer-obligation / timeout path is unresolved (→ WF-14).

---

### WF-5: Rückfragen vom Placer nach Abschluss

**Frage:** Rückfragen zum Austrittsbericht: Kann es nach Abschluss noch weiterführende Kommunikation geben (z. B. Rückfragen des Placers zur Medikation)? Oder muss dafür ein neuer Task erstellt werden? (Gemäss RequestStatus: `ServiceRequest.status == completed` → «No further activity will occur.»)

**Kenntnisstand:** _(im Q&A-Dokument nicht ausgefüllt)_

**Antwort (Entwurf):** `completed` is terminal — the state machine ends there (`completed --> [*]`), matching RequestStatus "no further activity will occur". A further clinical question after the discharge report (e.g. medication) is therefore **a new workflow**: a new `ServiceRequest` + `Task`, optionally `basedOn` / `replaces` the original for traceability. There is no re-open of a completed Task and no post-completion message channel in the current IG. A lightweight follow-up mechanism short of a full new referral would be a CR.

**IG-Auswirkung:** none — `completed` is already terminal in the IG.

---

### WF-6: Warum Task-at-Fulfiller?

**Frage:** Warum hat UMZH Connect bewusst Task-at-Fulfiller gewählt? Welche Vorteile gegenüber Task-at-Placer, Messaging oder einem zentralen Broker waren ausschlaggebend?

**Kenntnisstand:** Der `ServiceRequest` bleibt beim Placer, der Coordination Task liegt beim Fulfiller. Dadurch besitzt der Fulfiller den Bearbeitungszustand, während die klinischen Quelldaten beim Placer bleiben. COW kennt auch andere Patterns. **Offen:** welche konkreten Architekturgründe UMZH für diese Auswahl hatte und wie dauerhaft die Entscheidung ist.

**Antwort (Entwurf):** The rationale is present in the IG, spread across pages rather than as one "why" section: clinical data and the `ServiceRequest` stay with their controller at the Placer (data minimisation — "the principle of not posting sensitive data"), and the Fulfiller hosts only a **minimal `Task`** that establishes the workflow and the authorization context (`core-concept-workflow-api.md`, `security.md` context-centric authorization, `guidance-reference-architecture.md`). Task-at-Fulfiller lets the party doing the work own the processing state while the party owning the data keeps it. A written trade-off against Task-at-Placer / messaging / central broker is not in the IG. Position: **one model is chosen for the first phase**; it is the current normative contract and may be revisited later (see [WF-7](#wf-7-zentraler-orchestrator-vs-task-at-fulfiller)).

**IG-Auswirkung:** none — the design principles are already stated; a consolidated "why" note is optional.

---

### WF-7: Zentraler Orchestrator vs. Task-at-Fulfiller

**Frage:** Wann sollte statt dezentralen Fulfiller-Tasks ein zentraler Coordination-/Queue-Server eingesetzt werden? Ist der zentrale Coordinator wie in COW definiert («Coordinator Mediated Exchange») auch in UMZH Connect vorgesehen oder möglich?

**Kenntnisstand:** Beides ist FHIR-nah denkbar. Zentral erleichtert Multi-Fulfiller, Routing und Monitoring, entfernt sich aber stärker vom heutigen UMZH-Task-at-Fulfiller-Vertrag und schafft zusätzliche Security-/Governance-Verantwortung. Für eine Evolution aus UMZH heraus erscheint der dezentrale Task mit überlagerter Orchestrierung naheliegender.

**Antwort (Entwurf):** Decentralized Task-at-Fulfiller is the current normative contract; `guidance-reference-architecture.md` is explicitly informative and describes one architecture (the sandbox). A central coordinator ("Coordinator Mediated Exchange") is **not part of the IG today** and **not precluded** — it is a plausible later expansion, e.g. at national level as part of the handover (`governance-blueprint.md` §13), layered over the same Task contract rather than replacing it. It becomes attractive for multi-Fulfiller routing and central queueing / monitoring, at the cost of extra security / governance responsibility.

**IG-Auswirkung:** none — Task-at-Fulfiller is the phase-1 contract; a central coordinator is out of scope for now.

---

### WF-8: `rejected` → anderer Fulfiller

**Frage:** Was soll der Placer nach `rejected` tun? Darf derselbe `ServiceRequest` mit einem neuen Task bei Fulfiller B weiterverwendet werden? Wie werden die Versuche korreliert?

**Kenntnisstand:** `rejected` bedeutet Ablehnung vor Arbeitsbeginn. COW sieht grundsätzlich alternative Fulfiller vor. UMZH beschreibt aber derzeit keinen vollständigen Multi-Fulfiller-/Re-Routing-Flow. **Das ist eine wichtige offene Produkt- und Governancefrage.**

**Antwort (Entwurf):** Partly answered by the IG. `rejected` = declined before work; the transition table already states **"Placer may approach another Fulfiller"**. The `ServiceRequest` stays at the Placer and can back a **new `Task`** POSTed to Fulfiller B (fresh Task with its own id; `basedOn` / `focus` → the same ServiceRequest). Not defined: how attempts are correlated (e.g. the rejected Task referenced from the new one) and whether Fulfiller B is told this is a re-approach. Full multi-Fulfiller routing / correlation stays an open product/governance question (couples to [WF-9](#wf-9-failed--erneute-zuweisung), [WF-14](#wf-14-sla--keine-reaktion-timeouts)).

**IG-Auswirkung:** none for the basic path (already covered); an attempt-correlation convention would be new guidance if wanted.

---

### WF-9: `failed` → erneute Zuweisung

**Frage:** Wenn ein Auftrag nach Annahme auf `failed` geht: Darf der Placer denselben Auftrag bei einem anderen Fulfiller erneut platzieren?

**Kenntnisstand:** `failed` bedeutet Scheitern nach Annahme, im Gegensatz zu `rejected` vor Arbeitsbeginn. Was danach mit dem ursprünglichen `ServiceRequest` und einer möglichen Neuzuweisung geschieht, ist im heutigen UMZH-Vertrag nicht vollständig orchestriert.

**Antwort (Entwurf):** Both `rejected` and `failed` are **terminal** (`workflow-states.md`), differing only in timing: `rejected` before accepting (cannot / will not deliver), `failed` after accepting but unable to complete (e.g. patient no longer wants to attend). Neither reopens.

What happens next is **at the Placer's discretion** and identical in both cases — the IG prescribes no flow. The `ServiceRequest` stays with the Placer, so it may: re-route (new `Task` on the same `ServiceRequest` to another Fulfiller, `status` stays `active` — see [WF-8](#wf-8-rejected--anderer-fulfiller)); abandon (`ServiceRequest.status = revoked` — see [WF-2](#wf-2-synchronisation-servicerequeststatus-mit-task)); or handle it out of band. Attempt correlation is undefined (shared with WF-8; COW has no post-acceptance reassignment pattern).

**IG-Auswirkung:** none. Minor: the transition table's "Placer may approach another Fulfiller" note sits only on `rejected` — it applies equally to `failed`.

---

### WF-10: Termin / Terminänderung / No-show

**Frage:** Sind Termin, Terminverschiebung und No-show Task-Zustände oder Änderungen an `Appointment`?

**Kenntnisstand:** UMZH zeigt `Appointment` als Output des Tasks. Ein eigener UMZH-Task-State wie «Termin geplant» existiert nicht; interne Systeme dürfen solche Zustände führen, aber nicht als nicht vorgesehene UMZH-Task-Stati schreiben. **Offen:** wie Terminänderung und No-show konkret interoperabel signalisiert werden sollen.

**Antwort (Entwurf):** Not modelled as Task states. `Appointment` is a `Task.output` (`workflow-states.md`, usecase); the transition table has no scheduling / reschedule / no-show states, and internal systems must not write non-defined values to `Task.status` / `businessStatus`.
- *Scheduling a slot:* Fulfiller adds / updates the `Appointment` in `Task.output`; `Task.status` stays `in-progress`.
- *Reschedule:* update the same `Appointment` (`Appointment.status`, timing); versioned-update applies.
- *No-show:* `Appointment.status = noshow`; the Task continues — the Fulfiller decides whether to re-book, or eventually `completed` / `failed`.

*Open remainder:* whether reschedule / no-show need an explicit interoperable signal on the Task (a `businessStatus` code, a notification trigger) rather than only living on the `Appointment` — candidate CR.

**IG-Auswirkung:** `workflow-states.md` — short note that appointment lifecycle lives on `Appointment` in `Task.output`, not on `Task.status`. New `businessStatus` codes only if the CR above is accepted.

---

### WF-11: Bedeutung von `Task.owner`

**Frage:** Bedeutet `Task.owner` «wer muss als Nächstes handeln», «wer darf schreiben» oder «wer führt die Leistung aus»? (Vgl. auch [GEN-2](#gen-2-owner-sichtbarkeitsregel-fulfiller-verliert-zugriff-auf-eigenen-task).)

**Kenntnisstand:** In UMZH erfüllt `owner` mindestens zwei Funktionen: Verantwortlichkeit und Schreibrecht. Bei `awaiting-information` wird der Placer Owner, obwohl der Fulfiller weiterhin Leistungserbringer ist. Damit ist `owner` nicht einfach mit «Fulfiller der medizinischen Leistung» gleichzusetzen. **Semantik sollte explizit bestätigt werden.**

**Antwort (Entwurf):** `Task.owner` = the organisation that must **act next** — the "ball holder". The transition table shows it moving Fulfiller-org → Placer-org (`in-progress → awaiting-information`) → Fulfiller-org (`awaiting-information → in-progress`), tracking who owes the next step. Of the three readings in the Frage: **"who must act next" is correct**; it is *not* "who performs the medical service" (the Fulfiller performs throughout, including while `owner` = Placer), and *not* the write-permission control — writes are constrained separately (patch limited to `Task.input` / `owner` / `focus` / `businessStatus`; `requester` / `owner` gate cross-org read).

*Confirmed:* the owner switch to the Placer in `awaiting-information` is intentional and stays (see [GEN-2](#gen-2-owner-sichtbarkeitsregel-fulfiller-verliert-zugriff-auf-eigenen-task)).

**IG-Auswirkung:** none — the transition table already conveys "who acts next", and this matches FHIR's own `Task.owner` definition.

---

### WF-12: Task-Identifier / Korrelation

**Frage:** Welche Identifier müssen Systeme dauerhaft speichern, damit Request, Task, Notifications, Re-Routing und Outputs sicher korreliert werden können?

**Kenntnisstand:** Der Task besitzt einen eigenen `identifier`; `focus` und `basedOn` zeigen auf den `ServiceRequest`. Das Placer-System muss zusätzlich die beim Fulfiller entstandene Task-ID/URL dauerhaft kennen. **Offen:** welche Identifier über Organisationsgrenzen hinweg als verbindliche Business-Korrelation gelten sollen.

**Antwort (Entwurf):** The premise (a "binding business identifier" across orgs) is not needed — correlation is a search, not an identifier problem. The anchor already exists: the **ServiceRequest's absolute URL**, carried by every Task in `basedOn` and `focus` (`task.fsh`: `focus only Reference(ChUmzhConnectServiceRequest)`). Since the Placer is always `Task.requester`, Task search scoping does not get in the way — `GET {fulfiller}/Task?based-on={sr-absolute-url}` returns exactly the Placer's Task(s) for that ServiceRequest (all attempts, if re-routed per [WF-8](#wf-8-rejected--anderer-fulfiller); distinguish by `status` / `authoredOn`). The Task URL from the `201 Location` is a convenient handle for direct read/patch but can always be re-derived by search, so it need not be stored as a durable key; `Task.identifier` stays optional.

**IG-Auswirkung:** real, small gap. The CapabilityStatement declares Task search params `_id` / `owner` / `requester` / `status` only — **no `based-on` / `focus`**, so `Task?based-on=` is not conformant today. Fix = add `based-on` (and/or `focus`) to the Task search params + the `guidance-interactions.md` table. **TODO: open issue.**

---

### WF-13: Storno / Cancellation durch den Placer

**Frage:** Warum ist Storno durch den Placer nicht vorgesehen? Ist später das COW-Cancellation-Pattern geplant?

**Kenntnisstand:** Aktuell ausdrücklich **nicht vorgesehen** — eine bekannte Lücke für produktive Referral-Prozesse. COW besitzt weiterführende Cancellation-/Abort-Patterns; deren Übernahme in UMZH ist nicht festgelegt.
**Vorschlag aus Q&A:** `CancellationRequestTask` aus dem Basis-IG übernehmen und `cancelled` als Placer-Transition aus `requested`/`accepted` in die State-Tabelle aufnehmen; den Schreibpfad dafür deklarieren. Falls die Auslassung beabsichtigt bleibt: Grund nennen (wie bei «not selected» bereits vorbildlich getan) und den bilateralen Behelf beschreiben.

**Antwort (Entwurf):** Confirmed — **not in the current IG**. The state transition table has no `cancelled` state; `rejected` covers only Fulfiller-side decline before work. There is no conformant in-band way for a Placer to withdraw a `requested` / `accepted` / `in-progress` Task, so a cancellation today must be handled **out of band (manual process / bilateral contact)**. The `CancellationRequestTask` + `cancelled` transition (Kenntnisstand) is the proposed fix.

**IG-Auswirkung:** known gap, deferred. Neither current use case (orthopedic referral, sarcoma tumorboard) has a cancel step, so no `cancelled` path is defined yet. Solve when the first use case that needs it arrives (e.g. a lab order / Laborauftrag) — then add `cancelled` (+ `CancellationRequestTask` write path). Until then: `workflow-states.md` states the omission is deliberate and points to the out-of-band fallback.

---

### WF-14: SLA / keine Reaktion (Timeouts)

**Frage:** Was passiert, wenn ein Task tagelang auf `requested` bleibt oder eine Rückfrage auf `awaiting-information` hängen bleibt? Gibt es normative Timeouts?

**Kenntnisstand:** Nein, aktuell **kein normatives Timeout/SLA** für `requested` oder `awaiting-information`. Reminder, Eskalation oder alternative Stelle müssten derzeit bilateral bzw. durch eine Orchestrierungsschicht geregelt werden.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(offen — ob SLA normativ oder ausserhalb IG)_

---

### WF-15: Prozessgrafik-Fälle A–H vollständig abbildbar?

**Frage:** Können die Fälle Ablehnung, Rückfrage, Terminänderung, Storno, No-show, Teilergebnis, technischer Fehler und Abbruch konkret auf UMZH/COW abgebildet werden? Je Fall: Resource, Operation, `Task.status`, `businessStatus`, `owner`, Notification?

**Kenntnisstand:** Teilweise. Happy Path, Rückfrage, `rejected`, `failed` und Completion sind abbildbar. Storno durch den Placer ist in UMZH 1.0 nicht vorgesehen; für No-show, Terminänderung, Teilergebnisse und technische Fehler gibt es nicht zwingend eigene Task-Zustände. Diese Abgrenzung sollte bestätigt werden.

**Antwort:** _(zu formulieren — Sammeltabelle je Fall)_

**IG-Auswirkung:** _(bündelt WF-10, WF-13; ggf. Übersichtstabelle in `workflow-states.md`)_

---

## Techn. Kommunikation

### TK-1: Concurrent Updates / ETag / If-Match

**Frage:** Wie werden parallele Updates behandelt? Wird optimistisches Locking mit `ETag` / `If-Match` erwartet? Was soll bei `412 Precondition Failed` passieren?

**Kenntnisstand:** FHIR REST unterstützt genau dieses Standardmuster; für einen verteilten, mutierbaren Task ist Optimistic Locking sinnvoll, `ETag` / `If-Match` ist das empfohlene Verfahren. **Offen:** ob UMZH dies als verbindlichen Interoperabilitätsvertrag verlangt oder als Implementierungsdetail lässt.
**Vorschlag aus Q&A:** Fehlertabelle im IG mit `Bedingung → HTTP-Status → OperationOutcome.issue.code`.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(`guidance-interactions.md` — Concurrency + Fehlertabelle)_

---

### TK-2: Subscription vs. Polling

**Frage:** Wie soll der Placer zuverlässig Task-Änderungen erfahren: FHIR Subscription, Polling oder beides?

**Kenntnisstand:** COW beschreibt Subscriptions ausdrücklich als optional. Ohne Subscription kann der Placer den Task periodisch abfragen. Das UMZH-PDF zeigt ebenfalls «Task at Fulfiller with Optional Subscriptions». **Offen:** welche Variante für produktive UMZH-Integrationen empfohlen bzw. vorausgesetzt wird.

**Antwort (Entwurf):** Current IG: **polling is the baseline**; Subscription is **not yet** part of the IG. The CapabilityStatement declares no `Subscription` / `SubscriptionTopic`, and `core-concept-workflow-api.md` frames notification as an optional contract extension. The Placer polls `GET /Task?requester={placer}&status=...`; delta polling needs `_lastUpdated`, being added via issue [#99](https://github.com/umzhconnect/umzhconnect-ig/issues/99). Adding Subscription-based monitoring (rest-hook, topic filtered on `requester`, Placer-managed `Subscription` lifecycle) is proposed and open — issue [#92](https://github.com/umzhconnect/umzhconnect-ig/issues/92). Position to carry into those issues: polling stays the mandatory-to-support baseline regardless of #92; Subscription, once added, is an optimisation on top.

**IG-Auswirkung:** `guidance-interactions.md` + CapabilityStatement — state polling as the baseline and add `_lastUpdated` ([#99](https://github.com/umzhconnect/umzhconnect-ig/issues/99)); Subscription support pending [#92](https://github.com/umzhconnect/umzhconnect-ig/issues/92).

---

### TK-3: Lost Notifications / Reconciliation

**Frage:** Wenn eine Notification verloren geht, wie erfolgt die Wiederherstellung des korrekten Zustands?

**Kenntnisstand:** Robustes Modell: Notification ist ein Hinweis, der **Task bleibt Source of Truth**; Poll/Search/Reconciliation liest danach den tatsächlichen Zustand. Diese Kombination wäre insbesondere für eine Orchestrierungsplattform wichtig.

**Antwort (Entwurf):** Confirmed — the Kenntnisstand matches the IG design. Notification is an optional hint (`core-concept-workflow-api.md`); the `Task` is the source of truth. Recovery = re-poll / search the Task (and its `output`) against the Fulfiller; with `_lastUpdated` (issue [#99](https://github.com/umzhconnect/umzhconnect-ig/issues/99)) the Placer reconciles everything changed since its last successful poll, so a lost notification only delays, never corrupts, the Placer's view. Holds whether or not Subscription is later added (issue [#92](https://github.com/umzhconnect/umzhconnect-ig/issues/92)).

**IG-Auswirkung:** `guidance-interactions.md` — short reconciliation note (Task is source of truth; re-poll with `_lastUpdated`); depends on [#99](https://github.com/umzhconnect/umzhconnect-ig/issues/99).

---

### TK-4: Technischer Fehler vs. fachliches `failed`

**Frage:** Wie trennen wir Netzwerk-/Gateway-/Timeout-Fehler vom fachlichen `Task.status = failed`? Was gilt für Retries und Idempotenz?

**Kenntnisstand:** `failed` ist ein fachlicher Workflowzustand nach Annahme, kein HTTP-/Transportfehler. Technische Zustellung, Retry und Reconciliation müssen separat behandelt werden. **Offen:** welche Idempotenzregeln, Identifier-/Conditional-Create-Regeln und Retry-Strategien UMZH produktiv erwartet.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(`guidance-interactions.md` — Idempotenz/Retry; koppelt an TK-1)_

---

## Allgemeine Fragen und Probleme

### GEN-1: Naming: warum «UMZH Connect»?

**Frage:** Warum heisst es «UMZH Connect» und nicht generisch, damit es einfacher CH-weit skaliert?

**Kenntnisstand:** _(im Q&A-Dokument nicht ausgefüllt)_

**Antwort (Entwurf):** "UMZH Connect" is the name of the initiative and its current mandate/funding holder (UMZH = Universitäre Medizin Zürich). The governance is explicitly built for handover (`governance-blueprint.md` §13): the IG is being balloted through HL7 CH toward adoption as an HL7 CH IG — at which point HL7 CH becomes publisher — and the shared services transfer to a national operator. The name and conformance mark are governed by the Steering Committee (§12) and tied to certification status. Nothing in the governance docs blocks CH-wide scaling; the scaling path is the HL7 CH route.

**IG-Auswirkung:** optionally a one-line note in `index.md` that the IG is on the HL7 CH adoption path (ref. governance §13).

---

### GEN-2: `owner`-Sichtbarkeitsregel: Fulfiller verliert Zugriff auf eigenen Task

**Frage / Problem:** Im Zustand `awaiting-information` verliert der Fulfiller den Zugriff auf seinen eigenen Task.

**Kenntnisstand (Belegkette):**
- Sichtbarkeitsregel normativ, `guidance-interactions.md:34` (wörtlich): «`GET /Task` and `GET /Task?...` SHALL return only those Tasks for which the authenticated identity is either the requester (`Task.requester`) or the owner (`Task.owner`).»
- CapabilityStatement, `Task.read` (`UmzhConnectCapabilityStatement.fsh`, wörtlich): «Read a Task by logical id. Allowed if the calling identity is `Task.owner` or `Task.requester`.»
- `Task-ReferralOrthopedicSurgeryUpdated.fsh:7,12,13`, Zustand *Awaiting information*:
  ```
  * businessStatus = http://hl7.org/fhir/uv/cow/CodeSystem/temp#awaiting-information
  * requester = Reference(http://registry.example.org/fhir/Organization/Placer)
  * owner     = Reference(http://registry.example.org/fhir/Organization/Placer)
  ```
- `requester` ist per Definition immer der Placer; `owner` wechselt in diesem Zustand ebenfalls zum Placer. Der Fulfiller ist damit **weder `requester` noch `owner`** — obwohl er den Task hostet. Die Regel ist asymmetrisch: der Placer ist in jedem Zustand `requester` und sieht den Task immer; nur der Fulfiller kann den Zugriff verlieren.
- COW kennt keinen Wechsel des Performers zum Placer: In der Zeile *Potential Fulfiller Awaiting for Information* steht `Performer: [specified]` (`workflow-state-overview.md:17 @ f370703`).
- **Auswirkung:** Der Fulfiller kann seine eigene, gerade geschriebene Rückfrage nicht mehr lesen — kein «was habe ich offen»-Dashboard, keine Fristüberwachung, keine Eskalation bei ausbleibender Antwort. (Mit welchem Statuscode der Zugriff abgewiesen wird, ist nicht spezifiziert: `403` ist im IG nur für den `fhirContext`-Check belegt, und Task ist ausdrücklich **nicht** `fhirContext`-gated — siehe WF-14 / F14.)
- Dieselbe Kette trifft die `QuestionnaireResponse`: read ist «allowed if the linked Task is accessible» (`guidance-interactions.md:115`) — solange `owner = Placer`, ist der Task nicht zugänglich, also auch die auf dem eigenen Server liegende Antwort nicht (`QuestionnaireResponse-SmokingStatus.fsh`: «Hosted on fulfiller»).
- Query-Beispiel: `Task?owner=<self>&status=in-progress` — die naheliegendste Fulfiller-Arbeitsliste — blendet exakt die wartenden Fälle aus.

**Vorschlag aus Q&A:** Sichtbarkeitsregel um eine dauerhafte Fulfiller-Referenz erweitern («`requester`, `owner` oder ursprünglicher `owner`», ggf. als eigene Extension); oder den Ownership-Wechsel durch ein separates Zuständigkeitsfeld ersetzen und `owner` wie im Basis-IG stabil beim Fulfiller lassen; alternativ normativ klarstellen, dass die Regel nur für Cross-Org-Zugriffe gilt und der hostende Server seine eigenen Tasks stets lesen darf.

**Antwort (Entwurf):** Largely a scoping misunderstanding. The Task visibility rule is a **cross-organizational** access control — not a filter a Fulfiller's server applies when serving its own operator.

- `guidance-interactions.md` is scoped to the cross-organizational REST surface (see its Overview — `fhirContext` claim, SMART system scopes, cross-org polling). In the reference architecture the rule is enforced at the **external gateway + OPA** on inbound cross-party requests (`umzhconnect-governance/reference-architecture.md` §4.2, §4.4, §6.1); the Fulfiller's own clinical application reaches its FHIR server via the **internal gateway, no OPA check** (§4.3, §6.3). The Fulfiller always sees the Tasks it hosts — worklist, "what's open" dashboard and escalation timers are unaffected by `owner` moving to the Placer. `GET /Task?status=in-progress&businessStatus=awaiting-information` (no `owner` filter) returns the waiting cases on the internal path.
- The `owner` switch to the Placer in `awaiting-information` is **intentional and correct**: `owner` signals who must act next. It is not the cause and should stay (see [WF-11](#wf-11-bedeutung-von-taskowner)).
- The QuestionnaireResponse half of the original chain is separately resolved by PR [#87](https://github.com/umzhconnect/umzhconnect-ig/pull/87) (see [WF-4](#wf-4-rückfragen-questionnaire--questionnaireresponse-normativ)).

*IG clarification — needed?* Not for correctness; the page is already cross-org-scoped. Optional, to preempt the misread: **one clause, one place** — in `guidance-interactions.md` *Task search scoping*, qualify "the server enforces this implicit filter on every Task search" as *received over the cross-organizational API*, or add a one-sentence trailer that it does not constrain a server serving its own operator. CapabilityStatement wording can stay as-is.

**IG-Auswirkung:** at most a single-clause qualifier in `guidance-interactions.md` *Task search scoping*, optionally with a pointer to `reference-architecture.md` (internal vs. external gateway). No profile or CapabilityStatement change.

---

### GEN-3: `businessStatus`-Binding über ein Example-CodeSystem

**Frage / Problem:** Der einzige von UMZH Connect verwendete `businessStatus`-Code stammt aus einem als «example» deklarierten CodeSystem.

**Kenntnisstand:**
- Quelle: `CodeSystem` `COWTempCodeSystem`, Id `temp`, Title «Temp Clinical Order Workflow Example Codes», Description: «This code system contains codes for `Task.businessStatus` and `MessageHeader` event code. These are example codes, not intended to be used as is.»
- `awaiting-information` ist darin enthalten und Mitglied des gebundenen ValueSet `business-status` (`input/fsh/valuesets/business-status.fsh`, fünf Codes) — das Binding ist technisch gültig.
- Bindungsstärke unterscheidet sich:

  | IG | Binding | Stärke |
  |----|---------|--------|
  | COW (`CoordinationTask`) | `businessStatus` | `* businessStatus from BusinessStatus (example)` |
  | UMZH Connect (`ch-umzh-connect-coordinationtask`) | `http://hl7.org/fhir/uv/cow/ValueSet/business-status` | `extensible` |

- Die Beispiel-Instanz verwendet entsprechend `http://hl7.org/fhir/uv/cow/CodeSystem/temp#awaiting-information`.
- UMZH Connect verschärft `example` → `extensible` auf ein ValueSet, dessen CodeSystem sich selbst als «example codes, not intended to be used as is» bezeichnet und dessen Id `temp` lautet. `extensible` bedeutet: passende Codes daraus **müssen** verwendet werden. Damit hängt `awaiting-information` — der einzige Substatus der gesamten State-Machine und Angelpunkt des Rückfrage-Loops — an einem Provisorium des Basis-IG. Ändert COW diesen Canonical vor dem Release (was Name und Description nahelegen), bricht die State-Machine des derivierten IG.

**Vorschlag aus Q&A:** Bei HL7 OO klären, ob `…/CodeSystem/temp` ein stabiler Canonical ist. Falls nein: eigenes CH-CodeSystem für `awaiting-information` definieren (oder die Bindungsstärke bei `example` belassen) und die Abhängigkeit vom COW-Provisorium auflösen.

**Antwort (Entwurf):** In clarification with HL7.

**IG-Auswirkung:** `input/fsh/valuesets/business-status.fsh`, `ch-umzh-connect-coordinationtask` Profil, ggf. neues CH-CodeSystem.
