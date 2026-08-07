# 📋 Software Requirements Specification (SRS)

**A template for managing the lifecycle of software requirements**
via version control.

This repository is the home of the software requirements specification (SRS) for
[Project Name]. It defines the major operations and business rules of the
system, and the constraints within which the system is required to operate.

There are two parts to the SRS:

- A **mutable, living specification** of _what_ the production system does. The
  requirements are kept close to the code and configuration they specify, and
  maintained through the same version control system used to manage change in
  the software itself. This allows the SRS to be deeply integrated with the
  regular development lifecycle. A change in requirements is merged into the
  `main` trunk at the same time as the corresponding code and configuration are
  shipped to production. The specification therefore never drifts from reality.

- An **immutable, append-only log of product decisions**, in the form of
  "proposals" that drive changes to the specification. Proposals that are
  ultimately rejected are recorded, too. The objective is for the evolution of
  the system to be fully recorded, so its current state is justified by the
  decision log. Even when stewardship passes to people with no prior knowledge
  of the project's history, they inherit a deep appreciation for why the system
  is the way it is.

The SRS drives the [design docs](https://github.com/kieranpotts/design) and
proposals for changes to the system's requirements may specification may trigger
[requests for comments (RFCs)](https://github.com/kieranpotts/rfc), where design
options are discussed.

> [!NOTE]
> This is a reference implementation of
> [TS-1](https://github.com/kieranpotts/standards/tree/latest/dev/src/001),
> a technical standard for managing and documenting software requirements
> specifications (SRS).

## Ecosystem

This repository is one of six that form a coherent, version-controlled
documentation ecosystem. Each answers a different question about a software
system.

- [**📋 Software Requirements Specification (SRS)**](https://github.com/kieranpotts/specs) (this repository) \
  Captures what the system does today, plus proposals being discussed to change
  the requirements.

- [**📐 Design Docs**](https://github.com/kieranpotts/design) \
  Architectural views representing the as-is production system, plus proposals
  to evolve the architecture to meet new requirements.

- [**🗺️ Delivery Plans**](https://github.com/kieranpotts/plans) \
  Roadmaps, milestones, and the decomposition of work into independently
  shippable increments.

- [**💬 Requests for Comments (RFC)**](https://github.com/kieranpotts/rfc) \
  An historical record of key design and technical decisions, plus active
  proposals and their discussion threads.

- [**🔍 Architecture Audits**](https://github.com/kieranpotts/audits) \
  Point-in-time evaluations of the structural integrity of the code and data,
  which drive refactoring work.

- [**⚠️ Risk Register**](https://github.com/kieranpotts/risks) \
  Security and privacy risks inherent in the system, and the implementation
  status of mitigation strategies. Plus an archive of past threat modeling
  workshop reports.

In addition, the [**✨ Agent Skills**](https://github.com/kieranpotts/skills)
collection offers composable agentic workflows that operate across all six
repositories.

This separation into dedicated repositories is intended for application software
that spans multiple code repositories, and potentially multiple teams, where the
requirements, decisions, designs, plans, audits, and risks are shared concerns
that sit above any single codebase.

For a standalone code repository – a small utility library, say – it may be
better to fold all documentation into the same repository.

## Contents

- [**Specification**](./specification/) \
  Models and descriptions of the as-is production system.

- [**Proposals**](./proposals/) \
  A permanent archive of every major proposed change to the specification,
  including those that were ultimately rejected.

  - The [`INDEX`](./proposals/INDEX.md) lists all merged proposals, whether
    released, rejected, or superseded. Open proposals are tracked via the
    [pull requests](https://github.com/kieranpotts/specs/pulls) system.

  - The [`TEMPLATE`](./proposals/TEMPLATE.md) is the starting point
    for a new proposal.

- [**Contributing**](./CONTRIBUTING.md) \
  Instructions for shepherding proposals through their lifecycle, and for
  maintaining the specification.

- [**Agents**](./AGENTS.md) and [**Skills**](./.agents/skills/) \
  Instructions for agents to maintain the specification, and to manage the
  lifecycle of proposals with a high degree of autonomy.

- [**Documentation**](./docs/) \
  General guidance on managing software requirements, including best practices
  for scoping product features and writing testable requirements.

-----

Copyright © 2020-present Kieran Potts, [CC0 license](./LICENSE.txt)
