# Gherkin

We are using the Gherkin format to document the system's functional requirements. The Gherkin feature files are intended only for human consumption, but we may use them as the basis of automated integration tests in the future.

If you unfamiliar with Gherkin, here follows a brief introduction to the language's main features.

Gherkin is a human-readable, plain-text, line-oriented [domain specific language](https://martinfowler.com/bliki/BusinessReadableDSL.html) that can be written and understood by technical and non-technical people alike. It it also machine-parsable and can be used as the basis of automated acceptance testing.

Gherkin is a variation on the classic "user story" formula:

```
As a <user type>, I want to <some goal> so that <some reason>
```

A user story tells us *who* the feature is for, *what* the user wants to achieve, and *why*.

Gherkin flips this format around, putting the business value of each feature at the start of its description:

```
In order to <realise some business value>
As a <user type>
I want to <achieve something>
```

At this level, both user stories and Gherkin describe the problem, not the solution. But Gherkin goes further by describing how the problem will be solved in the software. This is done via "scenarios", each of which follows the format:

```
Given <precondition>
When <user action>
Then <testable outcome>
```

Gherkin specifies a software system on a feature-by-feature basis from the point of view of different types of users. Individual features are described in `.feature` files that follow this format:

```
Feature: A terse description of a desired feature 
  In order to realise a business value 
  As a particular type of user (an "actor") 
  I want to gain some beneficial outcome

  Scenario: Some determinable business situation 
    Given some precondition 
      And some other precondition 
     When some action by the actor 
     Then some testable outcome is achieved
```


#### Contents

- [Basic Structure](#basic-structure)
- [Features](#features)
- [Scenarios](#scenarios)
- [Steps](#steps)
- [Backgrounds](#backgrounds)

#### Basic Structure

[▲ Back to contents](#contents)

Business rules are structured by features, scenarios and steps. A software feature may have multiple scenarios, and a scenario may play out over multiple steps.

```
Feature: <title>
  In order to <something>
  As a <user>
  I want to achieve <goal>

  Scenario: <title>
    (<description>)
    Given <state>
     (And <state>)
     When <action>
     (And <action>)
     Then <expectation>
     (And <expectation>)
```

Example:

```
Feature: Refund item

  Scenario: Jeff returns a faulty microwave
    Given Jeff has bought a microwave for $100
    And he has a receipt
    When he returns the microwave
    Then Jeff should be refunded $100
```

#### Features

[▲ Back to contents](#contents)

A `.feature` file is meant to describe a single feature of the system, or a particular aspect of a feature. It's just a way to provide a high-level description of a software feature, and to group related scenarios.

The opening lines of a `.feature` file has the following structure:

```
Feature: A terse description of a desired feature
  In order to realise a named business value
  As a particular type of user
  I want to gain some beneficial outcome
```

This describes the business value derived from inclusion of the feature in the software, and the business value is defined in the format of an acceptance test. This top section is included for the benefit of humans; it is not used by machines in behaviour-driven tests.

#### Scenarios

[▲ Back to contents](#contents)

Typically, one feature is defined per `*.feature` file. But each feature typically consists of multiple scenarios. A scenario is a concrete example that illustrates a business rule. It consists of a list of steps. The number of steps per scenario is unlimited, but it is good practice to restrict the total number of steps to five or less. Any longer, and scenarios lose their expression power as specification and documenation.

Scenarios are also tests. Each scenario is an executable specification of the system.

Scenarios follow this pattern:

- Describe an initial context.
- Describe an event.
- Describe an expected outcome

```
  Scenario: Some determinable business situation
    Given some precondition
      And some other precondition
     When some action by the actor
      And some other action
      And yet another action
     Then some testable outcome is achieved
      And something else we can check happens too

  Scenario: A different situation
```

Examples:

```
Scenario: Wilson posts to his own blog
  Given I am logged in as Wilson
  When I try to post to "Expensive Therapy"
  Then I should see "Your article was published."

Scenario: Wilson fails to post to somebody else's blog
  Given I am logged in as Wilson
  When I try to post to "Greg's anti-tax rants"
  Then I should see "Hey! That's not your blog!"

Scenario: Greg posts to a client's blog
  Given I am logged in as Greg
  When I try to post to "Expensive Therapy"
  Then I should see "Your article was published."
```

#### Steps

[▲ Back to contents](#contents)

A step typically starts with Given, When or Then. If there are multiple Given or When steps underneath each other, you can use And or But.

Scenarios and backgrounds consist of multiple steps. Each step starts with one of the following keywords:

- `Given`
- `When`
- `Then`
- `And`
- `But`

Steps are also known as "Givens", "Whens" and "Thens". 

**Givens** are preconditions that put the system in a known state before a user or some external system starts interacting with it. Things that "happened earlier" are also OK:

```
Given there are no users on site
Given the database is clean
Given I am logged in as admin
```

Given steps are used to describe the initial context of the system — the scene of the scenario. It is typically something that happened in the past. Behavioural test frameworks will use this information to configure the system under test to be in a well-defined state. This may involve create a mock objects or adding records to a database, for example.

The user or client interaction is described by the **Whens**. These typically describe a transition in state.

```
When I am on "/some/page"
When I fill "username" with "admin"
When I fill "password" with "123456"
When I press "login"
When I call "ls -la"
```

`When` steps are used to describe an event, or an action. This can be a person interacting with the system, or it can be an event triggered by another system. It's strongly recommended you only have a single `When` step per scenario. If you feel compelled to add more it's usually a sign that you should split the scenario up into multiple scenarios.

The **Thens** are observations of outcomes. The observations should be related to the business value in the feature description. They should inspect the ouput of the system — a report, user interface repaint, message, command output, etc. — and not something deeply buried in the system such as a database change (which is an implementation detail and does not convey any business value).

`Then` steps are used to describe an expected outcome, or result. The step definition of a `Then` step should use an assertion to compare the actual outcome (what the system actually does) to the expected outcome (what the step says the system is supposed to do).

Use `And` and `But` to group multiple **Givens**, **Whens** and **Thens** within a single scenario.

```
Scenario: Multiple Givens
  Given one thing
  And an other thing
  And yet an other thing
  When I open my eyes
  Then I see something
  But I don't see something else
```

When executing a feature in a test automation system, the trailing portion of each step (the text after the keywords `Given`, `When`, `Then`, `And` and `But`) is matched using a regular expression, which executes a callback function. Testing tools may actually treat the step keywords the same, though human consumers should not.

#### Backgrounds

[▲ Back to contents](#contents)

Occasionally you'll find yourself repeating the same `Given` steps in all of the scenarios in a feature file. Since it is repeated in every scenario it is an indication that those steps are not essential to describe the scenarios, but rather they are probably incidental details. You can literally move such `Given` steps to the background by grouping them under a `Background` section before the first scenario.

```
Background:
  Given a $100 microwave was sold on 2015-11-03
  And today is 2015-11-18
```

Backgrounds allow you to add some context to all scenarios in a feature. A background is written like an untitled scenario, containing a number of steps but no title. The only difference is that backgrounds are run before all scenarios in a feature test. As with `Given` steps, they can help to put a system into a predetermined state before the tests are run proper.

```
Feature: Multiple site support

  Background:
    Given a global administrator named "Greg"
    And a blog named "Greg's anti-tax rants"
    And a customer named "Wilson"
    And a blog named "Expensive Therapy" owned by "Wilson"

  Scenario: Wilson posts to his own blog
    Given I am logged in as Wilson
    When I try to post to "Expensive Therapy"
    Then I should see "Your article was published."

  Scenario: Greg posts to a client's blog
    Given I am logged in as Greg
    When I try to post to "Expensive Therapy"
    Then I should see "Your article was published."
```
