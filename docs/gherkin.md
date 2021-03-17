# Gherkin primer

We're using the Gherkin format to document our software system's functional requirements.

If you're unfamiliar with Gherkin, here follows a brief introduction to the language's main features.

#### Overview

Gherkin is a human-readable, plain-text, line-oriented [domain specific language](https://martinfowler.com/bliki/BusinessReadableDSL.html) for documentation.

Gherkin specifies a software system on a feature-by-feature basis from the point of view of different groups of users. The objective is to provide a unified specification that can be written and understood by technical and non-technical (business) people alike.

Gherkin can also be parsed by machines and used as the basis for automated acceptance testing.

Each discrete feature is described in its own `.feature` file. 

The business rules for each feature are laid out as a series of scenarios and steps. A feature may have multiple scenarios, and a scenario may play out over multiple steps.

```
Feature: <title>
  In order to <do something>
  As a <user>
  I want to achieve <some goal>

  Scenario: <title>
    (<optional description>)
    Given <state or precondition>
     (And <state or precondition>)
     When <event or action>
     (And <event or action>)
     Then <expected outcome>
     (And <expected outcome>)
```

Example:

```
Feature: Refund item
  In order to be confident in my purchases
  As a Buyer
  I want to receive refunds for faulty goods

  Scenario: Jeff returns a faulty microwave
    Given Jeff has bought a microwave for $100
    And he has a valid receipt
    When he returns the microwave
    Then Jeff should be refunded $100
```

#### Features

The opening lines of a `.feature` file look like this:

```
Feature: A title or terse description of a feature
  In order to realise a named business value
  As a particular type of user
  I want to gain some beneficial outcome
```

This describes the business value derived from inclusion of the feature in the software. The business value is defined in the format of an acceptance test. This is a twist on the classis "user story" formula, which has the following structure:

```
As a <user type>, I want to <some goal> so that <some reason>
```

A user story tells us *who* the feature is for, *what* the user wants to achieve, and *why*. Gherkin flips this format around, putting the business value of each feature at the start of its description:

```
In order to <realise some business value>
As a <user type>
I want to <achieve something>
```

This top section is included for the benefit of humans. It is not intended to be used by machines in behaviour-driven tests.

#### Scenarios

At this level, both user stories and Gherkin describe the problem, not the solution. But Gherkin goes further by describing how the problem will be solved in the software. This is done via one or more scenarios, each of which follows the "given-when-then" format:

```
Given <precondition>
When <user action>
Then <testable outcome>
```

A scenario is a concrete example that illustrates a business rule. It consists of a list of steps. The number of steps per scenario is unlimited, but it is good practice to aim for five or less steps per scenario. Any longer, and scenarios lose their expressive power as specification and documentation.

Scenarios are also tests. Each scenario is an executable specification of the system. They are the basis of behaviour-driven testing.

Scenarios follow this pattern:

- Describe an initial context ("given")
- Describe an event ("when")
- Describe an expected outcome ("then")

```
  Scenario: Some determinable business situation
    Given some precondition
      And some other precondition
     When some action is undertaken by the user
      And some other system event happens
     Then some testable outcome is achieved
      And something else we can check happens, too

  Scenario: A different situation
    Given...
```

Examples:

```
Scenario: Wilson posts to his own blog
  Given I am logged in as Wilson
  When I try to publish a new blog post
  Then I should see "Your article was published."

Scenario: Wilson fails to post to somebody else's blog
  Given I am logged in as Wilson
  When I try to publish a new blog post
  Then I should see "Hey! That's not your blog!"

Scenario: Greg posts to a client's blog
  Given I am logged in as Greg
  When I try to publish a new blog post
  Then I should see "Your article was published."
```

#### Steps

Scenarios consist of multiple steps. Each step starts with one of the following keywords:

- `Given`
- `When`
- `Then`
- `And`
- `But`

Steps are also known as "Givens", "Whens" and "Thens". 

"**Givens**" are preconditions that put the system in a known state before a user or some external system starts interacting with it. Things that "happened earlier" are also okay:

```
Given there are no users logged on to the site
Given I am logged in as an administrator
```

Behavioural test frameworks will use the `Given` information to configure the system under test to an initial state. This may involve creating mock objects or adding records to a database, for example.

"**Whens**" are used to describe an event or action. This can be a person interacting with the system, or it can be an event triggered by another system, or a combination of both. Whatever happens, it causes a transition in state.

```
When I am on "/some/page"
When I fill "username" with "admin"
When I fill "password" with "123456"
When I press "login"
When I run "ls -la"
```

It is good practice to have no more than one or two `When` steps per scenario. Any more and you should think about splitting up the scenario into multiple smaller ones.

"**Thens**" are assertions that are used in software testing to compare _actual_ outcomes with _expected_ outcomes. They describe an expected outcome or result, or an expected new state. Automated testing systems may be required to inspect some aspect of the system – a log entry, user interface repaint, command output, etc. – to verify the assertion.

It is possible to have multiple `Given`, multiple `When` and multiple `Then` steps within a single scenario (but they must always be grouped in that order.) For better readability, you can swap subsequent `Given`, `When` and `Then` keywords for `And` or `But`:

```
Scenario: Multiple Givens
  Given one thing
  And an other thing
  And yet an other thing
  When I open my eyes
  Then I see something
  But I don't see something else
```

When executing a feature in a test automation system, the trailing portion of each step – the text after the keywords `Given`, `When`, `Then`, `And` and `But` – is matched using a regular expression, which in turn is mapped to a callback function. Testing tools may actually treat the step keywords the same, though human consumers should not.

#### Backgrounds

Occasionally you'll find yourself repeating the same `Given` steps in all the scenarios within a feature file. Repeated steps are usually an indication they are not essential to describing individual scenarios, but rather are incidental details. Gherkin provides a solution to quite literally move these details to the background. A single `Background` section may be placed near the top of a feature file, sandwiched between the `Feature` block and the first `Scenario` section.

```
Background:
  Given a $100 microwave was sold on 2015-11-03
  And today is 2015-11-18
```

Background sections provide context to all the subsequent scenarios. In fact, a background is written like an untitled scenario. An automated testing solution may run the background script immediately before testing each scenario, thus background information can help to put a system into a predetermined state.
