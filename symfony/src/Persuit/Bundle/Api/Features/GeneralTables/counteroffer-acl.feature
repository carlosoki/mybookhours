@counteroffer @acl
Feature: Add a new Counter Offer or update an existing Counter Offer roles test
  Background:
    Given I loadDB

    And the following "fileUpload" exist
      | path                            | fileName | entity                                | entityId | originalFileName | fileExtension |
      | api.persuit.local/opportunity/1 | foo      | Persuit\Bundle\Api\Entity\Opportunity | 3        | foo.pdf          | pdf           |


    And the following "Opportunity" exist
      | id | type             | status    | profession | headline                                       | description                             | inviteOnly | seeInvitedFirms | owningCompany | owningUser | invitedOffices | tcFile |
      | 1  | clientSecondment | published | 1          | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 1          | 0               | 1             | 2          | 3              |        |
      | 2  | clientSecondment | dealtime  | 1          | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 1          | 0               | 1             | 2          | 3              |        |
      | 3  | clientSecondment | dealtime  | 1          | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 0          | 0               | 1             | 2          | 3              | 1      |
      | 4  | clientSecondment | dealtime  | 1          | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 0          | 0               | 1             | 2          | 3              |        |
      | 5  | clientSecondment | dealtime  | 1          | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 1          | 0               | 1             | 2          | 3              |        |


    And the following "OfferClientSecondment" exist
      | id | status     | opportunity | company | createdBy  | type             |
      | 1  | published  | 1           | 3       | 20         | clientSecondment |
      | 2  | published  | 3           | 3       | 20         | clientSecondment |
      | 3  | published  | 4           | 3       | 20         | clientSecondment |
      | 4  | accepted   | 2           | 3       | 20         | clientSecondment |
      | 5  | published  | 4           | 3       | 20         | clientSecondment |

    #Counter Offer
    And the following "CounterOfferSecondment" exist
      | id | status    | opportunity | company | createdBy | offer | type             |
      | 6  | draft     | 3           | 1       | 2         | 2     | clientSecondment |
      | 7  | published | 3           | 1       | 2         | 5     | clientSecondment |


    # Scenario: Successful GET returns response
    Scenario Outline:
      ROLE_OPP_WRITE can view/update/create/delete a counteroffer
      Given I am authenticating as "<user>" with "<password>" password
      When I send a <method> request to "<url>" with body:
      """
        <json>
      """
      Then the response code should be <code>

      Examples:
        | user                              | password | method | url              | json                                | code |
        # Counter Offer already exists on an offer
        | write.dlapiper@sink.sendgrid.net  | 123      | POST   | offer   | {"status":"draft","total":1000, "offer":{"id":2}}     | 403  |
        # Cant put Counter offer on offer youve already accepted (only on published)
        | write.dlapiper@sink.sendgrid.net  | 123      | POST   | offer   | {"status":"draft","total":1000, "offer":{"id":4}}     | 403  |
        # Secondment owner only can make counter offer
        | write1.dlapiper@sink.sendgrid.net | 123      | POST   | offer   | {"status":"draft","total":1000, "offer":{"id":3}}     | 403  |
        # Cant make Counter Offer not in dealtime - fails
        | write.dlapiper@sink.sendgrid.net  | 123      | POST   | offer   | {"status":"draft","total":1000, "offer":{"id":1}}     | 403  |
        # Legit counter offer
        | write.dlapiper@sink.sendgrid.net  | 123      | POST   | offer   | {"type":"clientSecondment","status":"draft","total":1000, "offer":{"id":3}}     | 201  |
        # Delete Counter Offer fail, can only delete draft
        | write.dlapiper@sink.sendgrid.net  | 123      | DELETE | offer/7 | {"status":"draft","total":1000}     | 403  |
        # Update Counter Offer pass (ensure change from draft to published works in SecondmentOfferEditValidator.php)
        | write.dlapiper@sink.sendgrid.net  | 123      | PUT    | offer/6 | {"type":"clientSecondment","status":"published","total":1000} | 200  |
        # Accept Counter Offer in dealtime
        | offer.offer@sink.sendgrid.net     | 123      | PATCH  | offer/7 | {"status":"accepted"}               | 200  |
        # Accept SecondmentOffer can only PATCH "status" if not offer owner
        | write.dlapiper@sink.sendgrid.net  | 123      | PUT    | offer/7 | {"status":"accepted","total":1000}  | 403  |
        # Accept Counter Offer fail, not SecondmentOffer owner
        | write.dlapiper@sink.sendgrid.net  | 123      | PATCH  | offer/7 | {"status":"accepted"}               | 403  |
        # Secondment supplier can GET requestors counter offer
        | offer.offer@sink.sendgrid.net     | 123      | GET    | offer/7 |                                     | 200  |
        # Reject Counter Offer (ensure change from published to rejected works)
        | offer.offer@sink.sendgrid.net     | 123      | PATCH  | offer/7 | {"status":"rejected"}               | 200  |
        # Reject Counter Offer (ensure change from published to rejected on PATCH with more than status field in request - fails)
        | offer.offer@sink.sendgrid.net     | 123      | PATCH  | offer/7 | {"status":"rejected","total":1000}  | 403  |
        # Reject Counter Offer (ensure change from published to rejected on PUT fails)
        | offer.offer@sink.sendgrid.net     | 123      | PUT    | offer/7 | {"status":"rejected","total":1000}  | 403  |
        # Withdraw Counter Offer (ensure change from published to withdraw on PUT)
        | write.dlapiper@sink.sendgrid.net  | 123      | PATCH  | offer/7 | {"status":"withdrawn"}              | 200  |
