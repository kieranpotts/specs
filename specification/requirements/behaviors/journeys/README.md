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
list, search, or get-by-ID requests. Two capabilities span several calls and
carry state, so they are documented here as annotated call-sequences: the
Partner **reservation** flow, and the Shopper **checkout** flow.

### Journey: Partner reserves a product for a customer

A Partner holds a product while arranging a sale with a customer, then either
lets the administrative function complete the sale or releases the hold if the
sale falls through.

```mermaid
sequenceDiagram
    participant P as Partner
    participant API as Acme Catalog API
    P->>API: Search / get product by ID
    API-->>P: Product { status: available }
    P->>API: Reserve product (idempotency key)
    API-->>P: Reservation { heldBy: P, expiresAt }
    Note over P,API: Product is now reserved (R3); hold window is running (R5)
    alt Sale proceeds
        Note over API: A Shopper checkout, or the admin function, records the sale
        API-->>API: status → sold (observable to P)
    else Sale falls through
        P->>API: Release reservation
        API-->>P: Product { status: available }
    else Partner does nothing
        Note over API: Hold window elapses
        API-->>API: status → available (R5, automatic)
    end
```

**Steps and outcomes:**

1. **Find the product.** The Partner locates an `available` product via
   [search](../features/search-products.feature) or
   [get-by-ID](../features/get-product.feature). _Outcome:_ a product whose
   `status` is `available`.

2. **Reserve it.** The Partner calls
   [reserve](../features/reserve-product.feature) with an [idempotency
   key](../../../context/glossary/). _Outcome:_ the product moves to
   `reserved` ([R3](../rules/)), the Partner is recorded as holder, and an
   `expiresAt` is set. A retry with the same key is safe (see
   [idempotence](../../qualities/idempotence.md)).

3. **Resolve the hold.** Exactly one of three things happens next:
   - The sale completes — a Shopper checkout, or the administrative function,
     moves the product to `sold`, observable to the Partner as a status change.
   - The Partner [releases](../features/release-reservation.feature) the hold
     ([R4](../rules/)) — the product returns to `available`.
   - The Partner does nothing and the [hold window](../../../context/glossary/)
     elapses — the reservation lapses automatically ([R5](../rules/)) and the
     product returns to `available`.

The Partner observes the resolved state only by re-reading the product; the API
publishes no event on reservation expiry (see [interfaces](../interfaces/)).

### Journey: Shopper buys products through checkout

A Shopper assembles a basket, then checks out — the API captures payment and, on
success, moves every purchased product to `sold` in a single operation.

```mermaid
sequenceDiagram
    participant S as Shopper
    participant API as Acme Catalog API
    participant PSP as Payment provider
    S->>API: Search / get products by ID
    API-->>S: Product { status: available }
    S->>API: Add product(s) to basket
    API-->>S: Basket { productIds }
    S->>API: Check out (idempotency key, payment method)
    API->>PSP: Authorize + capture card
    alt Payment captured
        PSP-->>API: captured
        API-->>API: products → sold (R7); Order { status: paid }
        API-->>S: Order confirmed
        Note over API: order.placed event published (see interfaces)
    else Payment declined / provider unavailable
        PSP-->>API: declined / no response
        API-->>API: products unchanged; any consumed hold released (R8)
        API-->>S: Checkout failed (may be retried)
    end
```

**Steps and outcomes:**

1. **Find products.** The Shopper locates `available` products via
   [search](../features/search-products.feature) or
   [get-by-ID](../features/get-product.feature).

2. **Build a basket.** The Shopper adds one or more products to its
   [basket](../../../context/model/). _Outcome:_ a basket listing the chosen
   products.

3. **Check out.** The Shopper calls [checkout](../features/checkout.feature) with
   an [idempotency key](../../../context/glossary/) and a payment method. The API
   captures payment through the provider. _Outcome, on success:_ every product
   moves to `sold` ([R7](../rules/)), an [`Order`](../../../context/model/) is
   recorded as `paid`, and an `order.placed` event is published. A retry with the
   same key is safe and never double-charges (see
   [idempotence](../../qualities/idempotence.md)).

4. **Failure path.** If payment is declined or the provider is unavailable, no
   product moves to `sold`, any reservation the checkout would have consumed is
   released ([R8](../rules/)), and the Shopper may retry.
