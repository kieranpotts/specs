# Workflow

Anyone with write access to this repository may propose changes to the functional and non-functional requirements of the system. The product managers are responsible for maintaining the specification, and for tracking proposals through their lifecycle.

## Branch conventions

The default branch of this repository is `prod`. This name is intentional. The `prod` trunk always reflects the as-is state of the production system. The [specification sections](../specification/) on `prod` are the authoritative record of what the system currently does in production. Proposals that have not yet shipped to production are never merged into `prod`.

All proposal branches are cut from `prod` and merged back into `prod` — but only once the proposed changes have been released to real users. See the [proposal lifecycle](./lifecycle.md) for the full set of conditions that must be met before a proposal is merged.

## Proposing a change

### Step 1: Open an issue (REQUIRED)

Every proposal starts as a GitHub issue. Choose the appropriate template:

- **FEATURE**: To propose a new or changed functional requirement.
- **PERFORMANCE**: To propose a new or changed non-functional requirement.

Fill out the issue template, describing the proposed change at a high level: what it is, why it should be made, who it affects, and what the expected impact is.

The issue is the place for initial stakeholder feedback and triage. Product managers will evaluate whether the proposal is worth pursuing, and whether it is in scope.

### Step 2: Open a discussion (OPTIONAL)

If the idea needs more exploration before a firm proposal can be made, the proposer MAY open an [ideas discussion](https://github.com/kieranpotts/specs/discussions) in addition to the issue. There MUST be cross-references between the issue and the discussion thread.

Discussion threads are open-ended and well-suited to early  brainstorming.

### Step 3: Open a pull request (REQUIRED to move a proposal forward)

Once the issue has been reviewed and the idea is accepted for further development, the proposer opens a pull request to progress the proposal:

1. Branch off `prod` using the naming convention `proposal/[description]`, where `[description]` is a short hyphen-delimited slug. For example, `proposal/user-session-timeout`.

2. Copy [`proposals/TEMPLATE.md`](../proposals/TEMPLATE.md) to `proposals/[short-description].md` and fill it out. Set the `Issue` field to link back to the originating issue. Describe the change in full detail: the rationale, the expected impact on the business and its customers, and the alternatives that were considered.

3. Edit the specification sections to reflect the intended final state of the system after the change ships. You may add, modify, or delete artifacts as necessary. Treat the spec sections as the destination, not a changelog.

4. Commit your changes and open a pull request titled `proposal: [short description]`. Each pull request MUST be focused on a single atomic change. If you have multiple changes to propose, open multiple pull requests.

Your proposal is now open for detailed review. Invite feedback from all relevant stakeholders, and be prepared to iterate.

Product managers are responsible for using the PR's checklist to track the proposal through its lifecycle.

When a proposal is **ACCEPTED**, the product managers should assign the proposal a sequential ID, update its status, and queue it for implementation. When the implementation ships to production, the proposal's status becomes **RELEASED** and its changes to the specification sections are merged into `prod`.

When a proposal is **REJECTED**, the proposal document is still merged into `prod` (with status "REJECTED"), but the accompanying edits to the specification sections are reverted. This is how rejected proposals are preserved — the decision and its rationale live on in [`proposals/`](../proposals/), even though the system itself is unchanged.
