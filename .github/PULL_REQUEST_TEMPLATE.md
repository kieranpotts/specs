_Copy the "Summary" section from the proposal document here._

- Discussion thread: [Link] _(required — every proposal has one)_

> [!IMPORTANT]
> Please use the discussion thread linked above, not comments on this pull request, to provide feedback on this proposal. This keeps the PR thread focused on the edit history of the proposal document and the evolution of the specification artifacts.

----

## Checklist

The product managers will update this checklist as the proposal moves through its lifecycle. They will merge this PR only when the proposal is released to production, or when it is rejected. See the [contributing guidelines](../CONTRIBUTING.md) for more details about state transitions.

On opening this PR (open it as a draft):

- [ ] Exactly one type label — `FEATURE`, `QUALITY`, or `EPIC` — is applied.
- [ ] An associated discussion thread is opened and linked (both above and in the proposal document).

Mark this PR ready for review, and apply the `#proposed` label, when:

- [ ] The proposal document and specification edits are complete enough to invite stakeholder review.
- [ ] No generic template text or unfilled placeholders remain in the document.

Move from **`#proposed`** to **`#accepted`** when:

- [ ] Feedback is gathered from all relevant stakeholders.
- [ ] The main points of contention are resolved.
- [ ] The proposed specification has stabilized and reflects the intended end state of the system.
- [ ] Final comments have been solicited for at least ___ days, with no material change during that time.
- [ ] The proposal document's status is set to `ACCEPTED`.
- [ ] Implementation trackers are captured in the `Implementation trackers` field.
- [ ] The associated discussion thread is closed.

Move from **`#accepted`** to **`#released`**, and merge this PR, when:

- [ ] All blocking proposals (`Depends on`) are resolved.
- [ ] The implementation is released into production.
- [ ] The specification matches the final implementation in production.
- [ ] The proposal document's status is set to `RELEASED`.
- [ ] The proposal is added to `proposals/INDEX.md` with the next sequential number.

Move from **`#proposed`** to **`#rejected`**, and merge this PR, when:

- [ ] Feedback is gathered from all relevant stakeholders.
- [ ] There is consensus that the proposal should not be implemented.
- [ ] Final comments have been solicited for at least ___ days.
- [ ] The updates to the specification artifacts are reverted.
- [ ] Only the proposal document remains in the diff with `main`.
- [ ] The proposal document's status is set to `REJECTED`, and it captures the rationale for that decision.
- [ ] The proposal is added to `proposals/INDEX.md` with the next sequential number.
- [ ] The associated discussion thread is closed.

> [!IMPORTANT]
> Rejected proposals' specification edits MUST NOT be merged to `main`, because the `main` trunk represents the as-is state of the production system. Only the `REJECTED` proposal document is merged, capturing the rationale for the decision and preserving the history of the proposal's evolution.
