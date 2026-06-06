# Best practices

Practical guidance for writing proposals and maintaining the specification.

## Scope each proposal to a single, atomic change

A proposal SHOULD capture one feature or one quality requirement that can be reviewed, decided, and shipped independently of any other. Atomic proposals are easier to reason about, quicker to decide, and cleaner to record in the log.

When several changes genuinely depend on one another, keep them as separate proposals and group them under an `EPIC` pull request, linking each child proposal into the epic via the epic's `Depends on` field.

## Specify the end state, not a changelog

A proposal's specification edits SHOULD describe the system as it will be once the change has shipped. It SHOULD NOT specify the steps necessary to get to that end state.

Write "authenticated callers can filter the catalog by species," not "we will add a species filter."

The diff against `main` already shows what is changing. The prose SHOULD read as a description of the destination, so that when the proposal is released the specification is simply true.

How the change is rolled out — migration steps, sequencing, feature flags — is an implementation concern and does not belong in the SRS.

## Write functional requirements as testable scenarios

Functional requirements SHOULD be defined as [Gherkin](https://cucumber.io/docs/gherkin/) scenarios. Each scenario is an acceptance criterion, a concrete, observable behavior that can be checked against the running system.

Keep scenarios concrete. Prefer "then the response contains at most 10 pet records" over "then a reasonable number of records is returned."

Define one behavior per scenario. If a scenario has two unrelated `Then` outcomes, it is probably two scenarios.

Use the project's ubiquitous language. The same term should mean the same thing in the glossary, the model, and every scenario.

Don't forget to cover the unhappy paths, too: empty results, not-found, unauthorized, etc. The edge cases are where requirements are often the most ambiguous.

Cross-cutting invariants that constrain many features ("a pet is never in two states at once") do not belong in any single scenario. Better to state them as business rules and have the scenarios reference them.

## State non-functional requirements as measurable thresholds

A quality requirement that cannot be measured cannot be verified, and an unverifiable requirement is just a wish. Better to specify quality requirements as concrete, testable thresholds, ideally at a named percentile and load: "list responses within 300 ms at the 95th percentile under normal load," not "the API should be fast."

These are the system's _dynamic_ qualities — what it must achieve at runtime, observable to its users. _Static_ qualities of the code and design – readability, modularity, and the like – are a design concern, so not something the specification states.

Vague qualities give the false comfort of a requirement without the substance of one.

## Keep the description and the reasoning in their proper homes

The specification artifacts say _what_ the system does, while the proposal documents says _why_ this change was made. Don't smuggle rationale into the specification – it is meant to read as a timeless description of the present. Likewise, don't restate the full specification in the proposal – instead, link to the artifacts it edits.

The proposal is the place to be honest about motivation, alternatives considered, and trade-offs accepted. Focus on that – its what makes the log valuable years later.

## Use the discussion thread for debate

Every proposal has a discussion thread, and that is where review feedback, disagreement, and negotiation belong.

It keeps the PR history a clean record of how the proposal and specification documents evolved during that feedback period.

The discussion thread captures how the consensus formed, but this is ultimately summarized in the finalized proposal document. Once the final proposal document is merged, the discussion thread has served its purpose and can be dereferenced and, eventually, deleted.

## Record rejections as carefully as acceptances

A rejected proposal is not a failure to be hidden. It is a decision worth remembering. Reverting its specification edits leaves the system unchanged, but the document is merged and kept, so the next person who has the same idea can read why it was not pursued.

Write the `Motivation`, `Alternatives`, and `Tradeoffs and risks` sections of a doomed proposal with the same care as a winning one.

## Keep the specification honest

The specification's value rests entirely on one promise: that `main` describes production. Protect that promise. Do not merge an accepted proposal until its change is actually live.

When implementation reveals that the real behavior differs from the proposed specification, reconcile the difference back into the spec before release, rather than shipping a specification you know to be wrong.

A specification that is _mostly_ true is one nobody can trust.
