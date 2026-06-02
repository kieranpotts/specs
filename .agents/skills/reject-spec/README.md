# Reject proposal

Rejects a proposed proposal (proposed → rejected), preserving it permanently as a record.

## What it does

Confirms the rejection decision, reverts all `specification/` changes introduced by the branch (leaving only the proposal document), sets the document to `REJECTED`, records the next sequential number in `proposals/INDEX.md`, closes the associated discussion thread, applies the `#rejected` label, and prepares the pull request for merge into `main`.

## How to invoke

```
/reject-spec
```

Optionally name the proposal or PR number:

```
/reject-spec user-session-timeout
/reject-spec 42
```

## Examples

- `/reject-spec`: Walks through the rejection path for the proposal in context.

- `/reject-spec 42`: Rejects the proposal on PR #42, reverts its spec edits, and prepares the merge.
