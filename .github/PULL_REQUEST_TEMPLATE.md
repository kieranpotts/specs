Copy the "Summary" section from the proposal document here.

- Issue: #...
- Proposal document: ./proposals/[my-proposal].md
- Discussion thread: [Link]

**Please use the discussion thread, not this pull request, to provide feedback on the proposal.** This keeps the pull request thread clean and focused on the edit history of the proposal document itself.

## Checklist

This section is maintained by the project maintainers to track the proposal through its lifecycle. See the [proposal lifecycle docs](../docs/lifecycle.md) for the meaning of each state.

To move this proposal from **DRAFT** to **PROPOSED**:

- [ ] The originating issue was accepted before this pull request was opened.
- [ ] The proposal document is complete enough to invite review from other stakeholders.
- [ ] A discussion thread has been created (if needed) and linked from this pull request, and vice versa.
- [ ] The proposal's `Status` is set to "PROPOSED".

To move this proposal from **PROPOSED** to either **ACCEPTED** or **REJECTED**:

- [ ] Feedback has been gathered from the relevant stakeholders via the discussion thread.
- [ ] The main points of contention have been resolved and the proposed change has stabilized.
- [ ] Final comments have been solicited for at least ___ days.
- [ ] The proposal has not materially changed during the final comment period.
- [ ] A sequential ID has been assigned and the file renamed to `proposals/NNNN-[slug].md`.
- [ ] The proposal's `Status` is set to "ACCEPTED" or "REJECTED".

If **ACCEPTED**, before this pull request is merged:

- [ ] The edits to the specification sections reflect the intended final state of the system.
- [ ] Implementation tickets have been created and linked from the proposal document.

If **REJECTED**, before this pull request is merged:

- [ ] The edits to the specification sections have been reverted, so that only the proposal document will be added when this PR is merged. (The system itself is unchanged, but the decision is preserved.)

After the implementation has been released into production:

- [ ] The proposal's `Status` is set to "RELEASED".
- [ ] The specification sections match the final implementation in production.

> [!IMPORTANT]
> Do not merge this pull request until all checks above have been completed. The project maintainers will update this checklist as the proposal moves through its lifecycle, and will merge the PR only when the proposed changes have been released to users in production.
