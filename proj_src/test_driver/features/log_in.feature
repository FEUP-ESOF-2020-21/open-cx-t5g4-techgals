Feature: login
User should be able see login after pressing login button icon.

Scenario: Login into app successfully
Given I want to Log into the app
When I type 'email'
  And I type 'password'
  And I tap 'login button'
Then I should be successfully logged