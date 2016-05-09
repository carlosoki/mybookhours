@opportunity @opportunity-group
Feature: Add Group of secondees to a secondment opportunity
  In order to secure a secondee
  As the creator of a secondment opportunity
  I need to create group(s) of secondees for secondment opportunity

  Background:
    Given I loadDB

    And I am authenticating as "othercompany.hsf@sink.sendgrid.net"

  Scenario: Save an Opportunity of secondment without group of secondee
    Given I set header "content-type" with value "application/json"
    When I send a POST request to "opportunity" with body:
    """
    {
        "type":"clientSecondment",
        "status": "draft",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "We are looking for 5 Mid-Senior Web Developers",
        "publishDuration":"2017-01-01 17:00:00",
        "groups":[
            {
                "seniority":{"id":1}
            }
        ]
    }
    """
    Then the response code should be 201
    And result has "id" "1"
    And result has "type" "clientSecondment"
    And result has "status" "draft"

  Scenario: Save an Opportunity of secondment single group of secondee
    Given I set header "content-type" with value "application/json"
    When I send a POST request to "opportunity" with body:
    """
    {
        "type":"clientSecondment",
        "status": "draft",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "bla",
        "description": "bla",
        "requesterName": "Foo",
        "requesterTitle" : "Mr.",
        "industrySectors": [{"id": 1},{"id": 3}],
        "industrySubSectors": [{"id": 1}],
        "practiceAreas": [{"id": 4}],
        "practiceSubAreas": [{"id": 4}],
        "locations": [
           {
               "googleId": "b449cd4d6e7b95f0334503027ea90867a79929ab",
               "placeId": "ChIJgf0RD69C1moR4OeMIXVWBAU",
               "latitude": -37.8142155,
               "longitude": 144.96323069999994,
               "formattedAddress": "Melbourne VIC, Australia",
               "city": "Melbourne",
               "state": "Victoria",
               "country": "Australia"
           }
        ],
        "inviteOnly": true,
        "seeInvitedFirms": false,
        "invitedCompanies":[{"id":8}],
        "unlistedCompanies": [
            {
              "name": "Aaaa",
              "description": "...."
            }
        ],
        "conflictCheck": "baaaar",
        "startDate": "2016-07-20",
        "endDate": "2016-12-20",
        "currency":{"id": 1},
        "budgetRangeStart": 200,
        "budgetRangeEnd": 1500,
        "publishDuration":"2017-01-01 17:00:00",
        "groups": [
            {
               "seniority": {"id": 1},
               "yearsSeniority": 10,
               "yearsPqe": 10,
               "quantity":5,
               "practiceLocations":[
                   {
                       "googleId": "b449cd4d6e7b95f0334503027ea90867a79929ab",
                       "placeId": "ChIJgf0RD69C1moR4OeMIXVWBAU",
                       "latitude": -37.8142155,
                       "longitude": 144.96323069999994,
                       "formattedAddress": "Melbourne VIC, Australia",
                       "city": "Melbourne",
                       "state": "Victoria",
                       "country": "Australia"
                   }
               ],
               "admittedPracticeCourt": "High Court of Australia",
               "languages":[{"id":1},{"id":2}],
               "daysPerWeek":5
            }
        ]
    }
    """
    Then the response code should be 201
    And result has "type" "clientSecondment"
    And result has "status" "draft"
    And json collection result contains "groups" "0" "id" "1"
    And json collection result contains "groups" "0" "quantity" "5"
    Then json result contains 1level nested "groups" "0" "seniority" "id" "1"
    Then json result "groups" "0" contains 2level nested "practiceLocations" "0" "null" "null" "formattedAddress" "Melbourne VIC, Australia"

  Scenario: Save an Opportunity of secondment multiple groups of secondee
    Given I set header "content-type" with value "application/json"
    When I send a POST request to "opportunity" with body:
    """
    {
        "type":"clientSecondment",
        "status": "draft",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "bla",
        "description": "bla",
        "requesterName": "Foo",
        "requesterTitle" : "Mr.",
        "industrySectors": [{"id": 1},{"id": 3}],
        "industrySubSectors": [{"id": 1}],
        "practiceAreas": [{"id": 4}],
        "practiceSubAreas": [{"id": 4}],
        "locations": [
           {
               "googleId": "b449cd4d6e7b95f0334503027ea90867a79929ab",
               "placeId": "ChIJgf0RD69C1moR4OeMIXVWBAU",
               "latitude": -37.8142155,
               "longitude": 144.96323069999994,
               "formattedAddress": "Melbourne VIC, Australia",
               "city": "Melbourne",
               "state": "Victoria",
               "country": "Australia"
           }
        ],
        "inviteOnly": true,
        "seeInvitedFirms": false,
        "invitedCompanies":[{"id":8}],
        "unlistedCompanies": [
            {
              "name": "Aaaa",
              "description": "...."
            }
        ],
        "conflictCheck": "baaaar",
        "startDate": "2016-07-20",
        "endDate": "2016-12-20",
        "currency":{"id": 1},
        "budgetRangeStart": 200,
        "budgetRangeEnd": 1500,
        "publish_duration":10,
        "groups": [
            {
               "seniority": {"id": 1},
               "yearsSeniority": 10,
               "yearsPqe": 10,
               "quantity":5,
               "practice_locations":[
                   {
                       "googleId": "b449cd4d6e7b95f0334503027ea90867a79929ab",
                       "placeId": "ChIJgf0RD69C1moR4OeMIXVWBAU",
                       "latitude": -37.8142155,
                       "longitude": 144.96323069999994,
                       "formattedAddress": "Melbourne VIC, Australia",
                       "city": "Melbourne",
                       "state": "Victoria",
                       "country": "Australia"
                   }
               ],
               "admittedPracticeCourt": "High Court of Australia",
               "languages":[{"id":1},{"id":2}],
               "daysPerWeek":5
            },
            {
               "seniority": {"id": 1},
               "yearsSeniority": 5,
               "yearsPqe": 1,
               "quantity":2,
               "practice_locations":[
                   {
                       "googleIdd": "b449cd4d6e7b95f0334503027ea90867a79929ab",
                       "placeId": "ChIJgf0RD69C1moR4OeMIXVWBAU",
                       "latitude": -37.8142155,
                       "longitude": 144.96323069999994,
                       "formattedAddress": "Melbourne VIC, Australia",
                       "city": "Melbourne",
                       "state": "Victoria",
                       "country": "Australia"
                   }
               ],
               "admittedPracticeCourt": "High Court of Australia",
               "languages":[{"id":1},{"id":2}],
               "daysPerWeek":5
            }
        ]
    }
    """
    Then the response code should be 201
    And result has "type" "clientSecondment"
    And result has "status" "draft"
    And json collection result contains "groups" "0" "id" "1"
    And json collection result contains "groups" "0" "quantity" "5"
    And json collection result contains "groups" "1" "id" "2"
    And json collection result contains "groups" "1" "quantity" "2"
    Then json result contains 1level nested "groups" "0" "seniority" "id" "1"
    Then json result contains 1level nested "groups" "1" "seniority" "id" "1"

  Scenario: Update (include) single group of secondee
    Given the following "opportunity" exists
      | id | type             | status | owningCompany | profession | owningUser |
      | 1  | clientSecondment | draft  | 2             | 1          | 5          |

    When I set header "content-type" with value "application/json"
    When I send a PUT request to "opportunity/1" with body:
    """
    {
        "type":"clientSecondment",
        "status": "draft",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "bla",
        "description": "bla",
        "requesterName": "Foo",
        "requesterTitle" : "Mr.",
        "industrySectors": [{"id": 1},{"id": 3}],
        "industrySubSectors": [{"id": 1}],
        "practiceAreas": [{"id": 4}],
        "practiceSubAreas": [{"id": 4}],
        "locations": [
           {
               "googleId": "b449cd4d6e7b95f0334503027ea90867a79929ab",
               "placeId": "ChIJgf0RD69C1moR4OeMIXVWBAU",
               "latitude": -37.8142155,
               "longitude": 144.96323069999994,
               "formattedAddress": "Melbourne VIC, Australia",
               "city": "Melbourne",
               "state": "Victoria",
               "country": "Australia"
           }
        ],
        "inviteOnly": true,
        "seeInvitedFirms": false,
        "invitedCompanies":[{"id":8}],
        "unlistedCompanies": [
            {
              "name": "Aaaa",
              "description": "...."
            }
        ],
        "conflictCheck": "baaaar",
        "startDate": "2016-07-20",
        "endDate": "2016-12-20",
        "currency":{"id": 1},
        "budgetRangeStart": 200,
        "budgetRangeEnd": 1500,
        "tcFile":{
          "id": 45,
          "url": "//api.oki.local/persuit-file-upload/fa6d2d864ea084227b09cd16e40a3dce9f5561ba.pdf",
          "name": "Persuit.pdf"
        },
        "publishDuration":"2017-01-01 17:00:00",
        "groups": [
            {
               "seniority": {"id": 1},
               "yearsSeniority": 10,
               "yearsPqe": 10,
               "quantity":5,
               "practiceLocations":[
                   {
                       "googleId": "b449cd4d6e7b95f0334503027ea90867a79929ab",
                       "placeId": "ChIJgf0RD69C1moR4OeMIXVWBAU",
                       "latitude": -37.8142155,
                       "longitude": 144.96323069999994,
                       "formattedAddress": "Melbourne VIC, Australia",
                       "city": "Melbourne",
                       "state": "Victoria",
                       "country": "Australia"
                   }
               ],
               "admittedPracticeCourt": "High Court of Australia",
               "languages":[{"id":1},{"id":2}],
               "daysPerWeek":5
            }
        ]
    }
    """
    Then the response code should be 200
    And result has "id" "1"
    And result has "type" "clientSecondment"
    And result has "status" "draft"
    And json collection result contains "groups" "0" "id" "1"
    And json collection result contains "groups" "0" "quantity" "5"


  Scenario: remove group of secondee
    Given the following "opportunity" exists
      | id | type             | status | owningCompany | profession | owningUser |
      | 1  | clientSecondment | draft  | 2             | 1          | 5          |

    And the following "opportunity_group" exists
      | opportunity | seniority | quantity |
      | 1           | 1         | 1        |
      | 1           | 1         | 2        |

    When I set header "content-type" with value "application/json"
    When I send a PUT request to "opportunity/1" with body:
    """
    {
        "type":"clientSecondment",
        "status": "draft",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "We are looking for 5 Mid-Senior Web Developers",
        "publishDuration":"2017-01-01 17:00:00",
        "groups":[
            {
                "seniority":{"id":1}
            }
        ]
    }
    """
    Then the response code should be 200
    Then the response should contain json:
    """
    {
        "id": 1,
        "type":"clientSecondment",
        "status": "draft",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "We are looking for 5 Mid-Senior Web Developers",
        "publishDuration":"2017-01-01T17:00:00+1100",
        "groups": [
          {
            "id": 1,
            "seniority": {
              "id": 1,
              "name": "Partner"
            },
            "practiceLocations": [],
            "languages": [],
            "selectedProfiles":[]
          }
        ]
    }
    """
