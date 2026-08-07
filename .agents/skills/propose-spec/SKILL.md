---
name: propose-spec
description: >-
  Check that a draft proposal and its specification edits are complete, then
  take its pull request out of draft for stakeholder review. Use when the user
  says something like "this proposal is ready for review", "mark the proposal
  ready", "take this out of draft", "propose <slug>", or "propose
  <pr-number>". Do not use it to write the proposal or to decide it.
compatibility: >-
  requires Read, Edit, Bash (git, gh)
license: CC0-1.0
---

# Propose spec

Move a proposal from `DRAFT` to `PROPOSED`: confirm the proposal document and
the specification edits are complete, set the status, apply the `#proposed`
label, and take the pull request out of draft. Do not fill in gaps in the
proposal yourself, and do not decide it.

## Parameters

Determine the following information from the surrounding context and
environment, if possible. If you're uncertain about the required parameters,
prompt the user for clarification.

- **Target proposal — REQUIRED.** Infer it from the checked-out branch
  (`proposal/<slug>` or `epic/<slug>`). If on `main`, use the user's
  description, or list the open draft pull requests and ask the user to
  choose.

## Success criteria

- `proposals/<slug>/README.md` MUST read `Status: PROPOSED`, with
  `Last updated` set to today's date.

- The pull request MUST report `isDraft: false`.

- The pull request MUST carry `#proposed` alongside its single type label.

- The status change MUST be pushed, because reviewers read the proposal from
  the remote branch.

- No decision MUST have been recorded: `Decided by` and `Decision date` stay
  blank, and the proposal MUST NOT have been merged.

## Instructions

1.  Identify the proposal and its pull request.

    Infer the target from the checked-out branch. If on `main`, use the
    user's description, or list the open draft pull requests and ask the user
    to choose:

    ```sh
    gh pr list --draft --json number,title,headRefName
    ```

    Check out the branch, read `proposals/<slug>/README.md` in full, and
    confirm the pull request state:

    ```sh
    gh pr view <number> --json isDraft,labels
    ```

2.  Verify every rule below. Report any that are unmet, and stop without
    changing anything.

3.  Confirm the specification edits are present and match the document's
    `Proposed change` section.

    ```sh
    git diff main --name-only -- specification/
    ```

4.  Update the document: set `Status` to `PROPOSED` and `Last updated` to
    today's date.

5.  Apply the `#proposed` label, leaving the type label in place. There is no
    `#draft` label to remove — the draft state is the pull request's own
    draft flag.

    ```sh
    gh pr edit <number> --add-label "#proposed"
    ```

6.  Take the pull request out of draft.

    ```sh
    gh pr ready <number>
    ```

7.  Commit and push the document change.

    ```sh
    git commit -am "chore: mark <short lowercase description> ready for review"
    git push
    ```

8.  Report the transition, and remind the user that review feedback belongs
    in the proposal's discussion thread rather than in the pull request
    comments. The next transition is the stakeholders' decision, which is
    out-of-scope for this skill.

## Rules

- The proposal document MUST be substantive in every required section, with
  no generic prose carried over from `proposals/TEMPLATE.md`:

  - `Summary` — a concise description of the change.
  - `Motivation` — the problem, and who it affects.
  - `Impact` — `HIGH`, `MEDIUM`, or `LOW`, plus what is affected.
  - `Proposed change` — which specification artifacts are added, modified, or
    removed.
  - `Alternatives` — at least one alternative considered.
  - `Tradeoffs and risks` — an honest account of the downsides.

- No unfilled template tokens (`#...`, `YYYY-MM-DD`, `NNNN`) or placeholder
  prompts MUST remain in any completed section.

- The branch MUST edit `specification/` to describe the intended end state,
  and those edits MUST match the `Proposed change` section.

  Scenarios under `features/` MUST be valid Gherkin, each a concrete
  acceptance criterion. Requirements under `qualities/` MUST be measurable
  thresholds, not aspirations.

- The metadata header MUST be filled in: `Authors`, `Created`,
  `Last updated`, `Proposal PR`, and `Discussion thread` are all set, and
  `Status` still reads `DRAFT` before this skill advances it.

- The pull request MUST carry exactly one type label — `FEATURE`, `QUALITY`,
  or `EPIC`.

- You MUST NOT take the pull request out of draft while any of the above is
  unmet. An incomplete proposal wastes reviewers' time, and this readiness
  gate is the only thing standing between the two.

- You MUST NOT write or complete the proposal yourself. Where a section is
  thin, report it and stop; the proposer fills the gap.

- You MUST move the proposal only forward, `DRAFT` → `PROPOSED`. This skill
  does not decide the proposal, and the lifecycle permits no backwards move.

## Edge cases

- The branch has no changes under `specification/`.

  Stop and report it. A proposal with no specification edits describes no end
  state, so there is nothing for stakeholders to review. The one case worth
  checking before rejecting outright is a proposal that only withdraws a
  requirement — that still shows as a deletion in the diff.

## References

- [Pull request checklist](../../../.github/PULL_REQUEST_TEMPLATE.md) \
  Read when confirming the pull request is complete before taking it out of
  draft.
