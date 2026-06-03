# Skills

These on-demand agent skills manage the proposal workflow — one per state transition in the lifecycle (`draft → proposed → accepted → released`, or `proposed → rejected`):

- [`draft-spec`](./draft-spec/): Scaffold a new proposal and open it as a draft pull request, with a type label and a discussion thread.

- [`propose-spec`](./propose-spec/): Remove a PR's draft status, marking the proposal ready for review (`draft → proposed`).

- [`accept-spec`](./accept-spec/): Approve a proposed proposal and close its discussion (`proposed → accepted`). The PR stays open through implementation.

- [`release-spec`](./release-spec/): Once the implementation is live, assign the proposal's number and squash-merge it (`accepted → released`).

- [`reject-spec`](./reject-spec/): Reject a proposed proposal, revert its spec edits, and preserve it permanently as a record (`proposed → rejected`).

Each skill carries the gate rules for its own transition; there is no separate audit step. The `released → deprecated` transition is performed by hand when a later proposal supersedes or removes a feature.

A typical journey runs `/draft-spec` → _(write the proposal)_ → `/propose-spec` → _(stakeholder review)_ → `/accept-spec` → _(implementation)_ → `/release-spec`, or `/reject-spec` if the decision is not to proceed.
