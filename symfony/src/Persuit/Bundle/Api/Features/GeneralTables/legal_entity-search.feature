@legal_entity @search
Feature: LegalEntity search
  In order to find secondees
  As a corporate user
  I need to search for a legal entity

  Rules:
  - match any occurence of the search string in the field (doesn't have to be at the start)
  - results are ordered by name alphabetically (case insensitive)
  - search is case insensitive
  - need 3 characters minimum for the search to execute
  - special characters are not replaced (searching for 'and' will not search for '&')

  Background:
    Given I loadDB
    And I am authenticating as "publish.dlapiper@sink.sendgrid.net"

  Scenario: Basic match
    When I send a GET request to "/legal_entities?name=DLA"
    Then I get 1 result
    And result 1 contains "name" "DLA PTY"

  Scenario: No match
    When I send a GET request to "/legal_entities?name=Zaz"
    Then I get 0 result
