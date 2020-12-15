Feature: signup


Scenario: User should be able see signup after pressing signup button icon
Given I tapped the signup button in the homepage
When I type 'username'
    And I type 'email'
    And I type 'password'
    And I tap 'signup button'
Then I should be successfully signed up