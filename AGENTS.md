# [Project Name] — Software Requirements Specification

## Project overview

This repository holds the software requirements specification (SRS) for [Project Name] — _what_ the system does, defined in business terms. It is documentation, not code: nothing to build, lint, or run.

The SRS is implementation-agnostic. Decisions about _how_ the system is built are recorded separately. It SHOULD be possible to implement the system in any technology stack without changing the specification.

Changes are introduced through proposals. The [specification](./specification/) artifacts on the `main` trunk MUST reflect the current state of the system in production. The [`proposals/`](./proposals/) directory is the permanent archive of how that state was reached.

## Repository structure

- `specification/`: Describes the current production system.
  - `context/`: Problem space and domain model. Descriptive.
    - `overview/`: Mission statement, problem statement, project scope.
    - `glossary/`: The domain's ubiquitous language.
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
- `proposals/`: Permanent archive of every proposed change. Each proposal is a directory (`proposals/<slug>/`) holding its `README.md` and any supporting artifacts.
  - `TEMPLATE.md`: The starting point for a new proposal.
  - `INDEX.md`: The numbered catalog of merged proposals.

## Rules

The capitalized words REQUIRED, MUST, MUST NOT, RECOMMENDED, SHOULD, SHOULD NOT, OPTIONAL, and MAY, in the context of this document and agent skills/instructions/rules, are to be interpreted as described in [IETF RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

- MUST write everything in American English.

- The [specification artifacts](./specification/) on the `main` trunk (the default branch) MUST describe the production system as it exists now.

- Changes to specification artifacts MUST be introduced via proposal PRs. The specification changes MUST describe the intended final state after the changes are shipped. Proposal PRs MUST NOT specify a changelog of how to get to that end state – that's an implementation detail.

- MUST NOT merge accepted proposals into `main` until real users are using the proposed changes in production.

- MUST specify functional requirements as Gherkin scenarios. Each scenario MUST be a concrete, testable acceptance criterion.

- SHOULD specify non-functional requirements as measurable thresholds, not vague aspirations.

- A proposal MUST be a single atomic change. Author it on a `proposal/<slug>` branch cut from `main`, and open a PR titled `feature: <slug>` or `quality: <slug>`, carrying exactly one type label (`FEATURE` or `QUALITY`).

- Every proposal PR MUST have an associated discussion thread, opened with the PR (even as a draft) and used for all review feedback. Close it when the proposal is accepted or rejected.

- The current lifecycle state of a proposal is tracked via a label on the PR: `#proposed`, `#accepted`, `#rejected`, `#released`, or `#deprecated`. A new PR is opened as a GitHub **draft** while the document is refined; this draft state — not a label — represents work in progress.

- A sequential number is assigned at merge and recorded in [`proposals/INDEX.md`](./proposals/INDEX.md). The number lives only in the index; no proposal directory is ever renamed.

- While a proposal PR is open, its document and accompanying spec edits MAY be updated at any point. Once merged into `main` — so after `#released` for accepted proposals, or following the `#rejected` decision for rejected ones — it MUST be treated as immutable. To revisit a decision already merged to `main`, open a new proposal that supersedes the original.

- Never delete a proposal document, including rejected ones.

- The GitHub issue tracker is used only for repository maintenance (`MAINTENANCE`) and for grouping interdependent proposals (`EPIC`). Proposals run entirely through pull requests; open-ended brainstorming happens in [discussions](https://github.com/kieranpotts/specs/discussions).

## Proposing a change

Every proposal has an associated discussion thread (the channel for all review feedback) and a draft pull request.

1.  Open a [discussion](https://github.com/kieranpotts/specs/discussions) for the proposal's type (Feature or Quality). It MUST exist by the time the PR is opened. Link the discussion and the PR to each other.

2.  Branch off `main` as `proposal/<slug>` (short hyphen-delimited slug, eg. `proposal/user-session-timeout`).

3.  Copy [`proposals/TEMPLATE.md`](./proposals/TEMPLATE.md) to `proposals/<slug>/README.md` and fill it out. Supporting artifacts (wireframes, mock-ups, data) live alongside the `README.md`. Do not assign a numeric ID — that is added to `INDEX.md` at merge.

4.  Edit the [specification artifacts](./specification/) to describe the intended final state after the change ships.

5.  Open the PR **as a GitHub draft**, titled `feature: <slug>` or `quality: <slug>`, with one type label applied. Mark it ready for review and apply `#proposed` once it is complete.

## Proposal lifecycle

Each proposal moves through a state machine. From `proposed` onward, the current state is shown by a lifecycle label on the PR; before that, the proposal is an open **draft** pull request. Only product managers take the decision transitions.

Each state's full meaning, gate conditions, and immutability rules are defined once, canonically, in the [contributing guide](./CONTRIBUTING.md#proposal-lifecycle) — consult it rather than relying on a duplicate here. In brief: `draft` → being refined (a draft PR, no label); `#proposed` → under stakeholder review; `#accepted` → approved and queued for implementation (the PR stays open, discussion closed, spec edits MAY still evolve); `#rejected` → not taken forward (spec edits reverted, only the document merges); `#released` → live in production (spec edits merged); `#deprecated` → a released proposal no longer in effect. The sequential number is assigned in `INDEX.md` at merge — at `#released` or `#rejected`; no directory is ever renamed.

Permitted transitions (any other transition is forbidden — no moving backwards, no skipping states). Each non-manual transition has a skill that verifies its own gates:

| From | To | Skill | Condition |
| --- | --- | --- | --- |
| _(new PR)_ | `draft` | `draft-proposal` | Draft PR opened with scaffolded document, type label, and discussion thread. |
| `draft` | `#proposed` | `propose-proposal` | Document and spec edits complete; PR marked ready for review and labeled `#proposed`. |
| `#proposed` | `#accepted` | `accept-proposal` | Review concluded; approved; discussion closed. |
| `#proposed` | `#rejected` | `reject-proposal` | Review concluded; not taken forward; spec edits reverted; number in `INDEX.md`; merged. |
| `#accepted` | `#released` | `release-proposal` | Implementation shipped to production; number in `INDEX.md`; spec edits merged. |
| `#released` | `#deprecated` | _(manual)_ | Feature removed or superseded by a later proposal. |

## Skills

The [`.agents/skills/`](./.agents/skills/) directory provides on-demand skills for managing the proposal workflow — one per state transition. Each skill carries the gate rules for its own transition.

- [`draft-proposal`](./.agents/skills/draft-proposal/SKILL.md): scaffold a new proposal, open it as a draft PR, and open the associated discussion thread.
- [`propose-proposal`](./.agents/skills/propose-proposal/SKILL.md): `draft → proposed` — verify the document and spec edits are complete, then remove the PR's draft status and apply `#proposed`.
- [`accept-proposal`](./.agents/skills/accept-proposal/SKILL.md): `proposed → accepted` (also closes the discussion thread).
- [`release-proposal`](./.agents/skills/release-proposal/SKILL.md): `accepted → released` — record the number in `INDEX.md` and prepare for merge.
- [`reject-proposal`](./.agents/skills/reject-proposal/SKILL.md): `proposed → rejected` — revert spec edits, record the number, close the discussion, and prepare for merge.
