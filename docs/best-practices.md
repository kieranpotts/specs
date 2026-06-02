# Best practices

Practical guidance for writing proposals and maintaining the specification. The mechanics — branches, labels, the state machine — are in the [contributing guide](../CONTRIBUTING.md); this document is about doing the work _well_.

## Scope each proposal to a single, atomic change

A proposal should capture one feature or one quality requirement that can be reviewed, decided, and shipped independently of any other. Atomic proposals are easier to reason about, quicker to decide, and cleaner to record in the log. If you find yourself writing "and also…", that is a second proposal.

When several changes genuinely depend on one another, keep them as separate proposals and group them under an `EPIC` pull request, linking each child proposal to the epic via its `Depends on` field. Resist the urge to bundle — a large, multi-part proposal is hard to review and impossible to partially accept.

## Specify the end state, not a changelog

A proposal's specification edits describe the system **as it will be** once the change has shipped — not the steps to get there. Write "Authenticated callers can filter the catalog by species," not "we will add a species filter." The diff against `main` already shows what is changing; the prose should read as a description of the destination, so that when the proposal is released the specification is simply true.

How the change is rolled out — migration steps, sequencing, feature flags — is an implementation concern and belongs in the code repositories or the [RFC repository](https://github.com/kieranpotts/rfc), not here.

## Write functional requirements as testable scenarios

Functional requirements live in [`features/`](../specification/requirements/behaviors/features/) as [Gherkin](https://cucumber.io/docs/gherkin/) scenarios. Each scenario is an acceptance criterion: a concrete, observable behavior that can be checked against the running system.

- Keep scenarios concrete. Prefer "Then the response contains at most 10 pet records" over "Then a reasonable number of records is returned."
- One behavior per scenario. If a scenario has two unrelated `Then` outcomes, it is probably two scenarios.
- Use the project's [ubiquitous language](../specification/context/glossary/). The same term should mean the same thing in the glossary, the model, and every scenario.
- Cover the unhappy paths — empty results, not-found, unauthorized — not just the happy one. The edge cases are where requirements are most often ambiguous.

Cross-cutting invariants that constrain many features ("a pet is never in two states at once") do not belong in any single scenario. State them once in [`rules/`](../specification/requirements/behaviors/rules/) and let scenarios reference them.

## State non-functional requirements as measurable thresholds

A quality requirement that cannot be measured cannot be verified, and an unverifiable requirement is just a wish. Specify [qualities](../specification/requirements/qualities/) as concrete, testable thresholds, ideally at a named percentile and load: "list responses within 300 ms at the 95th percentile under normal load," not "the API should be fast." Vague qualities give the false comfort of a requirement without the substance of one.

## Keep the description and the reasoning in their proper homes

The [`specification/`](../specification/) artifacts say _what_ the system does; the [proposal document](../proposals/) says _why_ this change was made. Don't smuggle rationale into the specification (it is meant to read as a timeless description of the present), and don't restate the full specification in the proposal (link to the artifacts it edits instead). The proposal is the place to be honest about motivation, alternatives considered, and trade-offs accepted — that honesty is what makes the log valuable years later.

## Use the discussion thread for debate

Every proposal has a discussion thread, and that is where review feedback, disagreement, and negotiation belong — not in the pull request's own comments. This keeps the PR history a clean record of how the _document_ evolved, while the thread captures how the _consensus_ formed. Both are worth preserving, but they are different records.

## Record rejections as carefully as acceptances

A rejected proposal is not a failure to be hidden; it is a decision worth remembering. Reverting its specification edits leaves the system unchanged, but the document is merged and kept, so the next person who has the same idea can read why it was not pursued. Write the `Motivation`, `Alternatives`, and `Tradeoffs and risks` sections of a doomed proposal with the same care as a winning one — those are the sections future readers will mine.

## Keep the specification honest

The specification's value rests entirely on one promise: that `main` describes production. Protect that promise. Do not merge an accepted proposal until its change is actually live. When implementation reveals that the real behavior differs from the proposed specification, reconcile the difference back into the spec before release, rather than shipping a specification you know to be wrong. A specification that is _mostly_ true is one nobody can trust.
