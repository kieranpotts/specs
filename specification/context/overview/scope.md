# Scope

The boundaries of the system.

## In scope

_List the capabilities, user groups, and domains that the system is responsible
for._

- **Catalog browsing:** Listing, searching, and filtering the product catalog.

- **Catalog retrieval:** Fetching the full details of a single product listing
  by ID.

- **Reservations:** Allowing Partner callers to place a temporary hold on an
  available product, and to release a hold they own.

- **Purchasing:** Allowing Shopper callers to assemble a basket, check out, and
  pay for products, moving the purchased products to `sold`. Reservation and
  purchasing are the two caller-facing capabilities that change catalog state.

- **Payment capture:** Authorizing and capturing card payment for a checkout
  through an external payment provider. The system stores no raw card data (see
  [constraints](../constraints/)).

- **Authentication:** Verifying caller identity before granting access to
  catalog data.

- **API consumers:** Human operators accessing the catalog via a client
  application; automated systems (eg. partner platforms, internal services)
  consuming the API programmatically.

## Out of scope

_List anything that might reasonably be assumed to be part of the system but is
deliberately excluded. Recording what is out of scope is as important as
recording what is in scope: it prevents scope creep and sets clear expectations
with stakeholders._

- **Refunds, tax, and fraud:** Checkout captures payment, but refund handling,
  tax calculation, and fraud screening are deliberately excluded from this
  version and left to follow-up proposals.

- **Inventory management:** Catalog data is read-only. Adding, editing, or
  removing product listings is an administrative function outside this
  service.

- **User account management:** Registration, password reset, and profile
  management are handled by a separate identity service.

- **Recommendations and personalization:** The API returns raw catalog data; any
  ranking or personalization logic is the responsibility of consuming
  applications.
