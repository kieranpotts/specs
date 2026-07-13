# [Project Name] – Software Requirements Specification

The capitalized words REQUIRED, MUST, MUST NOT, RECOMMENDED, SHOULD, SHOULD NOT,
OPTIONAL, and MAY are to be interpreted as described in [IETF RFC
2119](https://www.ietf.org/rfc/rfc2119.txt).

## Project overview

This repository holds the software requirements specification (SRS) for [Project
Name] – _what_ the system does, defined in business terms. It is documentation,
not code. There's nothing to build, lint, or run.

The SRS is implementation-agnostic. Decisions about _how_ the system is built
are recorded separately. It SHOULD be possible to implement the system in any
technology stack without changing the specification.

Changes are introduced through proposals. The [specification](./specification/)
artifacts on the `main` trunk MUST reflect the current state of the system in
production. The [`proposals/`](./proposals/) directory is the permanent archive
of how that state was reached.

## Project structure

- **`specification/`**:
  Describes the current production system.

  - **`context/`**:
    Problem space and domain model. Descriptive.

    - **`overview/`**:
      Mission statement, problem statement, project scope.

    - **`constraints/`**:
      Regulatory and legal constraints, dependencies.

    - **`glossary/`**:
      The domain's ubiquitous language.

    - **`model/`**:
      Domain entities and their relationships.

    - **`actors/`**:
      Actors that interact with the system (definitions only – no permissions).

  - **`requirements/`**:
    Expected behaviors and qualities. Prescriptive.

    - **`behaviors/`**:
      Capabilities exposed and rules enforced.

      - **`access/`**:
        Permissions matrix – which actors have which capabilities.

      - **`rules/`**:
        Business rules, invariants, entity lifecycles.

      - **`features/`**:
        Functional requirements, Gherkin notation.

      - **`journeys/`**:
        User journeys – wireframes or call-sequences.

      - **`interfaces/`**:
        External behavioral contracts.

    - **`qualities/`**:
      Dynamic qualities, aka. non-functional requirements.

- **`proposals/`**:
  Permanent archive of every proposed change. Each proposal is a directory
  (`proposals/<slug>/`) holding its `README.md` and any supporting artifacts.

  - **`proposals/INDEX.md`** is the numbered catalog of merged proposals.

  - **`proposals/TEMPLATE.md`** is the starting point for a new proposal.

  - **`proposals/<slug>/product-requirements.md`**, when present, is the
    originating product-requirements document (PRD) — the business-language
    statement of need this proposal was specified from, preserved verbatim and
    linked from the proposal's `Origin` field. It is a frozen origin record:
    immutable once written, even while the proposal itself evolves. A proposal
    specified directly, with no PRD, omits it.

- **`docs/`**:
  General guidelines for humans to get the most out of the SRS process.

## Proposal lifecycle

Each proposal moves through a defined state machine:

- **`DRAFT`**: The proposal is being written. The pull request is open as draft
  and carries only its type label, eg. `FEATURE`. Not yet ready for review.

- **`PROPOSED`**: The proposal is complete and open for a decision. The pull
  request is marked ready for review and labeled `#proposed`. From this point,
  the author should not make further material changes except in response to
  reviewer feedback.

- **`ACCEPTED`**: The proposal is approved and the work is queued for
  implementation. The pull request stays open until the implementation reaches
  production. The proposal document and accompanying specification edits MAY
  continue to evolve during the implementation period, with feedback continuing
  on the still-open discussion thread.

- **`REJECTED`**: The proposal is not being taken forward. Its specification
  edits are reverted, and only the proposal document is merged into `main`,
  preserved permanently as the record of the decision and its rationale. After
  the merge, its number is recorded in `proposals/INDEX.md`.

- **`RELEASED`**: The implementation is live in production. The specification
  edits are merged into `main`, and after the merge the proposal is given its
  number in `proposals/INDEX.md`. A released decision stays in effect until a
  later proposal supersedes it.

- **`SUPERSEDED`**: The proposal was previously released but is no longer in
  effect, because a later released proposal has replaced or removed its feature.

The only allowed state transitions are:

- (New proposal) → DRAFT
- DRAFT → PROPOSED
- PROPOSED → ACCEPTED
- PROPOSED → REJECTED
- ACCEPTED → RELEASED
- RELEASED → SUPERSEDED

Transitions not listed above are NOT permitted. A proposal MUST NOT move
backwards or skip states.

## Rules

- Write in American English.

- The [specification artifacts](./specification/) on the `main` trunk (the
  default branch) MUST describe the production system as it exists now. It is
  the authoritative record of the current state of the system.

- Changes to specification artifacts MUST be introduced via proposal PRs. The
  specification changes MUST describe the intended final state after the changes
  are shipped, NOT a changelog of how to get to that end state – that's an
  implementation detail.

- A proposal MUST NOT be accepted unless its requirement meets the
  [Definition of
  Ready](./.agents/skills/write-spec/references/definition-of-ready.md). A
  sound-but-incomplete proposal is sent back for refinement, not accepted.

- An accepted proposal MUST NOT be merged into `main` until real users are using
  the proposed changes in production.

- Functional requirements MUST be specified as Gherkin scenarios. Each scenario
  MUST be a concrete, testable acceptance criterion.

- Non-functional requirements SHOULD be specified as measurable thresholds, not
  vague aspirations. Scope is the system's dynamic (runtime,
  externally-observable) qualities only – not static qualities of the code and
  design, which are out of scope for the specification.

