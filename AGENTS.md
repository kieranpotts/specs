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

- `specification/`. Describes the current production system.

  - `context/`. Problem space and domain model. Descriptive.

  - `requirements/`. Expected behaviors and qualities. Prescriptive.

- `proposals/`. Permanent archive of every proposed change. Each proposal is
  a directory (`proposals/<slug>/`) holding its `README.md` and any
  supporting artifacts.

  - `proposals/INDEX.md` is the numbered catalog of merged proposals.

  - `proposals/TEMPLATE.md` is the starting point for a new proposal.

- `docs/`. General guidelines for humans to get the most out of the SRS
  process.

## Lifecycle

See [CONTRIBUTING.md > Lifecycle](./CONTRIBUTING.md#lifecycle) for the state
machine and the table of permitted transitions.

## Workflow

See [CONTRIBUTING.md > Workflow](./CONTRIBUTING.md#workflow) for the
step-by-step process for shepherding a proposal from `DRAFT` to
`RELEASED`/`REJECTED`.

## Rules

Agents MUST follow the process rules in
[CONTRIBUTING.md > Rules](./CONTRIBUTING.md#rules). Re-read them before
creating, transitioning, or merging a proposal, rather than relying on your
memory of a prior state of the rules.

The conventions for writing specification content itself – Gherkin scenarios,
requirement identifiers, the qualities taxonomy, deprecation marking – are
documented where that content lives: see
[`specification/requirements/`](./specification/requirements/) and its
subdirectory READMEs, and [`docs/best-practices.md`](./docs/best-practices.md).
Read and apply these directly when authoring or editing specification
artifacts – authoring is not itself a skill in this repository. The
[`Definition of Ready`](./docs/definition-of-ready.md) states what "ready to
accept" means, verified by [`/accept-spec`](./.agents/skills/accept-spec/SKILL.md).

## References

The following technical standards (TS) govern this project. Fetch and ingest
the relevant standards as-and-when required for the task at hand.

- [**TS-1: Software Requirements Specification**](https://kieranpotts.com/standards/001) \
  Use when writing, reviewing, or evaluating a software requirements
  specification (SRS), acceptance criteria, Gherkin feature files,
  non-functional qualities, or the lifecycle of product proposals.

- [**TS-25: Technical Documentation**](https://kieranpotts.com/standards/025) \
  Use when deciding what documentation a project needs, where it should live,
  who it's for, or whether it's still trustworthy.

- [**TS-26: Technical Writing Style Guide**](https://kieranpotts.com/standards/026) \
  Use when writing or editing the prose of a technical document. Covers
  tone-of-voice, headings, terminology, lists, and citations.

- [**TS-9: Version Control**](https://kieranpotts.com/standards/009) \
  Use when working with Git. Covers commits, branching, merging, integration
  strategies, cutting releases, and configuring Git/PR/CI tooling.

## Skills

The `.agents/skills/` directory provides on-demand skills for managing the
lifecycle of a proposal. See the [README](./.agents/skills/README.md) for
descriptions of the available skills and their triggers.

It is RECOMMENDED to use these skills to drive state transitions.
