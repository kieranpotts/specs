---
name: accept-spec
description: Approve a proposed proposal — set its status to accepted and label the PR. The PR and its discussion thread stay open through implementation until release. Use when the user says "accept this proposal", "approve this proposal", or "mark this proposal accepted".
license: MIT
metadata:
  interactive: yes
---

# `/accept-spec`

<!-- TODO: Review these skills against the latest template. -->

Use this skill to move a proposal from `PROPOSED` to `ACCEPTED`: verify the approval gates, update the document, and label the PR `#accepted`. The proposal is now decided, but its pull request **stays open** until the implementation is released to production (see [`/release-spec`](../release-spec/SKILL.md)) — only at that point is the spec merged, the discussion thread closed, and a number assigned. The discussion thread stays open through implementation, as feedback may continue while the proposal evolves.

Do NOT use this skill for any other transition — to reject use [`/reject-spec`](../reject-spec/SKILL.md), to mark a shipped proposal released use [`/release-spec`](../release-spec/SKILL.md), and to scaffold or propose use [`/draft-spec`](../draft-spec/SKILL.md) / [`/propose-spec`](../propose-spec/SKILL.md).

## Transition gates: `PROPOSED` → `ACCEPTED`

The proposal MUST currently be `PROPOSED` (a non-draft PR carrying `#proposed`). Confirm **all** of the following before approving. If any is unmet, report it and pause.

-   **Stakeholder review has concluded.**

    Feedback gathered from all relevant stakeholders.

-   **The main points of contention are resolved.**

    The proposed specification has stabilized.

-   **A final-comment period has elapsed.**

    No material change to the document during it (per project convention).

-   **The specification edits reflect the intended end state.**

    They describe the system as it will be after the change ships.

-   **The requirement meets the [Definition of Ready](../write-spec/references/definition-of-ready.md).**

    Acceptance queues the work for implementation, so the requirement MUST be ready to build. Work through the full checklist in the [Definition of Ready](../write-spec/references/definition-of-ready.md); in summary, confirm the requirements are clear and unambiguous, functional acceptance criteria are testable Gherkin scenarios and quality requirements are measurable thresholds, the stakeholders are known, and the work is independent and implementable in small increments.

    If the proposal is sound in principle but not yet ready to build, send it back for refinement rather than accepting it.

-   **Blocking proposals are resolved.**

    Every proposal listed under `Depends on` is itself accepted (or further along).

-   **Only product managers may approve.**

    If there is any indication the current user is not a product manager, ask for confirmation first.

## Instructions

1.  **Identify the proposal and confirm it is `PROPOSED`.**

    Infer the target from the current checked-out branch (`proposal/<slug>` or `epic/<slug>`). If on `main`, use the user's description to infer the target proposal if they gave one; otherwise list the open `#proposed` pull requests and ask the user to choose:

    ```sh
    gh pr list --label "#proposed" --json number,title,headRefName
    ```

    Read the document. Check `Status` is `PROPOSED` and the PR carries `#proposed` and is not a draft (`gh pr view <number> --json labels,isDraft`).

2.  **Verify the transition gates above.**

    Report any unmet gate and stop.

3.  **Update the document.**

    - Set `Status` to `ACCEPTED` and `Last updated` to today's date.
    - Fill in `Decided by` and `Decision date` (the approval date).
    - Confirm `Proposal PR` is set, and link any `Implementation trackers` as they are created.

    Do **not** assign a number — that happens at merge, in [`/release-spec`](../release-spec/SKILL.md).

4.  **Apply the label.**

    ```sh
    gh pr edit <number> --add-label "#accepted" --remove-label "#proposed"
    ```

    This swaps only the lifecycle label; leave the type label in place. Keep the PR **open** — do not merge. Leave the discussion thread open too; it stays open through implementation and is closed only when the PR is merged at release.

5.  **Commit.**

    ```sh
    git commit -am "chore: accept <short lowercase proposal description>"
    ```

6.  **Queue the implementation.**

    Remind the user that the work now needs to be designed, built, tested, and shipped to production. The PR stays open through this phase; the document and spec edits MAY continue to evolve in response to implementation feedback, with feedback continuing on the still-open discussion thread. When the change is live, run [`/release-spec`](../release-spec/SKILL.md).

## Rules

-   **Only product managers may approve.**

    If unsure of the user's role, ask first.

-   **Forward only.**

    Approve only from `PROPOSED`. Never accept a draft, and never move backwards.

-   **Do not merge.**

    Acceptance is a decision, not a release. The PR stays open until the implementation ships.

-   **Proposals are immutable after merge.**

    While the PR is open — including through implementation — the document and its spec edits MAY still evolve. Once merged at `#released`, only the `Status` field, `Last updated` date, cross-references to related proposals, and implementation trackers may change.

## Success criteria

- `Status` is `ACCEPTED`, `Last updated` is today's date, and `Decided by` / `Decision date` are filled in.

- The PR carries `#accepted` (and its type label), not `#proposed`, and remains open.

- The associated discussion thread remains open — it is closed when the PR is merged at release.

- No number has been assigned — that waits for release.

## References

- [General reference information for agents](../../../AGENTS.md)

- [Definition of Ready](../write-spec/references/definition-of-ready.md): the canonical readiness checklist this skill verifies at the `PROPOSED` → `ACCEPTED` gate.

- [`/write-spec`](../write-spec/SKILL.md): owns the specification-content rules and authors content to meet the Definition of Ready.
