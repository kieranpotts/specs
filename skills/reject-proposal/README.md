# Reject proposal

Handles the rejection path for a proposal: reverts specification section edits, updates the proposal document status, and prepares the pull request for merge.

## What it does

Confirms the rejection decision, runs a pre-rejection audit, reverts all `specification/` changes introduced by the proposal branch (leaving only the proposal document), applies the `#rejected` label, and commits everything ready for merge into `main`.

## How to invoke

```
/reject-proposal
```

Optionally name the proposal:

```
/reject-proposal user-session-timeout
```

## Examples

- `/reject-proposal`: Agent identifies the current proposal from context and walks through the rejection path.

- `/reject-proposal 0003-user-session-timeout`: Rejects the named proposal, reverts its spec edits, and prepares the PR for merge.
