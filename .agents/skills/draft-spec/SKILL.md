---
name: draft-spec
description: Scaffold a new proposal for a change to the software requirements specification and open it as a draft pull request. Use when the user wants to propose a new feature or a changed functional/non-functional requirement, or says "draft a proposal", "new proposal", or "start a proposal".
license: MIT
---

# Draft proposal

Use this skill to start a new proposal: scaffold the branch and document from the template, then open a **draft pull request** with the artifacts in place, ready for the proposer to complete.

This is the entry point to the proposal lifecycle. The PR stays a GitHub draft while the proposer writes it; [`propose-spec`](../propose-spec/SKILL.md) removes the draft status once the document and spec edits are ready for review. Do NOT use this skill to advance an existing proposal — see [`propose-spec`](../propose-spec/SKILL.md), [`accept-spec`](../accept-spec/SKILL.md), [`release-spec`](../release-spec/SKILL.md), or [`reject-spec`](../reject-spec/SKILL.md).

## Instructions

1.  **Confirm the proposal slug and type.**

    Establish a short, hyphen-delimited slug (eg. `user-session-timeout`). Confirm the type: `FEATURE` (a new or changed functional requirement) or `QUALITY` (a new or changed non-functional requirement). If the user hasn't stated these, ask.

2.  **Create the branch.**

    ```sh
    git checkout main
    git pull
    git checkout -b proposal/<slug>
    ```

3.  **Create the proposal directory from the template.**

    Copy `proposals/TEMPLATE.md` to `proposals/<slug>/README.md`. The proposal lives in its own directory, so the proposer can add supporting artifacts (wireframes, mock-ups, data) alongside the `README.md` and link them from its `References` section. Do not add a numeric ID anywhere — proposal numbers are assigned only in `proposals/INDEX.md`, at merge.

4.  **Fill in the metadata header.**

    - `Authors`: the Git user's name and GitHub handle (run `git config user.name` if needed).
    - `Created` and `Last updated`: today's date in `YYYY-MM-DD` format.
    - `Status`: `PROPOSED`.
    - Leave `Approvers`, `Approval date`, `Proposal PR`, and `Implementation trackers` blank or as placeholders. The `Discussion thread` field is filled in at step 7.

    Leave the prose sections as the template placeholders for the proposer to complete.

5.  **Identify the specification sections to edit.**

    Based on the proposal type and description, locate the relevant files in `specification/` and list them in the `Proposed change` section as a starting point. Do not edit the spec files yet — leave that for the proposer.

    - Functional changes → `specification/requirements/behaviors/` (`features/`, `access/`, `rules/`, `journeys/`, `interfaces/`), `specification/context/actors/`, `specification/context/model/`.
    - Non-functional changes → `specification/requirements/qualities/`.

6.  **Commit and open a draft pull request.**

    ```sh
    git add proposals/<slug>/
    git commit -m "<type>: <slug>"          # feature: <slug> or quality: <slug>
    git push -u origin proposal/<slug>
    gh pr create --draft --title "<type>: <slug>" --fill
    ```

    Then apply exactly one type label — `FEATURE` or `QUALITY` — matching step 1:

    ```sh
    gh pr edit <number> --add-label "<FEATURE|QUALITY>"
    ```

    Do not apply a lifecycle label yet: the draft PR represents work in progress, and `#proposed` is applied later by [`propose-spec`](../propose-spec/SKILL.md).

7.  **Open the associated discussion thread.**

    Every proposal PR MUST have an associated discussion thread, where all review feedback is gathered. `gh` has no native discussion command, so use the GraphQL API. Look up the repository ID and the discussion category matching the proposal's type (`Features` or `Qualities`):

    ```sh
    gh api graphql -f query='
      query($owner:String!, $name:String!) {
        repository(owner:$owner, name:$name) {
          id
          discussionCategories(first:20) { nodes { id name } }
        }
      }' -F owner=<owner> -F name=<repo>
    ```

    Create the discussion, referencing the PR, and capture its URL:

    ```sh
    gh api graphql -f query='
      mutation($repoId:ID!, $categoryId:ID!, $title:String!, $body:String!) {
        createDiscussion(input:{repositoryId:$repoId, categoryId:$categoryId, title:$title, body:$body}) {
          discussion { url }
        }
      }' -F repoId=<repoId> -F categoryId=<categoryId> \
        -f title="<type>: <slug>" \
        -f body="Discussion thread for the **<slug>** proposal (PR #<number>). Please leave all feedback here, not on the pull request."
    ```

    Record the returned URL in the proposal's `Discussion thread` field and in the pull request body, then commit and push:

    ```sh
    git commit -am "chore: link discussion thread for <slug>"
    git push
    ```

## Rules

-   **One proposal per branch and pull request.**

    Never bundle multiple changes into a single branch. If the user describes changes that span multiple independent concerns, scaffold separate proposal branches.

-   **Branch from `main`, not from any other branch.**

    Proposals are always cut from `main`. If the local `main` is behind the remote, pull first.

-   **Open the PR as a draft.**

    A new proposal is not yet ready for review; it MUST be opened as a GitHub draft pull request.

-   **Every proposal PR has an associated discussion thread**, opened with the PR (even as a draft) and linked from both the document and the PR. All review feedback belongs in the discussion, not the PR's comments.

-   **Do not assign a numeric ID.**

    Proposal numbers are assigned only in `proposals/INDEX.md`, at merge. Nothing is ever renamed; the proposal stays at `proposals/<slug>/`.

-   **The specification edits describe the final state, not a diff.**

    When helping draft them, write as if the change has already shipped — not "we will add…" or "currently X, changing to Y".

## Success criteria

-   **Branch `proposal/<slug>` exists and is checked out.**

-   **`proposals/<slug>/README.md` exists**, a copy of `TEMPLATE.md` with the metadata header filled in and `Status: PROPOSED`.

-   **A draft pull request is open** (titled `feature: <slug>` or `quality: <slug>`), carrying exactly one type label and no lifecycle label.

-   **An associated discussion thread is open**, linked from the document's `Discussion thread` field and from the PR.

## References

- [`proposals/TEMPLATE.md`](../../../proposals/TEMPLATE.md): The proposal template to copy.

- [Contributing guide](../../../CONTRIBUTING.md): The full end-to-end process and the state machine.

- [`propose-spec`](../propose-spec/SKILL.md): Removes the draft status once the document is complete.
