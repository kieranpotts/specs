# Problem statement

A broad outline of the business problem and how the system solves it.

## The problem

_Describe the problem the system exists to solve. Who experiences this problem,
and what is the cost of leaving it unsolved?_

Retailers and online marketplaces need accurate, up-to-date catalog data —
product types, variants, pricing, availability — to power product listings and
purchasing flows. Today, each business maintains its own catalog in isolation,
leading to duplicated effort, stale data, and inconsistent product information
across channels. Development teams building on top of these catalogs must
negotiate bespoke data exports or screen-scraping workarounds, which are fragile
and expensive to maintain.

## The solution

_Describe, in business terms, how the system solves that problem. Keep this at
the level of outcomes and capabilities — the detailed functional requirements
belong in [features](../../requirements/behaviors/features/)._

The Acme Catalog API provides a single, authoritative source of product catalog
data accessible to both human operators and automated systems. Authenticated
callers can list all available products, search and filter the catalog by
type, variant, price range, or availability, and retrieve the full details of
any individual listing. The API is designed to be consumed by web applications, mobile clients,
and machine-to-machine integrations alike.
