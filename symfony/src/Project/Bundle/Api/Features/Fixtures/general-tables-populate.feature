@fixture @general-tables
Feature: This feature is to populate the fixed Tables on databases

  Background:
    Given the following "client" exist
      | name     | typeContract | rate  |
      | Client 1 | part-time    | 20.50 |
      | Client 2 | casual       | 22    |
      | Client 3 | full-time    | 18.56 |
  Scenario: Successful GET returns response
