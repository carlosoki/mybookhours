@opportunity @duplicate
Feature: Duplicate Opportunity

  Background:
    Given I loadDB

    Given the following "opportunity" exists
      | id | type             | status    | owningCompany | profession | owningUser | approver |
      | 1  | clientSecondment | published | 1             | 1          | 2          | 4        |

    And the following "opportunity_group" exists
      | opportunity | seniority |quantity|
      | 1           | 1         |10      |
      | 1           | 1         |5       |

  Scenario: Duplicate opportunity
    When I am authenticating as "publish.dlapiper@sink.sendgrid.net" with "123" password
    When I send a POST request to "/opportunity/duplicate/1"
    Then the response code should be 201
    And result has "id" "2"
    And result has "type" "clientSecondment"
    And result has "status" "draft"
    Then I send a GET request to "opportunity/2"
    Then the response code should be 200
    And json collection result contains "groups" "0" "id" "3"
    And json collection result contains "groups" "0" "quantity" "10"
    And json collection result contains "groups" "1" "id" "4"
    And json collection result contains "groups" "1" "quantity" "5"
