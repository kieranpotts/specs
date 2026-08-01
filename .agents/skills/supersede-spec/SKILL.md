---
name: supersede-spec
description: >-
  Supersede a previously-released proposal once a later proposal has
  replaced or removed its feature. Use this skill when the user says something
  like "supersede this proposal", "this proposal is superseded by ...", or
  otherwise wishes to retire a released feature in favor of a newer one.
license: CC0-1.0
metadata:
  interactive: yes
  preferred_model: ollama/WORKFLOW_BASIC
---

# Supersede spec

Use this skill to move a proposal from `RELEASED` to `SUPERSEDED`, once a
later, released proposal has replaced or removed its feature. This is the
only transition out of `#released`. The superseded document remains in
`proposals/` permanently as part of the historical record; nothing is
deleted.

A released proposal is already merged into `main`, so its document is
immutable — only its `Status` field, `Last updated` date, and the
`Superseded by` cross-reference may change. The actual specification edits
that remove or replace the feature ride on the successor proposal's own
pull request, through its normal `DRAFT` → … → `RELEASED` cycle; this
skill does not touch `specification/`.

## Parameters

Determine the following information from the surrounding context and
environment, if possible.

- **The proposal being superseded and its successor — REQUIRED.** Infer both
  from the user's description (eg. "X is superseded by Y"), or prompt for
  them.

## Success criteria

You will achieve the following outcomes:

<!-- The superseded proposal's document updated to `Status: SUPERSEDED` with a
`Superseded by` link, the `proposals/INDEX.md` row updated, and its
original PR carrying `#superseded`. -->

- `Status` is `SUPERSEDED`, `Last updated` is today's date, and
  `Superseded by` links the successor.

- The successor's `Supersedes` field links back to this proposal.

- The `proposals/INDEX.md` row for this proposal reads `SUPERSEDED`.

- The PR carries `#superseded` (and its type label), not `#released`.

- No files under `specification/` are changed by this skill.

## Instructions

1.  Identify both proposals.

    The released proposal being superseded, and the later released
    proposal that replaces or removes its feature. Ask the user for both
    if they are not clear from context. If the user gave a short
    description (eg. "X is superseded by Y"), use it to infer both.

    Read `proposals/<slug>/README.md` for the proposal being superseded;
    confirm its `Status` is `RELEASED` and the PR carries `#released`
    (`gh pr view <number> --json labels`). Confirm the successor is itself
    `RELEASED` and is the newer of the two.

2.  Verify the rules.

    Report any unmet rule and stop.

3.  Update the superseded document and the index.

    - Set `Status` to `SUPERSEDED` and `Last updated` to today's date.
    - Set the `Superseded by` cross-reference to the successor proposal.
    - In [`proposals/INDEX.md`](../../../proposals/INDEX.md), change this
      proposal's row status to `SUPERSEDED`.

    Change nothing else in the document — it is otherwise immutable. Do
    not assign a new number; the proposal keeps the number it was given at
    release.

4.  Confirm the successor links back.

    Ensure the successor proposal's `Supersedes` field references this
    proposal. The successor is edited through its own pull request; if the
    back-link is missing, flag it.

5.  Switch the state label on the old proposal.

    On the superseded proposal's original pull request:

    ```sh
    gh pr edit <number> --add-label "#superseded" --remove-label "#released"
    ```

6.  Land the document change.

    Commit the edit to the superseded document and its index row directly to
    `main`, and push. Both proposals are already merged, and every field
    touched here is one of the few a merged proposal may still change — so
    there is nothing for a pull request to review:

    ```sh
    git checkout main
    git pull --rebase
    git commit -am "chore: supersede <short lowercase proposal description>"
    git push
    ```

    The push is mandatory. An unpushed supersession leaves the archive
    claiming the old proposal is still in effect.

## Rules

- You MUST supersede only from `RELEASED`.

  A draft, proposed, accepted, or rejected proposal cannot be superseded.

- A later proposal MUST have replaced or removed the feature.

  That successor proposal is itself `RELEASED` — a draft, proposed,
  accepted, or rejected proposal cannot supersede a released one, because
  the change is not yet live for real users. The successor MUST be the
  newer of the two (a higher `proposals/INDEX.md` number).

- The cross-references MUST be reciprocal.

  The superseded proposal's `Superseded by` field links the successor, and
  the successor's `Supersedes` field links back to this one.

- A successor proposal MUST exist.

  Superseding is always driven by a later, released proposal that
  replaces or removes the feature. There is no standalone supersession.

- The cross-reference change MUST be committed directly to `main`, and
  pushed.

  Both proposals are already merged. The only fields this skill touches —
  `Status`, `Last updated`, `Superseded by`, and the index row — are among
  the few a merged proposal may still change, so a pull request would have
  nothing to review. This matches how proposal numbers are assigned at
  release and rejection, which also commit straight to `main`.

  The specification edits that remove or replace the feature are a separate
  matter: those ride on the successor proposal's own pull request.

- The document MUST remain immutable except for the cross-reference.

  Only the `Status` field, `Last updated` date, and the `Superseded by`
  link may change. Do not touch `specification/` — the spec edits belong
  to the successor proposal's pull request.

- You MUST NOT delete the proposal document.

  Superseded proposals are permanently archived in `proposals/` as part
  of the historical record.
