# CH Core Implementation Guide Repository Guidelines

## Overview
- Main repository for the UMZH Connect (R4) FHIR Implementation Guide.
- Built with the HL7 FHIR IG Publisher and FSH/SUSHI.
- Defines core FHIR profiles, extensions, and resource
- Canonical URL: http://fhir.ch/ig/ch-umzh-connect

## Project Structure & Module Organization
- `input/`: IG content (FSH definitions, markdown pages, examples)
  - `input/fsh/`: FHIR Shorthand (FSH) definitions
    - `ALIAS.fsh`: Commonly used aliases
    - `profiles`: Profile definitions for resources
    - `terminology`: terminology resources
  - `input/pagecontent/`: Markdown content for IG pages
  - `input/images/`: Images and diagrams
  - `input/includes/`: Template includes
- `sushi-config.yaml`: SUSHI configuration and IG metadata.
- `ig.ini`: IG Publisher configuration.
- `template/`: HL7 CH IG Publisher template.
- `scripts/`: IG build/update helpers (`_genonce.sh`, `_updatePublisher.sh`, `_gencontinuous.sh`).
- Generated: `fsh-generated/`, `output/`, `temp/`. Do not edit by hand.

## Build, Test, and Development Commands
- Prerequisites: Java 11+, Jekyll (for IG building)
- `npm run update:publisher`: Download/refresh HL7 IG Publisher (requires `curl`, Java).
- `npm run build:ig`: Build the Implementation Guide once (runs `./scripts/_genonce.sh`).
- `npm run build:ig:continuous`: Rebuild on change (runs `./scripts/_gencontinuous.sh`).
- `npm run serve:ig`: Serve built IG from `output/` directory.
- `npm run open:ig`: Open `output/index.html` in browser.
- Manual build: `java -Xms3550m -Xmx3550m -jar publisher.jar -ig ig.ini`

## Coding Style & Naming Conventions
- FSH files: 2-space indentation, kebab-case for file names.
- Profile IDs: Use `ch-umzh-connect-` prefix (e.g., `ch-umzh-connect-servicerequest`).
- Example instances: Clear, descriptive names reflecting Swiss use cases.
- Keep generated folders untracked in changes; edit sources only (`input/`, `sushi-config.yaml`).

## Testing Guidelines
- Add example instances in `input/fsh/instances/` to demonstrate profile usage.
- Validate examples against defined profiles before committing.

## Commit & Pull Request Guidelines
- When creating a new PR or commit first run npm build:ig, this can take a few minutes, only commit when the error count is not bigger than 1, analyze output/qa.html for detailed error message
- Branch names: Use underscores instead of slashes (e.g., `issue123_fix_extension` not `issue/123/fix-extension`). Slashes in branch names can cause issues with ci-build.
- Commits: Concise, imperative summaries (e.g., "Fix name extension binding strength"). Claude needs not to be mentioned.
- Reference issues in commits (e.g., "#381").
- Update changelog in input/pagecontent/changelog.md
- PRs: Include purpose, scope, linked issues, keep it short, Claude needs not to be mentioned as co-author.

## Security & Configuration Tips
- IG build contacts `tx.fhir.org` for terminology; offline builds pass `-tx n/a`.
- Need read access to https://github.com/HL7/fhir-ig-publisher/ and https://raw.githubusercontent.com/
- Do not embed test data with real patient information.

## Resources & Links
- HL7 Switzerland: https://www.hl7.ch/