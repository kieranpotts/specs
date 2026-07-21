---
name: write-spec
description: >-
  Author or edit the specification artifacts for a proposal – functional
  requirements as testable Gherkin acceptance criteria, non-functional
  requirements as measurable thresholds – and check them against the
  Definition of Ready. Use when writing the specification edits for a
  proposal, not when transitioning its lifecycle state.
license: MIT
metadata:
  interactive: yes
---

# Write spec

Use this skill to author or edit the content of the specification artifacts in
the [`specification/`](../../../specification/) directory: the functional and
non-functional requirements a proposal introduces or changes. It owns *what the
specification should contain and how it is written*. It is the authoring
counterpart to the lifecycle skills, which own *how a proposal moves through its
states*.

Do NOT use this skill to scaffold, advance, or merge a proposal. To start one,
use [`/scaffold-spec`](../scaffold-spec/SKILL.md); to transition its state, use
[`/propose-spec`](../propose-spec/SKILL.md),
[`/accept-spec`](../accept-spec/SKILL.md),
[`/release-spec`](../release-spec/SKILL.md),
[`/reject-spec`](../reject-spec/SKILL.md), or
[`/supersede-spec`](../supersede-spec/SKILL.md).

**Input:** The requirement to specify — REQUIRED, either from the user's
description or the proposal document already scaffolded on the current
`proposal/<slug>` branch.

**Output:** Specification artifacts written or edited under
[`specification/`](../../../specification/), checked against the Definition
of Ready.

This skill is the authoritative, agent-facing source for the project's
specification-content rules. A project MAY adjust these rules to its own
standards by editing this skill. Anything an agent needs in order to write a
conforming specification lives here or in [`AGENTS.md`](../../../AGENTS.md) –
not in the human-facing `docs/`.

## Instructions

1.  **Place each requirement in the right part of `specification/`.**

    The specification separates the descriptive problem space (`context/`) from
    the prescriptive requirements (`requirements/`):

    - Functional requirements → `specification/requirements/behaviors/`:
      `features/` (Gherkin), `rules/` (business rules, invariants, lifecycles),
      `access/` (the permissions matrix), `journeys/` (user journeys),
      `interfaces/` (external contracts).
    - Non-functional requirements → `specification/requirements/qualities/`.
    - Supporting context (new domain terms, entities, or actors the requirement
      introduces) → `specification/context/`: `glossary/`, `model/`, `actors/`.

2.  **Write functional acceptance criteria in Gherkin.**

    Each functional requirement is one or more concrete, testable acceptance
    criteria in Gherkin:

    ```feature
    Feature: <short description>
      In order to <realize some value>
      As a <user type>
      I want to <achieve some goal>

      Scenario: <determinable situation>
        Given <state or precondition>
         And <state or precondition>
        When <event or action>
        Then <expected outcome>
         And <expected outcome>
    ```

    Rules:

    - One `.feature` file per feature (or per aspect of a feature).
    - Aim for ≤5 steps per scenario; ≤2 `When` steps.
    - Use `Background:` to factor out repeated `Given` steps.
    - Use `Scenario Outline:` + `Examples:` for variable-driven business rules –
      but only when the rule itself varies, not for UI permutations.
    - Steps describe observable outcomes (a report, a UI repaint, a response, a
      state change visible to the user) – NOT internal state.
    - Cover the unhappy paths – empty results, not-found, unauthorized – not
      just the happy path.

