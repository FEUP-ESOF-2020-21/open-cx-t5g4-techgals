Feature: login
User should be able see login after pressing login button icon.

Scenario: Login into app successfully
Given I am at the 'welcomepage'
When I tap 'login'
  And I type 'email'
  And I type 'password'
  And I tap 'loginbtn'
Then I should be successfully logged