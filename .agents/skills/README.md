# Skills

This repository ships a small set of [agent skills](https://agentskills.io/) — invoked as slash commands through agentic tools such as Claude Code — that automate the proposal workflow.

There is one skill per proposal state transition: `DRAFT` → `PROPOSED` → `ACCEPTED` → `RELEASED`, plus `PROPOSED` → `REJECTED` and `RELEASED` → `SUPERSEDED`. Each skill knows the gate rules for its own transition and will not proceed until they are met, which keeps the process consistent whether a human or an agent is driving it.

The skills are, in lifecycle order:

- **[`/draft-spec`](./draft-spec/)**: Starts a new proposal as a `DRAFT` — scaffolds the branch and document from the template, opens a draft pull request with one type label applied, and opens the associated discussion thread — ready for you to complete.

- **[`/propose-spec`](./propose-spec/)**: `DRAFT` → `PROPOSED` — confirms the proposal document and specification edits are complete and free of leftover template text, applies the `#proposed` label, and takes the pull request out of draft so stakeholders can review it.

- **[`/accept-spec`](./accept-spec/)**: `PROPOSED` → `ACCEPTED` — verifies the approval gates, sets the document's `Status` to `ACCEPTED`, labels the pull request `#accepted`, and closes the discussion thread. The pull request stays open through implementation until release.

- **[`/release-spec`](./release-spec/)**: `ACCEPTED` → `RELEASED` — once the implementation is live in production, assigns the proposal's number in `INDEX.md`, sets `Status` to `RELEASED`, labels the pull request `#released`, and squash-merges it (on your confirmation).

- **[`/reject-spec`](./reject-spec/)**: `PROPOSED` → `REJECTED` — records the rejection: reverts the specification edits, assigns the proposal's number in `INDEX.md`, sets `Status` to `REJECTED`, labels the pull request `#rejected`, closes the discussion thread, and squash-merges the document (on your confirmation) as a permanent record.

- **[`/supersede-spec`](./supersede-spec/)**: `RELEASED` → `SUPERSEDED` — marks a released proposal as retired once a later (`RELEASED`) proposal has replaced or removed its feature, and sets up cross-references between the two.

A typical journey runs `/draft-spec` → you write the proposal → `/propose-spec` → stakeholder review → `/accept-spec` → implementation → `/release-spec`, or `/reject-spec` if the decision is not to proceed. Much later, `/supersede-spec` retires a feature that a newer proposal has replaced.
