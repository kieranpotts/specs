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

## Features

### Authenticated User

- [`list-products.feature`](./list-products.feature): List and filter the
  product catalog.

- [`search-products.feature`](./search-products.feature): Search the catalog by
  keyword and tag.

- [`get-product.feature`](./get-product.feature): Retrieve the full details of
  a single product by ID.

### Partner

- [`reserve-product.feature`](./reserve-product.feature): Place a temporary
  hold on an available product.

- [`release-reservation.feature`](./release-reservation.feature): Release a
  reservation the Partner holds.
