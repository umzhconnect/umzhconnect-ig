Instance: MedicationAspirin
InstanceOf: CHCoreMedicationStatement
Usage: #example
Title: "Discharge Medication Aspirin"
Description: "Aspirin (Acetylsalicylic acid 100 mg) blood thinner for thromboprophylaxis after knee surgery. Discharge medication referenced in the completed Coordination Task output. Hosted on fulfiller."
* contained[0] = MedAspirin
* status = #active
* medicationReference = Reference(MedAspirin)
* subject = Reference(PetraMeier)
* dosage.timing.repeat.boundsPeriod.start = "2026-01-20"
* dosage.timing.repeat.when = #MORN
* dosage.route = $edqm#20053000 "Oral use"
* dosage.doseAndRate.doseQuantity = 1 $ucum#{Piece} "Stk"

Instance: MedAspirin
InstanceOf: CHCoreMedication
Usage: #inline
* code.coding[0] = $atc#B01AC06 "Acetylsalicylic acid"
* code.text = "Aspirin (Filmtabl 100 mg)"
* form.coding[0] = $edqm#10221000 "Filmtablette"
* form.text = "Filmtablette"
* ingredient[0].itemCodeableConcept.coding[0] = $sct#387458008 "Aspirin (substance)"
* ingredient[0].itemCodeableConcept.text = "Acetylsalicylic acid"
