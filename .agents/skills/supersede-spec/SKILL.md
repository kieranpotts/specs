---
name: supersede-spec
description: >-
  Retire a released proposal once a later released proposal has replaced or
  removed its feature, setting the reciprocal cross-references and updating
  the proposal index. Use when the user says something like "supersede this
  proposal", "this proposal is superseded by ...", or otherwise wishes to
  retire a released feature in favor of a newer one. Do not use it to author
  the successor proposal or to edit the specification.
compatibility: >-
  requires Read, Edit, Bash (git, gh)
license: CC0-1.0
---

# Supersede spec

Move a proposal from `RELEASED` to `SUPERSEDED`, once a later released
proposal has replaced or removed its feature. Update only the status, the
`Superseded by` cross-reference, and the index row. Do not touch
`specification/` — those edits ride on the successor's own pull request.

## Parameters

Determine the following information from the surrounding context and
environment, if possible. If you're uncertain about the required parameters,
prompt the user for clarification.

- **The proposal being superseded — REQUIRED.** A released proposal, given by
  slug, index number, or description. Infer it from a phrasing such as "X is
  superseded by Y", or prompt for it.

- **The successor proposal — REQUIRED.** The later released proposal that
  replaced or removed the feature. There is no standalone supersession, so
  prompt for it if it is not clear from context.

## Success criteria

- The superseded `proposals/<slug>/README.md` MUST read
  `Status: SUPERSEDED`, with `Superseded by` linking the successor's index
  number and `Last updated` set to today's date.

- The successor's `Supersedes` field MUST link back to this proposal's index
  number, so the cross-references are reciprocal.

- The superseded proposal's row in `proposals/INDEX.md` MUST read
  `Superseded`.

- The superseded proposal's original pull request MUST carry `#superseded`
  alongside its type label, and MUST NOT carry `#released`.

- The change MUST be committed directly to `main` and pushed. An unpushed
  supersession leaves the archive claiming a retired feature is still in
  effect.

- Files under `specification/` MUST NOT have been changed, and no proposal
  document MUST have been deleted or renumbered.

## Instructions

1.  Identify both proposals.

    Read `proposals/<slug>/README.md` for the proposal being superseded, and
    confirm its `Status` reads `RELEASED` and its pull request carries
    `#released`:

    ```sh
    gh pr view <number> --json labels
    ```

    Confirm the successor is itself `RELEASED`, and that it carries the
    higher `proposals/INDEX.md` number of the two.

2.  Verify every rule below. Report any that are unmet, and stop without
    changing anything.

3.  Update the superseded document, on `main`.

    - Set `Status` to `SUPERSEDED` and `Last updated` to today's date.
    - Set `Superseded by` to the successor's index number.
    - Change nothing else; the document is otherwise immutable, and it keeps
      the number it was given at release.

4.  Update the superseded proposal's row in
    [`proposals/INDEX.md`](../../../proposals/INDEX.md) to read
    `Superseded`.

5.  Confirm the successor's `Supersedes` field links back to this proposal.
    The successor is edited through its own pull request, so if the back-link
    is missing, flag it to the user rather than editing the successor here.

6.  Swap the lifecycle label on the superseded proposal's original pull
    request, leaving the type label in place.

    ```sh
    gh pr edit <number> --add-label "#superseded" --remove-label "#released"
    ```

7.  Commit directly to `main` and push.

    ```sh
    git checkout main
    git pull --rebase
    git commit -am "chore: supersede <short lowercase description>"
    git push
    ```

8.  Report the transition.

## Rules

- You MUST supersede only from `RELEASED`. A draft, proposed, accepted, or
  rejected proposal was never in effect, so there is nothing to retire.

- A successor proposal MUST exist and MUST itself be `RELEASED`, and MUST be
  the newer of the two — a higher `proposals/INDEX.md` number.

  A proposal that has not shipped cannot retire a feature that is still live
  for real users. There is no standalone supersession.

- The cross-references MUST be reciprocal: `Superseded by` on the old
  proposal, `Supersedes` on the successor. A one-way link leaves the archive
  ambiguous about which proposal is in effect.

- The change MUST be committed directly to `main`, and pushed.

  Both proposals are already merged, and the fields this skill touches —
  `Status`, `Last updated`, `Superseded by`, and the index row — are among
  the few a merged proposal may still change, so a pull request would have
  nothing to review. This matches how proposal numbers are assigned at
  release and rejection, which also commit straight to `main`.

- You MUST NOT edit files under `specification/`. The edits that remove or
  replace the feature belong to the successor proposal's own pull request,
  and landed there when it was released.

- You MUST NOT delete or renumber the proposal document. Superseded proposals
  are archived permanently in `proposals/` as part of the historical record.

## Edge cases

- The successor's `Supersedes` field is missing or points elsewhere.

  Complete the supersession and flag the gap, naming the successor and the
  field to fix. The successor's document is immutable except for
  cross-references, so the back-link can be added by a separate direct commit
  to `main` — but that is the user's call, not an edit to make silently.
