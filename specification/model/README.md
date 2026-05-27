# Model

This section documents the entities in the system's domain model — the categories of information the system stores — and how each entity type relates to the others.

The domain model is the shared vocabulary of the project. The [actors](../actors/) and [features](../features/) are derived from it, so keeping the model accurate and unambiguous pays off across the whole specification.

_Describe each entity, its meaningful attributes, and its relationships to other entities. An entity-relationship diagram may be embedded here to summarize the model visually._

## Entities

### Pet

A `Pet` is a single animal available in the catalog. It is the primary entity in the domain.

| Attribute | Type | Description |
| --------- | ---- | ----------- |
| `id` | Unique identifier | Stable, system-assigned identifier for the listing. |
| `name` | String | The given name of the individual animal (eg. "Fido"). |
| `species` | Enum | The species category (eg. `dog`, `cat`, `bird`, `fish`, `reptile`, `small-animal`). |
| `breed` | String | The breed or variety within the species (eg. "Labrador Retriever"). Optional; may be blank for mixed-breed animals. |
| `age` | Object | Approximate age, expressed as `{ value: number, unit: "weeks" | "months" | "years" }`. |
| `price` | Decimal | Asking price in the catalog's configured currency. |
| `status` | Enum | Current availability: `available`, `reserved`, or `sold`. |
| `description` | String | Free-text description of the animal, its temperament, and care requirements. |
| `photoUrls` | Array of strings | One or more URLs pointing to images of the animal. |
| `tags` | Array of strings | Freeform labels for search and filtering (eg. "hypoallergenic", "house-trained"). |

### Category

A `Category` groups pets into broad catalog sections (eg. "Dogs", "Cats", "Birds"). A `Pet` belongs to exactly one `Category`.

| Attribute | Type | Description |
| --------- | ---- | ----------- |
| `id` | Unique identifier | Stable, system-assigned identifier. |
| `name` | String | Human-readable category name. |

## Relationships

- A `Pet` belongs to exactly one `Category`.
- A `Category` may contain zero or more `Pets`.
