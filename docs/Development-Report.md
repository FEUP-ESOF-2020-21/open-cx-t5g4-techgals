# openCX-*your module name* Development Report

Welcome to the documentation pages of the *your (sub)product name* of **openCX**!

You can find here detailed about the (sub)product, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP):

* Business modeling
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
* Requirements
  * [Use Case Diagram](#Use-case-diagram)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Prototype](#Prototype)
* [Implementation](#Implementation)
* [Test](#Test)
* [Configuration and change management](#Configuration-and-change-management)
* [Project management](#Project-management)

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us!

Thank you!

- Alexandra Ferreira
- Bianca Mota
- Marta Santos
- Raquel Sepúlveda
- Rita Silva


---

## Product Vision

At online conferences, meaningful connections and direct conversations
are lost. Thus, to enhance net-working, we built a virtual space in form
of a map, allowing users to walk in and out of conversations as naturally
as in real life - where interactions are solemnly based on one's interest.

Making the breaks between sessions more fun and opening up possibilities
for new connections.


## Elevator Pitch

This is a mobile app that allows online conference attendees
to interact with each other through chatrooms. This gives them a better
experience, keeping direct interactions alive.


## Requirements

The application should give the user the opportunity to choose his interests so that the map shows appealing topics. Hence the exhibited topics should lead to chatrooms where the users can communicate. It should be possible to leave the chatrooms. A user can create a new topic, giving him responsability for its chatroom management.

### Use case diagram

![Use case diagram](/docs/use_cases.png)

- **Sign In**
> **Actor**: Attendee  
> **Description**: This use case exists so that, at online conferences or during a break, the attendee can enter the application.  
> **Preconditions and Postconditions**: In order to sign in, the attendee must have an account. If not, he can create one. In the end, the user must have full access to the application   functionalities.   

> **Normal Flow**:    
  1. The attendee signs in.  
  2. The application validates email/password.  
  3. The application will ask for user's interests.   
  or  
  1. The attendee creates an account.  
  2. The application asks for personal information such as the email and password.  
  3. The application will ask for user's interests.  

> **Alternative Flows and Exceptions**: The user types his personal information -> the application doesn't recognize the email/password -> the application emits error message.   

- **Choose interests**  
> **Actor**: Attendee  
> **Description**: The application asks the user to set his interests.  
> **Preconditions and Postconditions**: In order to choose his interests, the user must first register and sign in. In the end, the user must be able to see a personalized map.  

> **Normal Flow**:
  1. The application asks the user to set his interests.  
  2. The application validates the interests entered by the attendee.  

- **Navigate the Map**
> **Actor**: Attendee  
> **Description**: The application directs the attendee to a personalized map view, showing points of interest in the form of discussion topics related to his interests.  
> **Preconditions and Postconditions**: In order to view the map, the attendee must have set his interests and personal information with success. In the end, the attendee can chose the chatrooms, represented on the map, he wants to join.  

> **Normal Flow**:
  1. The attendee has set his interests and personal information with success.
  2. The application shows a personalized map, showing discussion topics of interest.
  3. The attendee is able to choose any of the themes that lead to their respective chatroom.

> **Alternative Flows and Exceptions**: The user doesn't find a topic he really wanted to discuss -> He can create a new chatroom.  

- **Enter Chatroom**
> **Actor**: Attendee   
> **Description**: The attendee is directed to a chatroom.  
> **Preconditions and Postconditions**: In order to enter a chatroom, the attendee must choose on of the points in the map. In the end, the attendee can text the other chatroom participants, leave the chatroom or save information about other users.  

> **Normal Flow**:
  1. The attendee has chosen the discussion topic he wants to join.
  2. The attendee is directed to the chosen chatroom.
  3. The attendee is able to text, leave the chatroom, save someone's contact.

> **Alternative Flows and Exceptions**: The user is the chatroom creator -> The user can ban or mute other participants, in need. The user is the chatroom creator -> As long as there are people still participating in the chatroom, the moderator can't delete the chatroom.  

- **Create Chatroom**
> **Actor**: Attendee Chatroom Moderator  
> **Description**: The attendee has the option to create a new discussion topic.   
> **Preconditions and Postconditions**: In order to create a new chatroom, the attendee must click the 'create new topic' button and type its name. In the end, the user can text the other chatroom participants, leave the chatroom, save information about other users, mute/ban other participants, delete the chatroom.

> **Normal Flow**:
  1. The attendee clicks the button 'create new topic'.
  2. The attendee types the chatroom's name.
  3. The attendee is able to text, leave the chatroom, save someone's contact, ban/mute other participants, delete the chatroom.


### User stories

**[User Stories Board Link](https://github.com/FEUP-ESOF-2020-21/open-cx-t5g4-techgals/projects/1)**


1. **As a participant I want to login my interests and my contact information, so that I can have a personalized experience.**  
**Value:** Must-Have  
**Effort:**  L  
**Acceptance Tests:**  

 ```gherkin

    Given I want to access the app
    When I input invalid data
    Then I should be warned with an error message

    Given I am prompted to login in
    When I already have my information and interests defined
    And press the "let's go!" button
    Then I should be directed to the home page

```

**User interface mockups:**
![sign in](/docs/signin.png)

2. **As a participant I want to access a chatroom where I can talk to other users, so that I can discuss topics that interest me.**  
**Value:** Must-Have  
**Effort:**  M  
**Acceptance Tests:**  
```gherkin

   Given I want to talk to other users
   When I choose the topic I want to discuss
   Then I should be directed to its chatroom

```

3. **As a participant, I want to choose when to enter or leave a chatroom, so that I only participate in conversations that interest me.**  
**Value:** Must-Have  
**Effort:**  S  
**Acceptance Tests:**  
```gherkin

   Given I want to manage my experience
   When the option to leave a chatroom is clicked
   Then I must be directed to the map view and be able to join another chatroom

``` 

4. **As a chatroom moderator, I want to mute/banish people if need, so that the participants have a pleasant experience.**   
**Value:** Should-Have  
**Effort:**  M  
**Acceptance Tests:**  

```gherkin

   Given I created a new chatroom topic
   When I click the banish/mute button on a certain person
   Then messages from that person must not appear

``` 

**User interface mockups:**
![chatroom](/docs/chatroom.png)

5. **As a participant, I want to create a new chatroom with a different theme, so that I can discuss any topic I want even if it doesn't already exists.**
**Value:**  Should-Have  
**Effort:**  M  
**Acceptance Tests:**  

```gherkin

   Given the topic I want to discuss does not exist
   When I create a new topic,
   Then I should be able to discuss it when new participants join the chatroom

   Given the topic I want to discuss does not exist
   When I create a new topic
   Then I should be able to delete the chatroom only when it has no participants

```

**User interface mockups:**
![new chatroom](/docs/newchat.png)

6. **As a participant, I want to make friends / save someone's contact info, so that I can keep in touch with other like-minded users.**  
**Value:**  Could-Have  
**Effort:**  S  
**Acceptance Tests:**  

```gherkin

   Given I want to make new connections
   When I click on a participant's name,
   Then I should be able to see his information and copy it.

```

**User interface mockups:**
![save info](/docs/saveinfo.png)

7. **As a participant, I want to navigate the homepage, so that I can choose which functionality to access.**  
**Value:**  Must-Have  
**Effort:**  M  
**Acceptance Tests:**  

```gherkin

   Given I want to explore the app
   When I navigate the homepage,
   Then I should be able to choose which functionality to access.

   Given I want to explore the app
   When I navigate the homepage,
   Then I should be able to see where the profile button and the menu button are.
   
```

8. **As a participant I want to decide which chatroom I want to enter, so that I can discuss more than 1 theme if I want to.**  
**Value:**  Must-Have  
**Effort:**  M  
**Acceptance Tests:**  

```gherkin

   Given I want to explore the app
   When I click in a chatroom,
   Then I should be able to view information about the topic and the number of people participating in the conversation. 
   
```

**User interface mockups:**
![map](/docs/map.png)


### Domain model

To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module.

---

## Architecture and Design
The architecture of a software system encompasses the set of key decisions about its overall organization.

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them.

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

### Logical architecture
The purpose of this subsection is to document the high-level logical structure of the code, using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

It can be beneficial to present the system both in a horizontal or vertical decomposition:
* horizontal decomposition may define layers and implementation concepts, such as the user interface, business logic and concepts;
* vertical decomposition can define a hierarchy of subsystems that cover all layers of implementation.

### Physical architecture
![physical architecture](/docs/physical.png)


### Prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

---

## Implementation
Regular product increments are a good practice of product management.

While not necessary, sometimes it might be useful to explain a few aspects of the code that have the greatest potential to confuse software engineers about how it works. Since the code should speak by itself, try to keep this section as short and simple as possible.

Use cross-links to the code repository and only embed real fragments of code when strictly needed, since they tend to become outdated very soon.

---
## Test

There are several ways of documenting testing activities, and quality assurance in general, being the most common: a strategy, a plan, test case specifications, and test checklists.

In this section it is only expected to include the following:
* test plan describing the list of features to be tested and the testing methods and tools;
* test case specifications to verify the functionalities, using unit tests and acceptance tests.

A good practice is to simplify this, avoiding repetitions, and automating the testing actions as much as possible.

---
## Configuration and change management

Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).

For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the [GitHub flow](https://guides.github.com/introduction/flow/).


---

## Project management

Software project management is an art and science of planning and leading software projects, in which software projects are planned, implemented, monitored and controlled.

In the context of ESOF, we expect that each team adopts a project management tool capable of registering tasks, assign tasks to people, add estimations to tasks, monitor tasks progress, and therefore being able to track their projects.

Example of tools to do this are:
  * [Trello.com](https://trello.com)
  * [Github Projects](https://github.com/features/project-management/com)
  * [Pivotal Tracker](https://www.pivotaltracker.com)
  * [Jira](https://www.atlassian.com/software/jira)

We recommend to use the simplest tool that can possibly work for the team.


---

## Evolution - contributions to open-cx

Describe your contribution to open-cx (iteration 5), linking to the appropriate pull requests, issues, documentation.
