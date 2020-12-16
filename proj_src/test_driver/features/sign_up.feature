Feature: signup
User should be able see signup after pressing signup button icon.

Scenario: Signup into app successfully
Given I am at the 'welcomepage'
When I tap 'signup'
  And I type 'username'
  And I type 'email'
  And I type 'password'
  And I tap 'signupbtn'
Then I should be successfully signed up