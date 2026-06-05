# Supersede proposal

Retires a previously-released proposal once a later proposal has replaced or removed its feature (`RELEASED` → `SUPERSEDED`).

## What it does

Verifies that a later, released proposal replaces or removes the feature, sets the superseded proposal's document to `SUPERSEDED` (and its `Superseded by` cross-reference), changes its `proposals/INDEX.md` row to `SUPERSEDED`, and swaps the `#released` label for `#superseded` on its original pull request. It does **not** touch `specification/` — the spec edits that remove or replace the feature ride on the successor proposal's own pull request. The change lands on `main` through that successor PR.

## How to invoke

```
/supersede-spec
```

Optionally name the superseded proposal and its successor upfront:

```
/supersede-spec catalog-read-api superseded by catalog-read-api-v2
```

## Examples

- `/supersede-spec`: Agent asks which released proposal is being superseded and which later proposal replaces it, then verifies the gates and applies the change.

- `/supersede-spec catalog-read-api superseded by catalog-read-api-v2`: Supersedes the `catalog-read-api` proposal, linking it to its successor.
