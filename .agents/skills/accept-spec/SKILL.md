---
name: accept-spec
description: >-
  Approve a proposal. Use this skill when the user says something like
  "accept this proposal", "approve this proposal", "mark this proposal as
  accepted", "accept spec for <slug>", or "accept <pr-number>".
license: MIT
metadata:
  interactive: yes
  preferred_model: prose-writing
---

# Accept spec

Use this skill to transition a proposal from `PROPOSED` to `ACCEPTED`.

## Parameters

Determine the following information from the surrounding context and
environment, if possible.

- **Target — REQUIRED.** Infer the proposal from the checked-out branch
  (`proposal/<slug>` or `epic/<slug>`). If on `main`, use the user's
  description, or list the open `#proposed` pull requests and ask the user to
  choose.

## Success criteria

You will achieve the following outcomes:

<!-- The proposal document updated to `Status: ACCEPTED` with `Decided by` and
`Decision date` filled in, the PR carrying `#accepted` and left open. -->

- `Status` is `ACCEPTED`, `Last updated` is today's date, and `Decided by` /
  `Decision date` are filled in.

- The PR carries `#accepted` (and its type label), not `#proposed`, and
  remains open.

- The associated discussion thread remains open — it is closed when the PR
  is merged at release.

- No number has been assigned — that waits for release.

## Instructions

1.  Identify the proposal and confirm it is `PROPOSED`.

    Infer the target from the current checked-out branch (`proposal/<slug>`
    or `epic/<slug>`). If on `main`, use the user's description to infer the
    target proposal if they gave one; otherwise list the open `#proposed`
    pull requests and ask the user to choose:

    ```sh
    gh pr list --label "#proposed" --json number,title,headRefName
    ```

    Read the document. Check `Status` is `PROPOSED` and the PR carries
    `#proposed` and is not a draft (`gh pr view <number> --json
    labels,isDraft`).

2.  Verify the rules.

    Report any unmet rule and stop.

3.  Update the document.

    - Set `Status` to `ACCEPTED` and `Last updated` to today's date.
    - Fill in `Decided by` and `Decision date` (the approval date).
    - Confirm `Proposal PR` is set, and link any `Implementation trackers` as
      they are created.

    Do not assign a number — that happens at merge, in
    [`/release-spec`](../release-spec/SKILL.md).

4.  Apply the label.

    ```sh
    gh pr edit <number> --add-label "#accepted" --remove-label "#proposed"
    ```

    This swaps only the lifecycle label; leave the type label in place. Keep
    the PR open — do not merge. Leave the discussion thread open too; it
    stays open through implementation and is closed only when the PR is
    merged at release.

5.  Commit.

    ```sh
    git commit -am "chore: accept <short lowercase proposal description>"
    ```

6.  Queue the implementation.

    Remind the user that the work now needs to be designed, built, tested,
    and shipped to production. The PR stays open through this phase; the
    document and spec edits MAY continue to evolve in response to
    implementation feedback, with feedback continuing on the still-open
    discussion thread. When the change is live, run
    [`/release-spec`](../release-spec/SKILL.md).

## Rules

- Only product managers MAY approve a proposal.

  If unsure of the user's role, ask first.

- You MUST approve only from `PROPOSED`, never backwards.

  Approve only from `PROPOSED`. Never accept a draft, and never move
  backwards.

- Stakeholder review MUST have concluded.

  Feedback gathered from all relevant stakeholders.

- The main points of contention MUST be resolved.

  The proposed specification has stabilized.

- A final-comment period MUST have elapsed.

  No material change to the document during it (per project convention).

- The specification edits MUST reflect the intended end state.

  They describe the system as it will be after the change ships.

- The requirement MUST meet the [Definition of
  Ready](../../../docs/definition-of-ready.md).

  Acceptance queues the work for implementation, so the requirement MUST be
  ready to build. Work through the full checklist in the [Definition of
  Ready](../../../docs/definition-of-ready.md); in summary,
  confirm the requirements are clear and unambiguous, functional acceptance
  criteria are testable Gherkin scenarios and quality requirements are
  measurable thresholds, the stakeholders are known, and the work is
  independent and implementable in small increments.

  If the proposal is sound in principle but not yet ready to build, send it
  back for refinement rather than accepting it.

- Blocking proposals MUST be resolved.

  Every proposal listed under `Depends on` is itself accepted (or further
  along).

- You MUST NOT merge the pull request.

  Acceptance is a decision, not a release. The PR stays open until the
  implementation ships.

- Proposals MUST be treated as immutable after merge.

  While the PR is open — including through implementation — the document and
  its spec edits MAY still evolve. Once merged at `#released`, only the
  `Status` field, `Last updated` date, cross-references to related proposals,
  and implementation trackers may change.

## References

- [Definition of Ready](../../../docs/definition-of-ready.md): The
  canonical readiness checklist this skill verifies at the `PROPOSED` →
  `ACCEPTED` gate.
