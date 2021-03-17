# Workflow

#### How to propose a new feature

1.  Clone this repository, then create a branch from `main` with the prefix `proposal/` followed by a short descriptive slug. Example:

    ```
    git checkout main
    git branch proposal/single-sign-on-service
    git checkout proposal/single-sign-on-service
    ```

2.  Navigate to the `./src/proposals` directory and copy the file `TEMPLATE.md`. Rename the duplicate file for consistency with your branch's descriptive slug. Example:

    ```
    single-sign-on-service.md
    ```

3.  Edit the file. Follow the instructions in the template to define the requirements. If it is more appropriate to use other artefacts – such as entity diagrams, use cases, workflow diagrams, UI wireframes, test tables, etc. – to define the requirements, then go ahead and present your proposal as appropriate.

4.  Commit your changes and push upstream.

5.  Use GitLab's to request your `proposal/*` branch be merged into `main`. Your proposal will be peer reviewed.

#### Proposal review process

Subsequent steps are rather ad hoc at this time!
