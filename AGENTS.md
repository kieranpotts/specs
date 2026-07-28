# [Project Name] – Software Requirements Specification (SRS)

The capitalized words REQUIRED, MUST, MUST NOT, RECOMMENDED, SHOULD,
SHOULD NOT, OPTIONAL, and MAY are to be interpreted as described in
[IETF RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

## Project overview

See the [README](./README.md) for an overview of this project, and how it fits
alongside the sibling RFC, design, plans, audits, and risks repositories.

This repository is documentation, not code. There is nothing to build, lint,
or run.

## Project structure

- **`specification/`:** Describes the current production system.

  - **`context/`:** Problem space and domain model. Descriptive.

  - **`requirements/`:** Expected behaviors and qualities. Prescriptive.

- **`proposals/`:** Permanent archive of every proposed change. Each proposal
  is a directory (`proposals/<slug>/`) holding its `README.md` and any
  supporting artifacts.

  - **`proposals/INDEX.md`** is the numbered catalog of merged proposals.

  - **`proposals/TEMPLATE.md`** is the starting point for a new proposal.

- **`docs/`:** General guidelines for humans to get the most out of the SRS
  process.

## Lifecycle

See [CONTRIBUTING.md > Lifecycle](./CONTRIBUTING.md#lifecycle) for the state
machine and the table of permitted transitions.

## Workflow

See [CONTRIBUTING.md > Workflow](./CONTRIBUTING.md#workflow) for the
step-by-step process for shepherding a proposal from `DRAFT` to
`RELEASED`/`REJECTED`.

## Rules

Agents MUST follow the process rules in [CONTRIBUTING.md >
Rules](./CONTRIBUTING.md#rules). Re-read them before creating, transitioning,
or merging a proposal, rather than relying on your memory of a prior state of
the rules.

The conventions for writing specification content itself – Gherkin scenarios,
requirement identifiers, the qualities taxonomy, deprecation marking – are
documented where that content lives: see
[`specification/requirements/`](./specification/requirements/) and its
subdirectory READMEs, and [`docs/best-practices.md`](./docs/best-practices.md).
The [`/write-spec`](./.agents/skills/write-spec/SKILL.md) skill applies these
conventions. Use it when authoring or editing specification artifacts.

## Skills

The **`.agents/skills/`** directory provides on-demand skills for managing the
lifecycle of a proposal. See the [README](./.agents/skills/README.md) for
descriptions of the available skills and their triggers.

It is RECOMMENDED to use these skills to drive state transitions.
