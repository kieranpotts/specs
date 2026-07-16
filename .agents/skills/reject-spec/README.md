# Reject spec

Rejects a proposed proposal (`PROPOSED` → `REJECTED`), preserving it permanently
as a record.

## What it does

Confirms the rejection decision, reverts all `specification/` changes introduced
by the branch (leaving only the proposal document), sets the document to
`REJECTED`, closes the associated discussion thread, applies the `#rejected`
label, and squash-merges the pull request into `main` on your confirmation.
After the merge, assigns the next sequential number in `proposals/INDEX.md` on
`main`.

## How to invoke

> Reject user-session-timeout

> Reject 42

## Examples

- `/reject-spec`: Walks through the rejection path for the proposal in context.

- `/reject-spec 42`: Rejects the proposal on PR #42, reverts its spec edits, and
  prepares the merge.
