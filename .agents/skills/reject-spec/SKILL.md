---
name: reject-spec
description: >-
  Revert a proposal's specification edits and land the proposal document in
  the `main` trunk as a permanent record of the decision not to proceed. Use
  when the user says something like "reject this proposal", "this proposal was
  not approved", "reject <slug>", or "reject <pr-number>". Do not use it to
  delete a proposal or to close one that was never proposed.
compatibility: >-
  requires Read, Edit, Bash (git, gh)
license: CC0-1.0
---

# Reject spec

Move a proposal from `PROPOSED` to `REJECTED`: revert the specification edits,
record the decision on the proposal document, squash-merge it into `main`,
close the discussion thread, and assign the proposal its number. The decision
and its rationale are preserved permanently; the system is left unchanged.

## Parameters

Determine the following information from the surrounding context and
environment, if possible. If you're uncertain about the required parameters,
prompt the user for clarification.

- **Target proposal — REQUIRED.** Infer it from the checked-out branch
  (`proposal/<slug>` or `epic/<slug>`). If on `main`, use the user's
  description, or list the open `#proposed` pull requests and ask the user to
  choose.

- **Explicit confirmation that the decision is to reject — REQUIRED.** Never
  infer a rejection from a lukewarm discussion. Ask the user outright before
  touching anything.

- **Explicit instruction to merge — REQUIRED.** Confirm with the user before
  merging. A merged proposal is immutable.

## Success criteria

- `git diff main --name-only -- specification/` MUST return nothing on the
  branch once the revert is complete.

- `proposals/<slug>/README.md` MUST read `Status: REJECTED`, with
  `Decision date` set to the rejection date and `Last updated` set to today's
  date.

- The document MUST record the rationale for the rejection, since it is the
  only lasting artifact of the decision.

- The pull request MUST carry `#rejected` alongside its type label, and MUST
  NOT carry `#proposed`.

- The proposal document MUST be squash-merged into `main`, under the message
  `<type>: <short lowercase description> - REJECTED`.

- The discussion thread MUST be closed as resolved.

- `proposals/INDEX.md` on `main` MUST carry a new row for this proposal, with
  the next sequential number and `Rejected` status.

- The proposal document MUST NOT have been deleted, and its directory MUST
  NOT have been renamed.

## Instructions

1.  Identify the proposal and confirm the decision.

    Infer the target from the checked-out branch. If on `main`, use the
    user's description, or list the open `#proposed` pull requests and ask
    the user to choose:

    ```sh
    gh pr list --label "#proposed" --json number,title,headRefName
    ```

    Read `proposals/<slug>/README.md`, check `Status` reads `PROPOSED`, and
    confirm with the user that review is concluded and the decision is to
    reject. Do not proceed until that is explicit.

2.  Verify every rule below. Report any that are unmet, and stop without
    changing anything.

3.  List the specification edits this branch introduced, and present them to
    the user for confirmation before reverting anything.

    ```sh
    git diff main --name-only -- specification/
    ```

4.  Revert those edits: restore the `main` version of each changed file, and
    delete any file the branch added.

    ```sh
    git checkout main -- specification/<path/to/file>
    git rm specification/<path/to/new-file>
    git add specification/
    ```

5.  Update the document.

    - Set `Status` to `REJECTED` and `Last updated` to today's date.
    - Set `Decision date` to the date the rejection was decided.
    - Ensure the document captures the rationale for the rejection.
    - Change nothing else — the document is immutable from here on.

6.  Swap the lifecycle label, leaving the type label in place.

    ```sh
    gh pr edit <number> --add-label "#rejected" --remove-label "#proposed"
    ```

7.  Commit and push. The push is mandatory: the next step merges the remote
    branch, so an unpushed commit would land the un-reverted specification
    edits.

    ```sh
    git add proposals/ specification/
    git commit -m "chore: reject <short lowercase description>"
    git push
    ```

    The pull request should now show only the proposal document, with no
    changes under `specification/`.

8.  Confirm with the user that the pull request is ready to merge, then
    squash-merge it and delete the source branch.

    ```sh
    gh pr merge <number> --squash --subject "<type>: <short lowercase description> - REJECTED" --delete-branch
    ```

    `<type>` is `feature` for a feature proposal, or `update` for a quality or
    epic proposal.

9.  If the branch survived the merge, delete it directly.

    ```sh
    git push origin --delete proposal/<slug>   # or epic/<slug>
    ```

10. Close the discussion thread as resolved. `gh` has no native discussion
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

11. Assign the proposal its number, on `main`.

    A rejected proposal is archived in the ordered log like any other, so it
    takes the next number. Find the highest number in
    [`proposals/INDEX.md`](../../../proposals/INDEX.md), increment it, and
    zero-pad to four digits. Add a row carrying the number, the title, the
    type (`Feature`, `Quality`, or `Epic`), the `Rejected` status, and the
    proposal's `Decision date`, linking the number to `proposals/<slug>/`.

    ```sh
    git checkout main
    git pull --rebase
    git commit -am "chore: assign proposal <number>"
    git push
    ```

12. Report the transition.

## Rules

- You MUST reject only from `PROPOSED`. There is no path to rejection from a
  draft — an unwanted draft is simply abandoned, and its branch closed.

- Stakeholder review MUST have concluded, with consensus that the proposal
  should not be implemented.

- You MUST NOT delete the proposal document. Rejected proposals are archived
  permanently in `proposals/` as the record of the decision and its
  rationale, which is the whole point of merging one.

- The document MUST be a complete record before merge: `Motivation`,
  `Proposed change`, `Alternatives`, and `Tradeoffs and risks` are all
  substantive. A future reader needs to understand what was turned down and
  why.

- You MUST revert the specification edits precisely, touching only the
  changes this branch introduced. `main` describes production, which this
  decision leaves unchanged.

- You MUST push before merging. `gh pr merge` merges what is on the remote,
  so an unpushed revert would land the specification edits after all.

- You MUST NOT merge without explicit instruction from the user.

- You MUST assign the number in `proposals/INDEX.md` only after the merge,
  and MUST commit it directly to `main`. The number is not part of the
  proposal, so it is not part of what the pull request reviewed.

- The document MUST be treated as immutable once merged. To revisit the
  decision, open a new proposal.

## Edge cases

- The branch touched files outside `specification/` and `proposals/<slug>/`.

  Report them and stop. This skill reverts specification edits only; an
  unexpected change elsewhere means the branch carried more than one concern
  and needs untangling by hand first.
