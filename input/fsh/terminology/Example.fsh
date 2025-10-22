ValueSet: DesignationsVS
Id: example
Title: "CH IG Designations"
Description: "Example value set including all codes from the designations code system."
* ^experimental = false
* include codes from system DesignationsCS


CodeSystem: DesignationsCS
Id: example
Title: "CH IG Designations"
Description: "Example code system including own defined codes with multilingual designations."
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete

* #example-1 "Example 1"
* #example-1 ^designation[0].language = #de-CH
* #example-1 ^designation[=].value = "Beispiel 1"
* #example-1 ^designation[+].language = #fr-CH
* #example-1 ^designation[=].value = "Exemple 1"
* #example-1 ^designation[+].language = #it-CH
* #example-1 ^designation[=].value = "Esempio 1"

* #example-2 "Example 2"
* #example-2 ^designation[0].language = #de-CH
* #example-2 ^designation[=].value = "Beispiel 2"
* #example-2 ^designation[+].language = #fr-CH
* #example-2 ^designation[=].value = "Exemple 2"
* #example-2 ^designation[+].language = #it-CH
* #example-2 ^designation[=].value = "Esempio 2"

* #example-3 "Example 3"
* #example-3 ^designation[0].language = #de-CH
* #example-3 ^designation[=].value = "Beispiel 3"
* #example-3 ^designation[+].language = #fr-CH
* #example-3 ^designation[=].value = "Exemple 3"
* #example-3 ^designation[+].language = #it-CH
* #example-3 ^designation[=].value = "Esempio 3"
