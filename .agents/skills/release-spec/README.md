# Release proposal

Marks an accepted proposal as released once its implementation is live (accepted → released).

## What it does

Verifies the implementation is in production and the spec matches it, assigns the next sequential number in `proposals/INDEX.md`, sets the document to `RELEASED`, swaps the `#accepted` label for `#released`, and squash-merges the pull request (specification edits and all) into `main` on your confirmation.

## How to invoke

```
/release-spec
```

Optionally name the proposal or PR number:

```
/release-spec user-session-timeout
/release-spec 42
```

## Examples

- `/release-spec`: Verifies the proposal in context is live, numbers it, and prepares the merge.

- `/release-spec 42`: Releases the proposal on PR #42 once its implementation has shipped.
