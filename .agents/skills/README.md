# Agent skills

This repository ships a small set of [agent skills](https://agentskills.io/) — invoked as slash commands through agentic tools such as Claude Code — that automate the proposal workflow.

There is one skill per proposal state transition: `DRAFT` → `PROPOSED` → `ACCEPTED` → `RELEASED`, plus `PROPOSED` → `REJECTED` and `RELEASED` → `SUPERSEDED`. Each skill knows the gate rules for its own transition and will not proceed until they are met, which keeps the process consistent whether a human or an agent is driving it.

The skills are, in lifecycle order:

- **[`/draft-spec`](./draft-spec/)**: Scaffolds a new draft proposal, ready for the user to complete. Sets up the branch and proposal document from the template, opens a draft pull request and an associated discussion thread.

- **[`/propose-spec`](./propose-spec/)**: `DRAFT` → `PROPOSED` — Confirms the proposal document and specification edits are complete and free of leftover template text. Applies the `#proposed` label, and takes the pull request out of draft so stakeholders can review it.

- **[`/accept-spec`](./accept-spec/)**: `PROPOSED` → `ACCEPTED` — Verifies the approval gates, sets the document's `Status` to `ACCEPTED`, labels the pull request `#accepted`, and closes the discussion thread. The pull request stays open through implementation until release – it is not merged here.

- **[`/release-spec`](./release-spec/)**: `ACCEPTED` → `RELEASED` — Sets the document's `Status` to `RELEASED`, labels the pull request `#released`, and squash-merges it to `main`. After the merge, the proposal is assigned a unique number and listed in the proposals index – `proposals/INDEX.md`.

- **[`/reject-spec`](./reject-spec/)**: `PROPOSED` → `REJECTED` — Reverts the specification edits, sets the document's `Status` to `REJECTED`, labels the pull request `#rejected`, closes the discussion thread, and squash-merges it to `main`. After the merge, the proposal is given a unique reference number and listed in the proposals index.

- **[`/supersede-spec`](./supersede-spec/)**: `RELEASED` → `SUPERSEDED` — Marks a released proposal as retired once a newer proposal has replaced or overridden it. Sets up cross-references between the two.

A typical journey runs `/draft-spec` → the user writes the proposal → `/propose-spec` → stakeholder review → `/accept-spec` (or `/reject-spec` if the decision is not to proceed) → implementation → `/release-spec`. Much later, `/supersede-spec` retires a feature that a newer proposal has replaced.
