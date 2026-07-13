# Journeys

This section shows how the system's [features](../features/) combine into
coherent flows — the path a consumer follows to accomplish a goal.

Whereas [features](../features/) specify _what_ the system does, journeys show
_how_ those functions come together end to end. The form depends on the system:

- For **user-facing systems**, journeys are wireframes and visual designs — the
  screens a user moves through. Keep them at the level of structure and flow;
  pixel-perfect visual design is a downstream concern and does not belong in the
  requirements specification.

- For **headless systems**, journeys are annotated call-sequences — the ordered
  operations a consumer invokes to achieve a goal, with the significant inputs
  and outcomes at each step.

_Add wireframe assets (PNG, SVG) to this directory and reference them here, or
document call-sequences inline, grouped by journey._

## Journeys

The catalog's read operations are each met by a single call, so they need no
journey of their own: a consumer authenticates once, then issues independent
list, search, or get-by-ID requests. The reservation capability, however, spans
several calls and has time-sensitive state, so it is documented here as an
annotated call-sequence.

### Journey: Partner reserves a pet for a customer

A Partner holds a pet while arranging a sale with a customer, then either lets
the administrative function complete the sale or releases the hold if the sale
falls through.

```mermaid
sequenceDiagram
    participant P as Partner
    participant API as Petstore API
    P->>API: Search / get pet by ID
    API-->>P: Pet { status: available }
    P->>API: Reserve pet (idempotency key)
    API-->>P: Reservation { heldBy: P, expiresAt }
    Note over P,API: Pet is now reserved (R3); hold window is running (R5)
    alt Sale proceeds
        Note over API: Administrative function records the sale
        API-->>API: status → sold (out of scope, observable to P)
    else Sale falls through
        P->>API: Release reservation
        API-->>P: Pet { status: available }
    else Partner does nothing
        Note over API: Hold window elapses
        API-->>API: status → available (R5, automatic)
    end
```

**Steps and outcomes:**

1. **Find the pet.** The Partner locates an `available` pet via
   [search](../features/search-pets.feature) or
   [get-by-ID](../features/get-pet.feature). _Outcome:_ a pet whose `status` is
   `available`.

2. **Reserve it.** The Partner calls [reserve](../features/reserve-pet.feature)
   with an [idempotency key](../../../context/glossary/). _Outcome:_ the pet
   moves to `reserved` ([R3](../rules/)), the Partner is recorded as holder, and
   an `expiresAt` is set. A retry with the same key is safe (see
   [idempotence](../../qualities/idempotence.md)).

3. **Resolve the hold.** Exactly one of three things happens next:
   - The sale completes — the administrative function moves the pet to `sold`
     (out of scope for this API, but observable to the Partner as a status
     change).
   - The Partner [releases](../features/release-reservation.feature) the hold
     ([R4](../rules/)) — the pet returns to `available`.
   - The Partner does nothing and the [hold window](../../../context/glossary/)
     elapses — the reservation lapses automatically ([R5](../rules/)) and the
     pet returns to `available`.

The Partner observes the resolved state only by re-reading the pet; the API
publishes no event (see [interfaces](../interfaces/)).
