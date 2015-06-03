Feature: Customers
  Customers can sign up for locations

  Scenario: A customer can sign up for one or multiple locations
    Given Customer visits a location show page
    And   they fill out the email-birthday form
    Then  they are shown a confirmation screen
    And   they can click on a new location
    And   they can sign up for the new location
    And   they see the confirmation page again
