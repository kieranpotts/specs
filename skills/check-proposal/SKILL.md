---
name: check-proposal
description: Audit a proposal document and its accompanying specification edits for completeness, consistency, and process compliance. Use when the user wants to review a proposal before advancing it, says "check this proposal", "review this proposal", or "is this proposal ready to advance?".
license: MIT
---

# Check proposal

Use this skill to audit a proposal before it advances to the next lifecycle state. It verifies that required fields are filled in, the proposal document is internally consistent, the GitHub label and document Status field agree, cross-references resolve, and the specification edits are coherent with the proposal description.

Do NOT use this skill to advance a proposal's state (use [`advance-proposal`](../advance-proposal/SKILL.md)) or to scaffold a new proposal (use [`draft-proposal`](../draft-proposal/SKILL.md)).

## Instructions

1.  **Identify the proposal to check.**

    If the user does not specify, look for the most recently modified file in `proposals/` (excluding `TEMPLATE.md` and `README.md`), or ask.

2.  **Check the metadata header.**

    Verify that the following fields are filled in and non-placeholder:

    - `Authors` — at least one name present.
    - `Created` and `Last updated` — valid `YYYY-MM-DD` dates; `Last updated` is not older than `Created`.
    - `Status` — one of `#draft`, `#proposed`, `#accepted`, `#rejected`, `#released`, `#deprecated`.
    - `Proposal PR` — either a linked PR number or a note that the PR is not yet open (acceptable for `#draft`).
    - `Issue` — either a linked issue number or the default `_(if applicable)_` placeholder.

3.  **Check the label alignment.**

    If a PR number is present, run:

    ```sh
    gh pr view <number> --json labels,state
    ```

    Confirm that the PR carries the label matching the document's `Status` field (eg. `#proposed` when `Status: #proposed`), and that the PR is open (not merged or closed) unless the proposal is `#released` or `#rejected`.

4.  **Check the required prose sections.**

    Each of the following sections must be present and contain substantive content (not just the placeholder text from `TEMPLATE.md`):

    - `Summary` — a concise single-paragraph description of the change.
    - `Motivation` — explains the problem being solved and for whom.
    - `Impact` — one of `HIGH`, `MEDIUM`, or `LOW`, plus a description of who is affected.
    - `Proposed change` — describes which specification artifacts are added, modified, or removed.
    - `Alternatives` — at least one alternative considered.
    - `Tradeoffs and risks` — honest about downsides.

5.  **Check cross-references.**

    For each value in the `Related` section (`Supersedes`, `Superseded by`, `Depends on`, `Related to`):

    - If the reference is a proposal number, confirm the corresponding `NNNN-*.md` file exists in `proposals/`.
    - If the reference is a GitHub issue or PR number, it need not be verified locally, but note any that look malformed.

6.  **Check the specification edits.**

    List all files changed on this branch relative to `prod`:

    ```sh
    git diff prod --name-only
    ```

    For each changed file in `specification/`:

    - Confirm the change is referenced in the `Proposed change` section of the proposal document.
    - Confirm the edit describes the intended *final state*, not a changelog or diff description.
    - For `specification/features/` files: confirm scenarios are written as valid Gherkin.
    - For `specification/performance/` files: confirm requirements are expressed as measurable thresholds, not aspirations.

7.  **Check that the originating issue is closed (for `#proposed` or later).**

    If the `Issue` field is populated, run:

    ```sh
    gh issue view <number> --json state
    ```

    Confirm `state` is `CLOSED`. If not, flag it as a gate failure.

8.  **Report findings.**

    Produce a summary with two sections:

    - **Passes** — a bullet list of checks that passed.
    - **Failures / warnings** — a bullet list of anything that needs attention, with a brief explanation for each.

    Do not advance the proposal or make any changes. Report only.

## Rules

-   **Report, do not fix.**

    This skill is an auditor, not an editor. Surface findings and let the proposer or product manager decide how to address them.

-   **Distinguish failures from warnings.**

    A *failure* is a gate that must be resolved before the proposal can advance. A *warning* is a quality concern that does not block advancement but should be noted.

-   **Check all sections, even if early ones fail.**

    Run the full audit before reporting. A partial report is less useful than a complete one.

## Success criteria

-   **Every check listed in the Instructions has been performed.**

-   **The report clearly separates passes from failures/warnings.**

-   **No changes were made** to any file in the repository.

-   **Each failure names the specific field, section, or file** that did not pass, with enough detail for the proposer to act on it.

## References

- [Proposal lifecycle](../../docs/lifecycle.md): State machine and gate conditions.

- [PR checklist](../../.github/PULL_REQUEST_TEMPLATE.md): The authoritative checklist of gates per state transition.

- [`proposals/TEMPLATE.md`](../../proposals/TEMPLATE.md): Reference for required fields and sections.

- [`advance-proposal`](../advance-proposal/SKILL.md): Run after `check-proposal` passes to advance the state.
