@offer @acl
Feature: Add a new Offer or update an existing Offer roles test
  Background:
    Given I loadDB

    And the following "fileUpload" exist
      | path                            | fileName  | entity                                          | entityId  | originalFileName   | fileExtension |
      | api.persuit.local/secondment/1/ | foo       | Persuit\Bundle\Api\Entity\SecondmentOpportunity | 1         | foo.pdf            | pdf            |

    And the following "Opportunity" exist
      | type             | status     |profession | headline                                       | description                             | inviteOnly | seeInvitedFirms | owningCompany | owningUser | invitedOffices | tcFile |
      | clientSecondment | published  | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 1           | 0                 | 1             | 2          | 3               | 1       |
      | clientSecondment | published  | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 1           | 0                 | 1             | 2          | 3               |         |
      | clientSecondment | published  | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 1           | 0                 | 1             | 2          | 3,1             |         |
      | clientSecondment | dealtime   | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 0           | 0                 | 1             | 2          | 3               |         |
      | clientSecondment | published  | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 1           | 0                 | 1             | 2          | 3               |         |

    And the following "OpportunityAssign" exist
      | Opportunity | user |
      | 1           | 20   |
      | 2           | 20   |
      | 3           | 20   |
      | 3           | 9    |
      | 4           | 20   |
      | 5           | 20   |

    And the following "OfferClientSecondment" exist
    | status     | type             | opportunity | company | createdBy  | total |
    | draft      | clientSecondment | 1           | 3       | 20         | 1000  |
    | accepted   | clientSecondment | 3           | 3       | 20         | 1000  |
    | published  | clientSecondment | 4           | 3       | 20         | 1111  |
    | published  | clientSecondment | 2           | 3       | 20         | 1000  |

  # Scenario: Successful GET returns response
    Scenario Outline:
      ROLE_OFFER_WRITE can view/update/create/delete a secondment in draft
      Given I am authenticating as "<user>" with "<password>" password
      When I send a <method> request to "<url>" with body:
      """
        <json>
      """
      Then the response code should be <code>

      Examples:
        | user                                  | password | method | url      | json                                                                                           | code |
        # user not of invited office:
        | offer.pwc@sink.sendgrid.net           | 123      | POST   | offer    | {"opportunity": {"id":2}, "type":"clientSecondment", "status":"draft","total":1000}                  | 403  |
        #legit invited user, no existing offers on secopp:
        | offer.offer@sink.sendgrid.net         | 123      | POST   | offer    | {"opportunity": {"id":5}, "type":"clientSecondment", "status":"draft", "total":1000}                 | 201  |
        #Create SecondmentOffer not in published state - fails
        | offer.offer@sink.sendgrid.net         | 123      | POST   | offer    | {"opportunity": {"id":4}, "type":"clientSecondment","status":"draft", "total":1000}                  | 403  |
        #Company already has an active offer on this secondment
        | offer.offer@sink.sendgrid.net         | 123      | POST   | offer    | {"opportunity": {"id":1}, "type":"clientSecondment","status":"draft","total":1000}                   | 400  |
        #Update offer validate fail, offer not originally created by this user
        | offer1.offer@sink.sendgrid.net        | 123      | PUT    | offer/1  | {"type":"clientSecondment","status":"draft", "comments":"testing","total":1000}                      | 403  |
        #Update offer pass (ensure change from draft to published works in SecondmentOfferEditValidator.php)
        | offer.offer@sink.sendgrid.net         | 123      | PUT    | offer/1  | {"type":"clientSecondment","status":"published","comments":"testing","total":1000}                   | 200  |
        #cant edit offer thats accepted
        | offer.offer@sink.sendgrid.net         | 123      | PUT    | offer/2  | {"type":"clientSecondment","status":"published","comments":"testing","total":8000}                   | 403  |
        #New SecondmentOffer from different invited user
        | userwriter.dlapiper@sink.sendgrid.net | 123      | POST   | offer    | {"opportunity": {"id":3},"type":"clientSecondment","status":"draft","comments":"test","total":1000}  | 201  |
        #Accept SecondmentOffer in dealtime
        | write.dlapiper@sink.sendgrid.net      | 123      | PATCH  | offer/3  | {"status":"accepted"}                                                                          | 200  |
        #Accept SecondmentOffer can only PATCH "status" if not offer owner
        | write.dlapiper@sink.sendgrid.net      | 123      | PUT    | offer/3  | {"status":"accepted"}                                                                          | 403  |
        #Accept SecondmentOffer can only PATCH "status" if not offer owner
        | write.dlapiper@sink.sendgrid.net      | 123      | PATCH  | offer/3  | {"status":"accepted","total":1000}                                                             | 403  |
        #Accept SecondmentOffer not in dealtime - fails
        | write.dlapiper@sink.sendgrid.net      | 123      | PATCH  | offer/4  | {"status":"accepted"}                                                                          | 403  |
        #Accept SecondmentOffer fail, not Secondment owner
        | offer.offer@sink.sendgrid.net         | 123      | PATCH  | offer/3  | {"status":"accepted"}                                                                          | 403  |
        # Delete SecondmentOffer fail, can only delete draft
        | offer.offer@sink.sendgrid.net         | 123      | DELETE | offer/3  |                                                                                                | 403  |
        # GET SecondmentOffer fail, not Secondment owner
        | offer1.pwc@sink.sendgrid.net          | 123      | GET    | offer/3  |                                                                                                | 403  |
        #Withdraw offer (ensure change from published to withdraw works)
        | offer.offer@sink.sendgrid.net         | 123      | PUT    | offer/3  | {"type":"clientSecondment","status":"withdrawn","total":1000}                                        | 200  |