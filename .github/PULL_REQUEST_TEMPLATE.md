Copy the "Summary" section from the proposal document here.

- Originating issue: #... _(if applicable)_
- Discussion thread: [Link] _(if applicable)_

**Please use the discussion thread, not this pull request, to provide feedback on the proposal.** This keeps the pull request thread clean and focused on the edit history of the proposal document itself.

## Checklist

This section is maintained by the project maintainers to track the proposal through its lifecycle. See the [proposal lifecycle](../CONTRIBUTING.md#proposal-lifecycle) for the meaning of each state. Apply the matching lifecycle label to this PR as the proposal advances.

> [!IMPORTANT]
> Do not merge this pull request until all checks below have been completed. The project maintainers will update this checklist as the proposal moves through its lifecycle, and will merge the PR only when the proposed changes have been released to users in production.

To move this proposal from **draft** to **proposed**:

- [ ] The proposal document is complete enough to invite full stakeholder review.
- [ ] Any originating issue has been closed and linked from this pull request.
- [ ] A discussion thread has been created (if needed) and linked from this pull request, and vice versa.
- [ ] Label updated to `#proposed`.

To move this proposal from **proposed** to either **accepted** or **rejected**:

- [ ] Feedback has been gathered from the relevant stakeholders via the discussion thread.
- [ ] The main points of contention have been resolved and the proposed change has stabilized.
- [ ] Final comments have been solicited for at least ___ days.
- [ ] The proposal has not materially changed during the final comment period.
- [ ] A sequential ID has been assigned and the file renamed to `proposals/NNNN-[slug].md`.
- [ ] Label updated to `#accepted` or `#rejected`.

If **accepted**, before this pull request is merged:

- [ ] All blocking dependencies listed in the proposal's `Depends on` field are resolved, or the risks of proceeding have been explicitly accepted.
- [ ] The edits to the specification sections reflect the intended final state of the system.
- [ ] Implementation tickets have been created and linked from the proposal document.

If **rejected**, before this pull request is merged:

- [ ] The edits to the specification sections have been reverted, so that only the proposal document will be added when this PR is merged. (The system itself is unchanged, but the decision is preserved.)

After the implementation has been released into production:

- [ ] Label updated to `#released`.
- [ ] The specification sections match the final implementation in production.
