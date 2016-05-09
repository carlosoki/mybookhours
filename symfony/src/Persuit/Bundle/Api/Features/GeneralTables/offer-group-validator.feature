@offer @secondment @validate
Feature: Add a new Offer to a Opportunity
  Background:
    Given I loadDB

    And the following "Opportunity" exist
      | type              | status     |profession | headline                                       | description                             | inviteOnly  | seeInvitedFirms  | owningCompany  | owningUser | invitedOffices  |
      | clientSecondment  | published  | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 0           | 0                 | 1             | 2          | 1               |
      | clientSecondment  | dealtime   | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 0           | 0                 | 1             | 2          | 1               |

    And the following "OpportunityGroup" exists
      | opportunity | quantity |
      | 1           | 2        |
      | 2           | 2        |

    And the following "ProfileExtension" exist
      | id  | versionName         | professionalHeadline | professionalDetails           | default |
      | 1   | Tax Law             | Senior Lawyer        | 8 years experience with taxes | 1       |
      | 2   | Corporate Law       | Partner              | 25 years experience           | 0       |

    And the following "OpportunityAssign" exist
      | opportunity | user |
      | 1           | 20   |

  Scenario: Validation fails due to not having a matching group on the offer
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "offer" with body:
    """
    {
      "type": "clientSecondment",
      "comments": "test comment",
      "status": "draft",
      "total": "400000",
      "offerClientSecondmentGroup": [
      ],
      "opportunity": {
        "id":1
      }
    }
    """
    Then the response code should be 400

  Scenario: Validation fails due to not having a matching group on the offer
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "offer" with body:
    """
    {
      "type": "clientSecondment",
      "comments": "test comment",
      "status": "draft",
      "total": "400000",
      "offerClientSecondmentGroup": [
        {
          "opportunityGroup": {
            "id": 2
          },
          "resources": [
            {
              "amount":200000,
              "profileExtension": {
                "id": 1
              }
            }
          ]
        }
      ],
      "opportunity": {
        "id":1
      }
    }
    """
    Then the response code should be 400
