_Copy the "Summary" section from the proposal document here._

- Originating issue: #... _(if applicable)_
- Discussion thread: [Link] _(if applicable)_

> [!IMPORTANT]
> Please use the discussion thread linked above, not comments on this pull request, to provide feedback on this proposal. This will keep the PR thread focused on the edit history of the proposal document and the evolution of the specification artifacts.

----

## Checklist

The project maintainers will update this checklist as the proposal moves through its lifecycle. They will merge this PR only when the proposal is released to users in production, or when it is rejected. See the [contributing guidelines](../CONTRIBUTING.md) for more details about state transitions for requirements specifications.

Move from **`#draft`** to **`#proposed`** when:

- [ ] The proposal is complete enough to invite stakeholder review.
- [ ] A discussion thread is created, if needed.
- [ ] The originating issue, if there is one, is closed.

Move from **`#proposed`** to **`#accepted`** when:

- [ ] Feedback is gathered from all relevant stakeholders.
- [ ] The main points of contention are resolved.
- [ ] The proposed specification has stabilized.
- [ ] The specification reflects the intended end state of the system.
- [ ] Final comments have been solicited for at least ___ days.
- [ ] The specification has not materially changed during this time.
- [ ] The proposal doc's status is set to `ACCEPTED`.
- [ ] Implementation tickets are captured in the `Implementation trackers` field.

Move from **`#accepted`** to **`#released`**, and merge this PR, when:

- [ ] All implementation trackers (`Implementation trackers`) are resolved.
- [ ] The implementation is released into production.
- [ ] The specification matches the final implementation in production.
- [ ] The document is given a sequential prefix: `proposals/NNNN-[slug].md`.

Move from **`#proposed`** to **`#rejected`**, and merge this PR, when:

- [ ] Feedback is gathered from all relevant stakeholders.
- [ ] There is consensus that the proposals should not be implemented.
- [ ] Final comments have been solicited for at least ___ days.
- [ ] The updates to the specification artifacts are reverted.
- [ ] Only the proposal document exists in the diff with `main`.
- [ ] The proposal doc's status is set to `REJECTED`.
- [ ] The proposal doc captures the rationale for its `REJECTED` status.
- [ ] The document is given a sequential prefix: `proposals/NNNN-[slug].md`.

> [!IMPORTANT]
> Rejected specifications MUST NOT be merged to `main`, because the `main` trunk represents the as-is state of the production system. Only the `REJECTED` proposal document should be merged, capturing the rationale for the decision and preserving the history of the proposal's evolution.
