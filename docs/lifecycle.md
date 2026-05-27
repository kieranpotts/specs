# Proposal lifecycle

The [specification sections](../specification/) always reflect the _current_ state of the system, released to real users in production.

Changes to the production state are introduced through proposals. Every proposal starts as a GitHub issue (FEATURE or PERFORMANCE) to allow initial triage before any specification edits are made. Once the idea is accepted, a pull request is opened to carry the proposal through the rest of its lifecycle. See the [workflow](./workflow.md) for the full process.

Each proposal is a single, permanent document under [`proposals/`](../proposals/), and moves through the following states:

- **DRAFT**: A preliminary proposal, put forward for early feedback.

- **PROPOSED**: A proposal that is being negotiated with the relevant stakeholders.

- **ACCEPTED**: A proposal that has been approved and is pending implementation and release.

- **REJECTED**: A proposal that will not be taken forward. The document is kept as a permanent record of the decision and its rationale.

- **RELEASED**: A proposal whose changes are live in production and have been folded into the specification sections.

- **DEPRECATED**: A previously implemented proposal that has since been removed or superseded, and is no longer in effect.

```text
DRAFT → PROPOSED → ACCEPTED → RELEASED → DEPRECATED
                 ↘ REJECTED
```

Once a proposal reaches **ACCEPTED** or **REJECTED**, its document is treated as immutable. Only its status may change thereafter. This ensures that the record of every past decision — including rejected ones — is preserved indefinitely.

To revisit a past decision, open a new proposal that supersedes the original and cross-reference the two.
