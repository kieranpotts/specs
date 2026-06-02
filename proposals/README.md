# Proposals

This directory is the permanent archive of every proposed change to the software requirements specification.

The [specification sections](../specification/) always describe the system as it is _now_ in production. This proposals directory records how it got there. Every change is introduced through a proposal, and every proposal is kept here as a permanent document — including proposals that were ultimately rejected. Rejected proposals are not deleted, but remain as a record of the decision and the rationale behind it, so that the same ground is not needlessly re-trodden later.

## How it works

1. A proposal is opened as a pull request: a copy of [`TEMPLATE.md`](./TEMPLATE.md), authored on a `proposal/[short-description]` branch. A GitHub issue (FEATURE or QUALITY) MAY be opened first for lightweight early triage — if so, the proposer closes it when the PR is opened and links the two. See the [contributing guide](../CONTRIBUTING.md) for the full process.

2. The proposal moves through its [lifecycle](../CONTRIBUTING.md#proposal-lifecycle): `draft → proposed → accepted|rejected → released → deprecated`.

3. On merge, the project maintainers assign the proposal a sequential, zero-padded ID and rename its file to `NNNN-[description].md` (for example, `0002-private-browsing.md`).

4. A proposal document becomes immutable once its PR is merged into `main`. While a proposal is still open, its document may be updated at any point — including during the `#accepted` implementation phase, in response to technical feedback, implementation discoveries, or feedback from real users during beta testing. To revisit a decision that has already been merged, open a new proposal that supersedes the original, and cross-reference the two using the `Supersedes` / `Superseded by` fields in the template.

## Index

| ID   | Title | Author | Status |
| ---- | ----- | ------ | ------ |
| 0001 | [Catalog read API](./0001-catalog-read-api.md) | Kieran Potts | #released |
| 0002 | [Search by tag](./0002-search-by-tag.md) | Kieran Potts | #released |
