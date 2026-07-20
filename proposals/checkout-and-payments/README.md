# Checkout and payments

- Authors: Kieran Potts [@kieranpotts]
- Created: 2025-11-05
- Last updated: 2025-12-18
- Decided by: Kieran Potts
- Decision date: 2025-12-16
- Proposal PR: #21
- Discussion thread: https://github.com/kieranpotts/specs/discussions/22
- Implementation trackers: #24

## Status

RELEASED

## Related

- Supersedes NNNN
- Superseded by NNNN
- Depends on #14
- Related to #2

## Summary

Add a purchasing flow to the platform: a basket that aggregates a shopper's
chosen products, a checkout operation that captures customer and delivery
details, and payment processing that authorizes and captures a card payment
before converting the purchased products to `sold`. This extends the catalog
and reservation platform into an end-to-end commerce platform, adding a
customer-facing **Shopper** actor alongside the existing Partner.

## Motivation

Now that Partners can [reserve](../reservations/README.md) products, the natural
next step is to let a shopper complete the purchase through the platform itself
— adding a basket, a checkout step, and payment capture — rather than handing a
held product off to a separate order-management system. Integrators have
consistently asked for "one API to sell a product," and the reservation feature
on its own is only half a sale: it holds a product but provides no way to
complete the transaction.

Completing the sale in-platform keeps the catalog as the single source of truth
for a product's lifecycle — a product moves `available → reserved → sold`
without that final transition living in an external system the catalog cannot
observe. It also gives the business a single, auditable record of every order
and payment tied directly to the catalog it sold from.

## Impact

HIGH

This is the largest change to the system since its inception. It introduces
money movement, `Basket`, `Order`, and `Payment` entities to the domain model,
PCI-DSS obligations, a payment-provider dependency (Stripe), refund handling,
and a customer-facing **Shopper** actor distinct from the Partner. It touches
the domain model, actor hierarchy, scope, constraints, and adds a substantial
new slice of the requirements surface. It does not change any existing
read-only or reservation behavior: catalog reads and Partner reservations are
unaffected.

## Proposed change

This proposal introduces the following specification artifacts.

### Context

- [Mission statement](../../specification/context/overview/mission-statement.md):
  Revised to state that the platform now also lets shoppers purchase products,
  not only browse and hold them — while keeping the authoritative catalog as its
  foundation.

- [Scope](../../specification/context/overview/scope.md): Purchasing and payments
  moved from _out of scope_ to _in scope_ — basket management, checkout, and card
  payment. Inventory management and user account management remain out of scope.

- [Actors](../../specification/context/actors/README.md): New **Shopper** tier —
  an Authenticated User who may assemble a basket, check out, and pay. The Shopper
  sits alongside the Partner as a distinct authenticated capability, not above it
  in privilege.

- [Glossary](../../specification/context/glossary/README.md): New terms —
  **Basket**, **Order**, **Payment**, **Checkout**, and **Shopper**.

- [Domain model](../../specification/context/model/README.md): New `Basket`,
  `Order`, and `Payment` entities; `Order` references the purchased `Product`s
  and the resulting `Payment`; the `sold` status is now reachable through
  checkout as well as administratively.

- [System context](../../specification/context/overview/system-context.md): The
  Shopper caller and the external payment provider (Stripe) are added to the
  context diagram.

- [Constraints](../../specification/context/constraints/README.md): New
  regulatory constraint recording PCI-DSS obligations for card handling, and a
  new dependency on an external payment service provider.

### Requirements

- [Permission
  matrix](../../specification/requirements/behaviors/access/README.md): New
  **Shopper** column; new _Manage basket_, _Check out_, and _View own orders_
  capabilities, stated against Shopper.

- [Rules](../../specification/requirements/behaviors/rules/README.md): R2 further
  narrowed (checkout is a second caller-facing path to `status` change); new R6
  (checkout requires every basket product `available` or held by the checking-out
  Shopper), R7 (payment capture precedes `sold`), R8 (a failed or abandoned
  checkout releases any holds and leaves products unsold); the lifecycle diagram
  gains the checkout-driven `reserved → sold` transition.

- [Checkout
  feature](../../specification/requirements/behaviors/features/checkout.feature):
  New feature — assemble a basket, check out, capture payment, mark products
  `sold`, including the payment-declined and provider-unavailable paths.

- [Capture payment
  feature](../../specification/requirements/behaviors/features/capture-payment.feature):
  New feature — the idempotent payment-capture step, including retry under a
  client-supplied idempotency key and the double-charge-prevention guarantee.

- [Interfaces](../../specification/requirements/behaviors/interfaces/README.md):
  New _Manage basket_, _Check out_, and _View orders_ operations; an
  `order.placed` event is added to the events section.

- [Journeys](../../specification/requirements/behaviors/journeys/README.md): New
  annotated call-sequence for the Shopper checkout flow, including the
  payment-failure recovery path.

- [Quality: Idempotence](../../specification/requirements/qualities/idempotence.md):
  Payment capture made idempotent via a caller-supplied key, so a retried
  checkout never double-charges.

## Alternatives

**Keep purchasing out of scope; integrate with a dedicated commerce platform.**
Hand a held product to an external order-management/payment system rather than
building checkout in-platform. Rejected: it leaves the catalog blind to the
final `sold` transition, splits the order record across two systems, and never
satisfies the integrators asking for a single API to sell a product.

**A thin "mark sold" operation only.** Expose a single operation that converts a
held reservation to `sold`, leaving payment entirely external. Rejected: it
introduces an order record with no payment context, which is misleading, and
still leaves money movement in a second system the catalog cannot reconcile
against.

## Tradeoffs and risks

- **Regulatory burden.** Handling card payment pulls the platform into PCI-DSS
  scope. Mitigated by never storing raw card data ourselves — card details go
  directly to the payment provider (Stripe) and only a payment token and result
  are retained. Recorded as a [constraint](../../specification/context/constraints/README.md).

- **Dependency and liability surface.** The platform now depends on an external
  payment provider for authorization and capture, and inherits refund and
  dispute handling. Accepted as the cost of an end-to-end commerce capability;
  the dependency is isolated behind the payment step.

- **Double-charge risk on retry.** A shopper retrying a checkout after a network
  failure must not be charged twice. Addressed by making payment capture
  idempotent under a client-supplied key (see
  [idempotence](../../specification/requirements/qualities/idempotence.md)).

- **Scope growth.** Commerce is a large domain (tax, fraud, chargebacks). This
  proposal deliberately scopes to basket, checkout, and card capture; refunds,
  tax calculation, and fraud handling are acknowledged as follow-up proposals,
  not delivered here.

## Questions

None outstanding.

## References

- [Proposal 0003: Reservations](../reservations/README.md): The capability that
  prompted this proposal.
- [Scope](../../specification/context/overview/scope.md): Records purchasing and
  payments as in scope.
