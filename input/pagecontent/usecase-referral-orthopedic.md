### Referral - Orthopedic Surgery

The patient [PetraMeier](Patient-PetraMeier.html) visits the emergency department of HospitalP(lacer) with knee pain after falling on icy street. The [treating practitioner](PractitionerRole-HansMusterRole.html) suspects a rupture of the left ACL and suggests treatment at HospitalF(ulfiller).
Comorbidities: The patient is already being treated for heart problems in cardiology at HospitalP.

[Example ServiceRequest](ServiceRequest-ReferralOrthopedicSurgery.html)

#### Overview

```mermaid
sequenceDiagram
    actor HospitalP as HospitalP (Placer)
    actor HospitalF as HospitalF (Fulfiller)
    
    rect rgb(191, 223, 255)
    HospitalP->>HospitalP: Create ServiceRequest SR-HospitalP001
    HospitalP->>HospitalF: Create Task (focus: SR-HospitalP001)
    activate HospitalF
    HospitalF->>HospitalP: Task T-UKB001 created
    deactivate HospitalF
    end
    
    rect rgb(191, 223, 255)
    HospitalF->>HospitalF: Update Task T-UKB001<br/>(status: accepted)
    HospitalF->>HospitalP: Request Resources (Diagnoses, Medications)
    activate HospitalP
    HospitalP->>HospitalF: Resources Response
    deactivate HospitalP
    end
    
    rect rgb(255, 230, 204)
    Note over HospitalF: Outpatient phase **E-UKB001**:<br/>- Create Patient P-UKB001<br/>- Create Outpatient Encounter E-UKB001<br/>- Store diagnoses/meds from SR-HospitalP001
    Note over HospitalF: Create Appointment A-UKB001 (initial consult)
    HospitalF->>HospitalF: Update Task T-UKB001<br/>(status: in-progress, output: A-UKB001)
    HospitalF-->>HospitalP: Notify Task update
    end

    rect rgb(255, 230, 204)
    Note over HospitalF: Create Appointment A-UKB002 (preop)
    HospitalF->>HospitalF: Update Task T-UKB001<br/>(status: in-progress, output: A-UKB002)
    HospitalF-->>HospitalP: Notify Task update
    end

    rect rgb(204, 255, 204)
    Note over HospitalF: Inpatient phase **E-UKB002**:<br/>- Create Inpatient Encounter E-UKB002 (surgery)<br/>- Copy diagnoses/meds from E-UKB001<br/>- Create Appointment A-UKB003 (surgery)
    HospitalF->>HospitalF: Update Task T-UKB001<br/>(status: in-progress, output: A-UKB003)
    HospitalF-->>HospitalP: Notify Task update
    end
    
    rect rgb(204, 255, 204)
    HospitalF->>HospitalF: Update Task T-UKB001<br/>(status: completed, output: R-UKB001)
    HospitalF-->>HospitalP: Notify Task update
    end

```

#### Field Sources

The following table indicates the source of each field in the ServiceRequest:

| Field | Source | Description |
|-------|--------|-------------|
| `identifier[placerOrderIdentifier].system` | Hard-coded | TODO? |
| `identifier[placerOrderIdentifier].value` | Generated | Unique referral order number (e.g., REF-2025-001) |
| `status` | Hard-coded | Fixed value `active` |
| `intent` | Hard-coded | Fixed value `order` |
| `category` | Hard-coded | SNOMED CT code 306206005 "Referral to service" |
| `subject` | Referenced | the patient being referred |
| `requester` | Referenced | the referring physician with their organizational context |
| `authoredOn` | Current date | Date when the referral was created |
| `reasonReference` | Referenced | Primary diagnosis: [Suspected ACL Rupture](Condition-SuspectedACLRupture.html). If the primary diagnosis is unknown, all diagnoses go to supportingInfo as Condition. |
| `supportingInfo` | Referenced | Secondary diagnosis: [Heart Failure HFrEF](Condition-HeartFailureHFrEF.html); Medications: [Entresto](MedicationStatement-MedicationEntresto.html), [Concor](MedicationStatement-MedicationConcor.html) |
| `note.text` | Manual entry | Free-text clinical note entered ad-hoc for the referral |

