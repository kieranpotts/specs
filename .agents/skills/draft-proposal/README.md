# Draft proposal

Scaffolds a new proposal for a change to the software requirements specification.

## What it does

Creates a `proposal/<slug>` branch from `main`, copies `proposals/TEMPLATE.md` to `proposals/<slug>.md`, fills in the metadata header (authors, dates, issue link), sets the initial status, and identifies the specification section files that will need to be edited.

## How to invoke

```
/draft-proposal
```

Optionally include the slug and type upfront:

```
/draft-proposal user-session-timeout feature
```

## Examples

- `/draft-proposal`: Agent asks for the slug and type, then scaffolds the branch and document.

- `/draft-proposal password-complexity-rules feature`: Scaffolds immediately with the given slug.

- `/draft-proposal api-response-time quality`: Scaffolds a QUALITY proposal.
