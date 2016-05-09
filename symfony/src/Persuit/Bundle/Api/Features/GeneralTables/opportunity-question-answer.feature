@opportunity @question-answer
Feature: Add/Edit/Delete question and/or answer

  Background:
    Given I loadDB
    And the following "Opportunity" exist
      | id | type             | status    | owningCompany | profession | owningUser | approver | inviteOnly | invitedCompanies |
      | 1  | ClientSecondment | draft     | 1             | 2          | 2          | 4        |            |                  |
      | 2  | ClientSecondment | published | 1             | 2          | 2          | 4        |            |                  |
      | 3  | ClientSecondment | published | 1             | 2          | 2          | 4        | 1          | 3                |

  Scenario: Any Supplier can send a question for a SecOpp in marketplace
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "question_answer" with body:
    """
      {
        "opportunity": {"id":2},
        "question": "Foo bar?"
      }
    """
    Then the response code should be 201
    Then the response should contain json:
    """
      {
        "id": 1
      }
    """
    And json result contains "questionOwner" "id" 20
    And the response should contain "Foo bar?"

  Scenario: Any Requester type users that can view the opportunity can answer a question
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "question_answer" with body:
    """
      {
        "opportunity": {"id":2},
        "question": "Foo bar?"
      }
    """
    Then the response code should be 201
    Then I am authenticating as "read.dlapiper@sink.sendgrid.net"
    When I send a PATCH request to "question_answer/1" with body:
    """
      {
        "answer": "This is your answer."
      }
    """
    Then the response code should be 200
    And json result contains "questionOwner" "id" 20
    And json result contains "answerOwner" "id" 1
    And the response should contain "Foo bar?"
    And the response should contain "This is your answer."

  Scenario: Suppliers can only send/edit question
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "question_answer" with body:
    """
      {
        "opportunity": {"id":2},
        "answer": "This answer cannot be saved."
      }
    """
    Then the response code should be 400
    And the response should contain "Suppliers cannot write answers"

  Scenario: Requesters can only send/edit answers
    Given I am authenticating as "read.dlapiper@sink.sendgrid.net"
    When I send a POST request to "question_answer" with body:
    """
      {
        "opportunity": {"id":2},
        "question": "Foo bar?"
      }
    """
    Then the response code should be 400
    And the response should contain "Requesters cannot write questions"

  Scenario: Supplies cannot edit answers and Requesters cannot edit question
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "question_answer" with body:
    """
      {
        "opportunity": {"id":2},
        "question": "Foo bar?"
      }
    """
    Then the response code should be 201
    Then I send a PATCH request to "question_answer/1" with body:
    """
      {
        "answer": "This answer cannot be saved."
      }
    """
    Then the response code should be 400
    And the response should contain "Suppliers cannot write answers"
    Given I am authenticating as "read.dlapiper@sink.sendgrid.net"
    When I send a PATCH request to "question_answer/1" with body:
    """
      {
        "answer": "YES, requesters can answer..."
      }
    """
    Then the response code should be 200
    And json result contains "questionOwner" "id" 20
    And json result contains "answerOwner" "id" 1
    And the response should contain "Foo bar?"
    And the response should contain "YES, requesters can answer..."
    Then I send a PATCH request to "question_answer/1" with body:
    """
      {
        "question": "Question from requester user?"
      }
    """
    Then the response code should be 400
    And the response should contain "Requesters cannot write questions"

  Scenario: Only supplier owners can edit their questions
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "question_answer" with body:
    """
      {
        "opportunity": {"id":2},
        "question": "Foo bar?"
      }
    """
    Then the response code should be 201
    Then I am authenticating as "offer1.offer@sink.sendgrid.net"
    Then I send a PATCH request to "question_answer/1" with body:
    """
      {
        "question": "May I edit a question that is not mine?"
      }
    """
    Then the response code should be 400
    And the response should contain "Only the owner can edit the question"

  Scenario: Only Requesters owners can edit their answer
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "question_answer" with body:
    """
      {
        "opportunity": {"id":2},
        "question": "Foo bar?"
      }
    """
    Then the response code should be 201
    Given I am authenticating as "read.dlapiper@sink.sendgrid.net"
    When I send a PATCH request to "question_answer/1" with body:
    """
      {
        "opportunity": {"id":2},
        "answer": "YES, requesters can answer..."
      }
    """
    Then the response code should be 200
    And json result contains "questionOwner" "id" 20
    And json result contains "answerOwner" "id" 1
    And the response should contain "Foo bar?"
    And the response should contain "YES, requesters can answer..."
    Then I am authenticating as "write.dlapiper@sink.sendgrid.net"
    And I send a PATCH request to "question_answer/1" with body:
    """
      {
        "answer": "Editing a answer that is not mine..."
      }
    """
    Then the response code should be 403
