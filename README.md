# Software requirements specification (SRS)

**A template for managing the lifecycle of software requirements via version control.**

This repository is the home of the software requirements specification (SRS) for [Project Name]. It defines the major operations and business rules of the system, and the constraints within which the system is required to operate.

The SRS is a mutable living specification of _what_ the production system does. The specification is maintained by the product managers, with input from other stakeholders – both non-technical and technical. It evolves alongside the system. The specification changes with each production release.

The SRS also encapsulates an immutable, append-only log of product decisions, in the form of "proposals" that drive changes to the specification. Proposals that are ultimately rejected are also recorded in the log. The objective is for the evolution of the system to be fully recorded, so the rationale for its current state is justified by that decision log. When stewardship passes to new people, they should have a deep appreciation for why the system is where it is now.

Technical decisions about _how_ the solution works — its architecture and implementation — are out of scope. The SRS is implementation-agnostic. It should not contain any technical details that are not strictly necessary to understand the system's functional and non-functional requirements. If the system were re-platformed to another technology stack, it's specification should not need to change.

> [!NOTE]
> The SRS covers product decisions. Technical decisions — _how_ the solution is constructed — are tracked separately in the companion [Requests for Comments (RFC)](https://github.com/kieranpotts/rfc) repository.

## Contents

- [**Specification**](./specification/): Descriptions of the as-is production system. Covers the mission statement, the domain model, functional and non-functional requirements, and the actors and their journeys through the system.

- [**Proposals**](./proposals/): A permanent archive of every major proposed change to the specification, including those that were ultimately rejected.

- [**Contributing**](./CONTRIBUTING.md): Instructions for shepherding proposals through their lifecycle, and for maintaining the specification.

- [**Agents**](./AGENTS.md): Instructions for agentic tools to maintain the specifications and to manage the lifecycle of proposals with a high degree of autonomy. Includes links to domain-specific skills.

-----

Copyright © 2020-present Kieran Potts, [CC0 license](./LICENSE.txt)
