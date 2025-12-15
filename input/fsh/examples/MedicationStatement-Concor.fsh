Instance: MedicationConcor
InstanceOf: CHCoreMedicationStatement
Usage: #example
Title: "Medication Concor"
Description: "Concor (Bisoprolol 10 mg) beta-blocker for heart failure treatment."
* contained[0] = MedConcor
* status = #active
* medicationReference = Reference(MedConcor)
* subject = Reference(PetraMeier)
* dosage.text = "10 mg once daily"
* dosage.route = urn:oid:0.4.0.127.0.16.1.1.2.1#20053000 "Oral use"

Instance: MedConcor
InstanceOf: CHCoreMedication
Usage: #inline
* code.coding[0] = urn:oid:2.51.1.1#7680532900196 "CONCOR Filmtabl 10 mg 100 Stk"
* code.text = "Concor (Bisoprolol 10 mg)"
* form = urn:oid:0.4.0.127.0.16.1.1.2.1#10221000 "Film-coated tablet"

