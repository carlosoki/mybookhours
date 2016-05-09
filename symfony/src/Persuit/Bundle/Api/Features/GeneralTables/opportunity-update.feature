@opportunity @opportunity-update
Feature: Update Opportunity
  In order to manage an Opportunity
  As a writer or an Opportunity
  I need to be able to update the Opportunity

  Background:
    Given I loadDB
    And I am authenticating as "publish.dlapiper@sink.sendgrid.net"

  Scenario Outline: Invalid call to update opportunity status
    Given the following "opportunity" exists
      | id | type        | status          | owningCompany | profession | owningUser |
      | 1  | clientHours | <currentStatus> | 1             | 1          | 4          |

    When I send a PUT request to "/opportunity/1" with body:
    """
    {
        "type":"clientHours",
        "status": "<newStatus>",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "We are looking for 5 Mid-Senior Web Developers",
        "publishDuration":"5"
    }
    """
    Then the response code should be 400

    Examples:
      | currentStatus  | newStatus  |
      | draft          | closed     |
      | published      | draft      |

  Scenario Outline: Valid values on simple fields
    Given the following "opportunity" exists
      | id | type        | status | <field>        | owningCompany | profession | owningUser |
      | 1  | clientHours | draft  | <currentValue> | 1             | 1          | 4          |

    When I send a PUT request to "/opportunity/1" with body:
    """
    {
        "type":"clientHours",
        "status": "draft",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "We are looking for 5 Mid-Senior Web Developers",
        "<field>" : <newValue>
    }
    """
    Then the response code should be 200
    And the response should contain json:
    """
        {"<field>":<newValue>}
    """

    Examples:
      | field           | currentValue  | newValue  |
      | inviteOnly      | 0             | 1         |
      | inviteOnly      | 0             | true      |
      | inviteOnly      | 1             | false     |
      | seeInvitedFirms | 0             | 1         |
      | seeInvitedFirms | 0             | true      |
      | seeInvitedFirms | 1             | false     |

  Scenario Outline: Budget range validation
    And the following "opportunity" exists
      | id | type        | status | owningCompany | profession | owningUser |
      | 1  | clientHours | draft  | 1             | 1          | 4          |

    When I send a PUT request to "/opportunity/1" with body:
    """
    {
        "type":"clientHours",
        "status": "draft",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "We are looking for 5 Mid-Senior Web Developers",
        "currency" :{
            "id": <currency>
        },
        "budgetRangeStart" : <budgetRangeStart>,
        "budgetRangeEnd" : <budgetRangeEnd>
    }
    """
    Then the response code should be <code>
    And the response should contain json:
    """
        <json>
    """

    Examples:
      | budgetRangeStart | budgetRangeEnd | currency | code | json                                              |
      | 10000            | null           | 1        | 200  | {"budgetRangeStart":10000}                        |
      | 10000            | 10001          | 1        | 200  | {"budgetRangeStart":10000,"budgetRangeEnd":10001} |
      | 10000            | null           | null     | 400  | {"message":"Validation Failed"}                   |
      | 10000            | 9999           | 1        | 400  | {"message":"Validation Failed"}                   |
      | null             | 10000          | 1        | 200  | {"budgetRangeEnd":10000}                          |
      | null             | 10000          | null     | 400  | {"message":"Validation Failed"}                   |
      | 100000000        | null           | 1        | 400  | {"message":"Validation Failed"}                   |
      | null             | 100000000      | 1        | 400  | {"message":"Validation Failed"}                   |
      | -1               | null           | 1        | 400  | {"message":"Validation Failed"}                   |
      | null             | -1             | 1        | 400  | {"message":"Validation Failed"}                   |
      | 10000            | null           | 10       | 400  | {"message":"Validation Failed"}                   |


  Scenario: Only certain fields are editable when the opportunity is published - successful fields
    Given the following "opportunity" exists
      | id | type             | status    | owningCompany | profession | owningUser |
      | 1  | clientSecondment | published | 1             | 1          | 4          |

    And the following "opportunityGroup" exists
      | opportunity | seniority |
      | 1           | 1         |

    When I send a PATCH request to "/opportunity/1" with body:
    """
    {
        "status": "closed"
    }
    """
    Then the response code should be 200
    And result has "status" "closed"