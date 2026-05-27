# Software requirements specification (SRS)

**A template for managing the lifecycle of software requirements via version control.**

**🚧 Under construction.**

This repository is the home of the software requirements specification (SRS) for [Project Name]. It defines the major operations and business rules of the system, and the constraints within which the system is required to operate.

The SRS describes _what_ the system does, in business terms. It is maintained by the product managers, with input from other stakeholders (both non-technical and technical).

Technical decisions about _how_ the solution works — its architecture and implementation — are recorded separately. The SRS is implementation-agnostic and SHOULD NOT contain any technical details that are not strictly necessary to understand the system's functional and non-functional requirements.

## Contents

- [**Specification**](./specification/): Descriptions of the "as is" production system. Covers the mission statement, the domain model, both functional and non-functional requirements, and the actors and their journeys through the system.

- [**Proposals**](./proposals/): The permanent archive of every proposed change to the specification, including those that were ultimately rejected.

- [**Documentation**](./docs/): Instructions for shepherding proposals through their lifecycle, and for maintaining the specification.

The [**skills**](./skills/) directory captures artifacts intended for injection into AI model context windows.

-----

Copyright © 2020-present Kieran Potts, [CC0 license](./LICENSE.txt)
