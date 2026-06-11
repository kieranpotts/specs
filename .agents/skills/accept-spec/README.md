# Accept proposal

Approves a proposed proposal (`PROPOSED` → `ACCEPTED`).

## What it does

Verifies the approval gates, sets the document to `ACCEPTED` (filling in `Decided by` and `Decision date`), swaps the `#proposed` label for `#accepted`, and closes the associated discussion thread. The pull request **stays open** through implementation; no number is assigned until release.

## How to invoke

```
/accept-spec
```

Optionally name the proposal or PR number:

```
/accept-spec user-session-timeout
/accept-spec 42
```

## Examples

- `/accept-spec`: Verifies the gates for the proposal in context and accepts it.

- `/accept-spec 42`: Accepts the proposal on PR #42 after its gates pass.
