Instance: ch-umzhconnectig-sevicerequest-reasonreference
InstanceOf: SearchParameter
Usage: #definition
* name = "ch-umzhconnectig-servicerequest-reasonreference"
* description = "Custom search parameter for ServiceRequest.reasonReference"
* status = #active
* code = #ch-umzhconnectig-sevicerequest-reasonreference
* base = #ServiceRequest
* type = #reference
* expression = "ServiceRequest.reasonReference"
* xpathUsage = #normal
* multipleAnd = true

Instance: ch-umzhconnectig-sevicerequest-supportinginfo
InstanceOf: SearchParameter
Usage: #definition
* name = "ch-umzhconnectig-servicerequest-supportinginfo"
* description = "Custom search parameter for ServiceRequest.supportingInfo"
* status = #active
* code = #ch-umzhconnectig-sevicerequest-supportinginfo
* base = #ServiceRequest
* type = #reference
* expression = "ServiceRequest.supportingInfo"
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
