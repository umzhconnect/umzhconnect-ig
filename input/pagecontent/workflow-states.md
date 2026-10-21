<style>
div.mermaid iframe {
  width: 100% !important;
  height: 250px !important;
  border: 0 !important;
}
</style>


### Task Workflow States

The `CoordinationTask` lifecycle is governed by two complementary fields:

- **`Task.status`** — the FHIR base state machine ([Task state machine](https://hl7.org/fhir/task.html#statemachine)); reflects the overall lifecycle of the task
- **`Task.businessStatus`** — a domain-specific qualifier that sits *alongside* `Task.status` to convey sub-states meaningful to the workflow; codes are drawn from [COW business status codes](https://hl7.org/fhir/uv/cow/2025May/ValueSet-business-status.html)

This IG follows the [COW Workflow State Overview](https://hl7.org/fhir/uv/cow/2025May/workflow-state-overview.html) with the constraints documented below. Note that COW's `received` state is intentionally omitted in this version of the IG: a Task transitions directly from `requested` to `accepted` or `in-progress`.

**Rules:**

- Only the Fulfiller may change `Task.status`
- `Task.owner` is always the Fulfiller organization
- The Placer may only update the Task while `Task.businessStatus` is `awaiting-information`, and only to add entries to `Task.input` and to remove `Task.businessStatus`
- `Task.businessStatus` must only contain domain-specific workflow codes; `Task.status` codes must never be used as `businessStatus` values
- Cancellation by the Placer is not foreseen in this version of the IG
- Negative terminal states use base-FHIR `rejected` (Fulfiller declines before starting) and `failed` (accepted but not completed) rather than COW's `cancelled + statusReason`; COW's `cancelled` ("not selected") pattern assumes a multi-Fulfiller selection flow that is out of scope here

### State Diagram

```mermaid
stateDiagram-v2
    direction LR

    [*] --> requested : Placer POSTs Task to Fulfiller

    requested --> in_progress   : Fulfiller accepts & starts
    requested --> accepted      : Fulfiller explicitly accepts\n(request-with-acceptance pattern)
    requested --> rejected      : Fulfiller declines

    accepted  --> in_progress   : Fulfiller starts work

    state "in-progress\n[awaiting-information]" as awaiting
    in_progress --> awaiting    : Fulfiller needs more info
    awaiting    --> in_progress : Placer provides info

    in_progress --> completed   : Fulfiller completes
    in_progress --> failed      : Fulfiller unable to complete

    completed --> [*]
    rejected  --> [*]
    failed    --> [*]
```

### State Transition Table

{:class="table table-bordered"}
| State label | `Task.status` | `Task.businessStatus` | Who sets this | Notes |
|---|---|---|---|---|
| Requested | `requested` | — | Placer | Initial state when Task is POSTed to Fulfiller |
| Accepted | `accepted` | — | Fulfiller | Explicit acceptance; may be skipped in pre-agreed flows |
| In progress | `in-progress` | — | Fulfiller | Fulfiller has started work |
| Awaiting information | `in-progress` | `awaiting-information` | Fulfiller | Fulfiller has added Questionnaire to `Task.output` |
| Information received | `in-progress` | — | Placer | Placer has updated Task with QuestionnaireResponse in `Task.input` and cleared `businessStatus` |
| Completed | `completed` | — | Fulfiller | Results referenced in `Task.output` |
| Rejected | `rejected` | — | Fulfiller | Fulfiller declines; Placer may approach another Fulfiller |
| Failed | `failed` | — | Fulfiller | Fulfiller accepted but could not complete |
