# Access

This section is the authoritative map of which
[actors](../../../context/actors/) may exercise which capabilities of the
system. Where [actors](../../../context/actors/) describes _who_ the
participants are, this section states _what each is permitted to do_.

Permissions are inherited down the [actor hierarchy](../../../context/actors/):
a capability available to a lower-privileged actor is available to all
higher-privileged actors. State each capability once, against the
lowest-privileged actor that holds it. The matrix below is the single place to
read off the complete permission picture; individual [features](../features/)
specify the behavior of each capability, and [rules](../rules/) govern any
finer-grained conditions.

_Replace the capabilities and actors below with your own. One row per
capability, one column per actor, ordered from lowest to highest privilege._

## Permission matrix

| Capability | Anonymous User | Authenticated User | Partner | Shopper |
| ---------- | :------------: | :----------------: | :-----: | :-----: |
| List and filter the catalog | — | ✓ | ✓ | ✓ |
| Search the catalog | — | ✓ | ✓ | ✓ |
| Retrieve a single product by ID | — | ✓ | ✓ | ✓ |
| Reserve an available product | — | — | ✓ | — |
| Release a reservation it holds | — | — | ✓ | — |
| Manage its own basket | — | — | — | ✓ |
| Check out and pay | — | — | — | ✓ |
| View its own orders | — | — | — | ✓ |

✓ = permitted. — = not permitted. Read capabilities granted to the Authenticated
User are inherited by both Partner and Shopper.

Anonymous Users hold no capabilities: every operation requires a valid
[credential](../../../context/glossary/), so unauthenticated requests are
rejected.

The read capabilities are stated once, against Authenticated User, and inherited
by both Partner and Shopper. The reserve/release and basket/checkout capabilities
are two independent sets over that base: a caller may hold either, both, or
neither, according to the claims in its
[credential](../../../context/actors/). A Partner may only release a reservation
it placed itself ([rule R4](../rules/)); a Shopper may only check out its own
basket and view its own orders. Neither set is a superset of the other, so they
occupy separate columns rather than a single privilege ladder.
