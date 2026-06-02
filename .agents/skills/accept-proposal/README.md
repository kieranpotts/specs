# Accept proposal

Approves a proposed proposal (proposed → accepted).

## What it does

Verifies the approval gates, sets the document to `ACCEPTED` (filling in `Approvers` and `Approval date`), swaps the `#proposed` label for `#accepted`, and closes the associated discussion thread. The pull request **stays open** through implementation; no number is assigned until release.

## How to invoke

```
/accept-proposal
```

Optionally name the proposal or PR number:

```
/accept-proposal user-session-timeout
/accept-proposal 42
```

## Examples

- `/accept-proposal`: Verifies the gates for the proposal in context and accepts it.

- `/accept-proposal 42`: Accepts the proposal on PR #42 after its gates pass.
