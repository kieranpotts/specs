# Idempotence

Idempotence is the property that an operation can be repeated, re-run, or retried without causing unintended side effects.

Idempotent systems are common in everyday life: an elevator call button, or a pedestrian crossing request, move the system into a new state on the first press; subsequent presses, before the request is satisfied, have no further effect.

Idempotence is particularly valuable in client-server systems. A client cannot always be certain that its request reached the server — for example, after a network failure. If the operation is idempotent, the client can safely resend the request without risking duplicate side effects on the server's state.

_State which operations MUST be idempotent, and how clients are expected to retry them (for example, via an idempotency key on write requests)._

All Petstore API read operations (list, search, retrieve) are naturally idempotent: repeating the same request MUST return the same result given the same catalog state, with no side effects. Clients MAY safely retry any read request in the event of a network failure or timeout without risk of unintended consequences.
