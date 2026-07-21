---
name: supersede-spec
description: >-
  Supersede a previously-released proposal once a later proposal has
  replaced or removed its feature. Use when the user says "supersede this
  proposal", "this proposal is superseded by ...", or retires a released
  feature in favor of a newer one.
license: MIT
metadata:
  interactive: yes
---

# Supersede spec

Use this skill to move a proposal from `RELEASED` to `SUPERSEDED`, once a later,
released proposal has replaced or removed its feature. This is the only
transition out of `#released`. The superseded document remains in `proposals/`
permanently as part of the historical record; nothing is deleted.

A released proposal is already merged into `main`, so its document is immutable
— only its `Status` field, `Last updated` date, and the `Superseded by`
cross-reference may change. The actual specification edits that remove or
replace the feature ride on the **successor proposal's** own pull request,
through its normal `DRAFT` → … → `RELEASED` cycle; this skill does not touch
`specification/`.

Do NOT use this skill for any other transition — see
[`/accept-spec`](../accept-spec/SKILL.md),
[`/release-spec`](../release-spec/SKILL.md),
[`/reject-spec`](../reject-spec/SKILL.md),
[`/propose-spec`](../propose-spec/SKILL.md), or
[`/draft-spec`](../draft-spec/SKILL.md).

**Input:** The proposal being superseded and its successor — REQUIRED. Infer
both from the user's description (eg. "X is superseded by Y"), or prompt for
them.

**Output:** The superseded proposal's document updated to `Status:
SUPERSEDED` with a `Superseded by` link, the `proposals/INDEX.md` row
updated, and its original PR carrying `#superseded`.

## Transition gates: `RELEASED` → `SUPERSEDED`

The proposal being superseded MUST currently be `RELEASED`. Confirm **all** of
the following before superseding. If any is unmet, report it and pause.

-   **A later proposal has replaced or removed the feature.**

    That successor proposal is itself `RELEASED` — a draft, proposed, accepted,
    or rejected proposal cannot supersede a released one, because the change is
    not yet live for real users. The successor MUST be the newer of the two (a
    higher `proposals/INDEX.md` number).

-   **The cross-references are reciprocal.**

    The superseded proposal's `Superseded by` field links the successor, and the
    successor's `Supersedes` field links back to this one.

-   **Only product managers may supersede.**

    If there is any indication the current user is not a product manager, ask
    for confirmation first.

## Instructions

1.  **Identify both proposals.**

    The released proposal being superseded, and the later released proposal that
    replaces or removes its feature. Ask the user for both if they are not clear
    from context. If the user gave a short description (eg. "X is superseded by
    Y"), use it to infer both.

    Read `proposals/<slug>/README.md` for the proposal being superseded; confirm
    its `Status` is `RELEASED` and the PR carries `#released` (`gh pr view
    <number> --json labels`). Confirm the successor is itself `RELEASED` and is
    the newer of the two.

2.  **Verify the transition gates above.**

    Report any unmet gate and stop.

3.  **Update the superseded document and the index.**

    - Set `Status` to `SUPERSEDED` and `Last updated` to today's date.
    - Set the `Superseded by` cross-reference to the successor proposal.
    - In [`proposals/INDEX.md`](../../../proposals/INDEX.md), change this
      proposal's row status to `SUPERSEDED`.

    Change nothing else in the document — it is otherwise immutable. Do not
    assign a new number; the proposal keeps the number it was given at release.

4.  **Confirm the successor links back.**

    Ensure the successor proposal's `Supersedes` field references this proposal.
    The successor is edited through its own pull request; if the back-link is
    missing, flag it.

5.  **Switch the state label on the old proposal.**

    On the superseded proposal's original pull request:

    ```sh
    gh pr edit <number> --add-label "#superseded" --remove-label "#released"
    ```

6.  **Land the document change.**

    Commit the edit to the superseded document and index row — typically as part
    of the successor proposal's pull request, since `main` is updated only
    through pull requests:

    ```sh
    git commit -am "chore: supersede <short lowercase proposal description>"
    ```

## Rules

-   **Only from `RELEASED`.**

    A draft, proposed, accepted, or rejected proposal cannot be superseded.

-   **A successor is required.**

    Superseding is always driven by a later, released proposal that replaces or
    removes the feature. There is no standalone supersession.

-   **Immutable except the cross-reference.**

    Only the `Status` field, `Last updated` date, and the `Superseded by` link
    may change. Do not touch `specification/` — the spec edits belong to the
    successor proposal's pull request.

-   **Never delete the proposal document.**

    Superseded proposals are permanently archived in `proposals/` as part of the
    historical record.

## Success criteria

- `Status` is `SUPERSEDED`, `Last updated` is today's date, and `Superseded by`
  links the successor.

- The successor's `Supersedes` field links back to this proposal.

- The `proposals/INDEX.md` row for this proposal reads `SUPERSEDED`.

- The PR carries `#superseded` (and its type label), not `#released`.

- No files under `specification/` are changed by this skill.

## References

- [General reference information for agents](../../../AGENTS.md)

- [`/release-spec`](../release-spec/SKILL.md): How both the superseded proposal
  and its successor reached `#released`.
