# Feature title

> Use this template to write proposals for new **features** or changes in **functionality** in the software. Delete any sections from the template that are not applicable.

Write a short summary of the proposed feature here.


## Summary of changes

> Summarise all the changes that you propose be introduced:

- xxx
- xxx
- xxx


## User stories

> Write one or more user stories that describe the proposed feature, or how existing behaviours will change or be deprecated. User stories should clearly signal the benefits of the changes from the perspective of particular groups of users. Alternatively, there may be commercial motivations for introducing some changes, such as high running costs. In this case, tell the user story from the perspective of the software vendor.
>
> Use the following template for each story:

```
In order to [do something]
As a [user type]
I want to [some goal]
```

> Examples:

```
In order to evaluate the performance of the team
As a team manager
I want to generate performance reports
```

```
In order to evaluate the effectiveness of my strategy
As a team member
I want to see how my performance compares with my colleagues
```


## Acceptance criteria

> Write some acceptance criteria, covering all possible preconditions, processes and end results. Use the following template for each condition of satisfaction:

```
Scenario: [scenario]

Given [state]
 (And [state])
 When [action]
 (And [action])
 Then [result]
 (And [result])
```

> Examples:

```
Scenario: Team manager views performance report

Given I am logged in as a team manager
 When I go to the Reports section
 Then I see data and charts showing how all team members performed over the last 30 days
  And I can change the report to show results for the last 60 and 90 days

Scenario: Team member views performance report

Given I am logged in as a team member
 When I go to the Reports section
 Then I see data and charts showing my own performance over the last 30 days
  And I can view my results for the last 60 and 90 days too
  And I can see how my performance compares relative to the team average
```


## Design

> If you're familiar with the system's architecture and design, explain what code-level modifications or extensions will be required to implement the proposed functional changes. 
>
> Consider how best to present the solution. The choice of design artefacts will vary from problem to problem: usage examples (for API changes), mock-ups (for GUI changes), UML or other diagrammatic notations (for structural changes), and so on.


## Additional comments

> Is there anything else you would like to tell the project's maintainers?
