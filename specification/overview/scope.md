# Scope

The boundaries of the system.

## In scope

_List the capabilities, user groups, and domains that the system is responsible for._

- **Catalog browsing**: Listing, searching, and filtering the pet catalog.

- **Catalog retrieval**: Fetching the full details of a single pet listing by ID.

- **Authentication**: Verifying caller identity before granting access to catalog data.

- **API consumers**: Human operators accessing the catalog via a client application; automated systems (eg. partner platforms, internal services) consuming the API programmatically.

## Out of scope

_List anything that might reasonably be assumed to be part of the system but is deliberately excluded. Recording what is out of scope is as important as recording what is in scope: it prevents scope creep and sets clear expectations with stakeholders._

- **Purchasing and orders**: The API does not support placing orders, managing a basket, or processing payments.

- **Inventory management**: Catalog data is read-only. Adding, editing, or removing pet listings is an administrative function outside this service.

- **User account management**: Registration, password reset, and profile management are handled by a separate identity service.

- **Recommendations and personalization**: The API returns raw catalog data; any ranking or personalization logic is the responsibility of consuming applications.
