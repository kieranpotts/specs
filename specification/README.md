# Specification

This section documents the current specification of the production system — what the system does "as is".

These sections always reflect the system's current state. Changes to that state are introduced through [proposals](../proposals/). See the [contributing guide](../CONTRIBUTING.md) to understand the lifecycle from proposal to specification.

The specification is divided into two parts:

- [**Context**](./context/) — descriptive background: the problem space the system operates in, and what the domain _is_.

- [**Requirements**](./requirements/) — the prescriptive contract: what the system must _do_, and how _well_ it must do it.

## Context

- [**Overview**](./context/overview/): A high-level description of the system — its mission, the problem it solves, and its scope.

- [**Constraints**](./context/constraints/): The conditions imposed on the system from outside — regulatory, legal, and business constraints, standing assumptions, and external dependencies.

- [**Glossary**](./context/glossary/): The project's ubiquitous language — every domain term, briefly defined.

- [**Model**](./context/model/): The entities in the system's domain model, and how they relate to one another.

- [**Actors**](./context/actors/): The participants in the domain — people, organizations, and external systems — and the hierarchy between them.

## Requirements

### Behaviors — functional requirements

- [**Access**](./requirements/behaviors/access/): The permission matrix — which actors may exercise which capabilities.

- [**Rules**](./requirements/behaviors/rules/): Business rules, invariants, and policies that hold across features, including the lifecycle transitions of domain entities.

- [**Features**](./requirements/behaviors/features/): The system's functional requirements, expressed as scenarios in [Gherkin](https://cucumber.io/docs/gherkin/) notation.

- [**Journeys**](./requirements/behaviors/journeys/): How features combine into coherent flows — wireframes for user-facing systems, annotated call-sequences for headless ones.

- [**Interfaces**](./requirements/behaviors/interfaces/): The system's external contract — the operations, resources, and events it exposes to its consumers.

### Qualities — non-functional requirements

- [**Qualities**](./requirements/qualities/): The system's non-functional requirements: its quality attributes and performance targets.
