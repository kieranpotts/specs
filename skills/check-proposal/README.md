# Check proposal

Audits a proposal document and its specification edits for completeness, consistency, and process compliance.

## What it does

Checks that all required metadata fields are populated, the document's `Status` matches the GitHub PR label, prose sections contain substantive content, cross-references resolve to real files, specification edits are coherent with the proposal description, and (for `#proposed` or later) the originating issue is closed. Reports passes and failures without making any changes.

## How to invoke

```
/check-proposal
```

Optionally name the proposal file or PR number:

```
/check-proposal user-session-timeout
/check-proposal 42
```

## Examples

- `/check-proposal` — audits the most recently modified proposal in context.
- `/check-proposal 0003-user-session-timeout` — audits the named proposal file.
- `/check-proposal 42` — audits the proposal associated with PR #42.
