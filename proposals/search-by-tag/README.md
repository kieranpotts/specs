# Search by tag

- Authors: Kieran Potts [@kieranpotts]
- Created: 2024-04-02
- Last updated: 2024-05-14
- Approvers: Kieran Potts
- Approval date: 2024-05-12
- Proposal PR: #9
- Discussion thread: https://github.com/kieranpotts/specs/discussions/10
- Implementation trackers: #11

## Status

RELEASED

## Related

- Supersedes #...
- Superseded by #...
- Depends on #1
- Related to #...

## Summary

Extend the catalog API with a search capability that allows authenticated callers to find pets by free-text keyword and by tag, and to combine both filters in a single request.

## Motivation

The initial catalog API (see [proposal 0001](../catalog-read-api/README.md)) supports filtering by status, species, and price range, but gives consumers no way to search the catalog by descriptive attributes. Retailers have reported that their customers want to search for pets by characteristics such as "hypoallergenic", "house-trained", or "good with children" — qualities captured in free-text descriptions and tags but not surfaced by the existing filter set.

A keyword and tag search capability closes this gap without requiring changes to the domain model: the `Pet` entity already has `description` and `tags` attributes defined in proposal 0001.

## Impact

MEDIUM

This change extends the API surface available to Authenticated Users. It does not affect the domain model or the actor hierarchy. Existing integrations are unaffected; no existing endpoints or fields change. The primary impact is on the search index infrastructure required to support full-text keyword matching efficiently at scale.

## Proposed change

This proposal adds the following specification artifact:

- **[`specification/requirements/behaviors/features/search-pets.feature`](../../specification/requirements/behaviors/features/search-pets.feature)**: New feature file specifying keyword search (case-insensitive match against name, breed, and description), tag-based search, combined keyword-and-tag search, empty result handling, and unauthenticated rejection.

No changes are required to the domain model, actor hierarchy, or quality requirements established in [proposal 0001](../catalog-read-api/README.md). The latency threshold for the search endpoint is covered by the existing list/search threshold of 300ms at the 95th percentile.

## Alternatives

**Expose a dedicated full-text search service (eg. Elasticsearch)**: A purpose-built search engine would give consumers richer query syntax (fuzzy matching, relevance scoring, faceted navigation). Rejected for this proposal because the initial use case — matching on a small set of well-defined tags and short descriptive text — does not justify the operational complexity. If search volume or query complexity grows, this can be revisited in a future proposal.

**Extend the existing list endpoint with additional filter parameters**: Rather than a separate search endpoint, keyword and tag filters could be added as optional query parameters on the list endpoint. Considered and rejected because the semantics differ: the list endpoint returns structured filter results, whereas keyword search performs unstructured text matching. Keeping them separate makes the distinction explicit and avoids overloading a single endpoint with two different query models.

## Tradeoffs and risks

- **Full-text keyword search has non-trivial performance implications**: Matching against free-text `description` fields at scale requires indexing. If the underlying implementation uses a simple SQL `LIKE` or `ILIKE` query, it will not meet the latency thresholds at catalog sizes approaching the 50,000-record capacity target. The implementation team must choose an appropriate indexing strategy.
- **Tag matching is exact**: The specification requires exact tag matches (eg. "hypoallergenic" does not match "hypo-allergenic"). This may frustrate consumers if tag values are not normalized consistently when listings are created. Tag normalization is an administrative concern outside the scope of this API, but it is a real operational risk.
- **No relevance ranking**: Search results are returned in the default list order (id ascending). Consumers requiring ranked results must implement ranking client-side.

## Questions

- Should search results support the same pagination mechanism as the list endpoint? The current specification does not specify pagination for search results; this should be resolved before implementation.

## References

- [Proposal 0001: Catalog read API](../catalog-read-api/README.md): The foundational proposal this extends.
