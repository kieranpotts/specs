# Interfaces

This section describes the system's external contract — the surface through
which consumers interact with it. It lists the operations the system exposes,
the resources they act on, and any events it emits, described in terms of _what
each does_, not how it is implemented.

This is the behavioral contract, not a wire specification. Protocol, transport,
payload formats, and endpoint naming are technical design decisions, recorded
separately in the [RFC repository](https://github.com/kieranpotts/rfc). Here we
state only what a consumer can rely on: the operations available, their inputs
and outputs in [domain](../../../context/model/) terms, and the
[actors](../../../context/actors/) permitted to invoke them (see
[access](../access/)).

For user-facing systems this section may be thin, with the experience captured
instead under [journeys](../journeys/); for headless systems it is the primary
description of the system's surface.

_Replace the illustrative operations below with your own._

## Operations

### List pets

Returns a paginated collection of [`Pet`](../../../context/model/) records,
optionally filtered by status, species, or price range. Requires an
authenticated caller. Behavior is specified in
[`features/list-pets.feature`](../features/list-pets.feature).

### Search pets

Returns the [`Pet`](../../../context/model/) records matching a keyword and/or
tag query. Requires an authenticated caller. Behavior is specified in
[`features/search-pets.feature`](../features/search-pets.feature).

### Get pet by ID

Returns the full detail of a single [`Pet`](../../../context/model/) identified
by its `id`, or indicates not-found. Requires an authenticated caller. Behavior
is specified in [`features/get-pet.feature`](../features/get-pet.feature).

### Reserve a pet

Places a temporary hold on an `available` [`Pet`](../../../context/model/),
moving it to `reserved` and recording the caller as the holder. Requires a
[Partner](../../../context/actors/) caller. The operation is idempotent under a
caller-supplied idempotency key (see
[idempotence](../../qualities/idempotence.md)). Behavior is specified in
[`features/reserve-pet.feature`](../features/reserve-pet.feature), constrained
by [rule R3](../rules/).

### Release a reservation

Returns a `reserved` [`Pet`](../../../context/model/) to `available`, provided
the caller holds the reservation. Requires a [Partner](../../../context/actors/)
caller. Behavior is specified in
[`features/release-reservation.feature`](../features/release-reservation.feature),
constrained by [rule R4](../rules/).

## Resources

- **Pet** — the primary resource. See the [`Pet`](../../../context/model/)
  entity.

- **Category** — a grouping of pets. See the
  [`Category`](../../../context/model/) entity.

## Events

_The Petstore API emits no events. Reservation expiry ([rule R5](../rules/))
changes a pet's status internally and is observable only by polling its status;
no notification is published. If a future proposal introduces event delivery
(eg. a `reservation.expired` webhook), list each event here with its meaning and
payload described in domain terms._
