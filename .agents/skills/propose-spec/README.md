# Propose spec

Handles the `DRAFT` → `PROPOSED` transition.

Checks the proposal document and the `specification/` edits are complete, sets
the status, applies the `#proposed` label, and takes the pull request out of
draft so stakeholders can review it.

It applies a readiness gate. It does not fill in what is missing, and it
decides nothing about the proposal's merits.

## Interactivity

Interactive. Where the target proposal cannot be inferred from the checked-out
branch, the agent lists the open draft pull requests and asks which one is
meant. It is not suited to away-from-keyboard workflows.

## How to invoke

> This proposal is ready for review

> Mark the proposal ready

> Take this out of draft

> Propose user-session-timeout

> Propose 42

## Recommended models

A mid-tier model is sufficient. Applying the readiness gate calls for judgment
about whether a section is substantive, but the transition itself is
procedural.

## Suggested workflows

Run this once the proposal document and the specification edits are both
complete. Do not run it to solicit early feedback — that is what the
discussion thread is for, and the proposal can stay in `DRAFT` while it
happens.

```mermaid
flowchart LR
  %% Node labels and classes.
  before["🧑<br/>author proposal<br/>and spec edits"]:::anthropic
  this["🤖🧑<br/>propose-spec"]:::anthropic
  after["🤖🧑<br/>accept-spec<br/>or reject-spec"]:::anthropic

  %% Main workflow sequence.
  before ==> this
  this ==> after

  %% Class definitions.
  classDef agentic fill:#cce5ff,stroke:#004085,color:#004085,stroke-width:2px
  classDef scripted fill:#e2e3e5,stroke:#4b5157,color:#383d41,stroke-width:2px
  classDef anthropic fill:#fff3cd,stroke:#856404,color:#856404,stroke-width:1px,stroke-dasharray:2 3
```

## Related skills

- [**draft-spec**](../draft-spec/) \
  Scaffolds the branch, document, and pull request that this skill takes out
  of draft.

- [**accept-spec**](../accept-spec/) \
  Records the stakeholders' approval, the next transition after this one.

- [**reject-spec**](../reject-spec/) \
  Records the stakeholders' rejection, the alternative next transition.

## References

- [Contributing guidelines](../../../CONTRIBUTING.md) — the lifecycle state
  machine and the permitted transitions.
