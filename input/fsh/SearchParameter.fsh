Instance: ch-umzhconnectig-servicerequest-reasonreference
InstanceOf: SearchParameter
Usage: #definition
* name = "ch-umzhconnectig-servicerequest-reasonreference"
* description = "Custom search parameter for ServiceRequest.reasonReference"
* status = #active
* code = #ch-umzhconnectig-servicerequest-reasonreference
* base = #ServiceRequest
* type = #reference
* expression = "ServiceRequest.reasonReference"
* xpathUsage = #normal
* multipleAnd = true

Instance: ch-umzhconnectig-servicerequest-supportinginfo
InstanceOf: SearchParameter
Usage: #definition
* name = "ch-umzhconnectig-servicerequest-supportinginfo"
* description = "Custom search parameter for ServiceRequest.supportingInfo"
* status = #active
* code = #ch-umzhconnectig-servicerequest-supportinginfo
* base = #ServiceRequest
* type = #reference
* expression = "ServiceRequest.supportingInfo"
* xpathUsage = #normal
* multipleAnd = true

Instance: ch-umzhconnectig-servicerequest-insurance
InstanceOf: SearchParameter
Usage: #definition
* name = "ch-umzhconnectig-servicerequest-insurance"
* description = "Custom search parameter for ServiceRequest.insurance"
* status = #active
* code = #ch-umzhconnectig-servicerequest-insurance
* base = #ServiceRequest
* type = #reference
* expression = "ServiceRequest.insurance"
* xpathUsage = #normal
* multipleAnd = true

Instance: ch-umzhconnectig-task-inputreference
InstanceOf: SearchParameter
Usage: #definition
* name = "ch-umzhconnectig-task-inputreference"
* description = "Custom search parameter for Task.input.valueReference"
* status = #active
* code = #ch-umzhconnectig-task-inputreference
* base = #Task
* type = #reference
* expression = "Task.input.value as Reference"
* xpathUsage = #normal
* multipleAnd = true

Instance: ch-umzhconnectig-task-outputreference
InstanceOf: SearchParameter
Usage: #definition
* name = "ch-umzhconnectig-task-outputreference"
* description = "Custom search parameter for Task.output.valueReference"
* status = #active
* code = #ch-umzhconnectig-task-outputreference
* base = #Task
* type = #reference
* expression = "Task.output.value as Reference"
* xpathUsage = #normal
* multipleAnd = true

Instance: ch-umzhconnectig-task-outputcanonical
InstanceOf: SearchParameter
Usage: #definition
* name = "ch-umzhconnectig-task-outputcanonical"
* description = "Custom search parameter for Task.output.valueCanonical"
* status = #active
* code = #ch-umzhconnectig-task-outputcanonical
* base = #Task
* type = #reference
* expression = "Task.output.value as Canonical"
* xpathUsage = #normal
* multipleAnd = true
