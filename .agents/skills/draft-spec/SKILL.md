---
name: draft-spec
description: >-
  Scaffold the branch, proposal document, draft pull request, and discussion
  thread for a proposed change to the software requirements specification. Use
  when the user wants to propose a new feature or a change to a non-functional
  requirement, or says something like "draft a proposal", "new proposal", or
  "start a proposal". Do not use it to write the body of the proposal or to
  edit the specification artifacts.
compatibility: >-
  requires Read, Write, Edit, Glob, Grep, Bash (git, gh)
license: CC0-1.0
---

# Draft spec

Scaffold a new proposal: cut the branch, copy the template into
`proposals/<slug>/`, open a draft pull request, and link a discussion thread.
Do not write the substance of the proposal, and do not edit `specification/`.

## Parameters

Determine the following information from the surrounding context and
environment, if possible. If you're uncertain about the required parameters,
prompt the user for clarification.

- **A description of the proposed change — REQUIRED.** A short statement of
  the new or changed requirement, in the user's own words. Prompt for it if
  the user has not given one.

- **Change type — OPTIONAL.** One of `BEHAVIOR`, `QUALITY`, or `EPIC`. Infer
  it from the description where you can, and ask the user when the
  description is genuinely ambiguous.

- **A product-requirements document (PRD) — OPTIONAL.** The business-language
  statement of need this proposal is specified from. When absent, the
  proposal has no origin document and the `Origin` field is removed.

## Success criteria

- Branch `latest/proposal/<slug>` (or `latest/epic/<slug>` for an epic) MUST
  exist and MUST be checked out.

- `proposals/<slug>/README.md` MUST exist, copied from
  `proposals/TEMPLATE.md`, with its metadata header filled in and `Status`
  reading `DRAFT`.

- If a PRD was supplied, `proposals/<slug>/product-requirements.md` MUST hold
  it verbatim and the `Origin` field MUST link it; otherwise the `Origin`
  field MUST have been removed.

- A draft pull request MUST be open, titled `<commit type>: <short lowercase
  description>`, carrying exactly one type label and no lifecycle label.

