# Proposals

This directory is the permanent archive of every proposed change to the software requirements specification.

The [specification sections](../specification/) always describe the system as it is _now_ in production. This proposals directory records how it got there. Every change is introduced through a proposal, and every proposal is kept here as a permanent document — including proposals that were ultimately rejected. Rejected proposals are not deleted, but remain as a record of the decision and the rationale behind why they were rejected, so that the same ground is not needlessly re-trodden later.

## How it works

1. A proposal starts as a copy of [`TEMPLATE.md`](./TEMPLATE.md), authored on a `proposal/[short-description]` branch and opened as a pull request. See [the workflow](../docs/workflow.md) for the full process.

2. The proposal moves through its [lifecycle](../docs/lifecycle.md): `DRAFT → PROPOSED → ACCEPTED|REJECTED → RELEASED → DEPRECATED`.

3. On merge, the project maintainers assign the proposal a sequential, zero-padded ID and rename its file to `NNNN-[description].md` (for example, `0002-private-browsing.md`).

4. Once a proposal is **ACCEPTED** or **REJECTED**, its document is immutable. Only its status may change thereafter. To revisit a decision, open a new proposal that supersedes the original, and cross-reference the two using the `Supersedes` / `Superseded by` fields in the template.

## Index

| ID | Title | Author | Status |
| ---- | ----- | ------ | ------ |
|      |       |        |        |
