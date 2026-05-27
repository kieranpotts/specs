# Features

This section documents the user-facing features and behaviors of the current production system — the system's functional requirements.

Features are organized by actor. Because of the [actor hierarchy](../actors/) — in which privileges and permissions are inherited — features are specified once only, for the lowest-order actor type that has access to the feature. Thus, the features specified for Authenticated Users are available to all higher-privileged actor types.

We use [Gherkin](https://cucumber.io/docs/gherkin/) notation to specify the system's functions. Each feature lives in its own `.feature` file. Writing requirements as Gherkin scenarios keeps them concrete and testable. Each scenario is an acceptance criterion that can be verified against the running system.
