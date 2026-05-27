# Workflow

Anyone with write access to this repository may propose changes to the functional and non-functional requirements of the system. The product managers are responsible for maintaining the specification, and for tracking proposals through their lifecycle.

## Branch conventions

The default branch of this repository is `prod`. This name is intentional. The `prod` trunk always reflects the as-is state of the production system. The [specification sections](../specification/) on `prod` are the authoritative record of what the system currently does in production. Proposals that have not yet shipped to production are never merged into `prod`.

All proposal branches are cut from `prod` and merged back into `prod` — but only once the proposed changes have been released to real users. See the [proposal lifecycle](./lifecycle.md) for the full set of conditions that must be met before a proposal is merged.

## Proposing a change

To propose a change:

1. Branch off `prod` using the naming convention `proposal/[description]`, where `[description]` is a short hyphen-delimited slug. For example, `proposal/user-session-timeout`.

2. Copy [`proposals/TEMPLATE.md`](../proposals/TEMPLATE.md) to `proposals/[short-description].md` and fill it out. Describe the change, the rationale for it, and its expected impact on the business and its customers.

3. Edit the specification sections to reflect the intended final state of the system after the change ships. You may add, modify, or delete artifacts as necessary. Treat the spec sections as the destination, not a changelog.

4. Commit your changes and open a pull request titled `proposal: [short description]`. Each pull request MUST be focused on a single atomic change. If you have multiple changes to propose, open multiple pull requests.

Your proposal is now open for comments. Invite feedback from all relevant stakeholders, and be prepared to iterate.

Product managers are responsible for using the PR's checklist to track the proposal through its lifecycle.

When a proposal is **accepted**, the product managers should assign the proposal a sequential ID, update its status, and queue it for implementation. When the implementation ships to production, the proposal's status becomes **implemented** and its changes to the specification sections are merged into `prod`.

When a proposal is **rejected**, the proposal document is still merged into `prod` (with status `REJECTED`), but the accompanying edits to the specification sections are reverted. This is how rejected proposals are preserved – the decision and its rationale live on in [`proposals/`](../proposals/), even though the system itself is unchanged.
