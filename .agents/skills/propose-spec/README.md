# Propose proposal

Marks a proposal pull request ready for stakeholder review (draft → proposed).

## What it does

Confirms the proposal document and specification edits are complete and free of leftover template text, sets `Last updated`, applies the `#proposed` label, and removes the pull request's draft status so stakeholders can review it.

## How to invoke

```
/propose-spec
```

Optionally name the proposal or PR number:

```
/propose-spec user-session-timeout
/propose-spec 42
```

## Examples

- `/propose-spec`: Verifies the most recent proposal in context, then marks its PR ready.

- `/propose-spec 42`: Verifies and proposes the proposal on PR #42.
