# [Project Name] — Software Requirements Specification

## Project overview

This repository holds the software requirements specification (SRS) for [Project Name] — _what_ the system does, defined in business terms. It is documentation, not code: nothing to build, lint, or run.

The SRS is implementation-agnostic. Decisions about _how_ the system is built are recorded separately. It SHOULD be possible to implement the system in any technology stack without changing the specification.

Changes are introduced through proposals. The [specification](./specification/) artifacts on the `main` trunk MUST reflect the current state of the system in production. The [`proposals/`](./proposals/) directory is the permanent archive of how that state was reached.

## Repository structure

- `specification/`: Describes the current production system.
  - `context/`: Problem space and domain model. Descriptive.
    - `overview/`: Mission statement, problem statement, project scope.
    - `constraints/`: Regulatory and legal constraints, dependencies.
    - `glossary/`: The domain's ubiquitous language.
    - `model/`: Domain entities and their relationships.
    - `actors/`: Actors that interact with the system (definitions only — no permissions).
  - `requirements/`: Expected behaviors and qualities. Prescriptive.
    - `behaviors/`: Capabilities exposed and rules enforced.
      - `access/`: Permissions matrix — which actors may exercise which capabilities.
      - `rules/`: Business rules, invariants, entity lifecycles.
      - `features/`: Functional requirements, Gherkin notation.
      - `journeys/`: User journeys – wireframes or call-sequences.
      - `interfaces/`: External contract — the behavioral contract only; wire formats and protocols are technical decisions, recorded in the RFC repository.
    - `qualities/`: Dynamic qualities, aka. non-functional requirements.
- `proposals/`: Permanent archive of every proposed change. Each proposal is a directory (`proposals/<slug>/`) holding its `README.md` and any supporting artifacts.
  - `proposals/INDEX.md` is the numbered catalog of merged proposals.
  - `proposals/TEMPLATE.md` is the starting point for a new proposal.
- `docs/`: General guidelines for humans to get the most out of the SRS process.

## Proposal lifecycle

Each proposal moves through a defined state machine:

- `DRAFT`: The proposal is being written. The pull request is open as a GitHub draft and carries only its type label — there is no `#draft` label; "draft" is the pull request's own draft flag. Not yet ready for review.
- `PROPOSED`: The proposal is complete and open for a decision. The pull request is marked ready for review and labeled `#proposed`. From this point, the author should not make further material changes except in response to reviewer feedback.
- `ACCEPTED`: The proposal is approved and the work is queued for implementation. The discussion thread is closed. The pull request stays open until the implementation reaches production; the document and accompanying specification edits MAY continue to evolve during this period.
- `REJECTED`: The proposal is not being taken forward. Its specification edits are reverted, its number is recorded in `proposals/INDEX.md`, and only the proposal document is merged into `main`, preserved permanently as the record of the decision and its rationale.
- `RELEASED`: The implementation is live in production. The specification edits are merged into `main`, and the proposal is given its number in `proposals/INDEX.md`. A released decision stays in effect until a later proposal supersedes it.
- `SUPERSEDED`: The proposal was previously released but is no longer in effect, because a later released proposal has replaced or removed its feature. This is the only state reachable after RELEASED.

The proposer drives a proposal up to `PROPOSED`; only the product managers take the decision transitions (`ACCEPTED`, `REJECTED`, `RELEASED`, `SUPERSEDED`). Each state transition has a corresponding agent skill (see below), which carries the gate rules for that transition. The possible state transitions are:

- (New proposal) → DRAFT
- DRAFT → PROPOSED
- PROPOSED → ACCEPTED
- PROPOSED → REJECTED
- ACCEPTED → RELEASED
- RELEASED → SUPERSEDED

Transitions not listed above are NOT permitted. A proposal MUST NOT move backwards or skip states.

## Rules

- Write in American English.

- The [specification artifacts](./specification/) on the `main` trunk (the default branch) MUST describe the production system as it exists now. It is the authoritative record of the current state of the system.

- Changes to specification artifacts MUST be introduced via proposal PRs. The specification changes MUST describe the intended final state after the changes are shipped, NOT a changelog of how to get to that end state — that's an implementation detail.

- An accepted proposal MUST NOT be merged into `main` until real users are using the proposed changes in production.

- Functional requirements MUST be specified as Gherkin scenarios. Each scenario MUST be a concrete, testable acceptance criterion.

