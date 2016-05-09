@offer @hours @add
Feature: Add a new Offer to a Opportunity
  Background:
    Given I loadDB

    And the following "Opportunity" exist
      | type        | status     |profession | headline                                       | description                             | inviteOnly  | seeInvitedFirms  | owningCompany  | owningUser | invitedOffices  |
      | clientHours  | published  | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 0           | 0                 | 1             | 2          | 1               |
      | clientHours  | dealtime   | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 0           | 0                 | 1             | 2          | 1               |

    And the following "opportunityGroup" exists
      | opportunity | quantity |
      | 1           | 2        |

    And the following "ProfileExtension" exist
      | id  | versionName         | professionalHeadline | professionalDetails           | default |
      | 1   | Tax Law             | Senior Lawyer        | 8 years experience with taxes | 1       |
      | 2   | Corporate Law       | Partner              | 25 years experience           | 0       |

    And the following "OpportunityAssign" exist
      | opportunity | user |
      | 1           | 20   |

    And the following "OfferClientHour" exist
      | status         | opportunity | type        | company | createdBy  | total |
      | published      | 2           | clientHours | 6       | 23         | 1000  |

  Scenario: Save a Offer with to Secondment
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "offer" with body:
    """
    {
      "type": "clientHours",
      "comments": "test comment",
      "amendments": "test",
      "status": "draft",
      "total": 400000,
      "offerClientHoursGroup": [
        {
          "rate": 123,
          "hours": 1120,
          "opportunityGroup": {
            "id": 1
          },
          "resources": [
            {
              "hours": 200000,
              "profileExtension": {
                "id": 1
              }
            }
          ]
        }
      ],
      "opportunity": {
        "id": 1
      }
    }
    """
    Then the response code should be 201

    Then the response should contain json:
    """
    {
      "id": 2,
      "type": "clientHours",
      "comments": "test comment",
      "status": "draft",
      "total":400000,
      "company": {
        "id": 3,
        "name": "Ashursts"
      },
      "offerClientHoursGroup": [
        {
          "id":1,
          "rate": 123,
          "hours": 1120,
          "opportunityGroup": {
              "id": 1,
              "quantity": 2,
              "daysPerWeek": 5
          },
          "resources": [
            {
              "profileExtension": {
                "id": 1,
                "versionName": "Tax Law",
                "professionalHeadline": "Senior Lawyer",
                "profile":{"id":1,"firstName":"Benjamin","lastName":"Mooney","seniority": {"name":"Partner"}}
              },
              "hours": 200000,
              "id":1
            }
          ]
        }
      ]
    }
    """

    When I send a PUT request to "offer/2" with body:
    """
    {
      "type": "clientHours",
      "comments": "change comment",
      "amendments": "test",
      "status": "draft",
      "total": 300000,
      "offerClientHoursGroup": [
        {
          "rate": 123,
          "hours": 1120,
          "opportunityGroup": {
            "id": 1
          },
          "resources": [
            {
              "hours": 200000,
              "profileExtension": {
                "id": 1
              }
            }
          ]
        }
      ],
      "opportunity": {
        "id": 1
      }
    }
    """

    Then the response code should be 200
    Then the response should contain json:
    """
      {
        "id": 2,
        "comments": "change comment",
        "status": "draft",
        "total":300000
      }
    """
