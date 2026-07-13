# Proposals

This directory is the permanent archive of every proposed change to the software
requirements specification — released, rejected, and superseded alike. Nothing
here is ever deleted; rejected proposals remain as a record of the decision and
its rationale, so that the same ground is not needlessly covered again later.

## Layout

Each proposal is a directory:

```
proposals/
├── INDEX.md          # the numbered catalog of merged proposals
├── TEMPLATE.md       # the starting point for a new proposal
└── <slug>/
    ├── README.md                 # the proposal document
    ├── product-requirements.md   # the originating PRD, preserved (if any)
    └── …                         # wireframes, mock-ups, or other supporting artifacts
```

A proposal's directory holds its `README.md` (the proposal itself, copied from
[`TEMPLATE.md`](./TEMPLATE.md)) plus any supporting artifacts.

Where a proposal originates from a **product-requirements document** (PRD) — a
business-language statement of the need, such as a discovery report — that PRD
is preserved verbatim as `product-requirements.md` alongside the proposal, and
linked from the proposal's `Origin` field. It is a *frozen origin record*: the
requirement exactly as it arrived, before specification. The proposal and its
spec edits evolve through review and implementation; the preserved PRD does not.
Not every proposal has one — a small or internally-motivated change may be
specified directly — in which case the `Origin` field is omitted.

## How it works

1. A proposal is opened as a **draft pull request**, on a `proposal/<slug>`
   branch for a feature or quality proposal, or an `epic/<slug>` branch for an
   epic. The document lives at `proposals/<slug>/README.md`. The PR carries
   exactly one type label (`FEATURE`, `QUALITY`, or `EPIC`) and an associated
   discussion thread for all review feedback. (The issue tracker is not used for
   proposals; it is reserved for repository maintenance only.)

2. The proposal moves through its
   [lifecycle](../CONTRIBUTING.md#proposal-lifecycle): `DRAFT` → `PROPOSED` →
   `ACCEPTED` | `REJECTED`, then an accepted proposal becomes `RELEASED` once
   live in production, and may later be `SUPERSEDED`.

3. On merge, the product managers assign the proposal a sequential, zero-padded
   number and record it in [`INDEX.md`](./INDEX.md). The number appears only in
   the index — no directory is ever renamed.

4. Once merged into `main`, the document is immutable. While a proposal is still
   open, its document may be updated at any point — including during the
   `#accepted` implementation phase, in response to technical feedback,
   implementation discoveries, or feedback from real users during beta testing.
   To revisit a decision already merged, open a new proposal that supersedes the
   original, cross-referencing the two via the `Supersedes` / `Superseded by`
   fields.

See the [contributing guide](../CONTRIBUTING.md) for the full process, and the
[skills](../.agents/skills/) that automate it. The numbered catalog of all
merged proposals lives in [`INDEX.md`](./INDEX.md).
