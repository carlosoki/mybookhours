@opportunity @save-delete
Feature: Save, Delete opportunity
  In order to find a secondee
  As a corporate user
  I need to create an opportunity

  Background:
    Given I loadDB
    And I am authenticating as "publish.dlapiper@sink.sendgrid.net"

  Scenario: Save an Opportunity type secondment
    Given I set header "content-type" with value "application/json"
    When I send a POST request to "opportunity" with body:
    """
    {
        "type":"clientSecondment",
        "status": "draft",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "We are looking for 5 Mid-Senior Web Developers",
        "publishDuration":"2017-01-01 17:00:00",
        "groups":[
            {
                "seniority":{"id":1}
            }
        ]
    }
    """
    Then the response code should be 201

  Scenario: Save an Opportunity type hours
    Given I set header "content-type" with value "application/json"
    When I send a POST request to "opportunity" with body:
    """
    {
        "type":"clientHours",
        "status": "draft",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "We are looking for 5 Mid-Senior Web Developers",
        "publishDuration":"2017-01-01 17:00:00"
    }
    """
    Then the response code should be 201

  Scenario: Delete an opportunity when allowed
    Given the following "opportunity" exists
      | id | type             | status | owningCompany | profession | owningUser |
      | 1  | clientSecondment | draft  | 1             | 1          | 4          |

    When I send a DELETE request to "opportunity/1"
    Then the response code should be 204
    And from bundle "Api" check if "Opportunity" id 1 was 0 found

  Scenario Outline: Fail to Delete an opportunity - Blocking the delete action on voter its why return 403
    Given the following "opportunity" exists
      | id   | type             | status   | owningCompany | profession | owningUser |
      | <id> | clientSecondment | <status> | 1             | 1          | 4          |

    When I send a DELETE request to "<url>"
    Then the response code should be <code>
    And the response should contain json:
     """
        <json>
     """
    And from bundle "Api" check if "Opportunity" id <id> was <count> found


    Examples:
      | id | status    | url           | code | json                                                     | count |
      | 1  | published | opportunity/1 | 403  | {"message": "You do not have the necessary permissions"} | 1     |
      | 1  | closed    | opportunity/1 | 403  | {"message": "You do not have the necessary permissions"} | 1     |
      | 1  | draft     | opportunity/4 | 404  | {"message": "Opportunity 4 does not exist"}              | 1     |

  Scenario: Delete an opportunity when allowed
    Given the following "opportunity" exists
      | id | type             | status | owningCompany | profession | owningUser |
      | 1  | clientSecondment | draft  | 1             | 1          | 4          |

    When I send a DELETE request to "opportunity/1"
    Then the response code should be 204
