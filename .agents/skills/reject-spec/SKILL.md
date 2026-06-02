---
name: reject-spec
description: Reject a proposed proposal — revert its specification edits, record its number in the index, set its status to rejected, close its discussion, and prepare the pull request for merge as a permanent record. Use when the user says "reject this proposal" or "the proposal was not approved".
license: MIT
---

# Reject proposal

Use this skill to move a proposal from **proposed** to **rejected**. The key distinction from acceptance is that the specification edits MUST be reverted before merge, so only the proposal document itself is added to `main`. The decision and its rationale are preserved permanently; the system is unchanged.

Do NOT use this skill for any other transition — for the acceptance path use [`accept-spec`](../accept-spec/SKILL.md), and to scaffold or propose use [`draft-spec`](../draft-spec/SKILL.md) / [`propose-spec`](../propose-spec/SKILL.md).

## Transition rules (proposed → rejected)

The proposal MUST currently be `PROPOSED` (a non-draft PR carrying `#proposed`). Confirm **all** of the following before rejecting. If any is unmet, report it and pause.

-   **Stakeholder review has concluded**, with feedback gathered from all relevant stakeholders.
-   **There is consensus the proposal should not be implemented.**
-   **The document is a complete record.** `Motivation`, `Proposed change`, `Alternatives`, and `Tradeoffs and risks` are substantive — the document will be archived permanently as the record of this decision.
-   **Only product managers may reject.** If there is any indication the current user is not a product manager, ask for confirmation first.

## Instructions

1.  **Confirm the proposal and the decision.**

    Identify `proposals/<slug>/README.md` and its PR. Confirm with the user that the review is concluded and the decision is to reject. Do not proceed until this is explicit.

2.  **Verify the transition rules above.** Report any unmet gate and stop.

3.  **Identify the specification edits to revert.**

    List all changes to `specification/` introduced by this branch relative to `main`, and present them to the user for confirmation before reverting:

    ```sh
    git diff main --name-only -- specification/
    ```

4.  **Revert the specification edits.**

    Restore the `main` version of each changed file, and delete any files this branch added:

    ```sh
    git checkout main -- specification/<path/to/file>
    git rm specification/<path/to/new-file>
    git add specification/
    ```

5.  **Update the document.**

    - Set `Status` to `REJECTED` and `Last updated` to today's date.
    - Ensure the document captures the rationale for the rejection.
    - Do not alter any other field — the document is immutable after this point.

6.  **Assign the number in the index.**

    A rejected proposal is archived in the ordered log like any other, so it takes the next number at merge. Find the highest number in [`proposals/INDEX.md`](../../../proposals/INDEX.md), increment by one, zero-pad to four digits, and add a row — its number, title, type, `Rejected` status, the rejection date, and a link to its directory (`proposals/<slug>/`). The proposal directory is never renamed.

7.  **Close the associated discussion thread.**

    A decided proposal's discussion is closed. Find the discussion linked in the `Discussion thread` field and close it as resolved via the GraphQL API:

    ```sh
    gh api graphql -f query='
      query($owner:String!, $name:String!, $number:Int!) {
        repository(owner:$owner, name:$name) { discussion(number:$number) { id } }
      }' -F owner=<owner> -F name=<repo> -F number=<discussionNumber>

    gh api graphql -f query='
      mutation($id:ID!) {
        closeDiscussion(input:{discussionId:$id, reason:OUTDATED}) { discussion { closed } }
      }' -F id=<discussionId>
    ```

8.  **Apply the label.**

    ```sh
    gh pr edit <number> --add-label "#rejected" --remove-label "#proposed"
    ```

9.  **Commit and prepare for merge.**

    ```sh
    git add proposals/ specification/
    git commit -m "chore: reject <slug> (proposal <NNNN>)"
    ```

    The PR should now contain only the proposal document and the index row (no spec changes). Confirm with the user that it is ready to merge into `main`. Do not merge without explicit instruction.

## Rules

-   **Never delete the proposal document.** Rejected proposals are permanently archived in `proposals/` as the record of the decision and its rationale.

-   **Revert spec edits precisely.** Only revert changes introduced by this branch; do not touch unrelated changes.

-   **The document is immutable after `#rejected`.** To revisit the decision, open a new proposal that supersedes this one.

-   **Do not merge without instruction.**

## Success criteria

-   **No files under `specification/` are changed** on this branch relative to `main` after the revert.

-   **A `proposals/INDEX.md` row is added** with the next sequential number and `Rejected` status.

-   **The PR carries `#rejected`** (and its type label), the `## Status` section reads `REJECTED`, and `Last updated` is today's date.

-   **The associated discussion thread is closed.**

-   **The user has explicitly confirmed** the rejection decision before any changes were made.

## References

- [Contributing guide](../../../CONTRIBUTING.md): The lifecycle, rejection path, and immutability rules.

- [PR checklist](../../../.github/PULL_REQUEST_TEMPLATE.md): The rejection gates.

- [`accept-spec`](../accept-spec/SKILL.md): The acceptance path.
