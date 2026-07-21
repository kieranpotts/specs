---
name: reject-spec
description: >-
  Reject a proposed proposal — revert its specification edits, record its
  number in the index, set its status to rejected, close its discussion, and
  squash-merge the pull request as a permanent record. Use when the user
  says "reject this proposal" or "the proposal was not approved".
license: MIT
metadata:
  interactive: yes
---

# Reject spec

Use this skill to move a proposal from `PROPOSED` to `REJECTED`. The key
distinction from acceptance is that the specification edits MUST be reverted
before merge, so only the proposal document itself is added to `main`. The
decision and its rationale are preserved permanently; the system is unchanged.

Do NOT use this skill for any other transition — for the acceptance path use
[`/accept-spec`](../accept-spec/SKILL.md), to mark a shipped proposal released
use [`/release-spec`](../release-spec/SKILL.md), to retire a released proposal
use [`/supersede-spec`](../supersede-spec/SKILL.md), and to scaffold or propose
use [`/draft-spec`](../draft-spec/SKILL.md) /
[`/propose-spec`](../propose-spec/SKILL.md).

**Input:** Target — REQUIRED. Infer the proposal from the checked-out branch
(`proposal/<slug>` or `epic/<slug>`). If on `main`, use the user's
description, or list the open `#proposed` pull requests and ask the user to
choose. Explicit confirmation that the decision is to reject — REQUIRED.

**Output:** The specification edits reverted, the proposal document updated
to `Status: REJECTED`, the PR carrying `#rejected` and squash-merged into
`main`, its discussion thread closed, and a new numbered row appended to
`proposals/INDEX.md`.

## Transition gates: `PROPOSED` → `REJECTED`

The proposal MUST currently be `PROPOSED` (a non-draft PR carrying `#proposed`).
Confirm **all** of the following before rejecting. If any is unmet, report it
and pause.

-   **Stakeholder review has concluded.**

    Feedback gathered from all relevant stakeholders.

-   **There is consensus the proposal should not be implemented.**

-   **The document is a complete record.**

    `Motivation`, `Proposed change`, `Alternatives`, and `Tradeoffs and risks`
    are substantive — the document will be archived permanently as the record of
    this decision.

-   **Only product managers may reject.**

    If there is any indication the current user is not a product manager, ask
    for confirmation first.

## Instructions

1.  **Confirm the proposal and the decision.**

    Infer the target from the current checked-out branch (`proposal/<slug>` or
    `epic/<slug>`). If on `main`, use the user's description to infer the target
    proposal if they gave one; otherwise list the open `#proposed` pull requests
    and ask the user to choose:

    ```sh
    gh pr list --label "#proposed" --json number,title,headRefName
    ```

    Identify the document and PR. Confirm with the user that review is concluded
    and the decision is to reject. Do not proceed until this is explicit.

2.  **Verify the transition gates above.**

    Report any unmet gate and stop.

3.  **Identify the specification edits to revert.**

    List all changes to `specification/` introduced by this branch relative to
    `main`, and present them to the user for confirmation before reverting:

    ```sh
    git diff main --name-only -- specification/
    ```

4.  **Revert the specification edits.**

    Restore the `main` version of each changed file, and delete any files this
    branch added:

    ```sh
    git checkout main -- specification/<path/to/file>
    git rm specification/<path/to/new-file>
    git add specification/
    ```

5.  **Update the document.**

    - Set `Status` to `REJECTED` and `Last updated` to today's date.
    - Set `Decision date` to the date the rejection was decided.
    - Ensure the document captures the rationale for the rejection.
    - Do not alter any other field — the document is immutable after this point.

6.  **Apply the label.**

    ```sh
    gh pr edit <number> --add-label "#rejected" --remove-label "#proposed"
    ```

7.  **Commit.**

    ```sh
    git add proposals/ specification/
    git commit -m "chore: reject <short lowercase proposal description>"
    ```

    The PR should now contain only the proposal document (no spec changes).

8.  **Merge the pull request.**

    Confirm with the user that the PR is ready to merge into `main` — do not
    merge without explicit instruction. Once confirmed, squash-merge it with the
    message `<type>: <short lowercase proposal description> - REJECTED` (where
    `<type>` is `feature`, `quality`, or `epic`):

    ```sh
    gh pr merge <number> --squash --subject "<type>: <short lowercase proposal description> - REJECTED"
    ```

9.  **Close the associated discussion thread.**

    The proposal has merged, so its discussion is now closed. Find the
    discussion linked in the `Discussion thread` field and close it as resolved
    via the GraphQL API:

    ```sh
    gh api graphql -f query='
      query($owner:String!, $name:String!, $number:Int!) {
        repository(owner:$owner, name:$name) { discussion(number:$number) { id } }
      }' -F owner=<owner> -F name=<repo> -F number=<discussionNumber>

    gh api graphql -f query='
      mutation($id:ID!) {
        closeDiscussion(input:{discussionId:$id, reason:RESOLVED}) { discussion { closed } }
      }' -F id=<discussionId>
    ```

10. **After merge, assign the number.**

    The proposal number is assigned only after merge. A rejected proposal is
    archived in the ordered log like any other, so it takes the next number. On
    `main`, find the highest number in
    [`proposals/INDEX.md`](../../../proposals/INDEX.md), increment by one, and
    zero-pad to four digits. Add a row — its number, title, type, `Rejected`
    status, the decision date (its `Decision date`, ie. the rejection date), and
    a link to its directory (`proposals/<slug>/`). The proposal directory is
    never renamed.

    Commit this directly to `main`, and push:

    ```sh
    git commit -am "chore: assign next proposal number"
    git push
    ```

## Rules

-   **Never delete the proposal document.**

    Rejected proposals are permanently archived in `proposals/` as the record of
    the decision and its rationale.

-   **Revert spec edits precisely.**

    Only revert changes introduced by this branch; do not touch unrelated
    changes.

-   **The document is immutable after `#rejected`.**

    To revisit the decision, open a new proposal that supersedes this one.

-   **Do not merge without instruction.**

## Success criteria

- No files under `specification/` are changed on this branch relative to `main`
  after the revert.

- The PR carries `#rejected` (and its type label), the `## Status` section reads
  `REJECTED`, and `Last updated` is today's date.

- The associated discussion thread is closed.

- The proposal document is squash-merged into `main`.

- After merge: a `proposals/INDEX.md` entry is added on `main`, with the next
  sequential number and `Rejected` status.

- The user has explicitly confirmed the rejection decision before any changes
  were made.

## References

- [General reference information for agents](../../../AGENTS.md)
