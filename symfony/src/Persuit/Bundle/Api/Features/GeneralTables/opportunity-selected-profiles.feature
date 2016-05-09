@opportunity @selected-profiles
Feature: Attach profile extensions to opportunity

  Background:
    Given I loadDB

  Scenario: 1 - Add profiles to a group of opportunity type clientSecondment
    Given I am authenticating as "publish.dlapiper@sink.sendgrid.net"
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
                "seniority":{"id":1},
                "selectedProfiles":[
                   {
                       "profileExtension":{"id": 1},
                       "hours": 100
                   }
               ]
            }
        ]
    }
    """
    Then the response code should be 201
    Then json result contains 1level nested "groups" "0" "seniority" "id" "1"
    Then json result "groups" "0" contains 2level nested "selectedProfiles" "0" "profileExtension" "null" "id" "1"

  Scenario: 2 - Update profiles to a group of opportunity type clientSecondment
    Given the following "opportunity" exists
      | id | type             | status | owningCompany | profession | owningUser |
      | 1  | clientSecondment | draft  | 1             | 1          | 4          |

    And the following "opportunityGroup" exists
      | opportunity | seniority |
      | 1           | 1         |

    And the following "opportunitySelectedProfile" exists
      | opportunityGroup | profileExtension | hours |
      | 1                | 1                | 200   |

    Given I am authenticating as "publish.dlapiper@sink.sendgrid.net"
    When I send a PUT request to "opportunity/1" with body:
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
                "seniority":{"id":1},
                "selectedProfiles":[
                   {
                       "profileExtension":{"id": 2},
                       "hours": 100
                   }
               ]
            }
        ]
    }
    """
    Then the response code should be 200
    Then json result "groups" "0" contains 2level nested "selectedProfiles" "0" "profileExtension" "null" "id" "2"
    Then json result "groups" "0" contains 2level nested "selectedProfiles" "0" "null" "null" "hours" "100"

  Scenario: 3 - Remove profiles attached to a group of opportunity type clientSecondment
    Given the following "opportunity" exists
      | id | type             | status | owningCompany | profession | owningUser |
      | 1  | clientSecondment | draft  | 1             | 1          | 4          |

    And the following "opportunityGroup" exists
      | opportunity | seniority |
      | 1           | 1         |

    And the following "opportunitySelectedProfile" exists
      | opportunityGroup | profileExtension | hours |
      | 1                | 1                | 100   |
      | 1                | 2                | 200   |

    Given I am authenticating as "publish.dlapiper@sink.sendgrid.net"
    When I send a PUT request to "opportunity/1" with body:
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
                "seniority":{"id":1},
                "selectedProfiles":[
                   {
                       "profileExtension":{"id": 2},
                       "hours": 100
                   }
               ]
            }
        ]
    }
    """
    Then the response code should be 200
    Then json result "groups" "0" contains 2level nested "selectedProfiles" "0" "profileExtension" "null" "id" "2"
    Then json result "groups" "0" contains 2level nested "selectedProfiles" "0" "null" "null" "hours" "100"

