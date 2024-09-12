Feature: Flight Search and Sorting
  As a user
  I want to search for flights and apply various filters and sorting options
  So that I can find the most suitable flight based on my preferences, such as price, duration, and arrival time

  Scenario: Show only direct flights
    Given I am on the home page
    When I fill in "Departure city" with "New York"
    And I fill in "Destination city" with "Los Angeles"
    And I select the departure date "2024-09-20"
    And I press "Search Flights"
    And I check the "direct" checkbox
    And I fill in "Budget" with "400"
    And I press "Apply Filters"
    Then I should see only direct flights with price equal or below 400 in the results

  Scenario: Sort flights by price in ascending order
    Given I am on the home page
    When I fill in "Departure city" with "New York"
    And I fill in "Destination city" with "Los Angeles"
    And I select the departure date "2024-09-20"
    And I press "Search Flights"
    When I click on the "Total Price" header
    Then the results should be sorted by "price" in ascending order

  Scenario: Sort flights by duration in ascending order
    Given I am on the home page
    When I fill in "Departure city" with "New York"
    And I fill in "Destination city" with "Los Angeles"
    And I select the departure date "2024-09-20"
    And I press "Search Flights"
    When I click on the "Duration" header
    Then the results should be sorted by "duration" in ascending order

  Scenario: Sort flights by arrival time in ascending order
    Given I am on the home page
    When I fill in "Departure city" with "New York"
    And I fill in "Destination city" with "Los Angeles"
    And I select the departure date "2024-09-20"
    And I press "Search Flights"
    When I click on the "Arrival Time" header
    Then the results should be sorted by "arrival time" in ascending order
