# Actors

This section profiles the actors that interact with the system — the people, organizations, and external systems that have goals the system must serve. Actors are part of the domain [model](../model/): they describe _who_ participates, not _what_ each is permitted to do. Permissions are specified separately, in [access](../../requirements/behaviors/access/).

Different actors have different standing in the system, arranged as a hierarchy. Understanding these distinctions matters, because even small differences between actor types can have a significant impact on the system's design and the effort required to build it.

The actors are derived from the [domain model](../model/).

## Actor hierarchy

There is a hierarchy of actors, ordered from lowest to highest privilege. Privileges are inherited down the hierarchy: an actor holds every capability of the actors below it, plus whatever is granted to it directly. The [access](../../requirements/behaviors/access/) matrix records exactly which capabilities each actor holds.

The current actor hierarchy is as follows:

- **Anonymous User**: A caller who has not authenticated.

- **Authenticated User**: A caller who has presented a valid credential — either a human operator using a client application, or an automated system making machine-to-machine requests. Authenticated Users may read the catalog but may not change its state.

- **Partner**: An Authenticated User belonging to an organisation that holds a signed partner agreement (see [constraints](../constraints/)). A Partner inherits every read capability of an Authenticated User, and additionally may place and release [reservations](../glossary/) on pets — the only caller-facing operations that change catalog state. Partner status is asserted by a claim in the caller's [credential](../glossary/), issued by the identity service.

_Add further actor types as needed, ordered from lowest to highest privilege._
