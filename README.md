# 📋 Software Requirements Specification (SRS)

**A template for managing the lifecycle of software requirements via version control.**

This repository is the home of the software requirements specification (SRS) for [Project Name]. It defines the major operations and business rules of the system, and the constraints within which the system is required to operate.

There are two parts to the SRS:

- A **mutable, living specification** of _what_ the production system does. The requirements are kept close to the code and configuration they specify, and maintained through the same version control system used to manage change in the software itself. This allows the SRS to be deeply integrated with the regular development lifecycle, so the system and its specification stay synchronized. A change in requirements is merged into the `main` trunk _at the same time_ as the corresponding code and configuration are shipped to production. The specification therefore never drifts from reality.

- An **immutable, append-only log of product decisions**, in the form of "proposals" that drive changes to the specification. Proposals that are ultimately _rejected_ are recorded, too. The objective is for the evolution of the system to be fully recorded, so its current state is justified by the decision log. Even when stewardship passes to people with no prior knowledge of the project's history, they inherit a deep appreciation for why the system is the way it is.

The SRS is distinct from a PRD. A product requirements document is a precursor artifact, owned by product managers and generated through discover workshops with users. The SRS, which is maintained by the technical teams in collaboration with product stakeholders, translates the product vision into precise, testable functional and non-functional requirements. See [PRD versus SRS](./docs/prd.md) for more on the distinction.

> [!NOTE]
> This repository is the reference implementation of [**TS-1: Requirements Specification**](https://github.com/kieranpotts/standards/tree/dev/src/001), the technical standard that defines both _what_ a good specification contains and _how_ it is managed over time. Refer to TS-1 for the underlying rationale. This repository is the ready-to-use template that puts TS-1 into practice.

## Ecosystem

This repository is one of five that form a coherent, version-controlled documentation ecosystem modeling the software development lifecycle. Each is the reference implementation of an opinionated workflow, and answers a different question about the system:

- **📋 Software Requirements Specification (SRS)**: Records _what_ the system does, in business terms (this repository).

- [**💬 Requests for Comments (RFC)**](https://github.com/kieranpotts/rfc): Records _how_ significant technical decisions were made, and _why_.

- [**📐 Design Docs**](https://github.com/kieranpotts/design): Describe _what the system looks like_, its as-is architecture.

- [**🗺️ Delivery Plans**](https://github.com/kieranpotts/plans): Capture _when, and in what order_, the work gets done.

- [**🔍 Audits**](https://github.com/kieranpotts/audits): Evaluates the as-built system on its own terms – architecture and security findings, point-in-time.

The [**skills**](https://github.com/kieranpotts/skills) collection provides an agentic workflow that operates across all five.

This separation into dedicated repositories is intended for application software that spans multiple code repositories, and potentially multiple teams, where the requirements, decisions, designs, plans, and audits are shared concerns that sit above any single codebase. For a standalone code repository – a small utility library, say – it is better to fold these artifacts and skills directly into that repository, rather than maintain them separately.

## Contents

- [**Specification**](./specification/): Descriptions of the as-is production system. Covers the mission statement, the domain model, functional and non-functional requirements, and the actors and their journeys through the system.

- [**Proposals**](./proposals/): A permanent archive of every major proposed change to the specification, including those that were ultimately rejected.

  - The [`INDEX`](./proposals/INDEX.md) lists all merged proposals – released, rejected, and superseded. (Open proposals are tracked via the [pull requests](https://github.com/kieranpotts/specs/pulls) system.)

  - The [`TEMPLATE`](./proposals/TEMPLATE.md) is the starting point for a new proposal.

- [**Contributing**](./CONTRIBUTING.md): Instructions for shepherding proposals through their lifecycle, and for maintaining the specification.

- [**Agents**](./AGENTS.md) and [**Skills**](./.agents/skills/): Instructions for agentic tools to maintain the specification, and to manage the lifecycle of proposals with a high degree of autonomy.

- [**Documentation**](./docs/): General guidance on managing software requirements, including best practices for scoping product features and writing testable requirements.

-----

Copyright © 2020-present Kieran Potts, [CC0 license](./LICENSE.txt)
