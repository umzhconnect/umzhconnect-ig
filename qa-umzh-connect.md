# Q&A zu UMZH Connect — Antwortentwurf

Arbeitsdokument zur Beantwortung der Fragen aus `q_a_UMZH Connect-v20.pdf` (v20, 2025-08-14).

- **Kenntnisstand**: übernommen aus dem Q&A-Dokument (Spalte «heutiger Kenntnisstand»), leicht gekürzt.
- **Antwort**: von uns zu formulieren.
- **IG-Auswirkung**: falls die Antwort eine Anpassung an IG-Seiten, Profilen oder Beispielen nach sich zieht.
- **Status**: `offen` → `Entwurf` → `beantwortet`.

## Übersicht

| ID | Thema | Status |
|------|-------|--------|
| [ON-1](#on-1-initiales-onboarding-eines-le-placers) | Initiales Onboarding eines LE Placers | offen |
| [SEC-1](#sec-1-security-sicht-anbindung-erster-externer-partner) | Security-Sicht: Anbindung erster externer Partner | offen |
| [SEC-2](#sec-2-authentifikation-eines-placers-einmalig-oder-pro-task) | Authentifikation eines Placers: einmalig oder pro Task | offen |
| [SEC-3](#sec-3-zugriffslifecycle-auf-den-klinischen-graphen) | Zugriffslifecycle auf den klinischen Graphen | offen |
| [SEC-4](#sec-4-dynamischer-resource-graph-supportinginfo) | Dynamischer Resource-Graph (`supportingInfo`) | offen |
| [SEC-5](#sec-5-mtls-oder-dpop) | mTLS oder DPoP | offen |
| [WF-1](#wf-1-technisch-zugestellt-vs-fachlich-angenommen) | Technisch zugestellt vs. fachlich angenommen | offen |
| [WF-2](#wf-2-synchronisation-servicerequeststatus-mit-task) | Synchronisation `ServiceRequest.status` mit Task | offen |
| [WF-3](#wf-3-source-of-truth-bei-nderungen-am-laufenden-servicerequest) | Source of Truth bei Änderungen am laufenden ServiceRequest | offen |
| [WF-4](#wf-4-rckfragen-questionnaire--questionnaireresponse-normativ) | Rückfragen: Questionnaire → QuestionnaireResponse normativ? | offen |
| [WF-5](#wf-5-rckfragen-vom-placer-nach-abschluss) | Rückfragen vom Placer nach Abschluss | offen |
| [WF-6](#wf-6-warum-task-at-fulfiller) | Warum Task-at-Fulfiller? | offen |
| [WF-7](#wf-7-zentraler-orchestrator-vs-task-at-fulfiller) | Zentraler Orchestrator vs. Task-at-Fulfiller | offen |
| [WF-8](#wf-8-rejected--anderer-fulfiller) | `rejected` → anderer Fulfiller | offen |
| [WF-9](#wf-9-failed--erneute-zuweisung) | `failed` → erneute Zuweisung | offen |
| [WF-10](#wf-10-termin-terminnderung-no-show) | Termin / Terminänderung / No-show | offen |
| [WF-11](#wf-11-bedeutung-von-taskowner) | Bedeutung von `Task.owner` | offen |
| [WF-12](#wf-12-task-identifier--korrelation) | Task-Identifier / Korrelation | offen |
| [WF-13](#wf-13-storno--cancellation-durch-den-placer) | Storno / Cancellation durch den Placer | offen |
| [WF-14](#wf-14-sla--keine-reaktion-timeouts) | SLA / keine Reaktion (Timeouts) | offen |
| [WF-15](#wf-15-prozessgrafik-flle-ah-vollstndig-abbildbar) | Prozessgrafik-Fälle A–H vollständig abbildbar? | offen |
| [TK-1](#tk-1-concurrent-updates--etag--ifmatch) | Concurrent Updates / ETag / If-Match | offen |
| [TK-2](#tk-2-subscription-vs-polling) | Subscription vs. Polling | offen |
| [TK-3](#tk-3-lost-notifications--reconciliation) | Lost Notifications / Reconciliation | offen |
| [TK-4](#tk-4-technischer-fehler-vs-fachliches-failed) | Technischer Fehler vs. fachliches `failed` | offen |
| [GEN-1](#gen-1-naming-warum-umzh-connect) | Naming: warum «UMZH Connect»? | offen |
| [GEN-2](#gen-2-owner-sichtbarkeitsregel-fulfiller-verliert-zugriff-auf-eigenen-task) | `owner`-Sichtbarkeitsregel: Fulfiller verliert Zugriff auf eigenen Task | offen |
| [GEN-3](#gen-3-businessstatus-binding-ber-ein-example-codesystem) | `businessStatus`-Binding über ein Example-CodeSystem | offen |

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

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(offen — ggf. Onboarding-Ablauf als Guidance-Seite dokumentieren)_

---

## Security

### SEC-1: Security-Sicht: Anbindung erster externer Partner

**Frage:** Wie stellt ihr euch die Anbindung eines ersten externen Partners aus Security-Sicht vor? Intern wurde dazu bereits etwas umgesetzt.

**Kenntnisstand:** _(im Q&A-Dokument nicht ausgefüllt)_

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(offen)_

---

### SEC-2: Authentifikation eines Placers: einmalig oder pro Task

**Frage:** Werden Placer einmalig authorisiert und müssen sich beim Erstellen eines Task nicht neu authorisieren? Oder passiert das bei jedem Task neu und gilt nur für den einen Task?

**Kenntnisstand:** Einmalig beim Onboarding.

**Antwort:** _(zu formulieren — Kenntnisstand bestätigen und im IG verankern)_

**IG-Auswirkung:** _(ggf. `security.md` / `security-implementation.md` präzisieren)_

---

### SEC-3: Zugriffslifecycle auf den klinischen Graphen

**Frage:** Wann erhält und verliert eine Gegenpartei Zugriff auf den klinischen Graphen – insbesondere bei `rejected`, `failed`, `completed` oder künftig `cancelled`?

**Kenntnisstand:** Das UMZH-Modell bindet Zugriff an Workflow-Kontext, Gegenpartei und referenzierte Datengraphen. Ein lokaler FHIR `Consent` kann zusätzlich als Policy-Datensatz dienen, ist aber nicht zwingend die normative Grundlage. **Offen:** exakter Zugriffslifecycle und Retention nach Abschluss / Fehler / Ablehnung.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(Zugriffslifecycle in `security.md` bzw. `guidance-interactions.md` ergänzen)_

---

### SEC-4: Dynamischer Resource-Graph (`supportingInfo`)

**Frage:** Wenn der Placer während des laufenden Auftrags neue `supportingInfo` hinzufügt oder entfernt: ändert sich der Fulfiller-Zugriff automatisch?

**Kenntnisstand:** Logisch würde eine graphbasierte Policy den aktuell erreichbaren Graphen auswerten; eine neue Referenz könnte auch neue Berechtigung bedeuten. **Aber:** dieses konkrete Lifecycle-Verhalten sollte mit den Spezialisten bestätigt werden; es ist eine sicherheitsrelevante Detailfrage.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(hängt an SEC-3)_

---

### SEC-5: mTLS oder DPoP

**Frage:** Beide sind im IG als höchste Stufe für Client Authentication (Level 3) vorgesehen — mTLS (RFC 8705) und DPoP (RFC 9449). Welches Verfahren wird bevorzugt / als besser erachtet? Was setzt ihr UMZH-intern ein?

**Kenntnisstand:**
- **mTLS (RFC 8705):** Client präsentiert ein X.509-Zertifikat auf TLS-Layer; der Authorization Server (und optional der Resource Server) validiert es und injiziert den Client-Kontext von der Transport- in die Applikationsschicht. Tokens sind sender-constrained an das Client-Zertifikat.
- **DPoP (RFC 9449):** Client beweist Schlüsselbesitz pro Request über einen signierten `DPoP`-HTTP-Header und bindet das Token an diesen Schlüssel, ohne TLS-Client-Zertifikate zu erfordern.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(`security-implementation.md` — Empfehlung/Priorisierung ergänzen)_

---

## Workflow

### WF-1: Technisch zugestellt vs. fachlich angenommen

**Frage:** Wie unterscheiden wir technisch zugestellt, empfangen/gesehen und fachlich angenommen? Wann ist `accepted` zwingend bzw. sinnvoll und wann darf `requested` → `in-progress` direkt erfolgen?

**Kenntnisstand:** UMZH lässt den COW-State `received` bewusst weg. Nach Erstellung steht der Task auf `requested`; die fachliche Annahme erfolgt über `accepted` bzw. danach `in-progress`. Ein separater UMZH-Task-State für «zugestellt» existiert nicht. `accepted` bedeutet explizite Übernahme, `in-progress` gestartete Bearbeitung. **Offen:** SLA und gewünschte Interpretation von HTTP-Erfolg / Task-Erstellung als Zustellnachweis; ob UMZH für bestimmte Prozesse eine explizite Acceptance verlangt oder ob sie übersprungen werden darf.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(`workflow-states.md` — State-Tabelle präzisieren)_

---

### WF-2: Synchronisation `ServiceRequest.status` mit Task

**Frage:** Wie und wann soll `ServiceRequest.status` mit dem Lifecycle des Coordination Task synchronisiert werden? Wenn der Task `completed`, `rejected` oder `failed` wird: wer setzt wann `ServiceRequest.status`, und auf welchen Wert?

**Kenntnisstand:** _(im Q&A-Dokument nicht ausgefüllt)_

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(`workflow-states.md` / `core-concept-workflow-api.md` — Mapping-Tabelle Task-Status ↔ ServiceRequest.status)_

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

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(`guidance-interactions.md` — Verbindlichkeit des Rückfrage-Flows klarstellen)_

---

### WF-5: Rückfragen vom Placer nach Abschluss

**Frage:** Rückfragen zum Austrittsbericht: Kann es nach Abschluss noch weiterführende Kommunikation geben (z. B. Rückfragen des Placers zur Medikation)? Oder muss dafür ein neuer Task erstellt werden? (Gemäss RequestStatus: `ServiceRequest.status == completed` → «No further activity will occur.»)

**Kenntnisstand:** _(im Q&A-Dokument nicht ausgefüllt)_

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(offen — ggf. Guidance «neuer Request nach Abschluss»)_

---

### WF-6: Warum Task-at-Fulfiller?

**Frage:** Warum hat UMZH Connect bewusst Task-at-Fulfiller gewählt? Welche Vorteile gegenüber Task-at-Placer, Messaging oder einem zentralen Broker waren ausschlaggebend?

**Kenntnisstand:** Der `ServiceRequest` bleibt beim Placer, der Coordination Task liegt beim Fulfiller. Dadurch besitzt der Fulfiller den Bearbeitungszustand, während die klinischen Quelldaten beim Placer bleiben. COW kennt auch andere Patterns. **Offen:** welche konkreten Architekturgründe UMZH für diese Auswahl hatte und wie dauerhaft die Entscheidung ist.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(`guidance-reference-architecture.md` — Begründung ergänzen)_

---

### WF-7: Zentraler Orchestrator vs. Task-at-Fulfiller

**Frage:** Wann sollte statt dezentralen Fulfiller-Tasks ein zentraler Coordination-/Queue-Server eingesetzt werden? Ist der zentrale Coordinator wie in COW definiert («Coordinator Mediated Exchange») auch in UMZH Connect vorgesehen oder möglich?

**Kenntnisstand:** Beides ist FHIR-nah denkbar. Zentral erleichtert Multi-Fulfiller, Routing und Monitoring, entfernt sich aber stärker vom heutigen UMZH-Task-at-Fulfiller-Vertrag und schafft zusätzliche Security-/Governance-Verantwortung. Für eine Evolution aus UMZH heraus erscheint der dezentrale Task mit überlagerter Orchestrierung naheliegender.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(`guidance-reference-architecture.md`)_

---

### WF-8: `rejected` → anderer Fulfiller

**Frage:** Was soll der Placer nach `rejected` tun? Darf derselbe `ServiceRequest` mit einem neuen Task bei Fulfiller B weiterverwendet werden? Wie werden die Versuche korreliert?

**Kenntnisstand:** `rejected` bedeutet Ablehnung vor Arbeitsbeginn. COW sieht grundsätzlich alternative Fulfiller vor. UMZH beschreibt aber derzeit keinen vollständigen Multi-Fulfiller-/Re-Routing-Flow. **Das ist eine wichtige offene Produkt- und Governancefrage.**

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(Re-Routing-Flow — evtl. neue Guidance; verwandt mit WF-9)_

---

### WF-9: `failed` → erneute Zuweisung

**Frage:** Wenn ein Auftrag nach Annahme auf `failed` geht: Darf der Placer denselben Auftrag bei einem anderen Fulfiller erneut platzieren?

**Kenntnisstand:** `failed` bedeutet Scheitern nach Annahme, im Gegensatz zu `rejected` vor Arbeitsbeginn. Was danach mit dem ursprünglichen `ServiceRequest` und einer möglichen Neuzuweisung geschieht, ist im heutigen UMZH-Vertrag nicht vollständig orchestriert.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(verwandt mit WF-8)_

---

### WF-10: Termin / Terminänderung / No-show

**Frage:** Sind Termin, Terminverschiebung und No-show Task-Zustände oder Änderungen an `Appointment`?

**Kenntnisstand:** UMZH zeigt `Appointment` als Output des Tasks. Ein eigener UMZH-Task-State wie «Termin geplant» existiert nicht; interne Systeme dürfen solche Zustände führen, aber nicht als nicht vorgesehene UMZH-Task-Stati schreiben. **Offen:** wie Terminänderung und No-show konkret interoperabel signalisiert werden sollen.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(`workflow-states.md` — Umgang mit Appointment-Änderungen)_

---

### WF-11: Bedeutung von `Task.owner`

**Frage:** Bedeutet `Task.owner` «wer muss als Nächstes handeln», «wer darf schreiben» oder «wer führt die Leistung aus»? (Vgl. auch [GEN-2](#gen-2-owner-sichtbarkeitsregel-fulfiller-verliert-zugriff-auf-eigenen-task).)

**Kenntnisstand:** In UMZH erfüllt `owner` mindestens zwei Funktionen: Verantwortlichkeit und Schreibrecht. Bei `awaiting-information` wird der Placer Owner, obwohl der Fulfiller weiterhin Leistungserbringer ist. Damit ist `owner` nicht einfach mit «Fulfiller der medizinischen Leistung» gleichzusetzen. **Semantik sollte explizit bestätigt werden.**

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(`workflow-states.md` / `guidance-interactions.md` — `owner`-Semantik definieren; koppelt an GEN-2)_

---

### WF-12: Task-Identifier / Korrelation

**Frage:** Welche Identifier müssen Systeme dauerhaft speichern, damit Request, Task, Notifications, Re-Routing und Outputs sicher korreliert werden können?

**Kenntnisstand:** Der Task besitzt einen eigenen `identifier`; `focus` und `basedOn` zeigen auf den `ServiceRequest`. Das Placer-System muss zusätzlich die beim Fulfiller entstandene Task-ID/URL dauerhaft kennen. **Offen:** welche Identifier über Organisationsgrenzen hinweg als verbindliche Business-Korrelation gelten sollen.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(`guidance-interactions.md` — Identifier-/Korrelationsregeln)_

---

### WF-13: Storno / Cancellation durch den Placer

**Frage:** Warum ist Storno durch den Placer nicht vorgesehen? Ist später das COW-Cancellation-Pattern geplant?

**Kenntnisstand:** Aktuell ausdrücklich **nicht vorgesehen** — eine bekannte Lücke für produktive Referral-Prozesse. COW besitzt weiterführende Cancellation-/Abort-Patterns; deren Übernahme in UMZH ist nicht festgelegt.
**Vorschlag aus Q&A:** `CancellationRequestTask` aus dem Basis-IG übernehmen und `cancelled` als Placer-Transition aus `requested`/`accepted` in die State-Tabelle aufnehmen; den Schreibpfad dafür deklarieren. Falls die Auslassung beabsichtigt bleibt: Grund nennen (wie bei «not selected» bereits vorbildlich getan) und den bilateralen Behelf beschreiben.

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(`workflow-states.md` — State-Tabelle; ggf. neues Task-Profil)_

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

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(`guidance-interactions.md` / CapabilityStatement)_

---

### TK-3: Lost Notifications / Reconciliation

**Frage:** Wenn eine Notification verloren geht, wie erfolgt die Wiederherstellung des korrekten Zustands?

**Kenntnisstand:** Robustes Modell: Notification ist ein Hinweis, der **Task bleibt Source of Truth**; Poll/Search/Reconciliation liest danach den tatsächlichen Zustand. Diese Kombination wäre insbesondere für eine Orchestrierungsplattform wichtig.

**Antwort:** _(zu formulieren — Kenntnisstand bestätigen)_

**IG-Auswirkung:** _(`guidance-interactions.md` — Reconciliation-Guidance)_

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

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** _(ggf. `index.md` — Scope/Naming-Abschnitt)_

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

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** `guidance-interactions.md` (Sichtbarkeitsregel Zeile ~34 und ~115), `UmzhConnectCapabilityStatement.fsh`, ggf. `Task-ReferralOrthopedicSurgeryUpdated.fsh`. Koppelt an [WF-11](#wf-11-bedeutung-von-taskowner). Betrifft aktuellen Branch-Stand (`guidance-interactions.md` in Arbeit).

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

**Antwort:** _(zu formulieren)_

**IG-Auswirkung:** `input/fsh/valuesets/business-status.fsh`, `ch-umzh-connect-coordinationtask` Profil, ggf. neues CH-CodeSystem.
