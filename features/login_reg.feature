Feature: User login and administrative actions

  Scenario: User registers, logs in, searches for a city, and writes a review
    Given I am on the home page
    When I click on the "Sign Up"
    And I fill in "Password" with "securepassword"
    And I fill in "Password confirmation" with "securepassword"
    And I fill in "Email" with "newuser@example.com"
    When I press "Sign up"
    Then I should be logged in

    When I click on the "Logout"
    Then I should have "Sign In"
    
    When I click on the "Sign In"
    And I fill in "Password" with "securepassword"
    And I fill in "Email" with "newuser@example.com"
    When I press "Log in"
    Then I should be logged in


    When I search for a city called "Rome"
    Then I should have "Rome" 
    
    When I click on the "Show details"
    And I fill in "Write your review" with "Beautiful city with rich history."
    And I press "Add Review"
    Then I should have "Beautiful city with rich history"

  
    