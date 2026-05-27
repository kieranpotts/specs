# Proposal lifecycle

The [specification sections](../specification/) always reflect the _current_ state of the system, released to real users in production.

Changes to the production state are introduced through proposals. Each proposal is a single, permanent document under [`proposals/`](../proposals/), and moves through the following states:

- **Draft**: A preliminary proposal, put forward for early feedback.

- **Proposed**: A proposal that is being negotiated with the relevant stakeholders.

- **Accepted**: A proposal that has been approved and is pending implementation.

- **Rejected**: A proposal that will not be taken forward. The document is kept as a permanent record of the decision and its rationale.

- **Implemented**: A proposal whose changes are live in production and have been folded into the specification sections.

- **Deprecated**: A previously implemented proposal that has since been superseded and is no longer in effect.

- **Superseded**: A proposal that has been replaced by a later proposal.

```text
draft → proposed → accepted → implemented → deprecated
                 ↘ rejected               ↘ superseded
```

Once a proposal reaches **accepted** or **rejected**, its document is treated as immutable. Only its status may change thereafter. This ensures that the record of every past decision — including rejected ones — is preserved indefinitely.

To revisit a past decision, open a new proposal that supersedes the original and cross-reference the two.
