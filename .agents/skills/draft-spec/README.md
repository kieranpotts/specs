# Draft proposal

Scaffolds a new proposal and opens it as a draft pull request.

## What it does

Creates a `proposal/<slug>` branch (or `epic/<slug>` for EPICs) from `main`, copies `proposals/TEMPLATE.md` to `proposals/<slug>/README.md`, fills in the metadata header (authors, dates, `Status: PROPOSED`), identifies the specification files that will need editing, opens a **draft pull request** with one type label (`FEATURE`, `QUALITY`, or `EPIC`), and opens the associated discussion thread.

## How to invoke

```
/draft-spec
```

Optionally include the slug and type upfront:

```
/draft-spec user-session-timeout feature
```

## Examples

- `/draft-spec`: Agent asks for the slug and type, then scaffolds the branch, document, draft PR, and discussion.

- `/draft-spec password-complexity-rules feature`: Scaffolds immediately as a FEATURE proposal.

- `/draft-spec api-response-time quality`: Scaffolds a QUALITY proposal.

- `/draft-spec petstore-v2 epic`: Scaffolds an EPIC proposal on an `epic/petstore-v2` branch.
