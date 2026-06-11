# Propose proposal

Marks a proposal pull request ready for stakeholder review (`DRAFT` → `PROPOSED`).

## What it does

- Confirms the proposal document and specification edits are complete and free of leftover template text.
- Sets `Last updated`.
- Applies the `#proposed` label.
- Removes the pull request's draft status so stakeholders can review it.

## How to invoke

```
/propose-spec
```

The agent will determine the target from the current checked-out branch, else if will prompt you for more information. Alternatively, you can specify the proposal's slug or PR number:

```
/propose-spec user-session-timeout
/propose-spec 42
```

Alternatively, describe the proposal and let the agent look it up.

```
/propose-spec user session timeout
```

## Examples

- `/propose-spec`: Verifies the most recent proposal in context, then marks its PR ready.

- `/propose-spec 42`: Verifies and proposes the proposal on PR #42.
