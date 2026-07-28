# Features

This section documents the user-facing features and behaviors of the current
production system — the system's functional requirements.

Features are organized by actor. Because of the [actor
hierarchy](../../../context/actors/) — in which privileges and permissions are
inherited — features are specified once only, for the lowest-order actor type
that has access to the feature. Thus, the features specified for Authenticated
Users are available to all higher-privileged actor types. The complete map of
which actor may exercise which capability is recorded in [access](../access/).

We use [Gherkin](https://cucumber.io/docs/gherkin/) notation to specify the
system's functions. Each feature lives in its own `.feature` file. Writing
requirements as Gherkin scenarios keeps them concrete and testable. Each
scenario is an acceptance criterion that can be verified against the running
system.

See [`get-product.feature`](./get-product.feature) for an example of the
notation.

## Identifiers and tags

Each feature carries its identifier in the `Feature:` title, and each scenario
its two-part identifier in the `Scenario:` title:

```feature
Feature: [F4] Reserve a product

  @R1 @R3
  Scenario: [F4.1] Reserve an available product
```

Identifiers are permanent and are never reused, even after a requirement is
removed. Renaming a feature, rewording a scenario, or moving the file does not
change them.

Tags cross-reference a scenario to the [business rules](../rules/) it verifies,
by rule identifier (`@R1`, `@R3`). A rule with no scenario coverage — a
negative invariant or a time-triggered rule, say — is recorded as such in
[`rules/README.md`](../rules/README.md), so the gap is explained rather than
merely absent.

A feature or scenario whose removal has been agreed, but whose behavior is
still in production, carries a `@deprecated` tag alongside its rule tags, with
a comment naming the proposal that removes it and, where committed, the release
or date after which the behavior is unavailable:

```feature
  @R3 @deprecated
  # Deprecated by proposal `catalog-read-api`. Unavailable after 2027-01-01.
  Scenario: [F4.3] Reserve a product by legacy SKU
```

The tag is removed only by deleting the scenario, once the behavior is gone
from production.

## Features

### Authenticated User

- **F1** [`list-products.feature`](./list-products.feature): List and filter the
  product catalog.

- **F2** [`search-products.feature`](./search-products.feature): Search the
  catalog by keyword and tag.

- **F3** [`get-product.feature`](./get-product.feature): Retrieve the full
  details of a single product by ID.

### Partner

- **F4** [`reserve-product.feature`](./reserve-product.feature): Place a
  temporary hold on an available product.

- **F5** [`release-reservation.feature`](./release-reservation.feature):
  Release a reservation the Partner holds.

### Shopper

- **F6** [`checkout.feature`](./checkout.feature): Check out a basket, capturing
  payment and moving the purchased products to `sold`.

- **F7** [`capture-payment.feature`](./capture-payment.feature): Capture payment
  for an order idempotently, so a retried checkout never double-charges.