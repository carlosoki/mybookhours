@opportunity @publish-opportunity
Feature: Publish Opportunity type secondment
  As a user with publish privileges
  I can POST, PUT opportunity type secondment as published status

  Rules:
  - As publisher I can create a Secondment opportunity in published status (Scenario 1)
  - As publisher, to create a Secondment opportunity in published status I must have to send all compulsory fields (Scenario 2)
  - As publisher I can update a Secondment opportunity to published status (Scenario 3)
  - As publisher I cannot update a Secondment opportunity to published status if it is not completed (Scenario 4)
  - Only users with Publish privileges are able to publish a secondment opportunity (Scenario 5).
  - As invited to approve I can Publish secondment opportunity (Scenario 6).

  Background:
    Given I loadDB

  Scenario: 1 - User create a Secondment Opportunity as published when all data correct
    Given I am authenticating as "publish.dlapiper@sink.sendgrid.net"
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
    Then the response code should be 201
    And result has "type" "clientSecondment"
    And result has "status" "published"
    And json collection result contains "groups" "0" "id" "1"
    And json collection result contains "groups" "0" "quantity" "5"

  Scenario: 2 - Fail when try to create a Secondment Opportunity without all compulsory fields
    Given I am authenticating as "publish.dlapiper@sink.sendgrid.net"
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
        "description": "",
        "requesterName": "Foo",
        "requesterTitle" : "Mr.",
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
               "quantity":null,
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
               "daysPerWeek":null
            }
        ]
    }
    """
    Then the response code should be 400
    And the response should contain json:
    """
    {
      "code": 400,
      "message": "Validation Failed",
      "errors": {
        "practiceAreas": [
          "Field mandatory to publish an Opportunity"
        ],
        "industrySectors": [
          "Field mandatory to publish an Opportunity"
        ],
        "description": [
          "Field mandatory to publish an Opportunity"
        ],
        "locations": [
          "Field mandatory to publish an Opportunity"
        ],
        "startDate": [
          "Field mandatory to publish an Opportunity",
          "Start date must be in the future"
        ],
        "groups": [
          {
            "quantity": [
              "Field mandatory to publish Opportunity"
            ],
            "daysPerWeek": [
              "Field mandatory to publish Opportunity"
            ]
          }
        ]
      }
    }
    """

  Scenario: 3 - User can update (PUT) a Secondment Opportunity to published status
    Given the following "opportunity" exists
      | id | type             | status     | owningCompany | profession | owningUser | approver |
      | 1  | clientSecondment | unapproved | 1             | 1          | 2          | 4        |

    And the following "opportunityGroup" exists
      | opportunity | seniority |
      | 1           | 1         |

    When I am authenticating as "publish.dlapiper@sink.sendgrid.net" with "123" password
    Then I send a PUT request to "opportunity/1" with body:
    """
    {
        "type":"clientSecondment",
        "status": "published",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "approver":{
            "id": 4
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
    And the response code should be 200
    And the response should contain json:
    """
        {
          "id": 1,
          "status": "published",
          "headline": "bla"
        }
    """

  Scenario: 4 - User cannot update (PUT) a Secondment opportunity to published status if it is not completed
    Given the following "opportunity" exists
      | id | type             | status | owningCompany | profession | owningUser |
      | 1  | clientSecondment | draft  | 1             | 1          | 4          |

    And I am authenticating as "publish.dlapiper@sink.sendgrid.net"
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
        "description": "",
        "requesterName": "Foo",
        "requesterTitle" : "Mr.",
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
               "quantity":null,
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
               "daysPerWeek":null
            }
        ]
    }
    """
    Then the response code should be 400
    And the response should contain json:
	"""
    {
      "code": 400,
      "message": "Validation Failed",
      "errors": {
        "practiceAreas": [
          "Field mandatory to publish an Opportunity"
        ],
        "industrySectors": [
          "Field mandatory to publish an Opportunity"
        ],
        "description": [
          "Field mandatory to publish an Opportunity"
        ],
        "locations": [
          "Field mandatory to publish an Opportunity"
        ],
        "startDate": [
          "Field mandatory to publish an Opportunity",
          "Start date must be in the future"
        ],
        "groups": [
          {
            "quantity": [
              "Field mandatory to publish Opportunity"
            ],
            "daysPerWeek": [
              "Field mandatory to publish Opportunity"
            ]
          }
        ]
      }
    }
    """

  Scenario Outline: 5 - Only users with Publish privileges are able to publish a secondment opportunity
    Given I am authenticating as "<user>" with "<password>" password
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
    Then the response code should be <code>
    And from bundle "Api" check if "Opportunity" id 1 was <result> found

    Examples:
      | user                               | password | code | result |
      | publish.dlapiper@sink.sendgrid.net | 123      | 201  | 1      |
      | read.dlapiper@sink.sendgrid.net    | 123      | 403  | 0      |
      | write.dlapiper@sink.sendgrid.net   | 123      | 403  | 0      |

  Scenario Outline: 6 - As invited to approve I can Publish secondment opportunity
    Given the following "opportunity" exists
      | id | type             | status     | owningCompany | profession | owningUser | approver |
      | 1  | clientSecondment | unapproved | 1             | 1          | 3          | 4        |

    And the following "opportunityGroup" exists
      | opportunity | seniority |
      | 1           | 1         |

    When I am authenticating as "<user>" with "<password>" password
    Then I send a PUT request to "opportunity/1" with body:
    """
    {
        "type":"clientSecondment",
        "status": "published",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "approver":{
            "id": 4
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
    And the response code should be <code>
    And the response should contain json:
    """
        <response>
    """

    Examples:
      | user                               | password | code | response                                                             |
      | publish.dlapiper@sink.sendgrid.net | 123      | 200  | {"id": 1,"status": "published"}                                      |
      | othercompany.hsf@sink.sendgrid.net | 123      | 403  | {"code": 403,"message": "You do not have the necessary permissions"} |
      | write1.dlapiper@sink.sendgrid.net  | 123      | 403  | {"code": 403,"message": "You do not have the necessary permissions"} |