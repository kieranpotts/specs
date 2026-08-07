---
name: accept-spec
description: >-
  Record the stakeholders' approval of a proposed change to the software
  requirements specification, leaving its pull request open through
  implementation. Use when the user says something like "accept this
  proposal", "approve this proposal", "mark this proposal as accepted",
  "accept spec for <slug>", or "accept <pr-number>". Do not use it to merge
  the proposal or to assign it a number.
compatibility: >-
  requires Read, Edit, Bash (git, gh)
license: CC0-1.0
---

# Accept spec

Move a proposal from `PROPOSED` to `ACCEPTED`: verify the approval gates, set
the status and the decision fields, and swap the lifecycle label. Do not merge
the pull request — acceptance is a decision, not a release.

## Parameters

Determine the following information from the surrounding context and
environment, if possible. If you're uncertain about the required parameters,
prompt the user for clarification.

- **Target proposal — REQUIRED.** Infer it from the checked-out branch
  (`proposal/<slug>` or `epic/<slug>`). If on `main`, use the user's
  description, or list the open `#proposed` pull requests and ask the user to
  choose.

- **Decision record — REQUIRED.** Who approved the proposal, and on what
  date. Ask the user where the surrounding context does not supply both.

## Success criteria

- `proposals/<slug>/README.md` MUST read `Status: ACCEPTED`, with
  `Decided by` and `Decision date` filled in and `Last updated` set to
  today's date.

- The pull request MUST carry `#accepted` alongside its type label, and MUST
  NOT carry `#proposed`.

- The pull request MUST remain open, since `main` stays current with
  production and the change is not live yet.

- The discussion thread MUST remain open, so implementation feedback has
  somewhere to go.

- The status change MUST be pushed, because reviewers read the decision from
  the remote branch.

- No proposal number MUST have been assigned, and no row MUST have been added
  to `proposals/INDEX.md` — numbering waits for merge.

## Instructions

1.  Identify the proposal and confirm it is `PROPOSED`.

    Infer the target from the checked-out branch. If on `main`, use the
    user's description, or list the open `#proposed` pull requests and ask
    the user to choose:

    ```sh
    gh pr list --label "#proposed" --json number,title,headRefName
    ```

    Read `proposals/<slug>/README.md`. Check `Status` reads `PROPOSED`, and
    that the pull request carries `#proposed` and is not a draft:

    ```sh
    gh pr view <number> --json labels,isDraft
    ```

2.  Verify every rule below, working through the
    [Definition of Ready](../../../docs/definition-of-ready.md) in full.
    Report any that are unmet, and stop without changing anything.

3.  Update the document.

    - Set `Status` to `ACCEPTED` and `Last updated` to today's date.
    - Fill in `Decided by` and `Decision date`, the latter being the approval
      date.
    - Confirm `Proposal PR` is set, and link any `Implementation trackers`
      that already exist.

4.  Swap the lifecycle label, leaving the type label in place.

    ```sh
    gh pr edit <number> --add-label "#accepted" --remove-label "#proposed"
    ```

5.  Commit and push.

    ```sh
    git commit -am "chore: accept <short lowercase description>"
    git push
    ```

6.  Report the transition, and remind the user that the work now needs to be
    designed, built, tested, and shipped to production before the proposal
    can be released.

## Rules

- You MUST accept only from `PROPOSED`. A draft proposal has not been
  reviewed, and the lifecycle permits no backwards move.

- Stakeholder review MUST have concluded, with feedback gathered from every
  relevant stakeholder and the main points of contention resolved.

- A final-comment period MUST have elapsed with no material change to the
  document, per project convention.

- The specification edits MUST describe the system as it will be once the
  change ships, not the change itself.

- The requirement MUST meet the
  [Definition of Ready](../../../docs/definition-of-ready.md).

  Acceptance queues the work for implementation, so the requirement has to be
  ready to build: clear and unambiguous, with testable Gherkin acceptance
  criteria for functional requirements and measurable thresholds for quality
  requirements, known stakeholders, and work that is independent and
  deliverable in small increments. A proposal that is sound in principle but
  not yet ready to build SHOULD be sent back for refinement rather than
  accepted.

- Every proposal listed under `Depends on` MUST itself be accepted or further
  along.

- You MUST NOT merge the pull request. It stays open until the implementation
  is live, which is what keeps the `main` specification honest about
  production.

- You MUST push the status change and not merely commit it. The pull request
  is what stakeholders read, so an unpushed commit leaves the remote showing
  the pre-decision status.

- The document and its specification edits MAY continue to evolve while the
  pull request is open, including through implementation. Only after merge
  does the proposal become immutable.

## Edge cases

- The proposal is sound but a dependency is still `PROPOSED`.

  Do not accept it. Report the blocking dependency and stop. Accepting a
  proposal whose dependency may yet be rejected queues work that cannot be
  built.

## References

- [Definition of Ready](../../../docs/definition-of-ready.md) \
  Read in full at step 2. This is the canonical readiness checklist the
  `PROPOSED` → `ACCEPTED` gate verifies.
