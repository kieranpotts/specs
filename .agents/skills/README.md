# Agent skills

This repository ships a small set of [agent skills](https://agentskills.io/) —
invoked as slash commands through agentic tools such as Claude Code — that
automate the proposal workflow.

There is one skill per proposal state transition: `DRAFT` → `PROPOSED` →
`ACCEPTED` → `RELEASED`, plus `PROPOSED` → `REJECTED` and `RELEASED` →
`SUPERSEDED`. Each skill knows the gate rules for its own transition and will
not proceed until they are met, which keeps the process consistent whether a
human or an agent is driving it.

Alongside these lifecycle skills, one **content skill** –
[`/write-spec`](./write-spec/) – owns *what the specification contains and how
it is written* (the Gherkin conventions, measurable-threshold forms, and the
Definition of Ready), rather than a state transition. It is the agent-facing
home of the project's specification-content rules, and the place to tune them.

The lifecycle skills are, in order:

- **[`/draft-spec`](./draft-spec/):** Scaffolds a new draft proposal, ready for
  the user to complete. Sets up the branch and proposal document from the
  template, opens a draft pull request and an associated discussion thread.

- **[`/propose-spec`](./propose-spec/):** `DRAFT` → `PROPOSED` — Confirms the
  proposal document and specification edits are complete and free of leftover
  template text. Applies the `#proposed` label, and takes the pull request out
  of draft so stakeholders can review it.

- **[`/accept-spec`](./accept-spec/):** `PROPOSED` → `ACCEPTED` — Verifies the
  approval gates, sets the document's `Status` to `ACCEPTED`, and labels the
  pull request `#accepted`. The pull request and its discussion thread stay open
  through implementation until release – it is not merged here.

- **[`/release-spec`](./release-spec/):** `ACCEPTED` → `RELEASED` — Sets the
  document's `Status` to `RELEASED`, labels the pull request `#released`,
  squash-merges it to `main`, and closes the discussion thread. After the merge,
  the proposal is assigned a unique number and listed in the proposals index –
  `proposals/INDEX.md`.

- **[`/reject-spec`](./reject-spec/):** `PROPOSED` → `REJECTED` — Reverts the
  specification edits, sets the document's `Status` to `REJECTED`, labels the
  pull request `#rejected`, closes the discussion thread, and squash-merges it
  to `main`. After the merge, the proposal is given a unique reference number
  and listed in the proposals index.

- **[`/supersede-spec`](./supersede-spec/):** `RELEASED` → `SUPERSEDED` — Marks
  a released proposal as retired once a newer proposal has replaced or
  overridden it. Sets up cross-references between the two.

And the content skill:

- **[`/write-spec`](./write-spec/):** Authors and edits the specification
  artifacts for a proposal – functional requirements as testable Gherkin
  acceptance criteria, non-functional requirements as measurable thresholds –
  and checks them against the Definition of Ready. Used during `DRAFT`, after
  scaffolding, to write the actual specification edits.

A typical journey runs `/draft-spec` → `/write-spec` to write the proposal →
`/propose-spec` → stakeholder review → `/accept-spec` (or `/reject-spec` if the
decision is not to proceed) → implementation → `/release-spec`. Much later,
`/supersede-spec` retires a feature that a newer proposal has replaced.
