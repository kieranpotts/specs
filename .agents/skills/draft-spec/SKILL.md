---
name: draft-spec
description: Scaffold a new proposal for a change to the software requirements specification and open it as a draft pull request. Use when the user wants to propose a new feature, a changed non-functional requirement, or a large-scale epic initiative, or says "draft a proposal", "new proposal", or "start a proposal".
license: MIT
---

# Draft proposal

Use this skill to start a new proposal: scaffold the branch and document from the template, then open a draft pull request with the artifacts in place, ready for the user to complete.

This is the entry point to the requirement proposal lifecycle. The PR stays a draft while the user writes it.

Do NOT use this skill to advance an existing proposal, draft or otherwise. See [`propose-spec`](../propose-spec/SKILL.md), [`accept-spec`](../accept-spec/SKILL.md), [`release-spec`](../release-spec/SKILL.md), or [`reject-spec`](../reject-spec/SKILL.md).

## Instructions

1.  **Capture the description of the proposed specification change.**

    If the user did not explicitly input this information, prompt them for it.

2.  **Create a short, descriptive slug.**

    For example, for a behavioral change that sets a maximum duration for a user session before re-authentication is required, the short description may be "user session timeout" and its URL slug "user-session-timeout". Confirm with the user if you're not sure what is appropriate.

3.  **Determine the change type.**

    A specification change MUST be exactly one of the following types:

    - `FEATURE`: A new or changed functional requirement.
    - `QUALITY`: A new or changed non-functional requirements.
    - `EPIC`: A large-scale initiative spanning multiple feature and quality proposals.

    Determine which is the most appropriate category from the description. If you're not sure, ask the user.

4.  **Create the branch.**

    For `FEATURE` and `QUALITY` proposals use a `proposal/<slug>` branch; for `EPIC` proposals use `epic/<slug>`:

    ```sh
    git checkout main
    git pull
    git checkout -b proposal/<slug>   # or epic/<slug>
    ```

5.  **Create the proposal directory from the template.**

    Copy `proposals/TEMPLATE.md` to `proposals/<slug>/README.md`.

    The proposal lives in its own directory, so the user can add supporting artifacts (wireframes, mock-ups, data) alongside the `README.md` and link them from its `References` section.

6.  **Fill in the metadata header.**

    - `Authors`: the Git user's name and GitHub handle (run `git config user.name` if needed).
    - `Created` and `Last updated`: today's date in `YYYY-MM-DD` format.
    - `Status`: `DRAFT`.
    - Leave `Decided by`, `Decision date`, `Proposal PR`, and `Implementation trackers` blank or as placeholders. The `Discussion thread` field is filled in at step 7.

    Leave the prose sections as the template placeholders for the proposer to complete.

7.  **Identify the specification sections to edit.**

    Based on the proposal type and description, locate the relevant files in `specification/` and list them in the `Proposed change` section as a starting point. Do not edit the spec files here — the authoring is done with [`write-spec`](../write-spec/SKILL.md) once the proposal is scaffolded.

    - Functional changes → `specification/requirements/behaviors/` (`features/`, `access/`, `rules/`, `journeys/`, `interfaces/`), `specification/context/actors/`, `specification/context/model/`.

    - Non-functional changes → `specification/requirements/qualities/`.

8.  **Commit and open a draft pull request.**

    ```sh
    git add proposals/<slug>/
    git commit -m "<type>: <short lowercase proposal description>"
    git push -u origin proposal/<slug>  # or epic/<slug>
    gh pr create --draft --title "<type>: <short lowercase proposal description>" --fill
    ```

9.  **Apply the type label.**

    ```sh
    gh pr edit <number> --add-label "<type>"
    ```

    Apply exactly one type label to the PR, full uppercase: `FEATURE`, `QUALITY`, or `EPIC`.

10. **Open a discussion thread.**

    Every proposal PR MUST have an associated discussion thread, where all review feedback is gathered. `gh` has no native discussion command, so use the GraphQL API. Look up the repository ID and the discussion category matching the proposal's type (features, qualities, or epics):

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
        -f title="<type>: <short lowercase proposal description>" \
        -f body="Discussion thread for the **<short lowercase proposal description>** proposal (PR #<number>). Please leave all feedback here, not on the pull request."
    ```

    Record the returned URL in the proposal's `Discussion thread` field, and add it to the pull request description, so the two cross-reference each other:

    ```sh
    gh pr edit <number> --body "$(gh pr view <number> --json body -q .body)

    Discussion thread: <discussionUrl> — Please leave all review feedback there, not on this pull request."
    ```

    Then commit and push the document change:

    ```sh
    git commit -am "chore: link discussion thread"
    git push
    ```

11. **Hand off to [`write-spec`](../write-spec/SKILL.md).**

    The scaffold is now in place: branch, document, draft PR, and discussion thread. The next step is to author the actual specification content – the functional and non-functional requirements. Direct the user to [`write-spec`](../write-spec/SKILL.md) for that, and once the spec edits are complete, to [`propose-spec`](../propose-spec/SKILL.md) to mark the proposal ready for review.

## Rules

-   **A proposal is for a deliberate change to the specification.**

    Proposals are for new or changed requirements that warrant stakeholder review, not routine implementation work, bug fixes, or trivial edits, which go through the normal pull-request workflow. If the request looks too small to warrant a proposal, say so before scaffolding.

-   **One proposal per branch and pull request.**

    Never bundle multiple changes into a single branch. If the user describes changes that span multiple independent concerns, scaffold separate proposal branches.

-   **Branch from `main`, not from any other branch.**

    Proposals are always cut from `main`. If the local `main` is behind the remote, pull first.

-   **Open the PR as a draft.**

    A new proposal is not yet ready for review. It MUST be opened as a draft pull request.

-   **Every proposal PR has an associated discussion thread.**

    Opened with the PR (even as a draft) using the matching discussion category (`Features`, `Qualities`, or `Epics`), and linked from both the document and the PR. All review feedback belongs in the discussion, not the PR's comments.

-   **Do not assign a numeric ID.**

    Proposal numbers are assigned only in `proposals/INDEX.md`, after merge.

-   **The specification edits describe the final state, not a diff.**

    When helping draft them, write as if the change has already shipped — not "we will add…" or "currently X, changing to Y".

## Success criteria

- Branch `proposal/<slug>` exists and is checked out.

- `proposals/<slug>/README.md` exists, a copy of `TEMPLATE.md` with the metadata header filled in and `Status: DRAFT`.

- A draft pull request is open (titled `feature: <short lowercase proposal description>`, `quality: …`, or `epic: …`), carrying exactly one type label and no lifecycle label.

- An associated discussion thread is open, linked from the document's `Discussion thread` field and from the PR.

- The user has been directed to [`write-spec`](../write-spec/SKILL.md) to author the specification content.

## References

- [General reference information for agents](../../../AGENTS.md)

- [PR checklist](../../../.github/PULL_REQUEST_TEMPLATE.md)

