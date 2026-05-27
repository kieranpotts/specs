# [Project Name] — Software Requirements Specification

## Project overview

This repository holds the software requirements specification (SRS) for [Project Name]. It describes _what_ the system does, in business terms — its features, users, domain model, and non-functional constraints.

It is documentation, not code. There is nothing to build, lint, or run.

Decisions about _how_ the system is implemented are recorded separately. The focus of the SRS is on product requirements, not technical design. The SRS is implementation-agnostic. It should be possible to implement the system in any technology stack without changing the specification.

Changes are introduced through proposals. The [specification](./specification/) sections always reflect the current state of the system "as is" in production. The [`proposals/`](./proposals/) directory is the permanent archive of how that state was reached, including proposals that were rejected.

## Repository structure

- `specification/`: The current agreed specification of the production system ("as is"), organized into the following sections:

  - `specification/overview/`: Mission statement, problem statement, and project scope.

  - `specification/model/`: Domain entities and their relationships.

  - `specification/actors/`: The actors that interact with the system, and the permission hierarchy.

  - `specification/journeys/`: User journeys, as wireframes and visual designs.

  - `specification/features/`: Functional requirements as Gherkin `.feature` files.

  - `specification/performance/`: Non-functional requirements — quality attributes and performance targets.

- `proposals/`: The permanent archive of every proposed change. `TEMPLATE.md` is the starting point for a new proposal.

- `docs/`: Documentation about the proposal lifecycle and workflow.

## Rules

The capitalized words REQUIRED, MUST, MUST NOT, RECOMMENDED, SHOULD, SHOULD NOT, OPTIONAL, and MAY, in the context of this document and agent skills/instructions/rules, are to be interpreted as described in [RFC 2119](https://www.ietf.org/rfc/rfc2119.txt).

- Write in American English.

- The [specification sections](./specification/) describe the system "as is". When editing them as part of a proposal, describe the intended final state after the change ships — not a changelog.

- Specify functional requirements as Gherkin scenarios. Each scenario MUST be a concrete, testable acceptance criterion.

- State non-functional requirements as measurable thresholds, not aspirations.

- The default branch is `prod`. It always reflects the as-is state of the production system. Nothing merges into `prod` until real users are using the proposed change in production.

- A proposal MUST be a single atomic change. Author it on a `proposal/[description]` branch cut from `prod`, and open a pull request titled `proposal: [description]`. A GitHub issue (FEATURE or PERFORMANCE) MAY be opened first for early triage; if so, close it when the PR is opened and link the two via the `Issue` field in the proposal document.

- The current lifecycle state of a proposal is tracked via labels on the issue and PR. Apply the matching label (`#draft`, `#proposed`, `#accepted`, `#rejected`, `#released`, `#deprecated`) as the proposal advances.

- Once a proposal is `#accepted` or `#rejected`, its document is immutable. To change a past decision, open a new proposal that supersedes it – do NOT edit the original.

- Never delete a proposal document, including rejected ones.

## Skills

- `../skills/`: Shared AI skills. See https://github.com/kieranpotts/skills.
