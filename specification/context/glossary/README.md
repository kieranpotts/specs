# Glossary

This section defines the project's ubiquitous language — the domain terms used
throughout the specification, each with a single agreed meaning. Consistent
vocabulary is what keeps the [model](../model/), [actors](../actors/), and
[requirements](../../requirements/) coherent; this glossary is the authoritative
reference for every term.

Keep each definition short. For terms that are also domain entities, define the
term briefly here and link to the [model](../model/) for the full structure —
the glossary points, the model defines.

_List terms alphabetically. Replace the examples below with your own._

| Term | Definition |
| ---- | ---------- |
| **Basket** | A [Shopper](../actors/)'s transient collection of products they intend to buy, before checkout. See the [`Basket`](../model/) entity. |
| **Caller** | Any client that issues a request to the system, whether or not it is authenticated. See [actors](../actors/). |
| **Catalog** | The complete collection of product listings the system makes available to callers. |
| **Category** | A broad grouping of products within the catalog (eg. "Electronics", "Apparel"). See the [`Category`](../model/) entity. |
| **Checkout** | The operation by which a [Shopper](../actors/) converts a basket into an order, capturing payment and moving the purchased products to `sold`. See [checkout](../../requirements/behaviors/features/checkout.feature). |
| **Credential** | The token a caller presents to authenticate. Issued and verified by the external identity service (see [constraints](../constraints/)). |
| **Hold window** | The configured duration for which a reservation is honored before it automatically lapses. See [rule R5](../../requirements/behaviors/rules/). |
| **Idempotency key** | A caller-supplied token that lets a caller safely retry a state-changing request — a reserve or a payment capture — without duplicating its effect. See [idempotence](../../requirements/qualities/idempotence.md). |
| **Listing** | A single entry in the catalog representing one product. See the [`Product`](../model/) entity. |
| **Order** | The durable record of a completed purchase — the products bought and the payment that settled them. See the [`Order`](../model/) entity. |
| **Partner** | An authenticated caller belonging to an organization with a signed partner agreement, permitted to place and release reservations. See [actors](../actors/). |
| **Payment** | The authorization and capture of a card payment for an order, performed through the external payment provider. See the [`Payment`](../model/) entity. |
| **Reservation** | A temporary hold a [Partner](../actors/) places on an available product, reflected by the `reserved` [status](../../requirements/behaviors/rules/) and recording the holding Partner. Lapses automatically after the hold window. |
| **Shopper** | An authenticated caller who may assemble a basket, check out, and pay for products. See [actors](../actors/). |
