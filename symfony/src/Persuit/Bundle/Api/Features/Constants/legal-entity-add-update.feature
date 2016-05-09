@legal_entity
Feature: Add a new LegalEntity or update an existing LegalEntity
  Background:
    Given I loadConstants

    And the following "companies" exist
      | name                    | profession  | description      | service  | registered |
      | DLA Piper               | 1           | test description | 1        | 1          |
      | K\&L Gates              | 1           | test description | 1        |            |

    And the following "legalEntities" exist
      | company     | name                  | tax | billingStreet1  | billingCity | billingZip | billingCountry  | billingEmail  | billingPhone |
      | 1           | DLA PTY               | 0.1 | 10 Smith St     | Melbourne   | 3000       | Australia       | test@test.com | 092834239824 |

    And the following "users" exist
      | email                                 | roles                            | company | profession | password | activity | offices |
      | admin.persuit@sink.sendgrid.net       | ROLE_ADMIN                       |         | 1,2        | 123      | 1        |         |
      | userwriter.dlapiper@sink.sendgrid.net | ROLE_USER_WRITE,ROLE_OFFER_WRITE | 1       | 1          | 123      | 1        | 1       |

  Scenario: Save a LegalEntity
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "admin.persuit@sink.sendgrid.net"
    When I send a POST request to "legal_entity" with body:
     """
      {
        "name":"test",
        "tax":"0.1",
        "billingStreet1":"s1",
        "billingStreet2":"s2",
        "billingCity":"s1",
        "billingZip":"2000",
        "billingCountry":"Aust",
        "billingFirstName":"Test",
        "billingLastName":"Test",
        "mailingStreet1":"",
        "mailingStreet2":"",
        "mailingCity":"",
        "mailingZip":"",
        "mailingCountry":"",
        "company": {
            "id":1,
            "name":"Test Company",
            "description":"testing testing",
            "registered":true
        }
    }
    """

    Then the response code should be 201

    Then the response should contain json:
    """
      {
        "id": 2,
        "name": "test",
        "tax": "0.1",
        "billingStreet1": "s1",
        "billingStreet2": "s2",
        "billingCity": "s1",
        "billingZip": "2000",
        "billingCountry": "Aust",
        "billingFirstName":"Test",
        "billingLastName":"Test"
      }
    """
    And json result contains "company" "id" "1"

  Scenario: Update an existing LegalEntity
    And I set header "content-type" with value "application/json"
    And I am authenticating as "admin.persuit@sink.sendgrid.net"
    When I send a PUT request to "legal_entity/1" with body:
    """
      {
        "name":"test",
        "tax":"0.1",
        "billingStreet1":"s1",
        "billingStreet2":"s2",
        "billingCity":"s1",
        "billingZip":"2000",
        "billingCountry":"Aust",
        "billingFirstName":"Test",
        "billingLastName":"Test",
        "mailingStreet1":"",
        "mailingStreet2":"",
        "mailingCity":"",
        "mailingZip":"",
        "mailingCountry":"",
        "company": {
            "id":2,
            "name":"Test Company",
            "description":"testing testing",
            "registered":true
        }
      }
    """
    Then the response code should be 200
    And the response should contain json:
    """
      {
        "id": 1,
        "name": "test",
        "tax": "0.1",
        "billingStreet1": "s1",
        "billingStreet2": "s2",
        "billingCity": "s1",
        "billingZip": "2000",
        "billingCountry": "Aust",
        "billingFirstName":"Test",
        "billingLastName":"Test"
      }
    """
    And json result contains "company" "id" "2"
