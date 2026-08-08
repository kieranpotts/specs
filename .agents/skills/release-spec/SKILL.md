---
name: release-spec
description: >-
  Land an accepted proposal and its specification edits in the `main` trunk
  once the implementation is live in production, then assign the proposal its
  number. Use when the user says something like "release this proposal", "this
  proposal is live", "the implementation shipped", "release <slug>", or
  "release <pr-number>". Do not use it for a change that has not yet shipped
  to real users.
compatibility: >-
  requires Read, Edit, Bash (git, gh)
license: CC0-1.0
---

# Release spec

Move a proposal from `ACCEPTED` to `RELEASED`: confirm the change is live,
squash-merge the proposal document and its specification edits into `main`,
close the discussion thread, and assign the proposal its number in
`proposals/INDEX.md`.

## Parameters

Determine the following information from the surrounding context and
environment, if possible. If you're uncertain about the required parameters,
prompt the user for clarification.

- **Target proposal — REQUIRED.** Infer it from the checked-out branch
  (`proposal/<slug>` or `epic/<slug>`). If on `main`, use the user's
  description, or list the open `#accepted` pull requests and ask the user to
  choose.

- **Explicit instruction to merge — REQUIRED.** Confirm with the user before
  merging. The merge is irreversible in practice, since a merged proposal is
  immutable.

## Success criteria

- `proposals/<slug>/README.md` MUST read `Status: RELEASED`, with
  `Last updated` set to today's date.

- The pull request MUST carry `#released` alongside its type label, and MUST
  NOT carry `#accepted`.

- The proposal document and the specification edits MUST be squash-merged
  into `main`, under the message `<type>: <short lowercase description> -
  RELEASED`.

- The source branch MUST be deleted from the upstream repository.

- The discussion thread MUST be closed as resolved.

- `proposals/INDEX.md` on `main` MUST carry a new row for this proposal, with
  the next sequential number and `Released` status.

- The proposal's directory MUST NOT have been renamed. The number lives only
  in the index, so that links to `proposals/<slug>/` never break.

## Instructions

1.  Identify the proposal and confirm it is `ACCEPTED`.

    Infer the target from the checked-out branch. If on `main`, use the
    user's description, or list the open `#accepted` pull requests and ask
    the user to choose:

    ```sh
    gh pr list --label "#accepted" --json number,title,headRefName
    ```

    Read `proposals/<slug>/README.md`. Check `Status` reads `ACCEPTED` and
    the pull request carries `#accepted`:

    ```sh
    gh pr view <number> --json labels
    ```

2.  Verify every rule below. Report any that are unmet, and stop without
    changing anything.

3.  Update the document: set `Status` to `RELEASED`, set `Last updated` to
    today's date, and confirm `Implementation trackers` are linked.

4.  Swap the lifecycle label, leaving the type label in place.

    ```sh
    gh pr edit <number> --add-label "#released" --remove-label "#accepted"
    ```

5.  Commit and push. The push is mandatory: the next step merges the remote
    branch, so an unpushed commit would leave the merged document still
    reading `ACCEPTED`.

    ```sh
    git commit -am "chore: release <short lowercase description>"
    git push
    ```

6.  Confirm with the user that the pull request is ready to merge, then
    squash-merge it and delete the source branch.

    ```sh
    gh pr merge <number> --squash --subject "<type>: <short lowercase description> - RELEASED" --delete-branch
    ```

    `<type>` is `feature` for a feature proposal, or `update` for a quality or
    epic proposal.

7.  If the branch survived the merge, delete it directly.

    ```sh
    git push origin --delete proposal/<slug>   # or epic/<slug>
    ```

8.  Close the discussion thread as resolved. `gh` has no native discussion
    command, so look up the node ID and close it via the GraphQL API.

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

9.  Assign the proposal its number, on `main`.

    Find the highest number in
    [`proposals/INDEX.md`](../../../proposals/INDEX.md), increment it, and
    zero-pad to four digits (eg. `0006` → `0007`). Add a row carrying the
    number, the title, the type (`Feature`, `Quality`, or `Epic`), the
    `Released` status, and the proposal's `Decision date`, linking the number
    to `proposals/<slug>/`.

    ```sh
    git checkout main
    git pull --rebase
    git commit -am "chore: assign proposal <number>"
    git push
    ```

10. Report the transition. A released proposal stays in effect until a later
    proposal supersedes it.

## Rules

- You MUST release only from `ACCEPTED`. A draft, proposed, or rejected
  proposal has no approved change to land.

- The implementation MUST be live in production, experienced by real users
  right now. Releasing early is what makes `main` dishonest about the system
  it claims to describe.

- The specification edits MUST match the implementation as it actually
  shipped, with any drift discovered during implementation reconciled back
  into the specification before merge.

- Every proposal listed under `Depends on` MUST itself be released.

- You MUST push before merging. `gh pr merge` merges what is on the remote,
  so a status change committed locally but not pushed is silently dropped.

- You MUST NOT merge without explicit instruction from the user.

- You MUST assign the number in `proposals/INDEX.md` only after the merge,
  and MUST commit it directly to `main`. The number is not part of the
  proposal, so it is not part of what the pull request reviewed.

## Edge cases

- Implementation revealed the shipped behavior differs from the accepted
  specification.

  Do not release. Report the drift and stop, so the specification edits can
  be corrected on the branch first. The pull request is still open precisely
  so that this can happen.

- The merge succeeded but assigning the number failed.

  Retry step 9 on `main`. The number is assigned by a separate direct commit,
  so a failure there leaves the merge intact and needs no rework of the pull
  request.
