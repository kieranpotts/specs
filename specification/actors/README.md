# Actors

This section profiles the actors that interact with the system — the people, organizations, and external systems that have goals the system must serve.

Different actors follow different journeys through the system. Some have permissions or privileges that others do not. It is important to understand these distinctions fully, because even small differences in the required business logic between actor types can have a significant impact on the system's architecture and the effort required to build it.

The actors are derived from the [domain model](../model/).

## Actor hierarchy

There is a hierarchy of actors. Privileges and permissions are inherited down the hierarchy, so a [feature](../features/) is specified once only, for the lowest-order actor type that has access to it. Thus, the features available to Authenticated Users are also available to all higher-privileged actor types.

The current actor hierarchy is as follows:

- **Anonymous User**: A caller who has not authenticated. Anonymous Users cannot access any catalog data. All API endpoints require a valid credential; unauthenticated requests are rejected.

- **Authenticated User**: A caller who has presented a valid credential — either a human operator using a client application, or an automated system making machine-to-machine requests. Authenticated Users can list and search the catalog and retrieve the full details of any individual pet listing.

_Add further actor types as needed, ordered from lowest to highest privilege._
