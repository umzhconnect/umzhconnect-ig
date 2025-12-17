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

