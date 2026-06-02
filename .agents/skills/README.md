# Skills

These on-demand agent skills manage the proposal workflow — one per state transition in the lifecycle (`draft → proposed → accepted → released`, or `proposed → rejected`):

- [`draft-proposal`](./draft-proposal/): Scaffold a new proposal and open it as a draft pull request, with a type label and a discussion thread.

- [`propose-proposal`](./propose-proposal/): Remove a PR's draft status, marking the proposal ready for review (`draft → proposed`).

- [`accept-proposal`](./accept-proposal/): Approve a proposed proposal and close its discussion (`proposed → accepted`). The PR stays open through implementation.

- [`release-proposal`](./release-proposal/): Once the implementation is live, assign the proposal's number and prepare it for merge (`accepted → released`).

- [`reject-proposal`](./reject-proposal/): Reject a proposed proposal, revert its spec edits, and preserve it permanently as a record (`proposed → rejected`).

Each skill carries the gate rules for its own transition; there is no separate audit step. The `released → deprecated` transition is performed by hand when a later proposal supersedes or removes a feature.

A typical journey runs `/draft-proposal` → _(write the proposal)_ → `/propose-proposal` → _(stakeholder review)_ → `/accept-proposal` → _(implementation)_ → `/release-proposal`, or `/reject-proposal` if the decision is not to proceed.
