@company
Feature: Add a new Company or update an existing Company
  Background:
    Given I loadConstants


    And the following "companies" exist
      | name                    | profession| description      | service  | registered |
      | DLA Piper               | 1         | test description | 1        | 1          |

    And the following "users" exist
      | email                           | roles      | company | profession | password | activity | offices |
      | admin.persuit@sink.sendgrid.net | ROLE_ADMIN |         | 1,2        | 123      | 1        |         |

  Scenario: Save a Company with associated Professions
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "admin.persuit@sink.sendgrid.net"
    When I send a POST request to "company" with body:
    """
      {
        "name":"Test Company",
        "description":"testing testing",
        "registered":1,
        "services":[{
          "id": 2,
          "profession": {
            "id": 1,
            "name": "Legal"
          },
          "activity": {
            "id": 2,
            "name": "Supplier"
          }
        }],
        "professions":[{
          "id": 1,
          "name": "Legal"
        },
        {
          "id": 2,
          "name": "asdfasdf"
        }]
      }
    """

    Then the response code should be 201

    Then the response should contain json:
    """
      {
        "id": 2,
        "name": "Test Company",
        "description": "testing testing",
        "registered": true,
        "services": [
          {
            "id": 2,
            "profession": {
              "id": 1,
              "name": "Legal"
            },
            "activity": {
              "id": 2,
              "name": "Supplier"
            }
          }
        ],
        "professions": [
          {
            "id": 1,
            "name": "Legal"
          },
          {
            "id": 2,
            "name": "Accounting"
          }
        ]
      }
    """

  Scenario: Update an existing Company
    And I set header "content-type" with value "application/json"
    And I am authenticating as "admin.persuit@sink.sendgrid.net"
    When I send a PUT request to "company/1" with body:
    """
      {
          "id": 1,
          "name": "Test",
          "description": "test description",
          "registered": true,
          "professions": [
            {
              "id": 1,
              "name": "Legal"
            }
          ],
          "services": [{
            "id": 2,
            "profession": {
              "id": 1,
              "name": "Legal"
            },
            "activity": {
              "id": 2,
              "name": "Supplier"
            }
          }
          ]
      }
    """
    Then the response code should be 200
    And the response should contain json:
    """
    {
      "id":1,
      "name":"Test",
      "description":"test description",
      "registered":true,
      "professions":[{"id":1,"name":"Legal"}],
      "services":[{"id":2,"profession":{"id":1,"name":"Legal"},"activity":{"id":2,"name":"Supplier"}}]
    }
    """
