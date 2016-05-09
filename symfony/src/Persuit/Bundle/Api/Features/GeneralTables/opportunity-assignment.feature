@opportunity @assignment
Feature: Opportunity Assignment

  Background:
    Given I loadDB

    And the following "opportunity" exists
      | id | type             | status    | headline | owningCompany | profession | owningUser | approver | inviteOnly | invitedCompanies | invitedOffices |
      | 1  | clientSecondment | published | sec.opp1 | 1             | 1          | 2          | 4        | 1          | 3,6              | 3              |
      | 2  | clientSecondment | published | sec.opp2 | 1             | 1          | 2          | 4        | 1          | 6                |                |
      | 3  | clientSecondment | published | sec.opp3 | 1             | 1          | 2          | 4        | 0          |                  |                |
      | 4  | clientSecondment | published | sec.opp4 | 1             | 1          | 3          | 4        | 0          |                  |                |

    And the following "opportunityGroup" exists
      | opportunity | seniority |
      | 1           | 1         |
      | 2           | 1         |
      | 3           | 1         |
      | 4           | 1         |

  Scenario: 1 - Assign to me when opportunity in marketplace
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "opportunity/assign" with body:
      """
      {
          "opportunity":{"id":3},
          "user": {"id":20}
      }
      """
    Then the response code should be 204

  Scenario: 2 - Only one user per company can assign each opportunity in marketplace
    Given the following "opportunityAssign" exists
      | opportunity | User |
      | 3           | 19   |
      | 3           | 20   |

    And I am authenticating as "offer1.offer@sink.sendgrid.net"
    When I send a POST request to "opportunity/assign" with body:
      """
      {
          "opportunity":{"id":3},
          "user": {"id":20}
      }
      """
    Then the response code should be 400
    Then the response should contain "Assignments only allows one user per company"

  Scenario Outline: 3 - Only users with write Offer role can assign opportunity in marketplace
    Given I am authenticating as "<user>" with "<pass>" password
    When I send a POST request to "opportunity/assign" with body:
      """
      {
          "opportunity":{"id":3},
          "user": {"id":<userId>}
      }
      """
    Then the response code should be <code>
    Then the response should contain "<response>"

    Examples:
      | user                          | pass | userId | code | response                               |
      | offer.offer@sink.sendgrid.net | 123  | 20     | 204  |                                        |
      | read.pwc@sink.sendgrid.net    | 123  | 10     | 400  | User without privileges to be assigned |

  Scenario Outline: 4 - When opportunity NOT in marketplace only user from invited company can assign
    Given I am authenticating as "<user>"
    When I send a POST request to "opportunity/assign" with body:
      """
      {
          "opportunity":{"id":<secOpp>},
          "user": {"id":<userId>}
      }
      """
    Then the response code should be <code>
    Then the response should contain "<response>"

    Examples:
      | user                          | secOpp | userId | code | response                                                                 |
      | offer.offer@sink.sendgrid.net | 1      | 20     | 204  |                                                                          |
      | offer.offer@sink.sendgrid.net | 2      | 20     | 400  | Only users from invited companies are allowed to assign this opportunity |
      | offer.pwc@sink.sendgrid.net   | 3      | 24     | 204  |                                                                          |

  Scenario Outline: 5 - Only the assigned user can transfer (assign to another user)
    Given the following "opportunityAssign" exists
      | opportunity | User |
      | 3           | 19   |
      | 3           | 20   |

    And I am authenticating as "<user>"
    When I send a POST request to "opportunity/assign" with body:
      """
      {
          "opportunity":{"id":3},
          "user": {"id":<userId>}
      }
      """
    Then the response code should be <code>
    Then the response should contain "<response>"

    Examples:
      | user                          | userId | code | response                               |
      | offer.offer@sink.sendgrid.net | 21     | 204  |                                        |
      | read.pwc@sink.sendgrid.net    | 10     | 400  | User without privileges to be assigned |

  Scenario: 6 - Only suppliers can assign to an opportunity
    Given I am authenticating as "write.dlapiper@sink.sendgrid.net"
    When I send a POST request to "opportunity/assign" with body:
      """
      {
          "opportunity":{"id":3},
          "user": {"id":20}
      }
      """
    Then the response code should be 400
    Then the response should contain "Only Suppliers are able to assign to Opportunity"

  Scenario: 7 - User professions must match opportunity
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "opportunity/assign" with body:
    """
    {
        "opportunity":{"id":3},
        "user": {"id":25}
    }
    """
    Then the response code should be 400
    Then the response should contain "User must need to be on the same profession as the Opportunity"

  Scenario Outline: 8 - Auto assign when publish the Opportunity based in offices invited
  Rules:
  1 - waiting to be published(approved), not in market place, with companies and offices invited then invite
  one more company and office when publishing.
  2 - waiting to be published(approved), not in market place, with NO companies and offices invited then invite
  one company with one office when publishing.

    Given the following "opportunity" exists
      | id | type             | status   | headline      | owningCompany | profession | owningUser | approver | inviteOnly   | invitedCompanies   | invitedOffices   |
      | 5  | clientSecondment | <status> | opportunity 5 | 1             | 1          | 3          | 4        | <inviteOnly> | <invitedCompanies> | <invitedOffices> |

    And I am authenticating as "publish.dlapiper@sink.sendgrid.net"
    When I send a PUT request to "opportunity/5" with body:
    """
    {
        "type":"clientSecondment",
        "status": "published",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "bla",
        "description": "bla",
        "requesterName": "Foo",
        "requesterTitle" : "Mr.",
        "industrySectors": [{"id": 1},{"id": 3}],
        "industrySubSectors": [{"id": 1}],
        "practiceAreas": [{"id": 4}],
        "practiceSubAreas": [{"id": 4}],
        "locations": [
           {
               "googleId": "b449cd4d6e7b95f0334503027ea90867a79929ab",
               "placeId": "ChIJgf0RD69C1moR4OeMIXVWBAU",
               "latitude": -37.8142155,
               "longitude": 144.96323069999994,
               "formattedAddress": "Melbourne VIC, Australia",
               "city": "Melbourne",
               "state": "Victoria",
               "country": "Australia"
           }
        ],
        "inviteOnly": true,
        "seeInvitedFirms": false,
        "invitedCompanies":[<jsonCompanies>],
        "invitedOffices":[<jsonOffices>],
        "unlistedCompanies": [
            {
              "name": "Aaaa",
              "description": "...."
            }
        ],
        "conflictCheck": "baaaar",
        "startDate": "2016-07-20",
        "endDate": "2016-12-20",
        "currency":{"id": 1},
        "budgetRangeStart": 200,
        "budgetRangeEnd": 1500,
        "tcFile":{
          "id": 45,
          "url": "//api.oki.local/persuit-file-upload/fa6d2d864ea084227b09cd16e40a3dce9f5561ba.pdf",
          "name": "Persuit.pdf"
        },
        "publishDuration":"2017-01-01 17:00:00",
        "groups": [
            {
               "seniority": {"id": 1},
               "yearsSeniority": 10,
               "yearsPqe": 10,
               "quantity":5,
               "practiceLocations":[
                   {
                       "googleId": "b449cd4d6e7b95f0334503027ea90867a79929ab",
                       "placeId": "ChIJgf0RD69C1moR4OeMIXVWBAU",
                       "latitude": -37.8142155,
                       "longitude": 144.96323069999994,
                       "formattedAddress": "Melbourne VIC, Australia",
                       "city": "Melbourne",
                       "state": "Victoria",
                       "country": "Australia"
                   }
               ],
               "admittedPracticeCourt": "High Court of Australia",
               "languages":[{"id":1},{"id":2}],
               "daysPerWeek":5
            }
        ]
    }
    """
    Then the response code should be 200
    And user from office should be assigned to opportunity "5"

    Examples:
      | status     | inviteOnly | invitedCompanies | invitedOffices | jsonCompanies      | jsonOffices       |
      | unapproved | 1          | 3                | 3              | {"id":3},{"id":26} | {"id":3},{"id":5} |
      | unapproved | 1          |                  |                | {"id":3}           | {"id":3}          |

  Scenario Outline: 9 - Auto assign based in offices invited when Opportunity is published
  Rules:
  1 - Sec.Opp PUBLISHED, not in marketplace, with companies and offices invited, and assigned for a supplier user. Then invite
  one more company and office.
  2 - Sec.Opp PUBLISHED, IN marketplace, with NO company and office invited and one supplier user had assigned this sec.opp to him. Then
  the Requester invite the company that have assigned already. (Result nothing happens).
  3 - Sec.Opp PUBLISHED, IN marketplace, with NO company and office invited and one supplier user had assigned this sec.opp to him. Then
  the Requester invite other company and office.
  4 - idem 3.

    Given the following "opportunity" exists
      | id | type       | status    | headline | owningCompany  | profession | owningUser  | approver | inviteOnly   | invitedCompanies   | invitedOffices   |
      | 5  | clientSecondment | published | sec.opp5 | 1              | 2          | 3           | 4        | <inviteOnly> | <invitedCompanies> | <invitedOffices> |

    And the following "opportunityGroup" exists
      | opportunity | seniority |
      | 5           | 1         |

    And the following "opportunityAssign" exists
      | opportunity | User           |
      | 5           | <assignedUser> |

    And I am authenticating as "publish.dlapiper@sink.sendgrid.net"
    When I send a PATCH request to "opportunity/5" with body:
    """
        {
            "invitedCompanies":[<jsonCompanies>],
            "invitedOffices": [<jsonOffices>]
        }
    """
    Then the response code should be 200
    And user from office should be assigned to opportunity "5"

    Examples:
      | inviteOnly | invitedCompanies | invitedOffices | assignedUser | jsonCompanies      | jsonOffices       |
      | 0          |                  |                | 20           | {"id":3 }          | {"id":3}          |
      | 0          |                  |                | 20           | {"id":26}          | {"id":5}          |
      | 0          |                  |                | 24           | {"id":3},{"id":26} | {"id":3},{"id":5} |
