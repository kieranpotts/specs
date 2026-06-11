# Release proposal

Marks an accepted proposal as released once its implementation is live (`ACCEPTED` → `RELEASED`).

## What it does

Verifies the implementation is in production and the spec matches it, sets the document to `RELEASED`, swaps the `#accepted` label for `#released`, and squash-merges the pull request (specification edits and all) into `main` on your confirmation. After the merge, assigns the proposal the next sequential number and logs it in `proposals/INDEX.md` on `main`.

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

- `/release-spec`: Verifies the proposal in context is live, prepares the merge, and numbers it in the index afterwards.

- `/release-spec 42`: Releases the proposal on PR #42 once its implementation has shipped.
