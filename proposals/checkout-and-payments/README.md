# Checkout and payments

- Authors: Kieran Potts [@kieranpotts]
- Created: 2024-09-10
- Last updated: 2024-10-30
- Decided by: Kieran Potts
- Decision date: 2024-10-28
- Proposal PR: #21
- Discussion thread: https://github.com/kieranpotts/specs/discussions/22
- Implementation trackers: —

## Status

REJECTED

## Related

- Supersedes NNNN
- Superseded by NNNN
- Depends on #14
- Related to #2

## Summary

Add a full purchasing flow to the API: a basket that aggregates reserved pets, a
checkout operation that captures customer and delivery details, and payment
processing that converts reserved pets to `sold`. This would turn the catalog
service into an end-to-end commerce platform.

## Motivation

Now that Partners can [reserve](../reservations/README.md) pets, the natural
next step appears to be letting a consumer complete the purchase through the
same API — adding a basket, a checkout step, and payment capture — rather than
handing off to a separate administrative function. Several integrators have
asked for "one API to sell a pet," arguing that the reservation feature is only
half a sale.

## Impact

HIGH

This would be the largest change to the system since its inception. It
introduces money movement, a `Basket` and `Order` to the domain model, PCI-DSS
obligations, payment-provider dependencies, refund and chargeback flows, and a
customer-facing actor distinct from the Partner. It touches nearly every part of
the specification and fundamentally changes what the system _is_.

## Proposed change

_Not applied — this proposal was rejected. The change would have introduced
`Basket` and `Order` entities, a Customer actor, checkout and payment
operations, an order-status lifecycle, and PCI-related constraints and
qualities._

## Alternatives

**Keep purchasing out of scope; integrate with a dedicated commerce platform.**
The catalog and reservation API hands a held pet to an existing
order-management/payment system (Stripe, a retailer's own checkout) rather than
rebuilding that capability. This is the status quo and the preferred path.

**A thin "mark sold" operation only.** Expose a single Partner operation that
converts a held reservation to `sold`, leaving payment entirely external.
Considered as a middle ground, but it still introduces money-adjacent semantics
and an order record with no payment context, which is misleading. Better handled
wholly outside this service.

## Tradeoffs and risks

This proposal was **rejected**. The decision and its reasoning are recorded here
so the same ground is not re-covered.

- **Scope inversion.** The system's mission
  ([overview](../../specification/context/overview/mission-statement.md)) is to
  be the authoritative _catalog_ — a read-mostly source of truth. Bolting on
  payments would make commerce the centre of gravity and the catalog a
  sub-feature, contradicting the deliberate read-mostly scope reaffirmed as
  recently as the [reservations proposal](../reservations/README.md).

- **Regulatory burden.** Handling card data pulls the system into PCI-DSS scope,
  with audit, segregation, and liability obligations far heavier than anything
  the catalog carries today. The cost is not justified when capable payment
  platforms already exist.

- **Dependency and liability surface.** Payment providers, refunds, chargebacks,
  fraud, and tax all become the system's problem. Each is a domain in its own
  right.

- **No clear consumer demand for in-API payment.** The integrators asking for
  "one API" want a held pet to flow smoothly into _their_ checkout, which the
  existing reservation feature plus a documented hand-off already supports. None
  require the payment step to live in this service.

**Decision:** rejected. Purchasing and payment remain explicitly [out of
scope](../../specification/context/overview/scope.md). A Partner reserves a pet
through this API and completes the sale through an external commerce system; the
administrative function records the resulting `sold` status. Should a genuine,
evidenced need for in-API checkout emerge, a fresh proposal may revisit this —
but it would need to confront the regulatory and scope objections above head-on.

## Questions

None outstanding — the proposal is closed.

## References

- [Proposal 0003: Reservations](../reservations/README.md): The capability that
  prompted this proposal.
- [Scope](../../specification/context/overview/scope.md): Records purchasing and
  payments as out of scope.
