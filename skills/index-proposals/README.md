# Index proposals

Regenerates the index table in `proposals/README.md` from the current state of all proposal documents.

## What it does

Scans every `.md` file in `proposals/` (excluding `TEMPLATE.md` and `README.md`), reads the ID (from the filename prefix), title, authors, and status from each document, and rewrites the `## Index` table in `proposals/README.md`. Rows are sorted by numeric ID ascending; un-merged drafts without an ID appear at the bottom.

## How to invoke

```
/index-proposals
```

No arguments needed.

## Examples

After merging a new proposal and renaming the file to `0004-dark-mode.md`:

```
/index-proposals
```

The agent scans `proposals/`, rebuilds the table, and commits `proposals/README.md`.