- The detailed rules for *writing* the specification content – the Gherkin
  conventions, the measurable-threshold forms, and the problem-not-solution
  discipline – are owned by the
  [`/write-spec`](./.agents/skills/write-spec/SKILL.md) skill, which applies the
  the [Definition of
  Ready](./.agents/skills/write-spec/references/definition-of-ready.md). Apply
  `/write-spec` when authoring or editing specification artifacts. A project
  tunes its content standards by editing that skill.

- Every proposal pull request MUST be labeled with exactly one type –
  `FEATURE`, `QUALITY`, or `EPIC` – matching the kind of change.

- A `FEATURE` or `QUALITY` proposal MUST be a single, atomic change – one
  requirement reviewable, decidable, and shippable independently. Author it on a
  `proposal/<slug>` branch cut from `main`, and open a pull request titled
  `feature: <description>` or `quality: <description>`. The `<description>` is a
  short prose title of the proposal, written full lowercase – not the hyphenated
  branch slug (eg. PR title `feature: time out idle user sessions`, branch
  `proposal/user-session-timeout`). The slug is used only for the branch name
  and the proposal directory (`proposals/<slug>/`).

- An `EPIC` proposal spans multiple feature and quality requirements and is
  used for large-scale initiatives (eg. a greenfield system). Author it on an
  `epic/<slug>` branch cut from `main`, with a pull request titled `epic:
  <description>`. Individual feature and quality proposals that are part of an
  epic reference it via their `Depends on` field.

- Every proposal pull request MUST have an associated discussion thread,
  opened when the PR is opened (even as a draft) and used for all review
  feedback. The thread is closed when the PR is merged.

- The current lifecycle state of a proposal is tracked via a lifecycle label
  on the PR – `#proposed`, `#accepted`, `#rejected`, `#released`, `#superseded`.
  A pull request is opened initially as a draft while the document is refined.

- A pull request MUST be opened initially as a draft. The author marks the PR
  ready for review, and applies the `#proposed` label, once the document and
  spec edits are complete.

- A proposal MUST NOT be merged into `main` until it has been decided –
  either released or rejected.

- A sequential number is assigned after merge and recorded in
  [`proposals/INDEX.md`](./proposals/INDEX.md), in a direct-to-`main` commit.
  The number lives only in the index.

- Proposal branches MUST be squash-merged to `main`, and the squash commit
  message MUST take the form `<type>: <description> - RELEASED|REJECTED`, where
  `<type>` is `feature`, `quality`, or `epic`, and `<description>` is the prose
  proposal title, not the branch slug (eg. `feature: time out idle user sessions
  - RELEASED`). Released proposals merge at `#released`; rejected ones at
  `#rejected`.

- While a proposal PR is open, its document and accompanying spec edits MAY be
  updated at any point. Once merged into `main` – so after `#released` for
  accepted proposals, or following the `#rejected` decision for rejected ones –
  it MUST be treated as immutable. To revisit a decision already merged to
  `main`, open a new proposal that supersedes the original.

- The preserved `product-requirements.md` (the `Origin` PRD) is immutable from
  the moment it is written – stricter than the proposal document, which stays
  editable while the PR is open. It records the requirement *as it arrived,
  before specification*; refining it would destroy that. Capture any change of
  understanding in the proposal `README.md` or the spec edits, never by editing
  the preserved PRD.

- Never delete a proposal document, including rejected ones.

- The GitHub issue tracker is used only for maintenance work on this repository
  itself (via the `MAINTENANCE` template). Proposals are proposed, decided, and
  archived entirely through pull requests; open-ended brainstorming happens in
  [discussions](https://github.com/kieranpotts/specs/discussions).

## Skills

The [`.agents/skills/`](./.agents/skills/) directory provides on-demand skills
for managing the proposal workflow. See the [README](./.agents/skills/README.md)
for descriptions of the available skills
