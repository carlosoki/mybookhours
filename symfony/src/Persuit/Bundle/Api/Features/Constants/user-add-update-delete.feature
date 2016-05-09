@user
Feature: Add a new User or update an existing User
  Background:
    Given I loadConstants

    And the following "companies" exist
      | name                    | profession| description      | service  | registered |
      | DLA Piper               | 1         | test description | 1        | 1          |

    And the following "users" exist
      | email                                 | roles                            | company | profession | password | activity | offices |
      | read.dlapiper@sink.sendgrid.net       |                                  | 1       | 1,2        | 123      | 1        |         |
      | userwriter.dlapiper@sink.sendgrid.net | ROLE_USER_WRITE,ROLE_OFFER_WRITE | 1       | 1          | 123      | 1        | 1       |
      | admin.persuit@sink.sendgrid.net       | ROLE_ADMIN                       |         | 1,2        | 123      | 1        |         |

  Scenario: Save a User with Persuit ROLE_ADMIN
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "admin.persuit@sink.sendgrid.net"
    When I send a POST request to "user" with body:
     """
        {
            "firstName":"John",
            "middleName":"Paul",
            "lastName":"Jones",
            "phone":"04509909887",
            "company":{"id":1},
            "email":"test@test.com",
            "professions":[
              {
                "id": 1,
                "name": "Legal"
              }
            ],
            "activity":{
              "id": 1,
              "name": "Requester"
            },
            "roles":[
                "ROLE_USER_WRITE",
                "ROLE_USER"
            ]
        }
    """

    Then the response code should be 201
    Then the response should contain json:
    """
      {
      "id": 4,
      "firstName": "John",
      "middleName": "Paul",
      "lastName": "Jones",
      "phone": "04509909887",
      "professions": [
        {
          "id": 1,
          "name": "Legal"
        }
      ],
      "activity": {
        "id": 1,
        "name": "Requester"
      },
      "offices": [],
      "roles": [
        "ROLE_USER_WRITE",
        "ROLE_USER"
      ]
    }
    """
    And json result contains "company" "id" "1"

  Scenario: Update a User with persuit ROLE_ADMIN
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "admin.persuit@sink.sendgrid.net"
    When I send a PUT request to "user/1" with body:
     """
        {
            "firstName":"John",
            "middleName":"Jimmy",
            "lastName":"Jones",
            "phone":"04509909887",
            "company":{"id":1},
            "email":"read.dlapiper@sink.sendgrid.net",
            "professions":[{"id":1}],
            "activity":{"id":1},
            "roles":[
                "ROLE_USER_WRITE"
            ]
        }
    """
    Then the response code should be 200

    Then the response should contain json:
    """
      {
        "id": 1,
         "email": "read.dlapiper@sink.sendgrid.net",
        "firstName": "John",
        "middleName": "Jimmy",
        "lastName": "Jones",
        "phone": "04509909887",
        "professions": [
          {
            "id": 1,
            "name": "Legal"
          }
        ],
        "activity": {
          "id": 1,
          "name": "Requester"
        },
        "roles": [
          "ROLE_USER_WRITE",
          "ROLE_USER"
        ],
        "offices":[]
      }
    """

Scenario: Save a User with ROLE_USER_WRITE
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "userwriter.dlapiper@sink.sendgrid.net"
    When I send a POST request to "user" with body:
     """
        {
            "firstName":"John",
            "middleName":"Paul",
            "lastName":"Jones",
            "phone":"04509909887",
            "email":"test@test.com",
            "professions":[{"id":1}],
            "company":{"id":1},
            "activity":{"id":1},
            "roles":[
                "ROLE_USER_WRITE"
            ]
        }
    """

    Then the response code should be 201

    Then the response should contain json:
    """
      {
        "id": 4,
        "email": "test@test.com",
        "firstName": "John",
        "middleName": "Paul",
        "lastName": "Jones",
        "phone": "04509909887",
        "professions": [
          {
            "id": 1,
            "name": "Legal"
          }
        ],
        "activity": {
          "id": 1,
          "name": "Requester"
        },
        "roles": [
          "ROLE_USER_WRITE",
          "ROLE_USER"
        ]
      }
    """
    And json result contains "company" "id" "1"

Scenario: Update a User with ROLE_USER_WRITE
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "userwriter.dlapiper@sink.sendgrid.net"
    When I send a PUT request to "user/1" with body:
     """
        {
            "firstName":"John",
            "middleName":"Jimmy",
            "lastName":"Jones",
            "phone":"04509909887",
            "company":{"id":1},
            "email":"read.dlapiper@sink.sendgrid.net",
            "professions":[{"id":1}],
            "activity":{"id":1},
            "roles":[
                "ROLE_USER_WRITE"
            ]
        }
    """
    Then the response code should be 200

    Then the response should contain json:
    """
      {
        "id": 1,
       "email": "read.dlapiper@sink.sendgrid.net",
        "firstName": "John",
        "middleName": "Jimmy",
        "lastName": "Jones",
        "phone": "04509909887",
        "professions": [
          {
            "id": 1,
            "name": "Legal"
          }
        ],
        "activity": {
          "id": 1,
          "name": "Requester"
        },
        "roles": [
          "ROLE_USER_WRITE",
          "ROLE_USER"
        ]
      }
    """
    And json result contains "company" "id" "1"

  Scenario: Delete a User with Persuit ROLE_ADMIN
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "admin.persuit@sink.sendgrid.net"
    When I send a DELETE request to "user/1"

    Then the response code should be 204

  Scenario: Delete a User with Persuit ROLE_USER_WRITE
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "userwriter.dlapiper@sink.sendgrid.net"
    When I send a DELETE request to "user/1"

    Then the response code should be 204
