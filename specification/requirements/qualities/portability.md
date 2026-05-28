# Portability

A portable software system is one that can be moved between different host environments with minimal effort.

_State the portability requirement concretely. For example: which host environments must the system run in (specific cloud providers, on-premises, local development), and what is the acceptable effort to move between them? If the system must avoid lock-in to a particular vendor's proprietary services, say so here._

The Petstore API MUST be deployable in at least the following environments without code changes:

- A local development environment on a developer's workstation.
- A cloud-hosted production environment.

The system MUST NOT depend on proprietary managed services that would make migration to a different cloud provider impractical without significant rework.
