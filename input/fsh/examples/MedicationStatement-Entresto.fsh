Instance: MedicationEntresto
InstanceOf: CHCoreMedicationStatement
Usage: #example
Title: "Medication Entresto"
Description: "Entresto (Sacubitril/valsartan 97/103 mg) for heart failure treatment."
* contained[0] = MedEntresto
* status = #active
* medicationReference = Reference(MedEntresto)
* subject = Reference(PetraMeier)
* dosage.timing.repeat.boundsPeriod.start = "2025-12-19"
* dosage.timing.repeat.when[0] = #MORN
* dosage.timing.repeat.when[+] = #NOON
* dosage.timing.repeat.when[+] = #EVE
* dosage.route = $edqm#20053000 "Oral use"
* dosage.doseAndRate.doseQuantity = 1 $ucum#{Piece} "Stk"


Instance: MedEntresto
InstanceOf: CHCoreMedication
Usage: #inline
* code.coding[0] = urn:oid:2.51.1.1#7680656730044 "Entresto (Filmtabl 200 mg) Blist"
* code.coding[1] = $atc#C09DX04 "Valsartan und Sacubitril"
* code.text = "Entresto (Filmtabl 200 mg) Blist"
* form.coding[0] = $edqm#10221000 "Filmtablette"
* form.text = "Filmtablette"
* ingredient[0].itemCodeableConcept.coding[0] = $sct#716072000 "Sacubitril"
//* ingredient[0].strength.numerator = 97.2 $ucum#mg "mg"
* ingredient[1].itemCodeableConcept.coding[0] = $sct#386876001 "Valsartan"
//* ingredient[1].strength.numerator = 102.8 $ucum#mg "mg"
