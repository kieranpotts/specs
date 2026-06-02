---
name: accept-spec
description: Approve a proposed proposal — set its status to accepted, label the PR, and close its discussion thread. The PR stays open through implementation until release. Use when the user says "accept this proposal", "approve this proposal", or "mark this proposal accepted".
license: MIT
---

# Accept proposal

Use this skill to move a proposal from **proposed** to **accepted**: verify the approval gates, update the document, label the PR `#accepted`, and close its discussion thread. The proposal is now decided, but its pull request **stays open** until the implementation is released to production (see [`release-spec`](../release-spec/SKILL.md)) — only at that point is a number assigned and the spec merged.

Do NOT use this skill for any other transition — to reject use [`reject-spec`](../reject-spec/SKILL.md), to mark a shipped proposal released use [`release-spec`](../release-spec/SKILL.md), and to scaffold or propose use [`draft-spec`](../draft-spec/SKILL.md) / [`propose-spec`](../propose-spec/SKILL.md).

## Transition rules (proposed → accepted)

The proposal MUST currently be `PROPOSED` (a non-draft PR carrying `#proposed`). Confirm **all** of the following before approving. If any is unmet, report it and pause.

-   **Stakeholder review has concluded**, with feedback gathered from all relevant stakeholders.
-   **The main points of contention are resolved** and the proposed specification has stabilized.
-   **A final-comment period has elapsed** (per project convention) with no material change to the document during it.
-   **The specification edits reflect the intended end state** of the system after the change ships.
-   **Blocking proposals are resolved** — every proposal listed under `Depends on` is itself accepted (or further along).
-   **Only product managers may approve.** If there is any indication the current user is not a product manager, ask for confirmation first.

## Instructions

1.  **Identify the proposal and confirm it is `PROPOSED`.**

    Read `proposals/<slug>/README.md`; check `Status` is `PROPOSED` and the PR carries `#proposed` and is not a draft (`gh pr view <number> --json labels,isDraft`).

2.  **Verify the transition rules above.** Report any unmet gate and stop.

3.  **Update the document.**

    - Set `Status` to `ACCEPTED` and `Last updated` to today's date.
    - Fill in `Approvers` and `Approval date`.
    - Confirm `Proposal PR` is set, and link any `Implementation trackers` as they are created.

    Do **not** assign a number — that happens at merge, in [`release-spec`](../release-spec/SKILL.md).

4.  **Apply the label.**

    ```sh
    gh pr edit <number> --add-label "#accepted" --remove-label "#proposed"
    ```

    This swaps only the lifecycle label; leave the type label in place. Keep the PR **open** — do not merge.

5.  **Close the associated discussion thread.**

    A decided proposal's discussion is closed. Find the discussion linked in the `Discussion thread` field, look up its node ID, and close it as resolved (`gh` has no native discussion command, so use the GraphQL API):

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

6.  **Commit.**

    ```sh
    git commit -am "chore: accept <slug>"
    ```

7.  **Queue the implementation.**

    Remind the user that the work now needs to be designed, built, tested, and shipped to production. The PR stays open through this phase; the document and spec edits MAY continue to evolve in response to implementation feedback. When the change is live, run [`release-spec`](../release-spec/SKILL.md).

## Rules

-   **Only product managers may approve.** If unsure of the user's role, ask first.

-   **Forward only.** Approve only from `PROPOSED`. Never accept a draft, and never move backwards.

-   **Do not merge.** Acceptance is a decision, not a release. The PR stays open until the implementation ships.

## Success criteria

-   **`Status` is `ACCEPTED`**, `Last updated` is today's date, and `Approvers` / `Approval date` are filled in.

-   **The PR carries `#accepted`** (and its type label), not `#proposed`, and remains open.

-   **The associated discussion thread is closed.**

-   **No number has been assigned** — that waits for release.

## References

- [Contributing guide](../../../CONTRIBUTING.md): The full lifecycle and immutability rules.

- [`release-spec`](../release-spec/SKILL.md): Run once the implementation is live in production.

- [`reject-spec`](../reject-spec/SKILL.md): The other decision transition.
