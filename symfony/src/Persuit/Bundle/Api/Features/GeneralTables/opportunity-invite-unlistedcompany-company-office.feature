@opportunity @invite-company-office
Feature: Invite unlisted companies, companies and offices to opportunity
    I need to invite companies to my published secondment opportunity
    So I can get more offers

  Background:
    Given I loadDB

    Given the following "opportunity" exists
      | id | type             | status    | owningCompany | profession | owningUser | approver |
      | 1  | clientSecondment | draft     | 1             | 1          | 4          |          |
      | 2  | clientSecondment | published | 1             | 1          | 4          |          |
      | 3  | clientSecondment | published | 1             | 1          | 4          |          |

    And the following "opportunityGroup" exists
      | opportunity | seniority |
      | 2           | 1         |
      | 3           | 1         |

    And I am authenticating as "publish.dlapiper@sink.sendgrid.net"

  Scenario: 1 - POST Invite companies and offices in Draft - Success result
    When I send a POST request to "opportunity" with body:
    """
    {
        "type":"clientSecondment",
        "status": "published",
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
        "invitedCompanies":[
             {
                "id": 1
             },
             {
                 "id": 3
             }
        ],
        "invitedOffices":[
             {
                 "id":2
             },
             {
                 "id":4
             }
        ],
        "unlistedCompanies": [
            {
              "name": "new unlisted 1",
              "description": "...."
            },
            {
              "name": "new unlisted 2",
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
    Then the response code should be 201
    And the response should contain "DLA Melbourne"
    And the response should contain "Ashursts Melbourne"
    And the response should contain "new unlisted 1"
    And the response should contain "new unlisted 2"
    And opportunity 4 has companies "1,3"

  Scenario: 2 - POST Only one office is allowed for each company - Fail result
    When I send a POST request to "opportunity" with body:
    """
    {
        "type":"clientSecondment",
        "status": "published",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "bla",
        "description": "bla",
        "requester_name": "Foo",
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
        "invitedCompanies":[
             {
                "id": 1,
                "bla": "bla"
             }
        ],
        "invitedOffices":[
             {
                 "id":1
             },
             {
                 "id":2
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
    Then the response code should be 400
    And the response should contain "Only one office is allowed for each company"

  Scenario: 3 - POST Some of the offices does not belongs to the companies submitted
    When I send a POST request to "opportunity" with body:
    """
    {
        "type":"clientSecondment",
        "status": "published",
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
        "invitedCompanies":[
             {
                "id": 1,
                "bla": "bla"
             }
        ],
        "invitedOffices":[
             {
                 "id":1
             },
             {
                 "id":3
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
    Then the response code should be 400
    And the response should contain "Some of the offices does not belongs to the companies submitted"

  Scenario: 4 - POST You must have to submit a company when submitting an office
    When I send a POST request to "opportunity" with body:
    """
    {
        "type":"clientSecondment",
        "status": "published",
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
        "invitedCompanies":[],
        "invitedOffices":[
             {
                 "id":1
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
    Then the response code should be 400
    And the response should contain "You must have to submit a company when submitting an office"

  Scenario: 4 - PUT Invite companies and offices in Draft - Success result
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
        "invitedCompanies":[
             {
                "id": 1
             },
             {
                "id": 3
             }
        ],
        "invitedOffices":[
             {
                 "id":2
             },
             {
                 "id":4
             }
        ],
        "groups": [
            {
               "seniority": {"id": 1}
            }
        ]
    }
    """
    Then the response code should be 200
    And the response should contain "DLA Melbourne"
    And the response should contain "Ashursts Melbourne"
    And opportunity 1 has companies "1,3"

  Scenario: 5 - PUT Some of the offices does not belongs to the companies submitted
    When I send a PUT request to "opportunity/1" with body:
    """
    {
        "type":"clientSecondment",
        "status": "published",
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
        "invitedCompanies":[
             {
                "id": 1
             }
        ],
        "invitedOffices":[
             {
                 "id":2
             },
             {
                 "id":3
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
    Then the response code should be 400
    And the response should contain "Some of the offices does not belongs to the companies submitted"
    And opportunity 1 has companies "null"

  Scenario: 6 - Invite companies and offices when opportunity is published - Success result
    When I send a PATCH request to "opportunity/2" with body:
    """
    {
        "invitedCompanies":[
             {
                "id": 1
             },
             {
                 "id": 3
             }
        ],
        "invitedOffices": [
            {
                "id":2
            },
            {
                 "id":4
            }
        ]
    }
    """
    Then the response code should be 200
    And opportunity 2 has companies "1,3"
    And opportunity 2 has offices "2,4"

  Scenario: 7 - opportunity is published. Some of the offices does not belongs to the companies submitted
    When I send a PATCH request to "opportunity/2" with body:
    """
    {
        "invitedCompanies":[
             {
                "id": 1
             }
        ],
        "invitedOffices": [
            {
                "id":2
            },
            {
                "id":4
            }
        ]
    }
    """
    Then the response code should be 400
    And opportunity 2 has companies "null"
    And opportunity 2 has offices "null"
    And the response should contain "Some of the offices does not belongs to the companies submitted"

  Scenario: 8 - opportunity is published. Only one office is allowed for each company
    When I send a PATCH request to "opportunity/2" with body:
    """
    {
        "invitedCompanies":[
             {
                "id": 1
             }
        ],
        "invitedOffices": [
            {
                "id":1
            },
            {
                "id":2
            }
        ]
    }
    """
    Then the response code should be 400
    And opportunity 2 has companies "null"
    And opportunity 2 has offices "null"
    And the response should contain "Only one office is allowed for each company"

  Scenario: 9 - opportunity is published. You must have to submit a company when submitting an office
    When I send a PATCH request to "opportunity/2" with body:
    """
    {
        "invitedCompanies":[],
        "invitedOffices": [
            {
                "id":1
            }
        ]
    }
    """
    Then the response code should be 400
    And opportunity 2 has companies "null"
    And opportunity 2 has offices "null"
    And the response should contain "You must have to submit a company when submitting an office"

  Scenario: 10 - opportunity is published. Invite new unlisted companies without previous unlisted companies
   When I send a PATCH request to "opportunity/2" with body:
   """
   {
      "unlistedCompanies": [
          {
              "name": "new unlisted 1",
              "description": "...."
          },
          {
              "name": "new unlisted 2",
              "description": "...."
          }
      ]
   }
   """
  Then the response code should be 200
  And opportunity 2 has Unlisted companies "1,2"

  Scenario: 11 - opportunity is published. Invite new unlisted companies with previous unlisted companies
    When I send a PATCH request to "opportunity/3" with body:
    """
    {
        "unlistedCompanies": [
            {
                "name": "unlisted 1",
                "description": "...."
            },
            {
                "name": "unlisted 2",
                "description": "...."
            }
        ]
    }
    """
    Then the response code should be 200
    And opportunity 3 has Unlisted companies "1,2"
    Then I send a PATCH request to "opportunity/3" with body:
    """
    {
        "unlistedCompanies": [
            {
                "name": "unlisted 1",
                "description": "...."
            },
            {
                "name": "unlisted 2",
                "description": "...."
            },
            {
                "name": "new unlisted 3",
                "description": "...."
            }
        ]
    }
    """
    Then the response code should be 200
    And opportunity 3 has Unlisted companies "1,2,3"