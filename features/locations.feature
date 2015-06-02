Feature: Locations
  Locations can be created, updated destroyed....the usual

  Scenario: Customers can view locations
    Given Customer visits the locations_path
    Then  they can see a list of locations
