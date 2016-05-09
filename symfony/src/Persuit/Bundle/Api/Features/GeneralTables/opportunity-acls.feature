@opportunity @opportunity-acls
Feature: ACL for opportunity both Secondment and Hours request
  In order to validate users roles and permissions
  As a corporate user Authenticated

  Rules:
  | ROLE                            | VIEW | CREATE | UPDATE | PUBLISH |
  | ROLE_USER                       | yes  | no     | no     | no      |
  | ROLE_OPP_WRITE                  | yes  | yes    | yes    | no      |
  | ROLE_OPP_PUBLISH                | yes  | yes    | yes    | yes     |
  | ROLE_ADMIN                      | yes  | yes    | yes    | yes     |

  Background:
    Given I loadDB

    And the following "opportunity" exist
      | id | type             | status    | headline      | owningCompany | profession | owningUser | approver | inviteOnly | invitedCompanies |
      | 1  | clientHours      | draft     | OPPORTUNITY 1 | 1             | 1          | 3          | 4        |            |                  |
      | 2  | clientSecondment | draft     | OPPORTUNITY 2 | 2             | 1          | 5          |          |            |                  |
      | 3  | clientSecondment | published | OPPORTUNITY 3 | 1             | 1          | 3          | 4        |            |                  |
      | 4  | clientHours      | published | OPPORTUNITY 4 | 23            | 1          | 13         | 14       |            |                  |
      | 5  | clientSecondment | published | OPPORTUNITY 5 | 23            | 1          | 13         | 14       | 1          | 3                |

    And the following "opportunityGroup" exists
      | opportunity | seniority |
      | 3           | 1         |
      | 4           | 1         |
      | 5           | 1         |

  Scenario Outline: Only owners can view/update Secondment Opportunity in DRAFT
    Given I am authenticating as "<user>" with "<password>" password
    When I send a <method> request to "<url>" with body:
    """
      <json>
    """
    Then the response code should be <code>

    And check opportunity <id> and field <field> was changed <search> <count>

    Examples:
      | id | user                               | password | method | url           | json                                                                                                                           | code | field    | search     | count |
      |    | read.dlapiper@sink.sendgrid.net    | 123      | GET    | opportunity/1 | {}                                                                                                                             | 403  |          |            | 0     |
      |    | publish.dlapiper@sink.sendgrid.net | 123      | GET    | opportunity/1 | {}                                                                                                                             | 403  |          |            | 0     |
      | 1  | publish.dlapiper@sink.sendgrid.net | 123      | PUT    | opportunity/1 | {"type":"clientHours","status":"draft","profession":{"id":1},"headline": "change it!","publishDuration":"2017-01-01 17:00:00"} | 403  | headline | change it! | 0     |
      |    | write.dlapiper@sink.sendgrid.net   | 123      | GET    | opportunity/1 | {}                                                                                                                             | 403  |          |            | 0     |
      | 1  | write.dlapiper@sink.sendgrid.net   | 123      | PUT    | opportunity/1 | {"type":"clientHours","status":"draft","profession":{"id":1},"headline": "change it!","publishDuration":"2017-01-01 17:00:00"} | 403  | headline | change it! | 0     |
      | 1  | write1.dlapiper@sink.sendgrid.net  | 123      | GET    | opportunity/1 | {}                                                                                                                             | 200  |          |            | 1     |
      | 1  | write1.dlapiper@sink.sendgrid.net  | 123      | PUT    | opportunity/1 | {"type":"clientHours","status":"draft","profession":{"id":1},"headline": "change it!","publishDuration":"2017-01-01 17:00:00"} | 200  | headline | change it! | 1     |

  Scenario Outline: User with ROLE_ADMIN cannot read and write secondment opportunity for different companies
    Given I am authenticating as "othercompany.hsf@sink.sendgrid.net"
    When I send a <method> request to "<url>" with body:
    """
      <json>
    """
    Then the response code should be <code>

    And check opportunity <id> and field <field> was changed <search> <count>

    Examples:
      | id | method | url           | json                                                                                                                                                                  | code | field    | search     | count |
      | 1  | GET    | opportunity/1 | {}                                                                                                                                                                    | 403  |          |            | 1     |
      | 1  | PUT    | opportunity/1 | {"type":"clientHours","status":"draft","profession":{"id":1},"headline": "change it!","publishDuration":"2017-01-01 17:00:00"}                                        | 403  | headline | change it! | 0     |
      | 1  | PUT    | opportunity/1 | {"type":"clientHours","status":"published","profession":{"id":1},"headline": "change it!","publishDuration":"2017-01-01 17:00:00"}                                    | 403  | status   | published  | 0     |
      | 2  | GET    | opportunity/2 | {}                                                                                                                                                                    | 200  |          |            | 1     |
      | 2  | PUT    | opportunity/2 | {"type":"clientSecondment","status":"draft","profession":{"id":1},"headline": "change it!","publishDuration":"2017-01-01 17:00:00","groups":[{"seniority":{"id":1}}]} | 200  | headline | change it! | 1     |

  Scenario Outline: User with ROLE_OPP_WRITE can update but cannot publish secondment opportunity
    Given I am authenticating as "write1.dlapiper@sink.sendgrid.net"
    When I send a PUT request to "<url>" with body:
    """
      <json>
    """
    Then the response code should be <code>

    And check opportunity <id> and field <field> was changed <search> <count>

    Examples:
      | id | url           | json                                                                                                                                                | code | field    | search                     | count |
      |    | opportunity/1 | {"type":"clientHours","status":"draft","profession":{"id":1},"headline": "change it!","publishDuration":"2017-01-01 17:00:00"}                      | 200  | headline | change it!                 | 1     |
      | 2  | opportunity/2 | {"type":"clientSecondment","status":"draft","profession":{"id":1},"headline": "change other company's one","publishDuration":"2017-01-01 17:00:00"} | 403  | headline | change other company's one | 0     |
      | 1  | opportunity/1 | {"type":"clientHours","status":"published","profession":{"id":1},"headline": "change it!","publishDuration":"2017-01-01 17:00:00"}                  | 403  | status   | published                  | 0     |

  Scenario: User with ROLE_OPP_WRITE can create secondment opportunity
    Given I am authenticating as "write.dlapiper@sink.sendgrid.net"
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
        "description": "We are looking for 5 Mid-Senior Lawyers",
        "startDate": "2050-07-20",
        "inviteOnly": false,
        "seeInvitedFirms": false,
       "publishDuration":"2017-01-01 17:00:00",
        "groups":[
            {
                "seniority":{"id":1}
            }
        ]
    }
    """
    Then the response code should be 201
    Then the response should contain json:
    """
      {
        "status": "draft",
        "headline": "We are looking for 5 Mid-Senior Web Developers"
      }

    """
    And check opportunity "headline" was not saved "We are looking for 5 Mid-Senior Web Developers" 1

  Scenario: User with ROLE_OPP_WRITE cannot see secondment opportunity from other company
    Given I am authenticating as "write.dlapiper@sink.sendgrid.net"
    When I send a GET request to "opportunity/2"
    Then the response code should be 403
    And the response should contain json:
    """
      {
        "code": 403,
        "message": "You do not have the necessary permissions"
      }
    """

  Scenario: User with ROLE_OPP_WRITE can see the secondment opportunity from his company
    Given I am authenticating as "write.bhp@sink.sendgrid.net"
    When I send a GET request to "opportunity/4"
    Then the response code should be 200
    And the response should contain json:
    """
      {
         "id":4,
         "status":"published",
         "profession":{"id":1,"name":"Legal"}
      }
    """
    And json result contains "owningCompany" "id" "23"

  Scenario: User with ROLE_USER cannot create secondment opportunity
    Given I am authenticating as "read.dlapiper@sink.sendgrid.net"
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
          "description": "We are looking for 5 Mid-Senior Lawyers",
          "startDate": "2050-07-20",
          "inviteOnly": false,
          "seeInvitedFirms": false,
         "publishDuration":"2017-01-01 17:00:00",
          "groups":[
              {
                  "seniority":{"id":1}
              }
          ]
      }
     """
    Then the response code should be 403
    And check opportunity "headline" was not saved "We are looking for 5 Mid-Senior Web Developers" 0

  Scenario: User with ROLE_USER cannot see secondment opportunity from other company
    Given I am authenticating as "read.dlapiper@sink.sendgrid.net"
    When I send a GET request to "opportunity/2"
    Then the response code should be 403
    And the response should contain json:
    """
      {
        "code": 403,
        "message": "You do not have the necessary permissions"
      }
    """

  Scenario: User with ROLE_USER can see the secondment opportunity from his company
    Given I am authenticating as "read.bhp@sink.sendgrid.net"
    When I send a GET request to "opportunity/4"
    Then the response code should be 200
    And the response should contain json:
    """
        {

          "id":4,
          "status":"published",
          "profession":{"id":1,"name":"Legal"}
        }
    """
    And json result contains "owningCompany" "id" "23"

    Scenario: Validate ACL returned for ROLE_USER
      Given I am authenticating as "read.bhp@sink.sendgrid.net"
      When I send a GET request to "opportunity/4"
      Then the response code should be 200
      And the response should contain json:
      """
      {
        "acl":{
          "read":true,
          "write":false,
          "delete":false,
          "publish":false,
          "offer":false,
          "inviteCompany":false,
          "canAssign":false,
          "canTransfer":false,
          "withdraw":false
        }
      }
      """

    Scenario: Validate ACL returned for ROLE_OPP_WRITE in draft
      Given I am authenticating as "write1.dlapiper@sink.sendgrid.net"
      When I send a GET request to "opportunity/1"
      Then the response code should be 200
      And the response should contain json:
      """
      {
        "acl": {
          "read": true,
          "write": true,
          "delete": true,
          "publish": false,
          "offer": false,
          "inviteCompany": true,
          "canAssign": false,
          "canTransfer": false,
          "withdraw": false
        }
      }
      """

    Scenario: Validate ACL returned for Firm users (ROLE_OFFER_WRITE) can Assign in market place
      Given I am authenticating as "offer.offer@sink.sendgrid.net"
      When I send a GET request to "opportunity/4"
      Then the response code should be 200
      And the response should contain json:
      """
      {
        "acl": {
          "read": true,
          "write": false,
          "delete": false,
          "publish": false,
          "offer": false,
          "inviteCompany": false,
          "canAssign": true,
          "canTransfer": false,
          "withdraw": false
        }
      }
      """

    Scenario: Validate ACL returned Invited Firm users
      Given I am authenticating as "offer.offer@sink.sendgrid.net"
      When I send a GET request to "opportunity/5"
      Then the response code should be 200
      And the response should contain json:
      """
      {
        "acl": {
          "read": true,
          "write": true,
          "delete": false,
          "publish": false,
          "offer": false,
          "inviteCompany": false,
          "canAssign": true,
          "canTransfer": false,
          "withdraw": false
        }
      }
      """

    Scenario: Validate ACL returned Invited Firm users assigned
      Given the following "opportunityAssign" exists
        | opportunity | User |
        | 5           | 20   |
      Given I am authenticating as "offer.offer@sink.sendgrid.net"
      When I send a GET request to "opportunity/5"
      Then the response code should be 200
      And the response should contain json:
      """
      {
        "acl": {
          "read": true,
          "write": true,
          "delete": false,
          "publish": false,
          "offer": true,
          "inviteCompany": false,
          "canAssign": false,
          "canTransfer": true,
          "withdraw": false
        }
      }
      """

    Scenario: Validate ACL returned Invited Firm users assigned cannot transfer because there is offer
      Given the following "opportunityAssign" exists
        | opportunity | User |
        | 5           | 20   |

      Given the following "OfferClientSecondment" exist
        | status    | opportunity | type             | company | createdBy | total |
        | published | 5           | clientSecondment | 3       | 20        | 1000  |

      And I am authenticating as "offer.offer@sink.sendgrid.net"
      When I send a GET request to "opportunity/5"
      Then the response code should be 200
      And the response should contain json:
      """
      {
        "acl": {
          "read": true,
          "write": false,
          "delete": false,
          "publish": false,
          "offer": false,
          "inviteCompany": false,
          "canAssign": false,
          "canTransfer": false,
          "withdraw": false
        }
      }
      """