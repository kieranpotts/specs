# Proposal lifecycle

The [specification sections](../specification/) always reflect the _current_ state of the system, released to real users in production.

Changes to the production state are introduced through proposals. A proposal MAY be preceded by a GitHub issue (FEATURE or PERFORMANCE) for early triage, but issues are optional — a pull request MAY be opened directly. See the [workflow](./workflow.md) for the full process.

## State machine

Each proposal moves through a defined state machine. The current state is represented by a lifecycle label applied to the pull request. The labels are named `#draft`, `#proposed`, `#accepted`, `#rejected`, `#released`, and `#deprecated`. Only the product managers may advance a proposal's state, and only along the permitted transitions described below.

```text
draft → proposed → accepted → released → deprecated
                 ↘ rejected
```

The states are:

- **Draft**: The proposal has been opened as a pull request but is not yet ready for full stakeholder review. The proposer is still refining the proposal document and/or the specification edits.

- **Proposed**: The proposal is complete and is being formally reviewed and negotiated with the relevant stakeholders. No further material changes should be made to the proposal document during this period without resetting the review clock.

- **Accepted**: The proposal has been approved by the product managers and is queued for implementation. A sequential ID has been assigned.

- **Rejected**: The proposal will not be taken forward. The pull request is merged (so the decision is preserved in `prod`), but any accompanying edits to the specification sections are reverted first.

- **Released**: The implementation is live in production. The proposal's edits to the specification sections have been merged into `prod`.

- **Deprecated**: A previously released proposal that is no longer in effect — for example, because a later proposal superseded or removed the feature.

## Permitted transitions

| From | To | Condition |
| --- | --- | --- |
| _(new PR)_ | `#draft` | PR opened; proposal still being drafted |
| _(new PR)_ | `#proposed` | PR opened; proposal is already complete |
| `#draft` | `#proposed` | Proposal document and spec edits are complete and ready for review |
| `#proposed` | `#accepted` | Stakeholder review concluded; proposal approved |
| `#proposed` | `#rejected` | Stakeholder review concluded; proposal not approved |
| `#accepted` | `#released` | Implementation shipped to production |
| `#released` | `#deprecated` | Feature removed or superseded by a later proposal |

Transitions not listed above are not permitted. In particular: a proposal MUST NOT move backwards (eg. from `#proposed` back to `#draft`), and a proposal MUST NOT skip states (eg. from `#draft` directly to `#accepted`).

## Immutability

Once a proposal reaches **accepted** or **rejected**, its document is treated as immutable. Only its status label may change thereafter. This ensures that the record of every past decision — including rejected ones — is preserved indefinitely.

To revisit a past decision, open a new proposal that supersedes the original and cross-reference the two.
