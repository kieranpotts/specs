# Constraints

This section records the conditions imposed on the system from outside — the givens the system must work within, rather than behaviors it chooses to exhibit.

These are distinct from [qualities](../../requirements/qualities/), which the system commits to _achieving_. A constraint is a boundary set by the world: a law, a contract, a dependency, or an assumption the rest of the specification rests on. Recording them explicitly prevents them from being silently violated, and makes clear which parts of the specification would have to change if a constraint were lifted.

Where a constraint implies a testable obligation on the system, state that obligation as a [rule](../../requirements/behaviors/rules/) or a [quality](../../requirements/qualities/) and cross-reference it from here.

_Replace the illustrative examples below with the constraints that actually apply to your system._

## Regulatory and legal

- _eg._ Personal data handled by the system MUST be processed in accordance with applicable data-protection law.

## Business

- _eg._ The system MUST operate within the contractual terms of its hosting and third-party service agreements.

## Assumptions

Standing assumptions the specification depends on. If an assumption proves false, the affected requirements must be revisited.

- Callers are authenticated by a separate identity service; this system assumes a valid [credential](../glossary/) has already been issued before a request reaches it.

- Catalog data is maintained by an administrative function outside this system (see [scope](../overview/scope.md)); this system assumes that data is present and current.

## Dependencies

External systems and services this system relies on to function.

- **Identity service** — issues and verifies the [credentials](../glossary/) callers present. The system cannot authorize any request without it.
