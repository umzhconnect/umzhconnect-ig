<span style="color: red;"><em>✂️ Best practice: Keep a Guidance page but replace this informative content with your own IG-specific guidance ✂️</em></span>

For IG authors, the [Guidance for FHIR IG Creation](https://build.fhir.org/ig/FHIR/ig-guidance/index.html) provides comprehensive best practices for implementation guide development.

### Styles for Narrative
There are defined [styles](https://build.fhir.org/ig/FHIR/ig-guidance/best-practice.html#styles):
- `stu-note` (see the [Home](index.html) page)
- `dragon` (see below)
- etc

<div markdown="5" class="dragon">
    <p>
    This box is styled 'dragon' serves to warn about issues or pitfalls 
    </p>
</div>

### Instance Fragments
You can embed [instance fragments](https://build.fhir.org/ig/FHIR/ig-guidance/fragments.html) within a page:

{% fragment Patient/PetraMeier JSON %}

### Creating Diagrams 
- [Class Diagrams](https://build.fhir.org/ig/FHIR/ig-guidance/uml.html)
- [Mermaid](https://build.fhir.org/ig/FHIR/ig-guidance/diagrams-mermaid.html)
- [PlantUml](https://build.fhir.org/ig/FHIR/ig-guidance/diagrams-plantuml.html) (see example from CH Core below)

<div>{% include dependencies-igs.svg %}</div>

### Multi-Language Support
- Zulip Channel [Multi-lingual IGs](https://chat.fhir.org/#narrow/channel/380308-Multi-lingual-IGs)
- [Producing Multi-Language IGs](https://build.fhir.org/ig/FHIR/ig-guidance/languages.html)

TODO

### Cross-Versioning
See details about [extensions for converting between versions](https://build.fhir.org/versions.html#extensions) (see also [FHIR Cross-Version Mapping Pack](https://build.fhir.org/ig/HL7/fhir-cross-version/)).

CH IG example using a backport extension: [Cross-Version Encounter R4](Encounter-xver-encounter-r4.html):

{% fragment Encounter/xver-encounter-r4 XML EXCEPT:id|extension %}

CH IG profile using a backport extension: [CH IG Encounter](StructureDefinition-ch-ig-encounter.html)

### Guidelines HL7 Switzerland
- [Guidelines for Swiss IG Development](https://github.com/hl7ch/ch-core/wiki/Guidelines-for-Swiss-IG-Development)
- [HL7.ch FHIR IG Balloting](https://github.com/hl7ch/ch-core/wiki/HL7.ch-FHIR-IG-Balloting)
- [HL7 Switzerland IG template for IG Publisher](https://github.com/hl7ch/ig-template/?tab=readme-ov-file#hl7-switzerland-ig-template-for-ig-publisher): propose a change-link, logos, css adjustments