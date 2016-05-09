@offer @secondment @accept
Feature: Add a new Offer to a Opportunity
  Background:
    Given I loadDB

    And the following "Opportunity" exist
      | type              | status     |profession | headline                                       | description                             | inviteOnly  | seeInvitedFirms   | owningCompany | owningUser | invitedOffices  |
      | clientSecondment  | published  | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 0           | 0                 | 1             | 2          | 1               |
      | clientSecondment  | dealtime   | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 0           | 0                 | 1             | 2          | 1               |

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

    And the following "OfferClientSecondment" exist
      | status         | opportunity | type             | company | createdBy  | total |
      | published      | 2           | clientSecondment | 6       | 23         | 1000  |

  Scenario: Accept an offer with PATCH
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "write.dlapiper@sink.sendgrid.net"
    When I send a PATCH request to "offer/1" with body:
    """
    {
      "status":"accepted"
    }
    """
    Then the response code should be 200
    Then the response should contain json:
    """
    {
       "id":1,
       "comments":"Test Offer Comments",
       "status":"accepted",
       "type":"clientSecondment"
    }
    """
