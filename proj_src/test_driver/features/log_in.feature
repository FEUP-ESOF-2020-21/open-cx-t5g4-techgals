Feature: login
User should be able see login after pressing login button icon.

Scenario: Login into app successfully
Given I tapped the login button in the homepage
When I type 'email'
  And I type 'password'
  And I tap 'login button'
Then I should be successfully logged