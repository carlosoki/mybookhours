@offer @secondment @add
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

    And the following "ProfileExtension" exist
      | id  | versionName         | professionalHeadline | professionalDetails           | default |
      | 1   | Tax Law             | Senior Lawyer        | 8 years experience with taxes | 1       |
      | 2   | Corporate Law       | Partner              | 25 years experience           | 0       |

    And the following "OpportunityAssign" exist
      | opportunity | user |
      | 1           | 20   |

    And the following "OfferClientSecondment" exist
      | status         | opportunity | type             | company | createdBy  | total |
      | published      | 2           | clientSecondment | 6       | 23         | 1000  |

  Scenario: Save a Offer to Secondment
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
            "id": 1
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
    Then the response code should be 201

    Then the response should contain json:
    """
    {
      "id": 2,
      "comments": "test comment",
      "status": "draft",
      "total":400000,
      "company": {
        "id": 3,
        "name": "Ashursts"
      },
      "offerClientSecondmentGroup": [
        {
          "id":1,
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
              "amount": 200000,
              "id":1
            }
          ]
        }
      ]
    }
    """
    # Then json result "offer_secondment_group" contains 1level nested "resources" "0" "profile_extension" "null" "id" "1"

    When I send a PUT request to "offer/2" with body:
    """
    {
      "type": "clientSecondment",
      "comments": "change comment",
      "status": "draft",
      "total": "300000",
      "offerClientSecondmentGroup": [
        {
          "opportunityGroup": {
            "id": 1
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

 Scenario: Save a Counteroffer on Offer
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "write.dlapiper@sink.sendgrid.net"
    When I send a POST request to "offer" with body:
    """
    {
      "comments": "test counter offer comment",
      "status": "published",
      "total": "200000",
      "offerClientSecondmentGroup": [
        {
          "opportunityGroup": {
            "id": 1
          },
          "resources": [
            {
              "amount":100000,
              "profileExtension": {
                "id": 2
              }
            }
          ]
        }
      ],
      "offer": {
        "id":1
      }
    }
    """
    Then the response code should be 201
    Then the response should contain json:
    """
      {
        "id": 2,
        "comments": "test counter offer comment",
        "status": "published",
        "total": "200000",
        "isCounter":true,
        "type": "clientSecondment"
      }
    """