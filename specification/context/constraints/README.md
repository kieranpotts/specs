# Constraints

This section records the conditions imposed on the system from outside — the givens the system must work within, rather than behaviors it chooses to exhibit.

These are distinct from [qualities](../../requirements/qualities/), which the system commits to _achieving_. A constraint is a boundary set by the world: a law, a contract, a dependency, or an assumption the rest of the specification rests on. Recording them explicitly prevents them from being silently violated, and makes clear which parts of the specification would have to change if a constraint were lifted.

Where a constraint implies a testable obligation on the system, state that obligation as a [rule](../../requirements/behaviors/rules/) or a [quality](../../requirements/qualities/) and cross-reference it from here.

_Replace the illustrative examples below with the constraints that actually apply to your system._

## Regulatory and legal

- **Animal welfare advertising.** Catalog listings for live animals MUST comply with applicable animal-welfare and pet-advertising law in the jurisdictions the catalog serves — including, where required, the display of a seller licence number and the animal's country of origin. The system treats these as catalog data supplied by the administrative function; it does not originate them, but it MUST NOT suppress them.

- **Consumer pricing transparency.** Where a `price` is shown, it MUST be the price a consumer would pay, in a single declared currency, with no hidden surcharges introduced by this system. This obligation is restated as a testable [rule](../../requirements/behaviors/rules/) where it constrains responses.

- **Data protection.** Any personal data incidentally associated with a listing or a [reservation](../glossary/) — for example, a partner's contact reference — MUST be processed in accordance with applicable data-protection law. The catalog itself holds no consumer personal data.

## Business

- **Identity-service SLA.** Authentication depends on the external identity service (see _Dependencies_ below). The system's own availability commitments are bounded by that service's SLA: the Petstore API cannot promise availability higher than the identity service it relies on to authorize every request.

- **Hosting and third-party terms.** The system MUST operate within the contractual terms of its hosting and third-party service agreements, including any rate or egress limits those agreements impose.

- **Partner agreement required for reservations.** Placing a [reservation](../glossary/) is contractually restricted to organisations with a signed partner agreement. The system enforces this through the [Partner](../actors/) actor tier; the agreement itself is a business arrangement outside the system's control.

## Assumptions

Standing assumptions the specification depends on. If an assumption proves false, the affected requirements must be revisited.

- Callers are authenticated by a separate identity service; this system assumes a valid [credential](../glossary/) has already been issued before a request reaches it.

- Catalog data is maintained by an administrative function outside this system (see [scope](../overview/scope.md)); this system assumes that data is present and current.

## Dependencies

External systems and services this system relies on to function.

- **Identity service** — issues and verifies the [credentials](../glossary/) callers present. The system cannot authorize any request without it.
