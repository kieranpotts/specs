# `/accept-spec`

Approves a proposed proposal (`PROPOSED` → `ACCEPTED`).

## What it does

Verifies the approval gates, sets the document to `ACCEPTED` (filling in
`Decided by` and `Decision date`), and swaps the `#proposed` label for
`#accepted`. The pull request **stays open** through implementation, and so does
the discussion thread — it is closed when the PR is merged at release. No number
is assigned until release.

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
