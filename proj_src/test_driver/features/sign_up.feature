Feature: signup


Scenario: User should be able see signup after pressing signup button icon
Given I tapped the signup button in the homepage
When I type 'username'
    And I type 'email1'
    And I type 'password1'
    And I tap 'signup button'
Then I should be successfully signed up