#    And the response should contain "Only the owner can edit the answer"

  Scenario: Only invited suppliers are allowed to send a question
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "question_answer" with body:
    """
      {
        "opportunity": {"id":3},
        "question": "Foo bar?"
      }
    """
    Then the response code should be 201
    And json result contains "questionOwner" "id" 20
    And the response should contain "Foo bar?"
    Then I am authenticating as "offer.pwc@sink.sendgrid.net"
    When I send a POST request to "question_answer" with body:
    """
      {
        "opportunity": {"id":3},
        "question": "May I send question when my company was not invited?"
      }
    """
    Then the response code should be 403
    And the response should contain "You do not have the necessary permissions"

#  Scenario: Only one question per company is allowed
#    Given I am authenticating as "offer.offer@sink.sendgrid.net"
#    When I send a POST request to "question_answer" with body:
#    """
#      {
#        "opportunity": {"id":2},
#        "question": "Foo bar?"
#      }
#    """
#    Then the response code should be 201
#    And json result contains "questionOwner" "id" 20
#    And the response should contain "Foo bar?"
#    Then I am authenticating as "offer1.offer@sink.sendgrid.net"
#    When I send a POST request to "question_answer" with body:
#    """
#      {
#        "opportunity": {"id":2},
#        "question": "Another question from the same company?"
#      }
#    """
#    Then the response code should be 400
#    And the response should contain "Only one question per company is allowed"
#    Then I am authenticating as "offer.pwc@sink.sendgrid.net"
#    When I send a POST request to "question_answer" with body:
#    """
#      {
#        "opportunity": {"id":2},
#        "question": "Foo bar 2?"
#      }
#    """
#    Then the response code should be 201
#    And json result contains "questionOwner" "id" 24
#    And the response should contain "Foo bar 2?"

  Scenario: Questions with answers cannot be deleted
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "question_answer" with body:
    """
      {
        "opportunity": {"id":2},
        "question": "Foo bar?"
      }
    """
    Then the response code should be 201
    Then I am authenticating as "read.dlapiper@sink.sendgrid.net"
    When I send a PATCH request to "question_answer/1" with body:
    """
      {
        "answer": "YES, requesters can answer..."
      }
    """
    Then the response code should be 200
    Then I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a DELETE request to "question_answer/1" with body:
    """
    """
    Then the response code should be 400
    And the response should contain "You are not allowed to delete questions answered"

  Scenario: Only question without answer can be deleted
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "question_answer" with body:
    """
      {
        "opportunity": {"id":2},
        "question": "Foo bar?"
      }
    """
    Then the response code should be 201
    Then I send a DELETE request to "question_answer/1" with body:
    """
    """
    And the response code should be 204

  Scenario: Delete answer
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    When I send a POST request to "question_answer" with body:
    """
      {
        "opportunity": {"id":2},
        "question": "Foo bar?"
      }
    """
    Then the response code should be 201
    Given I am authenticating as "read.dlapiper@sink.sendgrid.net"
    When I send a PATCH request to "question_answer/1" with body:
    """
      {
        "answer": "YES, requesters can answer..."
      }
    """
    Then the response code should be 200
    When I send a PATCH request to "question_answer/1" with body:
    """
      {
        "answer": ""
      }
    """
    Then the response code should be 200
