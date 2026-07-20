# Rules

This section documents the business rules, invariants, and policies that hold
across the system — the constraints that are not tied to any single
[feature](../features/) but apply wherever the relevant entities and operations
appear.

Capturing them here, once, keeps them authoritative: a [feature](../features/)
scenario references a rule by its identifier rather than restating it, so each
invariant lives in exactly one place. Rules also document the lifecycle of
domain entities — the states a [model](../../../context/model/) entity can hold,
and the transitions permitted between them.

State each rule so that it is unambiguous and, where possible, testable. Give
each a stable identifier so it can be referenced from elsewhere.

_Replace the illustrative rules below with your own._

## Invariants

- **R1 — Single status.** A [`Product`](../../../context/model/) has exactly one
  `status` at any time: `available`, `reserved`, or `sold`. It is never in more
  than one state at once.

- **R2 — Catalog records are read-only to callers.** No caller-facing operation
  creates, edits, or deletes a `Product` record, nor changes any attribute other
  than `status`. The descriptive catalog (names, prices, descriptions, photos,
  tags) is maintained solely through a separate administrative function (see
  [scope](../../../context/overview/scope.md)). Reservation operations (R3) are
  the sole exception, and they change only `status`.

- **R3 — Reservation requires an available product.** A
  [Partner](../../../context/actors/) may reserve a `Product` only when its
  `status` is `available`. Reserving moves the product to `reserved` and
  records the reserving Partner as the holder. A request to reserve a product
  that is already `reserved` or `sold` is rejected, and the product's state is
  unchanged.

- **R4 — Only the holder may release.** A `reserved` product may be returned to
  `available` by a caller-facing operation only when the caller is the
  [Partner](../../../context/actors/) that holds the reservation. Any other
  caller's release request is rejected without changing state. A reservation may
  also lapse automatically (R5); that path is not caller-triggered.

- **R5 — Reservations expire.** A reservation that is neither released nor
  advanced to `sold` within its hold window automatically lapses, returning the
  product to `available`. The hold window is a configuration value, not a caller
  input. Expiry is observable to callers only as a subsequent `available`
  status.

## Lifecycle: Product status

A `Product`'s `status` (defined in the [model](../../../context/model/)) moves
through the states below. Only the transitions shown are permitted. The
transition into `sold` is driven by the administrative function and is out of
scope for this system; the transitions into and out of `reserved` are now
caller-triggerable by a [Partner](../../../context/actors/) (see R3–R5) or may
occur administratively. The resulting states are observable to all authenticated
callers.

```mermaid
stateDiagram-v2
  direction LR
  [*] --> available
  available --> reserved
  reserved --> available
  reserved --> sold
  sold --> [*]
```

- **available → reserved.** A [Partner](../../../context/actors/) places the
  product on hold (R3), or the administrative function does so. The reserving Partner is
  recorded as the holder.

- **reserved → available.** The holding Partner releases the reservation (R4),
  the reservation lapses (R5), or the administrative function releases it —
  returning the product to the catalog.

- **reserved → sold.** A reserved product is purchased. This transition is driven by
  the administrative function, not by any caller-facing operation. `sold` is
  terminal — a sold product undergoes no further transitions.

No other transitions are valid. In particular, a product cannot move directly from
`available` to `sold`, nor return from `sold`.
