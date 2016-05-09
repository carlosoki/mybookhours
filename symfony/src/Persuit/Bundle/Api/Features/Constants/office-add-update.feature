@office
Feature: Add a new Office or update an existing Office
  Background:
    Given I loadConstants

    And the following "companies" exist
      | name                    | profession  | description      | service  | registered |
      | DLA Piper               | 1           | test description | 1        | 1          |

    And the following "legalEntities" exist
      | company     | name                  | tax | billingStreet1  | billingCity | billingZip | billingCountry  | billingEmail  | billingPhone |
      | 1           | DLA PTY               | 0.1 | 10 Smith St     | Melbourne   | 3000       | Australia       | test@test.com | 092834239824 |

    And the following "offices" exist
      | company     | legalEntity | name                |
      | 1           | 1           | DLA Sydney          |

    And the following "users" exist
      | email                                 | roles                            | company | profession | password | activity | offices |
      | admin.persuit@sink.sendgrid.net       | ROLE_ADMIN                       |         | 1,2        | 123      | 1        |         |
      | userwriter.dlapiper@sink.sendgrid.net | ROLE_USER_WRITE,ROLE_OFFER_WRITE | 1       | 1          | 123      | 1        | 1       |

  Scenario: Save a Office with associated legal entity
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "admin.persuit@sink.sendgrid.net"
    When I send a POST request to "office" with body:
    """
      {
        "name":"Test Office",
        "company": {
          "id":1,
          "name":"Test Company",
          "description":"testing testing",
          "registered":true
        },
        "legalEntity":{
          "id": 1,
          "name": "test",
          "tax": "0.1",
          "billingStreet1": "s1",
          "billingStreet2": "s2",
          "billingCity": "s1",
          "billingZip": "2000",
          "billingCountry": "Aust"
        },
        "location":{
           "googleId": "044785c67d3ee62545861361f8173af6c02f4fae",
           "placeId": "ChIJP3Sa8ziYEmsRUKgyFmh9AQM",
           "latitude": -33.8674869,
           "longitude": 151.20699020000006,
           "formattedAddress": "Sydney NSW, Australia",
           "city": "Sydney",
           "state": "New South Wales",
           "country": "Australia"
        }
      }
    """

    Then the response code should be 201
    Then the response should contain json:
    """
      {
        "id": 2,
        "name": "Test Office"
      }
    """
    And json result contains "company" "id" "1"
    And json result contains "legalEntity" "id" "1"
    And json result contains "location" "googleId" "044785c67d3ee62545861361f8173af6c02f4fae"

  Scenario: Update an existing Office
    And I set header "content-type" with value "application/json"
    And I am authenticating as "admin.persuit@sink.sendgrid.net"
    When I send a PUT request to "office/1" with body:
    """
      {
        "name":"Sydney Office",
        "company": {
          "id":1,
          "name":"Test Company",
          "description":"testing testing",
          "registered":true
        },
        "legalEntity":{
          "id": 1,
          "name": "test",
          "tax": "0.1",
          "billingStreet1": "s1",
          "billingStreet2": "s2",
          "billingCity": "s1",
          "billingZip": "2000",
          "billingCountry": "Aust"
        },
        "location":{
            "placeId": "ChIJd2As2ZHx1moRINCMIXVWBAU",
            "formattedAddress": "Melton VIC 3337, Australia",
            "googleId": "936d295c3ea650a5063a4c4695aea8c84c37de6d",
            "latitude": -37.682979,
            "longitude": 144.5804663,
            "city": "Melton",
            "state": "Victoria",
            "country": "Australia",
            "postalCode": "3337"
        }
      }
    """
    Then the response code should be 200
    And the response should contain json:

    """
      {
        "id": 1,
        "name": "Sydney Office"
      }
    """
    And json result contains "company" "id" "1"
    And json result contains "legalEntity" "id" "1"
    And json result contains "location" "googleId" "936d295c3ea650a5063a4c4695aea8c84c37de6d"