- A discussion thread MUST be open, linked from the document's `Discussion
  thread` field and from the pull request body.

- The `Proposal PR` field MUST name the pull request, because the readiness
  gate later in the lifecycle requires it.

- Files under `specification/` MUST NOT have been edited — this skill
  scaffolds the proposal only, and the specification edits are authored
  afterwards.

## Instructions

1.  Capture the description of the proposed change, and prompt the user for
    it if they did not supply one.

2.  Derive a short, descriptive slug from it.

    For example, a change setting a maximum session duration before
    re-authentication gives the description "user session timeout" and the
    slug "user-session-timeout". Confirm with the user if you are unsure.

3.  Determine the change type. Exactly one applies:

    - `BEHAVIOR`: a new or changed functional requirement.
    - `QUALITY`: a new or changed non-functional requirement.
    - `EPIC`: a large-scale initiative spanning multiple feature and quality
      proposals.

    Ask the user if the description does not settle it. The change type sets
    the branch prefix and the PR type label; the commit message and PR title
    use a derived commit type instead — `behavior` for `BEHAVIOR`, and `create`
    for `QUALITY` or `EPIC` — per this repository's commit message
    conventions.

4.  Create the branch. Use `latest/proposal/<slug>` for `BEHAVIOR` and `QUALITY`
    proposals, and `latest/epic/<slug>` for `EPIC` proposals.

    ```sh
    git checkout latest/main
    git pull --rebase
    git checkout -b latest/proposal/<slug>   # or latest/epic/<slug>
    ```

5.  Copy `proposals/TEMPLATE.md` to `proposals/<slug>/README.md`.

    The proposal lives in its own directory so the user can add supporting
    artifacts — wireframes, mock-ups, data — alongside the `README.md` and
    link them from its `References` section.

6.  Preserve the originating PRD, if there is one.

    Write it verbatim to `proposals/<slug>/product-requirements.md`, beside
    the `README.md`. Save it as-supplied: do not edit, summarize, or reformat
    it. Its worth is that it captures the requirement exactly as it arrived,
    before specification.

    Where no PRD exists — the change is small enough to specify directly, or
    originates from a bug or an internal decision — skip this step.

7.  Fill in the metadata header:

    - `Authors`: the Git user's name and GitHub handle (`git config
      user.name` if needed).
    - `Created` and `Last updated`: today's date, `YYYY-MM-DD`.
    - `Status`: `DRAFT`.
    - `Origin`: `./product-requirements.md` if a PRD was preserved in step 6;
      otherwise remove the field.
    - Leave `Decided by`, `Decision date`, and `Implementation trackers`
      blank. `Proposal PR` and `Discussion thread` are filled in later in
      this procedure, once those artifacts exist.

    Leave the prose sections as template placeholders for the proposer.

8.  Identify the specification artifacts this proposal will touch, and list
    them in the `Proposed change` section as a starting point. Do not edit
    them.

    - Functional changes → `specification/requirements/behaviors/`
      (`features/`, `access/`, `rules/`, `journeys/`, `interfaces/`),
      `specification/context/actors/`, `specification/context/model/`.

    - Non-functional changes → `specification/requirements/qualities/`,
      under the subdirectory for the relevant ISO/IEC 25010 quality
      characteristic.

9.  Commit and open the draft pull request. Staging the whole proposal
    directory picks up the preserved `product-requirements.md` alongside the
    `README.md`.

    ```sh
    git add proposals/<slug>/
    git commit -m "<commit type>: <short lowercase description>"
    git push -u origin latest/proposal/<slug>   # or latest/epic/<slug>
    gh pr create --draft --title "<commit type>: <short lowercase description>" --fill
    ```

    Record the returned pull request number in the `Proposal PR` field.

10. Apply exactly one type label, in full uppercase.

    ```sh
    gh pr edit <number> --add-label "<TYPE>"
    ```

11. Open the discussion thread, using the category matching the proposal's
    type. `gh` has no native discussion command, so use the GraphQL API to
    look up the repository ID and category IDs:

    ```sh
    gh api graphql -f query='
      query($owner:String!, $name:String!) {
        repository(owner:$owner, name:$name) {
          id
          discussionCategories(first:20) { nodes { id name } }
        }
      }' -F owner=<owner> -F name=<repo>
    ```

    Create the discussion, referencing the pull request:

    ```sh
    gh api graphql -f query='
      mutation($repoId:ID!, $categoryId:ID!, $title:String!, $body:String!) {
        createDiscussion(input:{repositoryId:$repoId, categoryId:$categoryId, title:$title, body:$body}) {
          discussion { url }
        }
      }' -F repoId=<repoId> -F categoryId=<categoryId> \
        -f title="<commit type>: <short lowercase description>" \
        -f body="Discussion thread for the <short lowercase description> proposal (PR #<number>). Please leave all feedback here, not on the pull request."
    ```

    Record the returned URL in the `Discussion thread` field, and add it to
    the pull request body so the two cross-reference each other:

    ```sh
    gh pr edit <number> --body "$(gh pr view <number> --json body -q .body)

    Discussion thread: <discussionUrl> — Please leave all review feedback there, not on this pull request."
    ```

12. Commit and push the document changes.

    ```sh
    git commit -am "chore: link pull request and discussion thread"
    git push
    ```

13. Report what you scaffolded, and direct the user to author the
    specification content next, following
    [`docs/best-practices.md`](../../../docs/best-practices.md) and the
    `specification/requirements/` subdirectory READMEs. The pull request
    stays a draft until those edits are complete.

## Rules

- A proposal MUST be for a deliberate change to the specification.

  Proposals are for new or changed requirements that warrant stakeholder
  review — not routine implementation work, bug fixes, or trivial edits,
  which go through the normal pull-request workflow. If the request looks too
  small to warrant a proposal, say so before drafting.

- There MUST be exactly one proposal per branch and per pull request.

  Where the user describes changes spanning multiple independent concerns,
  scaffold separate proposals rather than bundling them.

- You MUST branch from `latest/main`, and pull first if local `latest/main` is
  behind the remote. Rebase to keep history linear.

- You MUST open the pull request as a draft, because a freshly scaffolded
  proposal has no substance for a reviewer to weigh in on yet.

- Every proposal pull request MUST have an associated discussion thread,
  opened in the category matching its type and linked from both the document
  and the pull request. All review feedback belongs in the discussion, not in
  the pull request comments.

- You MUST NOT assign a proposal number. Numbers are assigned in
  `proposals/INDEX.md` only after merge.

- The preserved PRD MUST be treated as a frozen input, never edited,
  summarized, or reformatted. The proposal document and the specification
  edits evolve; its origin record does not.

- You MUST NOT edit files under `specification/`. Authoring the specification
  content is the proposer's work, not this skill's.

## Edge cases

- The `gh` client is unavailable or not authenticated.

  Stop and report the failure. Leave the branch and the proposal document in
  place so the user can open the pull request and discussion by hand, then
  fill in the `Proposal PR` and `Discussion thread` fields themselves.

- The repository has no discussion category matching the proposal's type.

  Create the discussion in the closest available category and flag the
  mismatch to the user, rather than skipping the discussion thread
  altogether.

## References

- [Best practices](../../../docs/best-practices.md) \
  Read when you need to point the user at the conventions for authoring
  specification content.

- [Pull request checklist](../../../.github/PULL_REQUEST_TEMPLATE.md) \
  Read when filling out the pull request description in step 9.
