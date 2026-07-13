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

| Capability | Anonymous User | Authenticated User | Partner |
| ---------- | :------------: | :----------------: | :-----: |
| List and filter the catalog | — | ✓ | ✓ |
| Search the catalog | — | ✓ | ✓ |
| Retrieve a single pet by ID | — | ✓ | ✓ |
| Reserve an available pet | — | — | ✓ |
| Release a reservation it holds | — | — | ✓ |

✓ = permitted, and inherited by all higher-privileged actors. — = not permitted.

Anonymous Users hold no capabilities: every operation requires a valid
[credential](../../../context/glossary/), so unauthenticated requests are
rejected.

The reservation capabilities are stated once, against
[Partner](../../../context/actors/) — the lowest-privileged actor that holds
them. A Partner may only release a reservation it placed itself; releasing
another Partner's reservation is not permitted, a finer-grained condition
governed by [rule R4](../rules/).
