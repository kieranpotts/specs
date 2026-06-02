# Release proposal

Marks an accepted proposal as released once its implementation is live (accepted → released).

## What it does

Verifies the implementation is in production and the spec matches it, assigns the next sequential number in `proposals/INDEX.md`, sets the document to `RELEASED`, swaps the `#accepted` label for `#released`, and prepares the pull request (specification edits and all) for merge into `main`.

## How to invoke

```
/release-proposal
```

Optionally name the proposal or PR number:

```
/release-proposal user-session-timeout
/release-proposal 42
```

## Examples

- `/release-proposal`: Verifies the proposal in context is live, numbers it, and prepares the merge.

- `/release-proposal 42`: Releases the proposal on PR #42 once its implementation has shipped.
