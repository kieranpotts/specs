# Behaviors

This section documents the system's functional requirements — what the system does. Each artifact captures behavior from a different angle: who may do what, the rules that constrain every interaction, the concrete scenarios, the flows that string them together, and the surface through which they are invoked.

How _well_ the system must perform these behaviors is a separate, non-functional concern, documented under [qualities](../qualities/).

## Sections

- [**Access**](./access/): The permission matrix — which [actors](../../context/actors/) may exercise which capabilities.

- [**Rules**](./rules/): Business rules, invariants, and policies that hold across features — including the lifecycle transitions of domain entities.

- [**Features**](./features/): The system's functional requirements, expressed as scenarios in [Gherkin](https://cucumber.io/docs/gherkin/) notation.

- [**Journeys**](./journeys/): How features combine into coherent flows — wireframes for user-facing systems, annotated call-sequences for headless ones.

- [**Interfaces**](./interfaces/): The system's external contract — the operations, resources, and events it exposes to its consumers.