3.  **Write non-functional requirements as measurable thresholds.**

    Each NFR MUST name a metric, a target, and the conditions it holds under.
    Each is either:

    - A *quantitative metric* with a target (eg. "p99 latency under 200ms at
      1000 concurrent users", "99.9% uptime", "MTTR under 15 minutes"), OR
    - *Conformance to a published standard* (eg. AES-256 at rest, TLS 1.3 in
      transit, WCAG 2.2 AA, GDPR Article 32), OR
    - *A user-story-style requirement* for security/authorization concerns (eg.
      "As an admin, I can revoke a user's session so that...").

    A quality that cannot be measured cannot be verified. Reject vague
    aspirations ("must be fast", "should be secure"). The scope is the system's
    *dynamic* (runtime, externally-observable) qualities only – not static
    qualities of the code and design, which belong to the design documentation,
    not the specification.

4.  **Write the edits as the final state, not a diff.**

    The specification on `main` describes the production system as it exists. A
    proposal's edits describe the system as it *will* exist once the change
    ships – in the present tense, as if already live. Do NOT write "we will
    add…", "currently X, changing to Y", or a changelog of steps. The diff
    against `main` already shows what is changing.

5.  **Check against the Definition of Ready.**

    Before the specification edits are complete, confirm they satisfy every
    criterion in the [Definition of Ready](./references/definition-of-ready.md)
    – the canonical readiness checklist, also verified by
    [`/accept-spec`](../accept-spec/SKILL.md) at the `PROPOSED` → `ACCEPTED`
    gate. In summary: the requirements are clear and unambiguous, functional
    acceptance criteria are testable Gherkin scenarios, quality requirements are
    measurable thresholds, the stakeholders are known, and the work is
    independent and implementable in small increments. Read the reference for
    the full criteria, and report any unmet one as a specific gap.

6.  **Hand off to [`/propose-spec`](../propose-spec/SKILL.md).**

    Once the specification content is authored and meets the Definition of
    Ready, the proposal is ready to leave `DRAFT`. Direct the user to
    [`/propose-spec`](../propose-spec/SKILL.md), which verifies completeness and
    marks the pull request ready for stakeholder review. (If the proposal has
    not yet been scaffolded – no branch, document, or draft PR – use
    [`/scaffold-spec`](../scaffold-spec/SKILL.md) first.)

## Rules

-   **Specify the problem, not the solution.**

    Acceptance criteria describe user needs and outcomes. They MUST NOT
    prescribe implementation: no class names, no API endpoints, no database
    tables, no framework choices. The specification is implementation-agnostic –
    it SHOULD be possible to build the system in any technology stack without
    changing it. Decisions about *how* the system is built belong in the RFC
    archive, not here.

-   **Use domain language, not technical jargon.**

    The specification is a contract with business stakeholders. Use the
    vocabulary of the business domain (customer, order, refund, dosage, invoice)
    – not the vocabulary of the codebase (entity, repository, DTO, controller).
    Keep to the project's ubiquitous language.

-   **Assert on observable outcomes, not internal state.**

    `Then` steps assert on outputs the user can observe: rendered UI, API
    responses, logged messages, command output, state visible in a downstream
    report. Assertions on database rows, queue contents, or in-memory structures
    couple the specification to the implementation.

-   **Bundle authorization into functional requirements.**

    Permissions and roles ("As an admin, I can...") belong in the functional
    specification – as user stories in `behaviors/`, and in the `access/`
    permissions matrix – not in the non-functional `qualities/`. Encryption,
    audit logging, and compliance-driven constraints are non-functional and
    belong in `qualities/`.

-   **The DoR is generic by design.**

    The Definition-of-Ready criteria apply to any proposal regardless of
    subject, and judge the readiness of the *requirements* – not of a design or
    a delivery plan, which are out-of-scope for the specification.

## Success criteria

- Every functional requirement is expressed as one or more testable Gherkin
  scenarios, covering unhappy paths, with no implementation detail (no class,
  file, endpoint, table, or framework name).

- Every non-functional requirement names a metric, a target, and its conditions,
  and concerns a dynamic runtime quality only.

- The edits read as a description of the final shipped state, in the present
  tense – not a changelog.

- Each artifact sits in the correct `specification/` subdirectory, and any new
  domain terms, entities, or actors are reflected in `context/`.

- The specification edits satisfy every Definition-of-Ready criterion, or each
  unmet criterion is reported as a specific gap.

- Once the content is complete, the user has been directed to
  [`/propose-spec`](../propose-spec/SKILL.md) to mark the proposal ready for
  review.

## References

- [`references/definition-of-ready.md`](./references/definition-of-ready.md):
  The canonical readiness checklist applied in step 5. Read it before declaring
  the specification edits complete.

- [AGENTS.md](../../../AGENTS.md): The repository's agent-facing rules and the
  proposal lifecycle this content feeds into.

- [`/scaffold-spec`](../scaffold-spec/SKILL.md): Scaffolds the proposal and identifies
  which `specification/` files to edit; hands off to this skill for the
  authoring.

- [`/accept-spec`](../accept-spec/SKILL.md): Verifies the Definition of Ready at
  the `PROPOSED` → `ACCEPTED` gate.