- Non-functional requirements SHOULD be specified as measurable thresholds, not vague aspirations. Scope is the system's dynamic (runtime, externally-observable) qualities only — not static qualities of the code and design, which are out of scope for the specification.

- Every proposal pull request MUST be labeled with exactly one type — `FEATURE`, `QUALITY`, or `EPIC` — matching the kind of change.

- A `FEATURE` or `QUALITY` proposal MUST be a single, atomic change — one requirement reviewable, decidable, and shippable independently. Author it on a `proposal/<slug>` branch cut from `main`, and open a pull request titled `feature: <description>` or `quality: <description>`. The `<description>` is a short prose title of the proposal, written full lowercase — not the hyphenated branch slug (eg. PR title `feature: time out idle user sessions`, branch `proposal/user-session-timeout`). The slug is used only for the branch name and the proposal directory (`proposals/<slug>/`).

- An `EPIC` proposal spans multiple feature and quality requirements and is used for large-scale initiatives (eg. a greenfield system). Author it on an `epic/<slug>` branch cut from `main`, with a pull request titled `epic: <description>`. Individual feature and quality proposals that are part of an epic reference it via their `Depends on` field.

- Every proposal pull request MUST have an associated discussion thread, opened when the PR is opened (even as a draft) and used for all review feedback. The thread is closed when the proposal is accepted or rejected.

- The current lifecycle state of a proposal is tracked via a lifecycle label on the PR — `#proposed`, `#accepted`, `#rejected`, `#released`, `#superseded`. A pull request is opened initially as a GitHub **draft** while the document is refined; this draft state — not a label — represents work in progress.

- A pull request MUST be opened initially as a draft. The author marks the PR ready for review, and applies the `#proposed` label, once the document and spec edits are complete.

- A proposal MUST NOT be merged into `main` until it has been decided — either released or rejected.

- A sequential number is assigned at merge and recorded in [`proposals/INDEX.md`](./proposals/INDEX.md). The number lives only in the index; no proposal directory is ever renamed.

- Proposal branches MUST be squash-merged to `main`, and the squash commit message MUST take the form `<type>: <description> - RELEASED|REJECTED`, where `<type>` is `feature`, `quality`, or `epic`, and `<description>` is the prose proposal title, not the branch slug (eg. `feature: time out idle user sessions - RELEASED`). Released proposals merge at `#released`; rejected ones at `#rejected`.

- While a proposal PR is open, its document and accompanying spec edits MAY be updated at any point. Once merged into `main` — so after `#released` for accepted proposals, or following the `#rejected` decision for rejected ones — it MUST be treated as immutable. To revisit a decision already merged to `main`, open a new proposal that supersedes the original.

- Never delete a proposal document, including rejected ones.

- The GitHub issue tracker is used only for maintenance work on this repository itself (via the `MAINTENANCE` template). Proposals are proposed, decided, and archived entirely through pull requests; open-ended brainstorming happens in [discussions](https://github.com/kieranpotts/specs/discussions).

## Skills

The [`.agents/skills/`](./.agents/skills/) directory provides on-demand skills for managing the proposal workflow. There's one agent skill per state transition. Each skill carries the gate rules for its own discrete transition.

- [`draft-spec`](./.agents/skills/draft-spec/SKILL.md): Scaffolds a new proposal, opens it as a draft PR with one type label applied, and opens the associated discussion thread.
- [`propose-spec`](./.agents/skills/propose-spec/SKILL.md): Verifies and handles the `DRAFT` → `PROPOSED` transition.
- [`accept-spec`](./.agents/skills/accept-spec/SKILL.md): Verifies and handles the `PROPOSED` → `ACCEPTED` transition. Also closes the discussion thread. The PR stays open through implementation.
- [`reject-spec`](./.agents/skills/reject-spec/SKILL.md): Verifies and handles the `PROPOSED` → `REJECTED` transition. Reverts the spec edits, closes the discussion thread, and squash-merges the document as a permanent record.
- [`release-spec`](./.agents/skills/release-spec/SKILL.md): Verifies and handles the `ACCEPTED` → `RELEASED` transition. Records the number in `INDEX.md` and squash-merges.
- [`supersede-spec`](./.agents/skills/supersede-spec/SKILL.md): Verifies and handles the `RELEASED` → `SUPERSEDED` transition for a released proposal superseded by a later one.
