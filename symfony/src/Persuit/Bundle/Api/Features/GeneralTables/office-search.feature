@office @search
Feature: Office search
    Users need to be allocated to an office for auto assign secondments opportunities.
    Users are allocated by profession

    Rules:
        - Users can be assigned to multiple offices by profession.
        - An office can have multiple users assigned.
        - If a User has profession legal they cannot be assigned to an office If
        there is already a user assigned with legal profession.
        - If an office has a user assigned with the accounting profession. Then a user with
        legal profession can be assigned to the office.

    Background:
      Given I loadDB
      And I am authenticating as "offer2.offer@sink.sendgrid.net"

    Scenario: Basic match
        When I send a GET request to "/offices?professions=1"
        Then I get 1 result
        And result 1 contains "name" "Ashursts Melbourne"

    Scenario: Basic match
        When I send a GET request to "/offices?professions=2"
        Then I get 2 result
        And result 1 contains "name" "Ashursts Sydney"

    Scenario: Basic match
        When I send a GET request to "/offices?professions=1,2"
        Then I get 1 result
        And result 1 contains "name" "Ashursts Melbourne"