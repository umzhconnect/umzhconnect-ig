Instance: MedicationEntresto
InstanceOf: CHCoreMedicationStatement
Usage: #example
Title: "Medication Entresto"
Description: "Entresto (Sacubitril/valsartan 97/103 mg) for heart failure treatment."
* contained[0] = MedEntresto
* status = #active
* medicationReference = Reference(MedEntresto)
* subject = Reference(PetraMeier)
* dosage.text = "97/103 mg once daily"
* dosage.route = urn:oid:0.4.0.127.0.16.1.1.2.1#20053000 "Oral use"

Instance: MedEntresto
InstanceOf: CHCoreMedication
Usage: #inline
* code.coding[0] = urn:oid:2.51.1.1#7680651190013 "ENTRESTO Filmtabl 97/103 mg 56 Stk"
* code.text = "Entresto (Sacubitril/valsartan 97/103 mg)"
* form = urn:oid:0.4.0.127.0.16.1.1.2.1#10221000 "Film-coated tablet"

