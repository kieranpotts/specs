# Specification

This section documents the current specification of the production system — what the system does as-is.

These sections always reflect the system's current state. Changes to that state are introduced through [proposals](../proposals/). See the [contributing guide](../CONTRIBUTING.md) to understand the lifecycle from proposal to specification.

The specification is divided into two parts:

- [**Context**](./context/) — descriptive background: the problem space the system operates in, and what the domain _is_.

- [**Requirements**](./requirements/) — the prescriptive contract: what the system must _do_, and how _well_ it must do it.

## Layout

```
specification/
├── context/                  ← descriptive: the problem space
│   ├── overview/             mission, problem, scope
│   ├── constraints/          regulatory/legal/business constraints + assumptions + dependencies
│   ├── glossary/             ubiquitous language
│   ├── model/                domain entities, relationships, ERD
│   └── actors/               participants + hierarchy (definitions only — no permissions)
└── requirements/             ← prescriptive: the contract
    ├── behaviors/            functional requirements
    │   ├── access/           permission matrix: which actors may exercise which capabilities
    │   ├── rules/            invariants, policies, lifecycle transitions
    │   ├── features/         Gherkin scenarios
    │   ├── journeys/         wireframes and/or call-sequences
    │   └── interfaces/       external contract: operations, resources, events
    └── qualities/            non-functional requirements
        ├── latency.md
        └── …
```

## Context

- [**Overview**](./context/overview/): A high-level description of the system — its mission, the problem it solves, and its scope.

- [**Constraints**](./context/constraints/): The conditions imposed on the system from outside — regulatory, legal, and business constraints, standing assumptions, and external dependencies.

- [**Glossary**](./context/glossary/): The project's ubiquitous language — every domain term, briefly defined.

- [**Model**](./context/model/): The entities in the system's domain model, and how they relate to one another.

- [**Actors**](./context/actors/): The participants in the domain — people, organizations, and external systems — and the hierarchy between them.

## Requirements

### Behaviors — functional requirements

- [**Access**](./requirements/behaviors/access/): The permission matrix — which actors may exercise which capabilities.

- [**Rules**](./requirements/behaviors/rules/): Business rules, invariants, and policies that hold across features, including the lifecycle transitions of domain entities.

- [**Features**](./requirements/behaviors/features/): The system's functional requirements, expressed as scenarios in [Gherkin](https://cucumber.io/docs/gherkin/) notation.

- [**Journeys**](./requirements/behaviors/journeys/): How features combine into coherent flows — wireframes for user-facing systems, annotated call-sequences for headless ones.

- [**Interfaces**](./requirements/behaviors/interfaces/): The system's external contract — the operations, resources, and events it exposes to its consumers.

### Qualities — non-functional requirements

- [**Qualities**](./requirements/qualities/): The system's non-functional requirements: its quality attributes and performance targets.

## Why it's organized this way

The taxonomy above is the result of deliberate choices, not convention. Each split exists to give a category of requirement a single, unambiguous home, so that nothing is scattered across files or left undocumented. The reasoning behind the less obvious decisions is recorded here so it is not lost.

### Context vs. requirements — the descriptive/prescriptive spine

The top-level split is between what _is_ and what _must be_. [Context](./context/) is descriptive: the domain, its vocabulary, its participants, and the conditions the system operates within. None of it is a requirement in its own right — it is the shared frame of reference from which requirements are derived. [Requirements](./requirements/) is prescriptive: every statement is an obligation that can, in principle, be verified against the running system. Keeping the two apart means a reader always knows whether they are reading background or a binding commitment, and it prevents descriptive material from quietly accreting the force of a requirement. The older "functional vs. non-functional" cut survives one level down, as [behaviors](./requirements/behaviors/) vs. [qualities](./requirements/qualities/) — a better-named version of the same classic distinction.

### Why access is separate from actors

[Actors](./context/actors/) define _who_ participates — the roles and the hierarchy between them. That is a description of the domain, so it lives in context. [Access](./requirements/behaviors/access/) defines _what each participant is permitted to do_ — and a permission is a requirement the system must enforce, so it lives in requirements. Folding permissions into the actor definitions would straddle the context/requirements line: the actor list would become part-description, part-contract. Splitting them keeps each artifact on one side of the line, and gives the permission matrix a single authoritative home (capability × actor → allowed?) that features can reference rather than restate. The "specify a feature once, at the lowest actor that holds it" convention and the access matrix are complementary: the convention governs _where each feature is filed_; the matrix is _where you read off the complete permission picture_.

### Why rules is separate from features

A [feature](./requirements/behaviors/features/) is a concrete, scenario-level behavior. But invariants and policies — "a pet can't be reserved and sold at once," expiry rules, validation constraints — are cross-cutting: they constrain many features and belong to none. Captured inside feature files they get duplicated and drift out of sync. [Rules](./requirements/behaviors/rules/) gives each one a single authoritative statement with a stable identifier, so a feature scenario references the rule rather than restating it, and each invariant lives in exactly one place.

### Why entity lifecycle lives in rules, not model

The states an entity can hold (`available | reserved | sold`) are part of its structure, so the [model](./context/model/) declares that they exist. But _which transitions are legal_, and who may trigger them, is a prescriptive constraint — a rule. So the lifecycle state machine lives in [rules](./requirements/behaviors/rules/), cross-referencing the model. The seam is clean: the model defines the vocabulary of states; rules defines the legal moves between them.

### Why glossary is separate from model

The [model](./context/model/) defines entities. But not every domain term is an entity — _catalog_, _reservation_, _credential_, _currency_ are vocabulary with no structural definition. Forcing them into the model would distort it; leaving them undefined invites ambiguity. The [glossary](./context/glossary/) is the flat index of _all_ domain vocabulary; for any term that is also an entity, it gives a brief definition and links into the model for the full structure. The glossary points; the model defines — no duplication.

### Why journeys and interfaces are both present

This template must serve both user-facing and headless systems, so the experience layer and the contract layer are kept separate. [Journeys](./requirements/behaviors/journeys/) is the experience — wireframes for UI systems, annotated call-sequences for headless ones — and applies only when there is a multi-step flow worth showing. [Interfaces](./requirements/behaviors/interfaces/) is the external contract: the operations, resources, and events the system exposes, described behaviorally. For a UI product, interfaces may be thin and journeys rich; for a headless service, the reverse. Marking both "include as relevant" lets one template serve either kind without forcing empty sections. Note that interfaces is deliberately the _behavioral_ contract only — wire formats, protocols, and endpoint naming are technical decisions, recorded separately in the [RFC repository](https://github.com/kieranpotts/rfc).

### Why "Qualities", not "Performance"

The non-functional section was renamed from "Performance" because "performance" honestly means latency and throughput, yet the section must also umbrella compatibility, portability, and idempotence. A reader scanning for "compatibility" would never look under "Performance." [Qualities](./requirements/qualities/) (quality attributes) is the honest umbrella; latency and throughput become sub-files under it.

### Why constraints is context, not a requirement

A regulatory or contractual [constraint](./context/constraints/) reads like a requirement, but it is a boundary set by the world — a law, a contract, a dependency, a standing assumption — not a behavior the system chooses to exhibit. So the whole bundle stays in context as imposed givens. Where a constraint implies a testable obligation on the system, that obligation is restated as a [rule](./requirements/behaviors/rules/) or a [quality](./requirements/qualities/) and cross-referenced back, keeping the constraint itself purely descriptive.
