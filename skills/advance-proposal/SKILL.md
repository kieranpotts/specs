---
name: advance-proposal
description: Transition a proposal from its current lifecycle state to the next permitted state, verifying that all checklist gates are satisfied before doing so. Use when the user wants to move a proposal to the next state, says "advance this proposal", "mark this as proposed/accepted/rejected/released", or asks to apply a lifecycle label to a proposal PR.
license: MIT
---

# Advance proposal

Use this skill to move a proposal through its lifecycle state machine. It verifies that the gates for the target state are met, updates the proposal document's `Status` field and `Last updated` date, and applies the matching GitHub label to the PR.

Do NOT use this skill to scaffold a new proposal (use [`draft-proposal`](../draft-proposal/SKILL.md)) or to audit a proposal's content for completeness (use [`check-proposal`](../check-proposal/SKILL.md)). Do NOT move a proposal backwards or skip states — those transitions are not permitted.

## Instructions

1.  **Identify the proposal and its current state.**

    If not already open, read the proposal document in `proposals/`. Check the `Status` field and confirm it matches the current `#label` on the PR (run `gh pr view <number> --json labels` if needed).

2.  **Determine the target state.**

    The permitted transitions are:

    | From | To | Key gate |
    | --- | --- | --- |
    | `#draft` | `#proposed` | Document complete; originating issue closed |
    | `#proposed` | `#accepted` | Stakeholder review concluded; ID assigned |
    | `#proposed` | `#rejected` | Stakeholder review concluded; spec edits reverted |
    | `#accepted` | `#released` | Implementation shipped to production |
    | `#released` | `#deprecated` | Feature removed or superseded |

    If the user requests an unlisted transition (eg. `#proposed` back to `#draft`), refuse and explain why.

3.  **Verify the gates for the target state.**

    Run [`check-proposal`](../check-proposal/SKILL.md) against the proposal and confirm the relevant checklist gates in `.github/PULL_REQUEST_TEMPLATE.md` are satisfied. Report any unmet gates to the user and pause for direction before proceeding.

4.  **For `#proposed → #accepted`: assign the sequential ID.**

    Find the highest existing numeric ID in `proposals/` (eg. `0003-foo.md` → `0003`). Increment by one, zero-padded to four digits. Rename the file:

    ```sh
    git mv proposals/<slug>.md proposals/<NNNN>-<slug>.md
    ```

    Update the `Proposal PR` field in the document if it is not yet set.

5.  **For `#proposed → #rejected`: revert the specification edits.**

    Identify all changes to `specification/` that were introduced by this proposal branch and revert them, leaving only the proposal document itself. Confirm the revert with the user before committing.

6.  **Update the proposal document.**

    - Update `Last updated` to today's date.
    - For `#accepted`: fill in `Approvers` and `Approval date`.
    - For `#released`: confirm that `Implementation trackers` links are present.

7.  **Apply the GitHub label.**

    ```sh
    gh pr edit <number> --add-label "#<state>" --remove-label "#<previous-state>"
    ```

    Use the lowercase `#`-prefixed label names: `#draft`, `#proposed`, `#accepted`, `#rejected`, `#released`, `#deprecated`.

8.  **Commit the changes.**

    Stage and commit the updated proposal document (and any file rename or spec revert). Use the commit message convention from the [`commit`](../../skills/commit/SKILL.md) skill if available, otherwise use `chore: advance proposal to #<state>`.

## Rules

-   **Only product managers may advance a proposal's state.**

    If there is any indication the current user does not have that role, note it and ask for confirmation before proceeding.

-   **Never move backwards or skip states.**

    The state machine is strictly forward-only. If a correction is needed, open a new proposal that supersedes the original.

-   **Once `#accepted` or `#rejected`, the document is immutable.**

    After those states are reached, only the GitHub label may change. Do not edit any part of the document.

-   **Gate verification is mandatory.**

    Do not advance state without running `check-proposal` first. An unchecked gate is a process violation, not a minor omission.

## Success criteria

-   **The proposal document's `Status` matches the new state.**

-   **`Last updated` is set to today's date.**

-   **The GitHub PR label is updated** to the matching `#<state>` label.

-   **For `#accepted`: the file has been renamed** to `NNNN-<slug>.md` with the correct sequential ID.

-   **For `#rejected`: spec section edits have been reverted** and the commit is clean — only the proposal document remains.

-   **No prohibited transition was performed.**

## References

- [Proposal lifecycle](../../CONTRIBUTING.md#proposal-lifecycle): State machine, permitted transitions, and immutability rules.

- [PR checklist](../../.github/PULL_REQUEST_TEMPLATE.md): The gates that must be satisfied before each transition.

- [`check-proposal`](../check-proposal/SKILL.md): Run this before advancing to verify all gates.

- [`draft-proposal`](../draft-proposal/SKILL.md): For creating a new proposal from scratch.

- [`reject-proposal`](../reject-proposal/SKILL.md): Dedicated skill for the rejection path, including the spec revert.
