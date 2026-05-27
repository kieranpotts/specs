---
name: draft-proposal
description: Scaffold a new proposal for a change to the software requirements specification. Use when the user wants to propose a new feature, a changed functional requirement, or a changed non-functional requirement, or says "draft a proposal", "new proposal", or "start a proposal".
license: MIT
---

# Draft proposal

Use this skill to scaffold a new proposal in the `proposals/` directory. It creates the branch, copies the template, fills in the metadata, and stubs out the specification section edits so the proposer can focus on writing the content.

Do NOT use this skill to advance a proposal that already exists (use [`advance-proposal`](../advance-proposal/SKILL.md)), or to audit an existing proposal document (use [`check-proposal`](../check-proposal/SKILL.md)).

## Instructions

1.  **Confirm the proposal slug and type.**

    Establish a short, hyphen-delimited description slug for the proposal (eg. `user-session-timeout`). Also confirm whether this is a FEATURE proposal (new or changed functional requirement) or a PERFORMANCE proposal (new or changed non-functional requirement). If the user hasn't stated this, ask.

2.  **Create the branch.**

    ```sh
    git checkout main
    git pull
    git checkout -b proposal/<slug>
    ```

3.  **Copy the template.**

    Copy `proposals/TEMPLATE.md` to `proposals/<slug>.md`. Do not rename it with a numeric ID yet — that happens at merge time.

4.  **Fill in the metadata header.**

    Populate these fields in the new proposal document:

    - `Authors`: the Git user's name and GitHub handle (run `git config user.name` if needed).
    - `Created`: today's date in `YYYY-MM-DD` format.
    - `Last updated`: same as `Created` initially.
    - `Issue`: if the user provides an issue number, link it as `#NNN`; otherwise leave as `_(if applicable)_`.
    - `Proposal PR`: leave as `#...` — the PR number is not yet known.
    - Leave `Approvers`, `Approval date`, `Discussion thread`, and `Implementation trackers` blank.

5.  **Set the initial status.**

    If the proposal document and any planned specification edits are ready for stakeholder review, set the status to `#proposed`. Otherwise leave it at `#draft`.

6.  **Identify the specification sections to edit.**

    Based on the proposal type and description, locate the relevant files in `specification/`:

    - Functional changes → `specification/features/` (Gherkin `.feature` files) and/or `specification/actors/`, `specification/journeys/`, `specification/model/`.
    - Non-functional changes → `specification/performance/`.

    List these files in the `Proposed change` section of the proposal document as a starting point for the proposer. Do not edit the spec files yet — leave that for the proposer to fill in.

7.  **Remind the proposer of next steps.**

    Once the document and spec edits are complete, the proposer should open a pull request titled `proposal: <slug>`. Apply the `#draft` or `#proposed` label to the PR to match the current status. See the [contributing guide](../../CONTRIBUTING.md) for the full process.

## Rules

-   **One proposal per branch and pull request.**

    Never bundle multiple proposals into a single branch. If the user describes changes that span multiple independent concerns, scaffold separate proposal branches.

-   **Branch from `main`, not from any other branch.**

    Proposals are always cut from `main`. If the local `main` is behind the remote, pull first.

-   **Do not assign a numeric ID.**

    IDs are assigned by the product managers at merge time. Leave the filename as `<slug>.md`.

-   **The specification sections describe the final state, not a diff.**

    When helping the proposer draft the spec edits, write them as if the change has already shipped — not as "we will add…" or "currently X, changing to Y".

## Success criteria

-   **Branch `proposal/<slug>` exists and is checked out.**

-   **`proposals/<slug>.md` exists** and is a copy of `TEMPLATE.md` with metadata fields populated.

-   **Status is either `#draft` or `#proposed`**, consistent with the readiness of the document.

-   **`Authors`, `Created`, and `Last updated` fields are filled in.**

-   **The `Proposed change` section names the specific specification files** that will need to be edited.

## References

- [`proposals/TEMPLATE.md`](../../proposals/TEMPLATE.md): The proposal template to copy.

- [Contributing guide](../../CONTRIBUTING.md): Full end-to-end process for proposing a change, including the state machine and permitted transitions.

- [`advance-proposal`](../advance-proposal/SKILL.md): For advancing a proposal through its lifecycle after it is drafted.

- [`check-proposal`](../check-proposal/SKILL.md): For auditing a proposal before it advances to `#proposed`.
