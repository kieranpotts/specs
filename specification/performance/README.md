# Performance

This section sets out the system's non-functional requirements — its quality attributes and performance targets.

Where [features](../features/) describe _what_ the system does, this section describes _how well_ it must do it, and the constraints (eg. hardware resources) within which it must operate.

Performance requirements are architecturally significant. They have a big impact on the design of the system, and on the components and tools that can be used to build and deploy it.

_State each requirement as a measurable, testable threshold rather than a general aspiration. Vague requirements cannot be verified._

## Contents

_These are illustrative examples. Add, remove, or replace them with the quality attributes that actually matter for your system._

- [**Compatibility**](./compatibility.md): The web browsers and devices supported by the client application.

- [**Latency**](./latency.md): Maximum acceptable response times for user-facing operations.

- [**Throughput**](./throughput.md): The volume of requests or transactions the system must sustain.

- [**Capacity**](./capacity.md): The maximum load the system must support without degradation.

- [**Portability**](./portability.md): The ease with which the system can be moved between host environments.

- [**Idempotence**](./idempotence.md): The guarantee that operations can be retried safely without unintended side effects.
