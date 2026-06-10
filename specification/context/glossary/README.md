# Glossary

This section defines the project's ubiquitous language — the domain terms used throughout the specification, each with a single agreed meaning. Consistent vocabulary is what keeps the [model](../model/), [actors](../actors/), and [requirements](../../requirements/) coherent; this glossary is the authoritative reference for every term.

Keep each definition short. For terms that are also domain entities, define the term briefly here and link to the [model](../model/) for the full structure — the glossary points, the model defines.

_List terms alphabetically. Replace the examples below with your own._

| Term | Definition |
| ---- | ---------- |
| **Caller** | Any client that issues a request to the system, whether or not it is authenticated. See [actors](../actors/). |
| **Catalog** | The complete collection of pet listings the system makes available to callers. |
| **Category** | A broad grouping of pets within the catalog (eg. "Dogs", "Cats"). See the [`Category`](../model/) entity. |
| **Credential** | The token a caller presents to authenticate. Issued and verified by the external identity service (see [constraints](../constraints/)). |
| **Hold window** | The configured duration for which a reservation is honoured before it automatically lapses. See [rule R5](../../requirements/behaviors/rules/). |
| **Idempotency key** | A caller-supplied token that lets a Partner safely retry a reserve request without creating a duplicate hold. See [idempotence](../../requirements/qualities/idempotence.md). |
| **Listing** | A single entry in the catalog representing one animal. See the [`Pet`](../model/) entity. |
| **Partner** | An authenticated caller belonging to an organisation with a signed partner agreement, permitted to place and release reservations. See [actors](../actors/). |
| **Reservation** | A temporary hold a [Partner](../actors/) places on an available pet, reflected by the `reserved` [status](../../requirements/behaviors/rules/) and recording the holding Partner. Lapses automatically after the hold window. |
