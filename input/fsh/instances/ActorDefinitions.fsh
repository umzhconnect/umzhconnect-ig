Instance: ch-umzh-connect-placer
InstanceOf: ActorDefinition
Usage: #definition
* derivedFrom = "http://hl7.org/fhir/uv/cow/ActorDefinition/placer"
* name = "UMZHConnectPlacer"
* title = "Placer"
* status = #active
* type = #system
* description = "The party initiating the referral or order. Hosts the ServiceRequest and all referenced clinical resources."

Instance: ch-umzh-connect-fulfiller
InstanceOf: ActorDefinition
Usage: #definition
* derivedFrom = "http://hl7.org/fhir/uv/cow/ActorDefinition/filler"
* name = "UMZHConnectFulfiller"
* title = "Fulfiller"
* status = #active
* type = #system
* description = "The party performing the requested service. Hosts the Coordination Task and related output resources."
