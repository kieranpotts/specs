# Draft spec

Scaffolds a new proposal and opens it as a draft pull request.

## What it does

- Creates a `proposal/<slug>` branch (or `epic/<slug>` for EPICs).
- Copies `proposals/TEMPLATE.md` to `proposals/<slug>/README.md`.
- Fills in the metadata header (authors, dates, `Status: DRAFT`).
- Identifies the specification files that will need editing.
- Commits and pushes the change.
- Opens a draft pull request with one type label: `FEATURE`, `QUALITY`, or
  `EPIC`.
- Opens a discussion thread.
- Creates cross-references between the discussion and the PR.

## How to invoke

> Draft a spec for user session timeout.

## Examples

- `/draft-spec`: Agent will prompt you for the information it needs to prepare a
  draft PR, then scaffolds the branch, document, PR, and discussion.

- `/draft-spec <Description>`: Scaffolds immediately based on your description
  of the requirement.

Next, use [`/write-spec`](../write-spec/README.md) to author the specification
content (the functional and non-functional requirements). Once that's complete,
use [`/propose-spec`](../propose-spec/README.md) to mark the PR as "ready for
review".
