Instance: MedicationConcor
InstanceOf: CHCoreMedicationStatement
//InstanceOf: CHCoreMedicationRequest
//InstanceOf: CHEMEDMedicationRequest
Usage: #example
Title: "Medication Concor"
Description: "Concor (Bisoprolol 10 mg) beta-blocker for heart failure treatment."
* contained[0] = MedConcor
* status = #active
//* intent = #order
* medicationReference = Reference(MedConcor)
* subject = Reference(PetraMeier)
//* dosageInstruction[0].sequence = 1
//* dosageInstruction[0].timing.repeat.boundsPeriod.start = "2025-12-19"
//* dosageInstruction[0].timing.repeat.when = #MORN
//* dosageInstruction[0].route = $edqm#20053000 "Oral use"
//* dosageInstruction[0].doseAndRate[0].doseQuantity.value = 1 $ucum#{Piece} "Stk"
//* dispenseRequest.validityPeriod.start = "2025-12-19"

Instance: MedConcor
InstanceOf: Medication
Usage: #inline
* code.coding[0] = urn:oid:2.51.1.1#7680473110395 "Concor (Filmtabl 10 mg) Blist"
* code.coding[1] = $atc#C07AB07 "Bisoprolol"
* code.text = "Concor (Filmtabl 10 mg) Blist"
* form.coding[0] = $edqm#0221000 "Filmtablette"
* ingredient[0].itemCodeableConcept.coding[0] = $sct#386869006 "Bisoprolol fumarat"
* ingredient[0].itemCodeableConcept.text = "Bisoprolol fumarat"
* ingredient[0].strength.numerator = 10 $ucum#mg "mg"
