# Software requirements specification (SRS)

**A template for managing the lifecycle of software requirements via version control.**

This repository is the home of the software requirements specification (SRS) for [Project Name]. It defines the major operations and business rules of the system, and the constraints within which the system is required to operate.

The SRS is a mutable living specification of _what_ the production system does, defined from the perspective of its users. The specification is maintained by the product managers, with input from other stakeholders (both non-technical and technical).

The SRS also encapsulates an immutable, append-only log of product decisions, in the form of "proposals" that drive changes to the specification. Even proposals for new features that are ultimately rejected are recorded in the log, so that the rationale for the current state of the specification can be fully understood when it passes into the stewardship of new maintainers.

Technical decisions about _how_ the solution works — its architecture and implementation — are recorded separately. The SRS is implementation-agnostic and SHOULD NOT contain any technical details that are not strictly necessary to understand the system's functional and non-functional requirements.

> [!NOTE]
> The SRS covers product decisions. Technical decisions — _how_ the solution is constructed — are tracked separately in the companion [Requests for Comments (RFC)](https://github.com/kieranpotts/rfc) repository.

## Contents

- [**Specification**](./specification/): Descriptions of the "as is" production system. Covers the mission statement, the domain model, both functional and non-functional requirements, and the actors and their journeys through the system.

- [**Proposals**](./proposals/): The permanent archive of every proposed change to the specification, including those that were ultimately rejected.

- [**Contributing**](./CONTRIBUTING.md): Instructions for shepherding proposals through their lifecycle, and for maintaining the specification.

- [**Agents**](./AGENTS.md): Instructions for agentic tools to maintain the specifications and manage the lifecycle of proposals with a high degree of autonomy. Includes links to domain-specific skills.

-----

Copyright © 2020-present Kieran Potts, [CC0 license](./LICENSE.txt)
