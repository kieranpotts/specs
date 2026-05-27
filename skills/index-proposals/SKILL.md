---
name: index-proposals
description: Regenerate the index table in proposals/README.md by scanning all proposal documents in the proposals/ directory. Use when proposals have been merged, renamed, or their status has changed, or when the user says "update the proposals index", "regenerate the index", or "sync the proposals table".
license: MIT
---

# Index proposals

Use this skill to rebuild the index table at the bottom of `proposals/README.md`. It scans every proposal document in `proposals/`, extracts the ID, title, author(s), and current status, and rewrites the table.

Do NOT use this skill to create or advance proposals — those are separate workflows.

## Instructions

1.  **Scan the proposals directory.**

    List all `.md` files in `proposals/` excluding `TEMPLATE.md` and `README.md`:

    ```sh
    ls proposals/*.md | grep -v -E '(TEMPLATE|README)\.md'
    ```

2.  **Extract data from each proposal document.**

    For each file, read the following:

    - **ID**: the zero-padded numeric prefix of the filename (eg. `0003` from `0003-user-session-timeout.md`). For un-merged proposals without a numeric prefix, leave the ID cell blank.
    - **Title**: the top-level `#` heading (the first `#` line in the document).
    - **Authors**: the value of the `Authors:` field in the metadata header.
    - **Status**: the value of the `Status:` field in the metadata header (eg. `#accepted`, `#released`).

3.  **Sort the rows.**

    Sort by ID ascending (numeric order). Proposals without an ID (un-merged drafts) go at the bottom, sorted alphabetically by filename.

4.  **Rewrite the index table in `proposals/README.md`.**

    Replace everything from the `## Index` heading to the end of the file with the regenerated table:

    ```markdown
    ## Index

    | ID | Title | Author | Status |
    | ---- | ----- | ------ | ------ |
    | 0001 | Proposal title here | Author Name | #released |
    | 0002 | Another proposal | Author Name | #accepted |
    |      | Draft proposal slug | Author Name | #draft |
    ```

    Use four-character-wide ID cells (padded with spaces if needed) to keep the table readable in source.

5.  **Commit the change.**

    ```sh
    git add proposals/README.md
    git commit -m "chore: regenerate proposals index"
    ```

## Rules

-   **Never edit proposal documents** — only `proposals/README.md`.

-   **Preserve the rest of `proposals/README.md`.**

    Only replace from the `## Index` heading onward. The introductory paragraphs and "How it works" section must be left untouched.

-   **Do not infer status from the filename or PR labels.**

    Read the `Status:` field directly from each proposal document. That is the authoritative source.

## Success criteria

-   **Every `.md` file in `proposals/` (except `TEMPLATE.md` and `README.md`) has a row in the table.**

-   **ID, Title, Author, and Status values match the source documents.**

-   **Rows are sorted by ID ascending**, with ID-less drafts at the bottom.

-   **No other content in `proposals/README.md` was modified.**

## References

- [`proposals/README.md`](../../proposals/README.md): The file that contains the index table.
- [`proposals/TEMPLATE.md`](../../proposals/TEMPLATE.md): Reference for the metadata field names to extract.
