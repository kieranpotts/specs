---
name: propose-spec
description: >-
  Remove the draft status from a proposal pull request, marking it ready for
  stakeholder review. Use when the user says "propose this", "this proposal
  is ready for review", "mark the proposal ready", or "take it out of
  draft".
license: MIT
metadata:
  interactive: yes
---

# Propose spec

Use this skill to move a proposal from `DRAFT` to `PROPOSED`: confirm the
document and specification edits are complete, apply the `#proposed` label, and
remove the pull request's draft status so stakeholders can review it.

Do NOT use this skill to scaffold a new proposal (use
[`/draft-spec`](../draft-spec/SKILL.md)) or to decide one (use
[`/accept-spec`](../accept-spec/SKILL.md),
[`/release-spec`](../release-spec/SKILL.md), or
[`/reject-spec`](../reject-spec/SKILL.md)).

**Input:** Target — REQUIRED. Infer the proposal from the checked-out branch
(`proposal/<slug>` or `epic/<slug>`). If on `main`, list open draft pull
requests and ask the user to choose.

**Output:** The proposal document updated to `Status: PROPOSED`, the PR
carrying `#proposed` and taken out of draft.

## Transition gates: `DRAFT` → `PROPOSED`

Before removing draft status, confirm **all** of the following. If any fails,
report it and pause — do not mark the PR ready.

-   **The document is reasonably complete.**

    Every required section contains substantive, change-specific content — not
    the generic placeholder prose carried over from `TEMPLATE.md`:

    - `Summary` — a concise description of the change.
    - `Motivation` — the problem and who it affects.
    - `Impact` — `HIGH`, `MEDIUM`, or `LOW`, plus what is affected.
    - `Proposed change` — which specification artifacts are added, modified, or
      removed.
    - `Alternatives` — at least one alternative considered.
    - `Tradeoffs and risks` — an honest account of the downsides.

-   **The specification edits are present and coherent.**

    The branch actually edits `specification/` to describe the intended end
    state, and those edits match the `Proposed change` section. Run `git diff
    main --name-only -- specification/` to confirm.

    - For `features/` files: scenarios are valid Gherkin, each a concrete
      acceptance criterion.
    - For `qualities/` files: requirements are measurable thresholds, not
      aspirations.

-   **No leftover template text.**

    No italic placeholder prompts and no unfilled tokens (`#...`, `YYYY-MM-DD`)
    remain in any completed section.

-   **The metadata header is filled in.**

    `Authors`, `Created`, `Last updated`, and `Proposal PR` are set; `Status` is
    `DRAFT` (this skill advances it to `PROPOSED`); the `Discussion thread`
    field links the thread.

-   **Exactly one type label on the PR.**

    `FEATURE`, `QUALITY`, or `EPIC`.

## Instructions

1.  **Identify the proposal and its PR.**

    Infer the target from the current checked-out branch (`proposal/<slug>` or
    `epic/<slug>`). If on `main`, list all open draft pull requests and ask the
    user to choose:

    ```sh
    gh pr list --draft --json number,title,headRefName
    ```

    Then checkout the branch, read the proposal document
    (`proposals/<slug>/README.md`), and confirm its PR (`gh pr view <number>
    --json isDraft,labels`) if needed.

2.  **Verify the transition gates above.**

    Read the document in full, check each gate, and report any failures. Stop if
    unmet.

3.  **Update the document.**

    Set `Status` to `PROPOSED` and `Last updated` to today's date.

4.  **Apply the `#proposed` label.**

    ```sh
    gh pr edit <number> --add-label "#proposed"
    ```

    Leave the type label in place. (There is no `#draft` label to remove — the
    draft state is the pull request's own draft flag.)

5.  **Remove the draft status.**

    ```sh
    gh pr ready <number>
    ```

6.  **Commit any document change.**

    ```sh
    git commit -am "chore: mark <short lowercase proposal description> ready for review"
    git push
    ```

7.  **Hand off to stakeholder review and the decision.**

    The proposal is now `PROPOSED` and open for review, with feedback gathered
    in its discussion thread. The next transition is the decision: once
    stakeholders agree, use [`/accept-spec`](../accept-spec/SKILL.md) to move it
    to `ACCEPTED`; if it will not be taken forward, use
    [`/reject-spec`](../reject-spec/SKILL.md). Both are out of scope for this
    skill.

## Rules

-   **Do not mark a PR ready until the document and spec edits are complete.**

    An incomplete or boilerplate-laden proposal wastes reviewers' time. The
    completeness gate is mandatory.

-   **Forward only.**

    This skill only moves `DRAFT` → `PROPOSED`. It does not decide the proposal.

## Success criteria

- The PR is no longer a draft (`isDraft: false`).

- The `#proposed` label is applied, alongside the type label.

- `Last updated` is today's date and `Status` is `PROPOSED`.

## References

- [General reference information for agents](../../../AGENTS.md)

- [PR checklist](../../../.github/PULL_REQUEST_TEMPLATE.md)
