### Introduction

**CH UMZH Connect** is a FHIR Implementation Guide for the University Medicine Zurich (UMZH) focusing on referral and external service order processes

The UMZH-connect project aims to improve digital connectivity for referrals and external orders (e.g., lab orders) between healthcare providers in the Zurich area, particularly the university hospitals. The system is designed to be extensible — both in terms of use cases and participating organizations.

The goal is to establish an API framework that allows participants, as API consumers, to digitally create orders and referrals and, depending on the use case, access authorized data from each other. Hospitals — and later medical practices — will provide REST APIs that support read and write operations on authorized data scopes via web services.

Initial Use Cases focus on the following resource types:
* Order, service request and clinical question
* Administrative data (personal details, insurance, etc.)
* Diagnoses
* Medication
* Allergies
* Reports (documents)
* ImagingStudies

These content areas are intended to be expandable in the future.

### Workflow orientation

This implementation guide is based on the core principles of [Clinical Order Workflow IG](http://hl7.org/fhir/uv/cow/ImplementationGuide/hl7.fhir.uv.cow) with a focus on the [*Task at Fulfiller*](https://build.fhir.org/ig/HL7/fhir-cow-ig/en/fulfiller-determination.html#task-at-fulfiller) principle where the Placer creates a ServiceRequest and POSTs a Task to the Fulfiller's FHIR server, with the ServiceRequest referenced in `Task.basedOn`. The Fulfiller manages the Task lifecycle and updates the Placer about progress and outcomes.

The core concepts and principles are depicted in detail here:

[Core concepts](core-concepts.html)


* **Resource Querying**: The Placer SHALL support the `_include` parameter for querying the ServiceRequest along with all referenced resources.


### Security

This IG specifies OAuth 2.0 and OpenID Connect–based architectures for securing APIs by the use of Security profiles such as SMART on FHIR define standards and OpenID Foundation’s FAPI 2.0, which sharpens security awareness by enforcing measures to mitigate particular risk scenarios.

The detailed security concept can be found here:

[Security concept](security.html)

### Use cases



<div markdown="1" class="stu-note">

[Changelog](changelog.html) with significant changes, open and closed issues.

</div>

<!-- **Download**: You can download this implementation guide in the [NPM package](https://confluence.hl7.org/display/FHIR/NPM+Package+Specification) format from [here](package.tgz). -->

### IP Statements
This document is licensed under Creative Commons "No Rights Reserved" ([CC0](https://creativecommons.org/publicdomain/zero/1.0/)).

HL7®, HEALTH LEVEL SEVEN®, FHIR® and the FHIR <img src="icon-fhir-16.png" style="float: none; margin: 0px; padding: 0px; vertical-align: bottom"/>&reg; are trademarks owned by Health Level Seven International, registered with the United States Patent and Trademark Office.

This implementation guide contains and references intellectual property owned by third parties ("Third Party IP"). Acceptance of these License Terms does not grant any rights with respect to Third Party IP. The licensee alone is responsible for identifying and obtaining any necessary licenses or authorizations to utilize Third Party IP in connection with the specification or otherwise.

{% include ip-statements.xhtml %}

### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

### Dependency Table

{% include dependency-table.xhtml %}

### Globals Table

{% include globals-table.xhtml %}
