# Propose proposal

Marks a proposal pull request ready for stakeholder review (draft → proposed).

## What it does

Confirms the proposal document and specification edits are complete and free of leftover template text, sets `Last updated`, applies the `#proposed` label, and removes the pull request's draft status so stakeholders can review it.

## How to invoke

```
/propose-proposal
```

Optionally name the proposal or PR number:

```
/propose-proposal user-session-timeout
/propose-proposal 42
```

## Examples

- `/propose-proposal`: Verifies the most recent proposal in context, then marks its PR ready.

- `/propose-proposal 42`: Verifies and proposes the proposal on PR #42.
