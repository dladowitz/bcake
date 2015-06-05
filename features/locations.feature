Feature: Locations
  Locations can be created, updated destroyed....the usual

  Scenario: Customers can view locations
    Given Customer visits the locations_path
    Then  they can see a list of locations
    Then  they can view a single location

  Scenario: User(owners) can create and view locations
    Given A non-admin user signs in successfully
    Then  they can create a new location
    Then  they can view that location
