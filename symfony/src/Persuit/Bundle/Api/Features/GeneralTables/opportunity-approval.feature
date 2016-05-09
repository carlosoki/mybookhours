@opportunity @approval
Feature: Secondment Opportunity request for approval

  Rules:
  - Only owners can request to approve secondment opportunity (Scenario 1).
  - An approver is mandatory when request for approval (POST) (Scenario 2).
  - You cannot set yourself as Approver (POST) (Scenario 3).
  - User without privileges to Approve (POST) (Scenario 4).

  Background:
    Given I loadDB

  Scenario Outline: 1 - Only owners can request to approve secondment opportunity
    Given the following "opportunity" exists
      | id | type             | status | owningCompany | profession | owningUser | approver |
      | 1  | clientSecondment | draft  | 1             | 1          | 2          | 4        |
      | 2  | clientSecondment | draft  | 1             | 1          | 3          | 4        |

    Then I am authenticating as "<user>" with "<password>" password

    When I send a PUT request to "<url>" with body:
    """
    {
        "type":"clientSecondment",
        "status": "unapproved",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "We are looking for 5 Mid-Senior Web Developers",
        "publish_duration":"5",
        "groups":[
            {
                "seniority":{"id":1}
            }
        ]
    }
    """
    Then the response code should be <code>
    And the response should contain json:
    """
        <response>
    """

    Examples:
      | user                             | password | url           | code | response                                                             |
      | write.dlapiper@sink.sendgrid.net | 123      | opportunity/1 | 200  | {"id":1,"status":"unapproved"}                                       |
      | write.dlapiper@sink.sendgrid.net | 123      | opportunity/2 | 403  | {"code": 403,"message": "You do not have the necessary permissions"} |

  Scenario: 2 - An approver is mandatory when request for approval (POST)
    Given I am authenticating as "write1.dlapiper@sink.sendgrid.net"
    When I send a POST request to "opportunity" with body:
    """
    {
        "type":"clientSecondment",
        "status": "unapproved",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "We are looking for 5 Mid-Senior Web Developers",
        "publish_duration":"5",
        "groups":[
            {
                "seniority":{"id":1}
            }
        ]
    }
    """
    Then the response code should be 400
    And the response should contain "Approver cannot be blank"

  Scenario: 3 - You cannot set yourself as Approver (POST)
    Given I am authenticating as "write1.dlapiper@sink.sendgrid.net"
    When I send a POST request to "opportunity" with body:
    """
    {
        "type":"clientSecondment",
        "status": "unapproved",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "approver":{
          "id": 3
        },
        "headline": "We are looking for 5 Mid-Senior Web Developers",
        "publish_duration":"5",
        "groups":[
            {
                "seniority":{"id":1}
            }
        ]
    }
    """
    Then the response code should be 400
    And the response should contain "You cannot set yourself as Approver"

  Scenario: 4 - User without privileges to Approve (POST)
    Given I am authenticating as "write1.dlapiper@sink.sendgrid.net"
    When I send a POST request to "opportunity" with body:
    """
    {
        "type":"clientSecondment",
        "status": "unapproved",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "approver":{
          "id": 2
        },
        "headline": "We are looking for 5 Mid-Senior Web Developers",
        "publish_duration":"5",
        "groups":[
            {
                "seniority":{"id":1}
            }
        ]
    }
    """
    Then the response code should be 400
    And the response should contain "User without privileges to Approve"