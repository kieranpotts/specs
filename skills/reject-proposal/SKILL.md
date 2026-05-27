---
name: reject-proposal
description: Handle the rejection path for a proposal: revert any specification section edits from the proposal branch, update the proposal status to #rejected, and prepare the pull request for merge. Use when the user says "reject this proposal", "the proposal was not approved", or when advancing a proposal from #proposed to #rejected.
license: MIT
---

# Reject proposal

Use this skill to handle the rejection path for a proposal. The key distinction from acceptance is that spec section edits must be reverted before merge, so that only the proposal document itself is added to `prod`. The decision and its rationale are preserved permanently; the system itself is unchanged.

Do NOT use this skill to advance a proposal to any state other than `#rejected`. For the acceptance path, use [`advance-proposal`](../advance-proposal/SKILL.md). For auditing, use [`check-proposal`](../check-proposal/SKILL.md).

## Instructions

1.  **Confirm the proposal and the decision.**

    Identify the proposal document and PR. Confirm with the user that the stakeholder review is concluded and the decision is to reject. Do not proceed until this is explicit.

2.  **Run a pre-rejection audit.**

    Run [`check-proposal`](../check-proposal/SKILL.md) to verify the proposal document is complete. The `Motivation`, `Proposed change`, `Alternatives`, and `Tradeoffs and risks` sections should be substantive, since the document will be permanently archived as the record of this decision.

3.  **Identify the specification edits to revert.**

    List all changes to `specification/` introduced by this proposal branch relative to `prod`:

    ```sh
    git diff prod --name-only -- specification/
    ```

    Present the list to the user for confirmation before reverting.

4.  **Revert the specification edits.**

    For each changed file in `specification/`, restore the `prod` version:

    ```sh
    git checkout prod -- specification/<path/to/file>
    ```

    If any new files were added to `specification/` by this branch, delete them:

    ```sh
    git rm specification/<path/to/new-file>
    ```

    Stage the reverts:

    ```sh
    git add specification/
    ```

5.  **Update the proposal document.**

    - Update `Last updated` to today's date.
    - Do not alter any other field — the document is now immutable after this point.

6.  **Apply the GitHub label.**

    ```sh
    gh pr edit <number> --add-label "#rejected" --remove-label "#proposed"
    ```

7.  **Commit the changes.**

    Commit the reverted spec files and the updated proposal document together:

    ```sh
    git add proposals/<slug>.md
    git commit -m "chore: reject proposal <slug>"
    ```

8.  **Confirm the PR is ready to merge.**

    The PR should now contain only the proposal document (no spec section changes). Confirm with the user that it is ready to merge into `prod`. Do not merge without explicit instruction.

## Rules

-   **Never delete the proposal document.**

    Rejected proposals are permanently archived in `proposals/`. The document is the record of the decision and its rationale.

-   **Revert spec edits precisely.**

    Only revert changes introduced by this specific proposal branch. Do not accidentally revert unrelated changes.

-   **The document is immutable after `#rejected`.**

    Once the proposal reaches `#rejected`, no further edits to the proposal document are permitted. To revisit the decision, open a new proposal that supersedes this one using the `Supersedes` field.

-   **Do not merge without instruction.**

    Prepare the PR and confirm it is ready, but wait for explicit confirmation before merging.

## Success criteria

-   **No files under `specification/` are changed** on this branch relative to `prod` after the revert.

-   **The GitHub PR label is `#rejected`** and `Last updated` in the proposal document is today's date.

-   **The GitHub PR label is `#rejected`.**

-   **The commit contains only the proposal document** (plus any spec reverts as separate staged changes committed together).

-   **The user has explicitly confirmed** the rejection decision before any changes were made.

## References

- [Proposal lifecycle](../../docs/lifecycle.md): State machine, rejection path, and immutability rules.
- [PR checklist](../../.github/PULL_REQUEST_TEMPLATE.md): The rejection gate in the checklist.
- [`check-proposal`](../check-proposal/SKILL.md): Run before rejecting to confirm the document is complete.
- [`advance-proposal`](../advance-proposal/SKILL.md): For all other state transitions.
