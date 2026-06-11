# Reservations

- Authors: Kieran Potts [@kieranpotts]
- Created: 2024-06-03
- Last updated: 2024-08-21
- Approvers: Kieran Potts
- Decision date: 2024-08-19
- Proposal PR: #14
- Discussion thread: https://github.com/kieranpotts/specs/discussions/15
- Implementation trackers: #18

## Status

RELEASED

## Related

- Supersedes NNNN
- Superseded by NNNN
- Depends on 0001
- Related to 0002

## Summary

Add a reservation capability to the catalog API: a new **Partner** actor may place a temporary hold on an available pet and release a hold it owns. This is the first caller-facing capability that changes catalog state, and it introduces a third tier to the actor hierarchy. Reservations expire automatically after a configurable hold window.

## Motivation

Retailers and marketplace operators (see [proposal 0001](../catalog-read-api/README.md)) report that customers regularly express interest in a specific animal, but a sale takes time to arrange — a home visit, a deposit, a transport booking. Today nothing prevents two consumers from being shown the same `available` pet and both being told it is for sale, because the catalog is read-only and offers no way to hold an animal. The result is double-promised pets, disappointed customers, and manual reconciliation outside any system.

A reservation gives a trusted integrator a way to hold a pet for a bounded period while a sale is arranged, and to release it promptly if the sale falls through. Restricting this to vetted **Partner** organisations (those with a signed partner agreement) keeps the privilege to hold inventory away from ordinary read-only consumers, and gives the business an audit point for who is holding what.

## Impact

MEDIUM

This proposal extends the actor hierarchy and the API surface, and introduces the first caller-driven state change. Existing read-only consumers are unaffected: no existing endpoint, field, or permission changes for Anonymous or Authenticated Users, and the `Pet` model gains only an optional `reservation` attribute that is absent unless a pet is held. The notable new concerns are concurrency (two Partners racing to reserve the same pet), idempotent retries on the write path, and the operational machinery for expiring stale holds.

## Proposed change

This proposal introduces the following specification artifacts.

### Context

- [Actors](../../specification/context/actors/README.md): New **Partner** tier above Authenticated User, asserted by a credential claim, holding the reservation capabilities; the actor-hierarchy diagram is extended to include it.

- [Scope](../../specification/context/overview/scope.md): Reservations added to _in scope_; the _out of scope_ purchasing note clarified — a reservation holds a pet but does not buy it.

- [Glossary](../../specification/context/glossary/README.md): New terms — **Partner**, **Hold window**, **Idempotency key** — and the **Reservation** definition revised to reflect caller-managed holds.

- [Domain model](../../specification/context/model/README.md): `Pet` gains an optional `reservation` attribute (`heldBy`, `expiresAt`), present only while `reserved`; the embedded `Reservation` value object and its link to the Partner actor are added to the ER and class diagrams.

- [System context](../../specification/context/overview/system-context.md): The Partner caller and its reserve/release interaction are added to the context diagram.

- [Constraints](../../specification/context/constraints/README.md): New business constraint recording that reservations require a signed partner agreement.

### Requirements

- [Permission matrix](../../specification/requirements/behaviors/access/README.md): New **Partner** column; new _Reserve_ and _Release_ capabilities, stated against Partner.

- [Rules](../../specification/requirements/behaviors/rules/README.md): R2 narrowed (status is now caller-mutable via reservations); new R3 (reserve requires `available`), R4 (only the holder may release), R5 (reservations expire); lifecycle annotations updated to show caller-triggered transitions.

- [Reserve a pet feature](../../specification/requirements/behaviors/features/reserve-pet.feature): New feature — reserve an available pet, rejection of already-reserved/sold pets, idempotent retry, forbidden for non-Partners, unauthenticated rejection.

- [Release a reservation feature](../../specification/requirements/behaviors/features/release-reservation.feature): New feature — release a held reservation, rejection of releasing another Partner's hold, idempotent no-op release, forbidden for non-Partners, unauthenticated rejection.

- [Interfaces](../../specification/requirements/behaviors/interfaces/README.md): New _Reserve a pet_ and _Release a reservation_ operations; events section updated to note expiry is not published.

- [Journeys](../../specification/requirements/behaviors/journeys/README.md): New annotated call-sequence for the Partner reservation flow, with the three resolution paths (sale, release, expiry).

- [Quality: Latency](../../specification/requirements/qualities/latency.md): New 400ms p95 threshold for the write endpoints.

- [Quality: Idempotence](../../specification/requirements/qualities/idempotence.md): Reserve made idempotent via a caller-supplied key; release idempotent by nature.

## Alternatives

**Let any Authenticated User reserve.** Simpler — no third actor tier. Rejected because holding inventory is a privileged action with commercial consequences (a held pet is unavailable to everyone else); the business wants it limited to vetted partners with a contractual relationship and an audit trail.

**Reservations never expire; the holder must always release explicitly.** Rejected because partners forget, integrations crash, and pets would be stranded in `reserved` indefinitely. An automatic hold window bounds the damage from an abandoned reservation. The cost is the operational machinery to expire holds.

**Model a `Reservation` as its own first-class entity.** A separate entity with its own lifecycle would generalise more cleanly to multiple concurrent holds or a waitlist. Rejected for now as over-engineered: a pet holds at most one reservation at a time, so an optional attribute on `Pet` is sufficient. Revisit if waitlisting is ever proposed.

## Tradeoffs and risks

- **Concurrency on reserve.** Two Partners may attempt to reserve the same `available` pet simultaneously. The specification requires that exactly one succeeds and the other is rejected (R3); the implementation must enforce this atomically. A naive read-then-write will admit double holds under load.

- **Clock dependence of expiry.** R5 makes a pet's observable status depend on elapsed time. Tests and consumers must not assume a reservation is still held right up to `expiresAt`; expiry processing may lag the timestamp slightly.

- **Idempotency-key hygiene is the caller's responsibility.** A Partner that reuses a key across different pets, or fails to send one, loses the safe-retry guarantee. This is documented but not enforceable by the API beyond per-pet scoping of the key.

- **No expiry notification.** Because the API publishes no events, a Partner only learns a hold has lapsed by re-reading the pet. Partners with time-critical flows must poll. An event/webhook mechanism is explicitly deferred.

## Questions

- Should the hold window be a single system-wide configuration value, or negotiable per partner agreement? This proposal assumes a single configured value; per-partner windows can be a later proposal.

- Should a Partner be able to extend an active reservation before it expires? Out of scope here; raise as a follow-up if partners request it.

## References

- [Proposal 0001: Catalog read API](../catalog-read-api/README.md): The foundational proposal this extends.
- [Proposal 0002: Search by tag](../search-by-tag/README.md): The prior extension to the catalog surface.
