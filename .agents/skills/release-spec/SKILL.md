---
name: release-spec
description: >-
  Mark an accepted proposal as released once its
  implementation is live in production — set its status to released, label the PR,
  squash-merge it, and assign its number in the index. Use when the user says
  "release this proposal", "this proposal is live", or "the implementation
  shipped".
license: MIT
metadata:
  interactive: yes
---

# `/release-spec`

Use this skill to move a proposal from `ACCEPTED` to `RELEASED`, once its
implementation is live in production. This is the point at which the proposal's
pull request is squash-merged into `main` — its specification edits becoming
part of `main` — and the proposal is assigned its number in
[`proposals/INDEX.md`](../../../proposals/INDEX.md).

Do NOT use this skill for any other transition — see
[`/accept-spec`](../accept-spec/SKILL.md),
[`/reject-spec`](../reject-spec/SKILL.md),
[`/propose-spec`](../propose-spec/SKILL.md), or
[`/draft-spec`](../draft-spec/SKILL.md).

## Transition gates: `ACCEPTED` → `RELEASED`

The proposal MUST currently be `ACCEPTED` (a PR carrying `#accepted`). Confirm
**all** of the following before releasing. If any is unmet, report it and pause.

-   **The implementation is live in production.**

    The change is being experienced by real users right now.

-   **The specification edits match the final implementation.**

    Any drift discovered during implementation has been reconciled back into the
    spec, so `main` will describe the system as it actually is.

-   **Blocking proposals are resolved.**

    Every proposal listed under `Depends on` is itself released.

-   **Only product managers may release.**

    If there is any indication the current user is not a product manager, ask
    for confirmation first.

## Instructions

1.  **Identify the proposal and confirm it is `ACCEPTED`.**

    Infer the target from the current checked-out branch (`proposal/<slug>` or
    `epic/<slug>`). If on `main`, use the user's description to infer the target
    proposal if they gave one, otherwise list the open `#accepted` pull requests
    and ask the user to choose:

    ```sh
    gh pr list --label "#accepted" --json number,title,headRefName
    ```

    Read the document. Check `Status` is `ACCEPTED` and the PR carries
    `#accepted` (`gh pr view <number> --json labels`).

2.  **Verify the transition gates above.**

    Report any unmet gate and stop.

3.  **Update the document.**

    - Set `Status` to `RELEASED` and `Last updated` to today's date.
    - Confirm `Implementation trackers` are linked.

4.  **Apply the label.**

    ```sh
    gh pr edit <number> --add-label "#released" --remove-label "#accepted"
    ```

    This swaps only the lifecycle label; leave the type label in place.

5.  **Commit.**

    ```sh
    git commit -am "chore: release <short lowercase proposal description>"
    ```

6.  **Merge the pull request.**

    The specification edits and the proposal document are now ready to land on
    `main`. Confirm with the user that the PR is ready to merge — do not merge
    without explicit instruction. Once confirmed, squash-merge it with the
    message `<type>: <short lowercase proposal description> - RELEASED` (where
    `<type>` is `feature`, `quality`, or `epic`):

    ```sh
    gh pr merge <number> --squash --subject "<type>: <short lowercase proposal description> - RELEASED"
    ```

7.  **Close the associated discussion thread.**

    The proposal has merged, so its discussion is now closed. Find the
    discussion linked in the `Discussion thread` field, look up its node ID, and
    close it as resolved (`gh` has no native discussion command, so use the
    GraphQL API):

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

8.  **After merge, assign the number.**

    The proposal number is assigned only after merge. On `main`, find the
    highest number in [`proposals/INDEX.md`](../../../proposals/INDEX.md),
    increment by one, and zero-pad to four digits (eg. `0006` → `0007`). Add a
    row for this proposal — its number, title, type (`Feature` or `Quality`),
    `Released` status, the proposal's `Decision date`, and a link to its
    directory (`proposals/<slug>/`). The number lives only in the index; the
    proposal's directory is never renamed.

    Commit this directly to `main`, and push:

    ```sh
    git commit -am "chore: assign proposal <number>"
    git push
    ```

    A released proposal stays in effect until a later proposal supersedes it.

## Rules

-   **Only product managers may release.**

    If unsure of the user's role, ask first.

-   **Only from `ACCEPTED`.**

    Never release a draft, proposed, or rejected proposal.

-   **Release means production.**

    Do not mark a proposal released until its change is actually live for real
    users — that is what keeps `main` honest.

-   **Do not merge without instruction.**

## Success criteria

- `Status` is `RELEASED` and `Last updated` is today's date.

- The PR carries `#released` (and its type label), not `#accepted`.

- The specification edits and the proposal document are squash-merged into
  `main`.

- The associated discussion thread is closed.

- After merge: a `proposals/INDEX.md` entry is added on `main`, with the next
  sequential number and `Released` status.

## References

- [General reference information for agents](../../../AGENTS.md)
