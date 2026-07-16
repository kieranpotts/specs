# Propose spec

Marks a proposal pull request ready for stakeholder review (`DRAFT` →
`PROPOSED`).

## What it does

- Confirms the proposal document and specification edits are complete and free
  of leftover template text.
- Sets `Last updated`.
- Applies the `#proposed` label.
- Removes the pull request's draft status so stakeholders can review it.

## How to invoke

> Propose user-session-timeout

> Propose 42

## Examples

- `/propose-spec`: Verifies the most recent proposal in context, then marks its
  PR ready.

- `/propose-spec 42`: Verifies and proposes the proposal on PR #42.

Once the proposal is `PROPOSED` and stakeholders have reviewed it, the decision
is made with [`/accept-spec`](../accept-spec/README.md) (to move it to
`ACCEPTED`) or [`/reject-spec`](../reject-spec/README.md) (if it will not be
taken forward).
