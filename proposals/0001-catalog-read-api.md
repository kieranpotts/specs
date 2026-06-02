# Catalog read API

- Authors: Kieran Potts [@kieranpotts]
- Created: 2024-01-15
- Last updated: 2024-03-20
- Approvers: Kieran Potts
- Approval date: 2024-03-18
- Issue: #1
- Proposal PR: #2
- Discussion thread:
- Implementation trackers: #5

## Status

RELEASED

## Related

- Supersedes #...
- Superseded by #...
- Depends on #...
- Related to #...

## Summary

Introduce the foundational Petstore API: a read-only digital service that allows authenticated callers to list, filter, and retrieve individual pet listings from the catalog. This establishes the domain model and the core actor hierarchy.

## Motivation

Pet retailers and marketplace operators need a reliable, programmatic way to access catalog data. Without a shared API, each consuming application must maintain its own copy of catalog data, leading to duplication, staleness, and fragile bespoke integrations. A read API that is accessible to both human-operated clients and automated systems eliminates this duplication and provides a single authoritative source of truth for catalog state.

The API must be accessible to two distinct caller types: human operators using a client application, and automated systems making machine-to-machine requests. Both are modeled as Authenticated Users in the actor hierarchy.

## Impact

HIGH

This proposal establishes the entire foundation of the system. It affects all current and future consumers of the API (retailers, marketplace operators, internal services), defines the domain model that all subsequent proposals will extend, and sets the performance baseline for all read operations.

## Proposed change

This proposal introduces the following specification artifacts.

### Context

- [Mission statement](../specification/context/overview/mission-statement.md): New content stating the core purpose of the Petstore API.

- [Problem statement](../specification/context/overview/problem-statement.md): New content describing the catalog data fragmentation problem and the API solution.

- [Scope](../specification/context/overview/scope.md): New content bounding the system to catalog read operations; purchasing, inventory management, and user account management are explicitly out of scope.

- [Constraints](../specification/context/constraints/README.md): New content recording the external givens — the dependency on a separate identity service, and the assumption that catalog data is maintained by an administrative function outside this system.

- [Glossary](../specification/context/glossary/README.md): New content defining the project's ubiquitous language — caller, catalog, category, credential, listing, and reservation.

- [Domain model](../specification/context/model/README.md): New domain model defining the `Pet` and `Category` entities, their attributes, and their relationship.

- [Actor hierarchy](../specification/context/actors/README.md): Updated actor hierarchy: Anonymous User and Authenticated User.

### Requirements

- [Permission matrix](../specification/requirements/behaviors/access/README.md): New permission matrix. Anonymous Users have no access; Authenticated Users may list and retrieve catalog data.

- [Rules](../specification/requirements/behaviors/rules/README.md): New business rules and the `Pet` status lifecycle — the single-status invariant, the read-only-to-callers invariant, and the `available → reserved → sold` state machine.

- [List pets feature](../specification/requirements/behaviors/features/list-pets.feature): New feature file specifying list and filter behavior, including pagination, status filter, species filter, price range filter, empty result, and unauthenticated rejection.

- [Get pet by ID feature](../specification/requirements/behaviors/features/get-pet.feature): New feature file specifying retrieval of a single pet by ID, including the not-found and unauthenticated cases.

- [Quality: Latency](../specification/requirements/qualities/latency.md): Petstore-specific latency thresholds for list/search (300ms p95) and get-by-ID (100ms p99).

- [Quality: Throughput](../specification/requirements/qualities/throughput.md): Minimum throughput of 200 req/s normal, 600 req/s peak.

- [Quality: Capacity](../specification/requirements/qualities/capacity.md): Support for 5,000 concurrent callers and a catalog of at least 50,000 records.

- [Quality: Compatibility](../specification/requirements/qualities/compatibility.md): API protocol compatibility commitments: any HTTP client, no proprietary SDK required, backwards-compatible within a major version.

- [Quality: Portability](../specification/requirements/qualities/portability.md): Deployable in local development and cloud-hosted production without code changes; no proprietary service lock-in.

- [Quality: Idempotence](../specification/requirements/qualities/idempotence.md): All read operations are idempotent; clients may safely retry on failure.

## Alternatives

**GraphQL API instead of REST-style HTTP**: A query language would give consumers more flexibility to request only the fields they need, reducing over-fetching. Rejected at this stage because the catalog model is small and stable, and the additional tooling overhead is not justified for a read-only use case with well-defined response shapes. Can be reconsidered if consumers report significant over-fetching problems.

**Open access (no authentication)**: Removing the authentication requirement would simplify integration for casual consumers. Rejected because the business requires control over who accesses catalog data; unauthenticated access would expose pricing and availability information without any audit trail.

## Tradeoffs and risks

- **Read-only scope may frustrate early adopters**: Consumers who want to manage listings via the same API will need to use a separate administrative interface until write operations are specified and built. This may slow early adoption.

- **Domain model is intentionally minimal**: The `Pet` entity omits health records, vaccination status, and lineage data that some retailers may consider essential. These can be added via future proposals, but early integrators building against the initial model may need to accommodate schema additions.

- **Performance thresholds are estimates**: The latency and throughput targets in this proposal are based on comparable catalog APIs, not load testing against a running system. They should be validated during implementation.

## Questions

- Should the catalog support multiple currencies, or is a single configured currency sufficient for the initial version?

- What credential mechanism (eg. API key, OAuth 2.0 bearer token) will authentication use? This is out of scope for the specification but needs to be resolved before implementation.

## References

- [Swagger Petstore](https://petstore.swagger.io/): The original reference implementation that inspired this domain model.
