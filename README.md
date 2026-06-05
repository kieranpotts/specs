# Software requirements specification (SRS)

**A template for managing the lifecycle of software requirements via version control.**

This repository is the home of the software requirements specification (SRS) for [Project Name]. It defines the major operations and business rules of the system, and the constraints within which the system is required to operate.


The SRS is a mutable living specification of _what_ the production system does. The specification is kept close to the code and configuration of the system that it specifies. The specification is maintained through the same version control system used to manage change in the software itself, meaning it can be deeply integrated with the regular development lifecycle. The system and its specification thus remain synchronized. The specification is updated – merged into the `main` trunk – with each production release, preventing drift from reality. Thus, changes in requirements gets merged to the `main` production trunk _at the same time_ as the corresponding changes in software code and configuration are shipped to production.

The software requirements specification is maintained through collaboration between product managers and the technical leads. It is _not_ a product requirements document (PRD), which is a precursor artifact generated through discovery workshops with users. The software requirements specification translates the product vision into precise, testable functional and non-functional specifications.

<!--

The other insurance gate is involvement of technical stakeholders. Although product managers are ultimately responsible for the management of the lifecycle of requirements specifications, technical stakeholders are required to sign-off on requirements specifications. For example, acceptance criteria will not be approved for implementation until they are written in a testable form.

-->

This repository also encapsulates an immutable, append-only log of product decisions, in the form of "proposals" that drive changes to the specification. Proposals that are ultimately rejected are also recorded in the log. The objective is for the evolution of the system to be fully recorded, so the rationale for its current state is justified by that decision log. Even when stewardship of the project passes to new people with no prior knowledge of the project's history, they will nonetheless inherit a deep appreciation for why the system is where it is now.

Technical decisions about _how_ the solution works — its architecture and implementation — are out of scope. Those are tracked separately in the companion [requests for comments (RFC)](https://github.com/kieranpotts/rfc) repository. The SRS is implementation-agnostic. It should not contain any technical details that are not strictly necessary to understand the system's functional and non-functional requirements. If the system were re-platformed to another technology stack tomorrow, its specification should not need to change.

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
