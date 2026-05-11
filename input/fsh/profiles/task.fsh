Profile: ChUmzhConnectCoordinationTask
Parent: CowCoordinationTask
Id: ch-umzh-connect-coordinationtask
Title: "CH UMZH Connect Coordination Task"
Description: "CH UMZH Connect Coordination Task"

* focus only Reference(ChUmzhConnectServiceRequest)
* code from ChUmzhConnectServiceRequestCategoryVS (extensible)
* businessStatus from ChUmzhConnectTaskBusinessStatus (extensible)

* requester 1..1
* requester only Reference(Organization)
* requester obeys ch-umzh-abs-url

* owner 1..1
* owner only Reference(Organization)
* owner obeys ch-umzh-abs-url

Invariant: ch-umzh-abs-url
Description: "Reference must be an absolute URL (http:// or https://)"
Expression: "reference.exists() implies reference.matches('^https?://')"
Severity: #error