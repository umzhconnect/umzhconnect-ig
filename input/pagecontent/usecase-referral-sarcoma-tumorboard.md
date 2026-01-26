### Referral - Sarcoma Tumor Board

The patient [PetraMeier](Patient-PetraMeier.html) has been diagnosed with a histologically confirmed synovial sarcoma of the right knee. The [treating practitioner](PractitionerRole-HansMusterRole.html) refers the case to the tumor board for multidisciplinary review and therapy recommendations.

[Example ServiceRequest](ServiceRequest-ReferralTumorboard.html)

#### Overview

This use case demonstrates a referral to a tumor board for cancer care review. The referral includes:
- Primary diagnosis: [Synovial sarcoma of the right knee](Condition-SarcomaKnee.html)
- Supporting information: 
  - [Gadolinium contrast allergy](AllergyIntolerance-AllergyGado.html)
  - [CT scan of the right knee](ImagingStudy-ImagingCT.html)
  - [PET scan for staging](ImagingStudy-ImagingPET.html)


#### Field Sources

The following table indicates the source of each field in the ServiceRequest:

| Field | Source | Description |
|-------|--------|-------------|
| `identifier[placerOrderIdentifier].value` | Generated | Unique referral order number (e.g., REF-2025-002) |
| `status` | Hard-coded | Fixed value `active` |
| `intent` | Hard-coded | Fixed value `order` |
| `category` | Hard-coded | SNOMED CT code 720006006 "Cancer care review (procedure)" |
| `subject` | Referenced | The patient being referred: [PetraMeier](Patient-PetraMeier.html) |
| `requester` | Referenced | The referring physician with their organizational context: [HansMusterRole](PractitionerRole-HansMusterRole.html) |
| `authoredOn` | Current date | Date when the referral was created |
| `reasonReference` | Referenced | Primary diagnosis: [Synovial sarcoma of the right knee](Condition-SarcomaKnee.html) |
| `supportingInfo` | Referenced | [Gadolinium contrast allergy](AllergyIntolerance-AllergyGado.html), [CT scan](ImagingStudy-ImagingCT.html), [PET scan](ImagingStudy-ImagingPET.html) |
| `note.text` | Manual entry | Free-text clinical note: "Review therapy recommendations." |
