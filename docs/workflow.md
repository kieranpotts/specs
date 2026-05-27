# Workflow

Anyone with write access to this repository may propose changes to the functional and non-functional requirements of the system. The product managers are responsible for maintaining the specification, and for tracking proposals through their lifecycle.

## Branch conventions

The default branch of this repository is `prod`. This name is intentional. The `prod` trunk always reflects the as-is state of the production system. The [specification sections](../specification/) on `prod` are the authoritative record of what the system currently does in production. Proposals that have not yet shipped to production are never merged into `prod`.

All proposal branches are cut from `prod` and merged back into `prod` — but only once the proposed changes have been released to real users. See the [proposal lifecycle](./lifecycle.md) for the full set of conditions that must be met before a proposal is merged.

## Proposing a change

### Step 1: Open an issue (OPTIONAL)

Before writing a full proposal, the proposer MAY open a GitHub issue to gather early feedback and gauge whether the idea is worth progressing. Choose the appropriate template:

- **FEATURE**: To canvas opinion on a new or changed functional requirement.
- **PERFORMANCE**: To canvas opinion on a new or changed non-functional requirement.

The issue is a lightweight way to surface the idea to stakeholders and get initial triage from the product managers without committing to a full proposal. When the proposer decides to move forward, they close the issue and open a pull request (see Step 2). If the idea is not pursued, the issue is simply closed without further action.

If an issue is opened, there MUST be a cross-reference between the issue and the pull request when one is subsequently opened.

### Step 2: Open a discussion (OPTIONAL)

If the idea needs more in-depth exploration before a firm proposal can be written, the proposer MAY open an [ideas discussion](https://github.com/kieranpotts/specs/discussions) in addition to (or instead of) an issue. There MUST be cross-references between the discussion thread and any related issue or pull request.

Discussion threads are open-ended and well-suited to early brainstorming.

### Step 3: Open a pull request (REQUIRED to progress a proposal)

A pull request is the formal vehicle for a proposal. It MAY be opened at any point — with or without a prior issue — as soon as the proposer is ready to commit to writing the full proposal document.

1. Branch off `prod` using the naming convention `proposal/[description]`, where `[description]` is a short hyphen-delimited slug. For example, `proposal/user-session-timeout`.

2. Copy [`proposals/TEMPLATE.md`](../proposals/TEMPLATE.md) to `proposals/[short-description].md` and fill it out. If an issue was opened, set the `Issue` field to link back to it. Describe the change in full detail: the rationale, the expected impact on the business and its customers, and the alternatives that were considered.

3. Edit the specification sections to reflect the intended final state of the system after the change ships. You may add, modify, or delete artifacts as necessary. Treat the spec sections as the destination, not a changelog.

4. Commit your changes and open a pull request titled `proposal: [short description]`. Each pull request MUST be focused on a single atomic change. If you have multiple changes to propose, open multiple pull requests.

The pull request MAY be opened at `#draft` status while the proposal document and specification edits are still being refined, or at `#proposed` status when it is ready for full stakeholder review.

Product managers are responsible for using the PR's checklist to track the proposal through its lifecycle, and for applying the matching lifecycle label (`#draft`, `#proposed`, `#accepted`, `#rejected`, `#released`) to the PR as the proposal advances.

When a proposal is `#accepted`, the product managers should assign the proposal a sequential ID, update its status, and queue it for implementation. When the implementation ships to production, the proposal's status becomes `#released` and its changes to the specification sections are merged into `prod`.

When a proposal is `#rejected`, the proposal document is still merged into `prod`, but the accompanying edits to the specification sections are reverted. This is how rejected proposals are preserved — the decision and its rationale live on in [`proposals/`](../proposals/), even though the system itself is unchanged.
