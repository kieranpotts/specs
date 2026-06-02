# [Project Name] — Software Requirements Specification

## Project overview

This repository holds the software requirements specification (SRS) for [Project Name] — _what_ the system does, defined in business terms. It is documentation, not code: nothing to build, lint, or run.

The SRS is implementation-agnostic. Decisions about _how_ the system is built are recorded separately. It SHOULD be possible to implement the system in any technology stack without changing the specification.

Changes are introduced through proposals. The [specification](./specification/) artifacts on the `main` trunk MUST reflect the current state of the system in production. The [`proposals/`](./proposals/) directory is the permanent archive of how that state was reached.

## Repository structure

- `specification/`: Describes the current production system.
  - `context/`: Problem space and domain model. Descriptive.
    - `overview/`: Mission statement, problem statement, project scope.
    - `glossary/`: The domains's ubiquitous language.
    - `model/`: Domain entities and their relationships.
    - `actors/`: Actors that interact with the system.
    - `constraints/`: Regulatory and legal constraints, dependencies.
  - `requirements/`: Expected behaviors and qualities. Prescriptive.
    - `behaviors/`: Capabilities exposed and rules enforced.
      - `features/`: Functional requirements, Gherkin notation.
      - `rules/`: Business rules, invariants, entity lifecycles.
      - `access/`: Permissions matrix.
      - `interfaces/`: External contract, including events.
      - `journeys/`: User journeys – wireframes or call-sequences.
    - `qualities/`: Non-functional requirements.
- `proposals/`: Permanent archive of every proposed change.
  - `TEMPLATE.md`: The starting point for a new proposal.

## Rules

The capitalized words REQUIRED, MUST, MUST NOT, RECOMMENDED, SHOULD, SHOULD NOT, OPTIONAL, and MAY, in the context of this document and agent skills/instructions/rules, are to be interpreted as described in [IETF RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

- MUST write everything in American English.

- The [specification artifacts](./specification/) on the `main` trunk (the default branch) MUST describe the production system as it exists now.

- Changes to specification artifacts MUST be introduced via proposal PRs. The specification changes MUST describe the intended final state after the changes are shipped. Proposal PRS MUST NOT specify a changelog of how to get to that end state – that's an implementation detail.

- MUST NOT merge accepted proposals into `main` until real users are using the proposed changes in production.

- MUST specify functional requirements as Gherkin scenarios. Each scenario MUST be a concrete, testable acceptance criterion.

- SHOULD specify non-functional requirements as measurable thresholds, not vague aspirations.

- A proposal MUST be a single atomic change.

- The current lifecycle state of a proposal is tracked via a label on the PR: `#draft`, `#proposed`, `#accepted`, `#rejected`, `#released`, or `#deprecated`.

- While a proposal PR is open, its document and accompanying spec edits MAY be updated at any point. Once a proposal document is merged into `main` — so after `#released` for accepted proposals, or following the `#rejected` decision for rejected ones – it MUST be treated as immutable. To revisit a decision already merged to `main`, open a new proposal that supersedes the original.

- Never delete a proposal document, including rejected ones.

## Proposing a change

<!--

Author it on a `proposal/[description]` branch cut from `main`, and open a PR titled `feature: [description]` or `quality: [description]`. A GitHub issue (labelled `FEATURE` or `QUALITY`) MAY be opened first for early triage; if so, close it when the PR is opened and link the two via the `Issue` field.

-->

A proposer MAY first open a GitHub issue (labelled `FEATURE` or `QUALITY`) for early triage, and MAY open a [discussion](https://github.com/kieranpotts/specs/discussions) for open-ended brainstorming. Both are optional. If an issue is opened first, close it when the PR is opened and link the two via the `Issue` field. Discussions opened alongside an issue MUST be cross-referenced with it.

To open a proposal:

1.  Branch off `main` as `proposal/[description]` (short hyphen-delimited slug, eg. `proposal/user-session-timeout`).

2.  Copy [`proposals/TEMPLATE.md`](./proposals/TEMPLATE.md) to `proposals/[description].md` and fill it out. Do not assign a numeric ID — the product managers do that at merge time.

3.  Edit the [specification artifacts](./specification/) to describe the intended final state after the change ships.

4.  Open a PR titled `feature: [description]` or `quality: [description]`. Label it `#draft` while still being refined, or `#proposed` when ready for stakeholder review.

## Proposal lifecycle

Each proposal moves through a state machine tracked by a label on its PR. Only product managers advance state.

State meanings:

- `#draft`: PR opened, proposal still being refined. Proposer MAY solicit early feedback.

- `#proposed`: Document complete and under formal stakeholder review. No further material changes SHOULD be made unless requested by the product managers.

- `#accepted`: Approved. A sequential ID is assigned, implementation tickets are opened in the relevant code repositories, and the PR stays open until shipped. Document and spec edits MAY continue to evolve in response to feedback from technical stakeholders, implementation discoveries, or beta/staged-rollout feedback from real users.

- `#rejected`: Will not be taken forward. Spec edits MUST be reverted before merging — only the proposal document is added to `main`, preserving the decision and rationale.

- `#released`: Implementation is live in production. Spec edits are merged into `main`.

- `#deprecated`: A previously released proposal no longer in effect, eg. superseded by a later proposal.

Permitted transitions (any other transition is forbidden — no moving backwards, no skipping states):

| From | To | Condition |
| --- | --- | --- |
| _(new PR)_ | `#draft` | PR opened but still in draft. |
| _(new PR)_ | `#proposed` | PR opened, ready for review. |
| `#draft` | `#proposed` | Document and spec edits complete, ready for review. |
| `#proposed` | `#accepted` | Review concluded; approved. |
| `#proposed` | `#rejected` | Review concluded; not taken forward. |
| `#accepted` | `#released` | Implementation shipped to production. |
| `#released` | `#deprecated` | Feature removed or superseded. |

## Skills

Skills for managing the proposal workflow:

- [`draft-proposal`](./skills/draft-proposal/SKILL.md): Scaffold a new proposal branch and document.
- [`check-proposal`](./skills/check-proposal/SKILL.md): Audit a proposal for completeness and process compliance before advancing it.
- [`advance-proposal`](./skills/advance-proposal/SKILL.md): Transition a proposal to the next permitted lifecycle state.
- [`reject-proposal`](./skills/reject-proposal/SKILL.md): Handle the rejection path — revert spec edits and prepare the PR for merge.
- [`index-proposals`](./skills/index-proposals/SKILL.md): Regenerate the index table in `proposals/README.md`.
