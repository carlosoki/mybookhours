@user @validate
Feature: Add a new User with conflicting requester / supplier roles
  Background:
    Given I loadDB

  Scenario: Try to save a User with activity 'requester' and ROLE_OFFER_WRITE
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "admin.persuit@sink.sendgrid.net"
    When I send a POST request to "user" with body:
     """
        {
            "first_name":"John",
            "middle_name":"Paul",
            "last_name":"Jones",
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
                "ROLE_OPP_PUBLISH",
                "ROLE_OFFER_WRITE"
            ]
        }
    """

    Then the response code should be 400

    Scenario: Update a User with oki ROLE_ADMIN
        Given I set header "content-type" with value "application/json"
        And I am authenticating as "admin.persuit@sink.sendgrid.net"
        When I send a PUT request to "user/1" with body:
         """
            {
                "first_name":"John",
                "middle_name":"Jimmy",
                "last_name":"Jones",
                "phone":"04509909887",
                "company":{"id":1},
                "email":"read.dlapiper@sink.sendgrid.net",
                "professions":[{"id":1}],
                "activity":{"id":1},
                "roles":[
                    "ROLE_USER_WRITE"
                ],
                "offices":[{"id":3}]
            }
        """
        Then the response code should be 400

    Scenario: Try to save a User and allocate office already taken by another user with that profession
        Given I set header "content-type" with value "application/json"
        And I am authenticating as "admin.persuit@sink.sendgrid.net"
        When I send a POST request to "user" with body:
         """
            {
                "first_name":"Jane",
                "last_name":"Doe",
                "phone":"04500000000",
                "company":{"id":1},
                "email":"email@test.com",
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
                    "ROLE_OPP_PUBLISH"
                ],
                "offices":[{"id":1}]
            }
        """
        Then the response code should be 400