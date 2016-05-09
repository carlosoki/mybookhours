@user @search
Feature: User search
  In order to find users
  I need to search for a user

  Background:
    Given I loadDB

  #ROLE_ADMIN
  Scenario: role
    Given I am authenticating as "admin.persuit@sink.sendgrid.net"
    When I send a GET request to "/users?role=ROLE_USER_WRITE"
    Then I get 2 result
    And result 1 contains "email" "userwriter.dlapiper@sink.sendgrid.net"

  Scenario: professions
    Given I am authenticating as "admin.persuit@sink.sendgrid.net"
    When I send a GET request to "/users?professions=1"
    Then I get 23 result

  Scenario: company
    Given I am authenticating as "admin.persuit@sink.sendgrid.net"
    When I send a GET request to "/users?company=2"
    Then I get 3 result

  #ROLE_USER_WRITE
  Scenario: role
    Given I am authenticating as "userwriter.dlapiper@sink.sendgrid.net"
    When I send a GET request to "/users?role=ROLE_USER_WRITE"
    Then I get 1 result
    And result 1 contains "email" "userwriter.dlapiper@sink.sendgrid.net"

  Scenario: professions
    Given I am authenticating as "userwriter.dlapiper@sink.sendgrid.net"
    When I send a GET request to "/users?professions=1"
    Then I get 5 result

  #company is ignored here and all users own company is retreived
  Scenario: company
    Given I am authenticating as "userwriter.dlapiper@sink.sendgrid.net"
    When I send a GET request to "/users?company=2"
    Then I get 5 result
