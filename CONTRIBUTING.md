# Contributing

Anyone with write access to this repository may propose changes to the functional and non-functional requirements of the system. The product managers are responsible for maintaining the specification, and for tracking proposals through their lifecycle.

## Branch conventions

The default branch of this repository is `prod`. This name is intentional. The `prod` trunk always reflects the as-is state of the production system. The [specification sections](./specification/) on `prod` are the authoritative record of what the system currently does in production. Proposals that have not yet shipped to production are never merged into `prod`.

All proposal branches are cut from `prod` and merged back into `prod` — but only once the proposed changes have been released to real users. See the [lifecycle](#proposal-lifecycle) section below for the full set of conditions that must be met before a proposal is merged.

## Proposing a change

### Step 1: Open an issue (OPTIONAL)

Before writing a full proposal, the proposer MAY open a GitHub issue to gather early feedback and gauge whether the idea is worth progressing. Choose the appropriate template:

- **FEATURE**: To canvass opinion on a new or changed functional requirement.

- **PERFORMANCE**: To canvass opinion on a new or changed non-functional requirement.

The issue is a lightweight way to surface the idea to stakeholders and get initial triage from the product managers without committing to a full proposal. When the proposer decides to move forward, they close the issue and open a pull request (see step 3). If the idea is not pursued, the issue is simply closed without further action.

If an issue is opened, there MUST be a cross-reference between the issue and the pull request, when one is subsequently opened.

### Step 2: Open a discussion (OPTIONAL)

If the idea needs more in-depth exploration before a firm proposal can be written, the proposer MAY open a [discussion](https://github.com/kieranpotts/specs/discussions) in addition to the issue. There MUST be cross-references between the discussion thread and any related issues or pull requests.

Discussion threads are open-ended and well-suited to early brainstorming.

### Step 3: Open a pull request (REQUIRED to progress a proposal)

A pull request is the formal vehicle for a proposal. It MAY be opened at any point — with or without a prior issue or discussion — as soon as the proposer is ready to commit to writing the full proposal document.

Follow these steps to prepare the pull request:

1. Branch off `prod` using the naming convention `proposal/[description]`, where `[description]` is a short hyphen-delimited slug. For example, `proposal/user-session-timeout`.

2. Copy [`proposals/TEMPLATE.md`](./proposals/TEMPLATE.md) to `proposals/[description].md` and fill it out. If an issue was opened, set the `Issue` field to link back to it. Describe the change in full detail: the rationale, the expected impact on the business and its customers, and the alternatives that were considered.

3. Edit the specification sections to reflect the intended final state of the system after the change ships. You may add, modify, or delete artifacts as necessary. Treat the spec sections as the destination, not a changelog.

4. Commit your changes and open a pull request titled `feature: [description]` (for functional changes) or `performance: [description]` (for performance changes). Each pull request MUST be focused on a single atomic change — one feature or performance requirement that can be reviewed, decided, and shipped independently of any other. If you have multiple changes to propose, open multiple pull requests.

The pull request MAY be opened at `#draft` status while the proposal document and specification edits are still being refined, or at `#proposed` status when it is ready for full stakeholder review.

## Proposal lifecycle

The [specification sections](./specification/) always reflect the _current_ state of the system, as it is experienced by real users in production. Changes to that state are introduced through proposals.

### State machine

Each proposal moves through a defined state machine. The current state is represented by a lifecycle label applied to the pull request. The labels are named `#draft`, `#proposed`, `#accepted`, `#rejected`, `#released`, and `#deprecated`. Only the product managers may advance a proposal's state. They verify gates using the PR's checklist and apply the matching label as each transition occurs.

```text
draft → proposed → accepted → released → deprecated
                 ↘ rejected
```

The states are:

- **Draft**: The proposal has been opened as a pull request but is not yet ready for full stakeholder review. The proposer is still refining the proposal document and/or the specification edits.

- **Proposed**: The proposal is complete and is being formally reviewed and negotiated with the relevant stakeholders. No further material changes should be made to the proposal document during this period, unless requested by the product managers.

- **Accepted**: The proposal has been approved by the product managers, who assign a sequential ID and queue the work for implementation. This may involve, for example, opening issues against the relevant code repositories and linking them back to the proposal.

- **Rejected**: The proposal will not be taken forward. The accompanying edits to the specification sections are reverted before merge, so the system itself is unchanged. But the proposal document is preserved permanently in [`proposals/`](./proposals/) as the record of the decision and its rationale.

- **Released**: The implementation is live in production. The proposal's edits to the specification sections have been merged into `prod`.

- **Deprecated**: A previously released proposal that is no longer in effect — for example, because a later proposal superseded or removed the feature.

### Permitted transitions

| From | To | Condition |
| --- | --- | --- |
| _(new PR)_ | `#draft` | PR opened; proposal still being drafted. |
| _(new PR)_ | `#proposed` | PR opened; proposal is already complete. |
| `#draft` | `#proposed` | Proposal document and spec edits are complete and ready for review. |
| `#proposed` | `#accepted` | Stakeholder review concluded; proposal approved. |
| `#proposed` | `#rejected` | Stakeholder review concluded; proposal not approved. |
| `#accepted` | `#released` | Implementation shipped to production. |
| `#released` | `#deprecated` | Feature removed or superseded by a later proposal. |

Transitions not listed above are not permitted. In particular: a proposal MUST NOT move backwards (eg. from `#proposed` back to `#draft`), and a proposal MUST NOT skip states (eg. from `#draft` directly to `#accepted`).

### Immutability

Once a proposal reaches the `#accepted` or `#rejected` state, its document is treated as immutable. Only its status label may change thereafter. This ensures that the record of every past decision — including rejected ones — is preserved indefinitely.

To revisit a past decision, open a new proposal that supersedes the original and cross-reference the two.
