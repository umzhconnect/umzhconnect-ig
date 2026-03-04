# Contributing

Thank you for your interest in contributing to the UMZH Connect Implementation Guide.

## Getting Started

1. Fork the repository and create a branch from `main`.
2. Branch names should use underscores (e.g., `issue123_fix_extension`).
3. Follow the [build instructions](README.md#building-the-implementation-guide) to set up a local environment.

## Making Changes

- Edit only source files under `input/` and `sushi-config.yaml`. Do not edit generated folders (`fsh-generated/`, `output/`, `temp/`).
- FSH files use 2-space indentation and kebab-case file names.
- Profile IDs use the `ch-umzh-connect-` prefix.
- Add example instances in `input/fsh/instances/` and validate them against the relevant profile before committing.
- Update `input/pagecontent/changelog.md` with a brief description of your change.

## Before Committing

Run the IG build and check the QA report:

```sh
npm run build:ig
```

Open `output/qa.html` and ensure the error count has not increased before submitting.

## Pull Requests

- Keep PRs focused and concise.
- Reference related issues (e.g., `#123`) in your commits and PR description.
- Commits should use imperative summaries (e.g., `Fix name extension binding strength`).

## Questions

For questions about the project, open an issue or reach out via [HL7 Switzerland](https://www.hl7.ch/).
