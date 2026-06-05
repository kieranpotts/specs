# Software requirements specification (SRS)

**A template for managing the lifecycle of software requirements via version control.**

This repository is the home of the software requirements specification (SRS) for [Project Name]. It defines the major operations and business rules of the system, and the constraints within which the system is required to operate.

The SRS is a mutable, living specification of _what_ the production system does. It is kept close to the code and configuration it specifies, maintained through the same version control system used to manage change in the software itself. This keeps it deeply integrated with the regular development lifecycle, so the system and its specification stay synchronized. A change in requirements is merged into the `main` trunk _at the same time_ as the corresponding code and configuration are shipped to production. The specification therefore never drifts from reality.

The specification is maintained through collaboration between product managers and technical leads. It is _not_ a product requirements document (PRD), which is a precursor artifact generated through discovery workshops with users. The SRS translates that product vision into precise, testable functional and non-functional requirements. See [PRD versus SRS](./docs/prd.md) for more on the distinction.

This repository also holds an immutable, append-only log of product decisions, in the form of "proposals" that drive changes to the specification. Proposals that are ultimately _rejected_ are recorded too. The objective is for the evolution of the system to be fully recorded, so its current state is justified by the decision log. Even when stewardship passes to people with no prior knowledge of the project's history, they inherit a deep appreciation for why the system is the way it is.

## Scope

The SRS is implementation-agnostic. Technical decisions about _how_ the solution works — its architecture and implementation — are out of scope, and are tracked separately in the companion [requests for comments (RFC)](https://github.com/kieranpotts/rfc) repository. The specification should contain no technical detail beyond what is strictly necessary to understand the system's functional and non-functional requirements. If the system were re-platformed to another technology stack tomorrow, its specification should not need to change.

## Contents

- [**Specification**](./specification/): Descriptions of the as-is production system. Covers the mission statement, the domain model, functional and non-functional requirements, and the actors and their journeys through the system.

- [**Proposals**](./proposals/): A permanent archive of every major proposed change to the specification, including those that were ultimately rejected.

  - The [`INDEX`](./proposals/INDEX.md) lists all merged proposals — released, rejected, and superseded. (Open proposals are tracked via the pull requests system.)

  - The [`TEMPLATE`](./proposals/TEMPLATE.md) is the starting point for a new proposal.

- [**Contributing**](./CONTRIBUTING.md): Instructions for shepherding proposals through their lifecycle, and for maintaining the specification.

- [**Agents**](./AGENTS.md): Instructions for agentic tools to maintain the specification, and to manage the lifecycle of proposals with a high degree of autonomy.

- [**Documentation**](./docs/): Further guidance on the SRS process, including best practices for scoping proposals and writing testable requirements.

-----

Copyright © 2020-present Kieran Potts, [CC0 license](./LICENSE.txt)
