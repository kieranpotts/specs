---
name: release-spec
description: Mark an accepted proposal as released once its implementation is live in production — assign its number in the index, set its status to released, label the PR, and prepare it for merge. Use when the user says "release this proposal", "this proposal is live", or "the implementation shipped".
license: MIT
---

# Release proposal

Use this skill to move a proposal from **accepted** to **released**, once its implementation is live in production. This is the point at which the proposal is assigned its number in [`proposals/INDEX.md`](../../../proposals/INDEX.md), its specification edits become part of `main`, and the pull request is prepared for merge.

Do NOT use this skill for any other transition — see [`accept-spec`](../accept-spec/SKILL.md), [`reject-spec`](../reject-spec/SKILL.md), [`propose-spec`](../propose-spec/SKILL.md), or [`draft-spec`](../draft-spec/SKILL.md).

## Transition rules (accepted → released)

The proposal MUST currently be `ACCEPTED` (a PR carrying `#accepted`). Confirm **all** of the following before releasing. If any is unmet, report it and pause.

-   **The implementation is live in production** — the change is being experienced by real users right now.
-   **The specification edits match the final implementation.** Any drift discovered during implementation has been reconciled back into the spec, so `main` will describe the system as it actually is.
-   **Blocking proposals are resolved** — every proposal listed under `Depends on` is itself released.
-   **Only product managers may release.** If there is any indication the current user is not a product manager, ask for confirmation first.

## Instructions

1.  **Identify the proposal and confirm it is `ACCEPTED`.**

    Read `proposals/<slug>/README.md`; check `Status` is `ACCEPTED` and the PR carries `#accepted` (`gh pr view <number> --json labels`).

2.  **Verify the transition rules above.** Report any unmet gate and stop.

3.  **Assign the number in the index.**

    Find the highest number in [`proposals/INDEX.md`](../../../proposals/INDEX.md), increment by one, and zero-pad to four digits (eg. `0006` → `0007`). Add a row for this proposal — its number, title, type (`Feature` or `Quality`), `Released` status, the decision (approval) date, and a link to its directory (`proposals/<slug>/`). The number lives only in the index; the proposal's directory is never renamed.

4.  **Update the document.**

    - Set `Status` to `RELEASED` and `Last updated` to today's date.
    - Confirm `Implementation trackers` are linked.

5.  **Apply the label.**

    ```sh
    gh pr edit <number> --add-label "#released" --remove-label "#accepted"
    ```

    This swaps only the lifecycle label; leave the type label in place.

6.  **Commit.**

    ```sh
    git commit -am "chore: release <slug> (proposal <NNNN>)"
    ```

7.  **Prepare for merge.**

    The specification edits and the proposal document are now ready to land on `main`. Confirm with the user that the PR is ready to merge. Do not merge without explicit instruction. A released proposal stays in effect until a later proposal deprecates it.

## Rules

-   **Only product managers may release.** If unsure of the user's role, ask first.

-   **Only from `ACCEPTED`.** Never release a draft, proposed, or rejected proposal.

-   **Release means production.** Do not mark a proposal released until its change is actually live for real users — that is what keeps `main` honest.

-   **Do not merge without instruction.**

## Success criteria

-   **A `proposals/INDEX.md` row is added** for the proposal, with the next sequential number and `Released` status.

-   **`Status` is `RELEASED`** and `Last updated` is today's date.

-   **The PR carries `#released`** (and its type label), not `#accepted`.

-   **The specification edits are intact** on the branch, ready to merge into `main`.

## References

- [Contributing guide](../../../CONTRIBUTING.md): The full lifecycle and immutability rules.

- [`accept-spec`](../accept-spec/SKILL.md): The transition that precedes release.
