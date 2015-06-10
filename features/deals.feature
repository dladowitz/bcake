Feature: Deals
  Deals can be created, updated destroyed....the usual

  Scenario: User(owners) can create and view deals for their locations
    Given A non-admin user signs in successfully
    And   they view a location
    Then  they create a deal
