# Requirements

This part is the prescriptive contract: what the system must do, and how well it
must do it. Every statement here is a requirement that can, in principle, be
verified against the running system. The descriptive background these
requirements draw on — the domain model, the actors, the vocabulary — lives in
[context](../context/).

Requirements divide into two kinds:

- [**Behaviors**](./behaviors/) — the system's functional requirements: _what_
  it does.

- [**Qualities**](./qualities/) — the system's non-functional requirements: _how
  well_ it does it at runtime. Scope is the system's dynamic (runtime,
  externally-observable) qualities only. Static qualities of the code and design
  are out of scope.
