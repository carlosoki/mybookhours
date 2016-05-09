@profile
Feature: Add a new Profile or update an existing Profile
  Background:
    Given I loadDB

    And the following "Profile" exist
      | id | firstName | initial | lastName  | availableForSecondment | availableForSecondmentFrom | availableForSecondmentTo | indicativeMonthlyRate | currentJobTitle | profession | company | seniority | language | practiceArea | practiceSubArea | industrySector | industrySubSector | secondmentLocations | admittedToPracticeLocations |
      | 1  | Benjamin  | J       | Mooney    | 1                      | 2015-01-01                 | 2016-01-01               | 21000                 | Janitor         | 1          | 3       | 1         | 3        |              |                 |                |                   |                     |                             |
      | 2  | Frank     |         | Smith     | 1                      | 2015-01-02                 | 2016-01-01               | 15000                 | Vice President  | 1          | 3       | 1         |          |              |                 |                |                   |                     |                             |
      | 3  | Paul      | P       | Jones     | 0                      | 2015-01-03                 | 2016-01-01               | 20000                 | Senior Dev      | 1          | 3       | 1         |          |              |                 |                |                   |                     |                             |
      | 4  | Sven      |         | Ulrick    | 1                      | 2015-01-01                 | 2016-01-01               | 19000                 |                 | 2          | 6       | 10        | 6        |              |                 |                |                   |                     |                             |
      | 5  | Stina     |         | Inngvar   | 1                      |                            |                          | 17000                 | Backend Dev     | 2          | 6       | 10        | 6        |              |                 |                |                   |                     |                             |
      | 6  | Tuve      | J       | Inngen    | 1                      | 2015-01-01                 | 2015-06-01               | 18000                 |                 | 2          | 6       | 10        | 6        |              |                 |                |                   |                     |                             |
      | 7  | Rebecca   |         | Lock      | 0                      | 2015-01-01                 | 2015-06-01               | 25000                 | CEO             | 1          | 1       | 1         |          |              |                 |                |                   |                     |                             |
      | 8  | Matthew   | T       | Pollock   | 0                      | 2015-01-01                 | 2015-06-01               | 2000                  |                 | 1          | 1       | 1         |          |              |                 |                |                   |                     |                             |
      | 9  | Jackson   | I       | Pollock   | 0                      |                            |                          | 21000                 |                 | 2          | 21      | 12        |          |              |                 |                |                   |                     |                             |
      | 10 | Andreas   | P       | Inniesta  | 1                      |                            |                          | 2000                  |                 | 2          | 21      | 12        |          | 4            | 5               | 1              | 1                 | 1                   | 1                           |
      | 11 | Innès     |         | Gunnar    | 1                      |                            |                          | 24000                 |                 | 2          | 21      | 16        |          |              |                 |                |                   |                     |                             |
      | 12 | Matias    |         | Oinni     | 1                      |                            |                          | 60000                 |                 | 2          | 19      | 12        | 5        |              |                 |                |                   |                     |                             |
      | 13 | Ebba      | F       | Larsen    | 1                      |                            |                          | 40000                 |                 | 2          | 19      | 16        |          |              |                 |                |                   |                     |                             |
      | 14 | Oskar     | Z       | Berg      | 0                      |                            |                          | 20000                 |                 | 2          | 19      | 17        | 5        |              |                 |                |                   |                     |                             |
      | 15 | Alinna    | Z       | Nop       | 1                      |                            |                          | 1000                  |                 | 2          | 21      | 15        |          | 4            | 6               | 1              | 1                 | 1                   |                             |
      | 16 | Frank     | Y       | Innazy    | 0                      |                            |                          | 9000                  |                 | 1          | 3       | 2         | 3,7      |              |                 |                |                   |                     |                             |
      | 17 | Andrew    |         | Innopolus | 1                      | 2015-01-01                 | 2017-01-01               | 2100                  |                 | 1          | 3       | 4         |          |              |                 |                |                   |                     |                             |
      | 18 | Yimmy     | X       | Inntut    | 0                      |                            |                          | 22000                 |                 | 2          | 20      | 15        |          | 4            | 6               | 1              | 1                 |                     |                             |
      | 19 | Yimmy     | X       | Noop      | 1                      | 2015-01-01                 | 2017-01-01               | 22000                 | Web Pleb        | 2          | 20      | 15        | 6,7      | 4            | 6               | 1              | 1                 | 2                   | 2                           |

    And the following "ProfileExtension" exist
      | id  | versionName         | professionalHeadline | professionalDetails           | default |
      | 1   | Tax Law             | Senior Lawyer        | 8 years experience with taxes | 1       |
      | 2   | Corporate Law       | Partner              | 25 years experience           | 0       |

  Scenario: Add a Profile with minimal info
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "write1.ashursts@sink.sendgrid.net"
    When I send a POST request to "profile" with body:
     """
      {
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "firstName": "benjamin",
        "lastName": "mooney",
        "availableForSecondment": true,
        "seniority": {
          "id": 1,
          "name": "Partner"
        },
        "profileExtensions":
        [
          {
            "versionName":"version name",
            "professionalHeadline":"professional headline",
            "professionalDetails":"professional details"
          }
        ]
      }
    """

    Then the response code should be 201
    Then the response should contain json:
    """
      {
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "firstName": "benjamin",
        "lastName": "mooney",
        "availableForSecondment": true,
        "profileExtensions":
        [
          {
            "id":3,
            "versionName":"version name",
            "professionalHeadline":"professional headline",
            "professionalDetails":"professional details",
            "default":false
          }
        ]
      }
    """
    And json result contains "company" "id" "3"
    And json result contains "seniority" "id" "1"

  Scenario: Add a Profile with full info
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "write1.ashursts@sink.sendgrid.net"
    When I send a POST request to "profile" with body:
     """
      {
        "profession": {
          "id": 2,
          "name": "Accounting"
        },
        "firstName": "Frank",
        "initial": "P",
        "lastName": "Jones",
        "availableForSecondment": true,
        "availableForSecondmentFrom": "2016-02-01",
        "availableForSecondmentTo": "2016-11-01",
        "rateCurrency": {
          "id": 2,
          "name": "Pounds"
        },
        "indicativeMonthlyRate": 7000.00,
        "preferredWorkDays": 5,
        "currentJobTitle": "My Magnificent Title",
        "seniority": {
          "id": 12,
          "name": "Senior Auditor"
        },
        "seniorityYearsOfExperience": "27",
        "biography": "a1 blaa blaa blaa...",
        "education": "a2 blaa blaa blaa...",
        "practiceAreas": [
          {
          "id": 4,
          "name": "Tax"
          }
        ],
        "practiceSubAreas": [
          {
          "id": 4,
          "name": "Corporate Tax"
          }
        ],
        "industrySectors": [
          {
          "id": 1,
          "name": "Accounting"
          },
          {
          "id": 3,
          "name": "Banks"
          }
        ],
        "industrySubSectors": [
          {
          "id": 1,
          "name": "Account for tax return"
          },
          {
          "id": 5,
          "name": "banks insurance"
          }
        ],
        "admittedToPracticeCourts": "a3 blaa blaa blaa...",
        "admittedToPracticeLocations": "a4 blaa blaa blaa...",
        "languages": [
          {
        "id": 1,
        "name": "English"
        },
        {
        "id": 4,
        "name": "French"
        },
        {
          "id": 5,
          "name": "German"
        }
        ],
        "offices": [
          {
          "id": 1,
          "name": "DLA Sydney"
          },
          {
          "id": 2,
          "name": "DLA Melb"
          }
        ],
        "secondmentLocations": [
          {
          "googleId": "b449cd4d6e7b95f0334503027ea90867a79929ab",
          "placeId": "ChIJgf0RD69C1moR4OeMIXVWBAU",
          "latitude": -37.8142155,
          "longitude": 144.96323069999994,
          "formattedAddress": "Melbourne VIC, Australia",
          "city": "Melbourne",
          "state": "Victoria",
          "country": "Australia"
          },
          {
          "googleId": "044785c67d3ee62545861361f8173af6c02f4fae",
          "placeId": "ChIJP3Sa8ziYEmsRUKgyFmh9AQM",
          "latitude": -33.8674869,
          "longitude": 151.20699020000006,
          "formattedAddress": "Sydney NSW, Australia",
          "city": "Sydney",
          "state": "New South Wales",
          "country": "Australia"
          }
        ],
        "admittedToPracticeLocations": [
          {
          "googleId": "b449cd4d6e7b95f0334503027ea90867a79929ab",
          "placeId": "ChIJgf0RD69C1moR4OeMIXVWBAU",
          "latitude": -37.8142155,
          "longitude": 144.96323069999994,
          "formattedAddress": "Melbourne VIC, Australia",
          "city": "Melbourne",
          "state": "Victoria",
          "country": "Australia"
          },
          {
          "googleId": "044785c67d3ee62545861361f8173af6c02f4fae",
          "placeId": "ChIJP3Sa8ziYEmsRUKgyFmh9AQM",
          "latitude": -33.8674869,
          "longitude": 151.20699020000006,
          "formattedAddress": "Sydney NSW, Australia",
          "city": "Sydney",
          "state": "New South Wales",
          "country": "Australia"
          }
        ],
        "profileExtensions": [
          {
          "versionName": "frontend dev",
          "professionalHeadline": "Frontend Developer",
          "professionalDetails": "Benjamin is super frontend dev, blaa blaa blaa...",
          "default": true
          },
          {
          "versionName": "backend dev",
          "professionalHeadline": "Backend Developer",
          "professionalDetails": "Benjamin is super backend dev, blaa blaa blaa...",
          "default": false
          }
        ]
      }
    """

    Then the response code should be 201
    Then the response should contain json:
    """
      {
        "firstName": "Frank",
        "initial": "P",
        "lastName": "Jones",
        "availableForSecondment": true,
        "availableForSecondmentFrom": "2016-02-01T00:00:00+1100",
        "availableForSecondmentTo": "2016-11-01T00:00:00+1100",
        "indicativeMonthlyRate": 7000.00,
        "preferredWorkDays": 5,
        "currentJobTitle": "My Magnificent Title",
        "seniorityYearsOfExperience": "27",
        "biography": "a1 blaa blaa blaa...",
        "education": "a2 blaa blaa blaa...",
        "admittedToPracticeCourts": "a3 blaa blaa blaa..."
      }
    """
    And json result contains "company" "id" "3"

    And json result contains "seniority" "id" "12"
    And json result contains "rateCurrency" "id" "2"
    And json result contains "seniority" "id" "12"

    And json collection result contains "practiceAreas" "0" "id" "4"
    And json collection result contains "practiceSubAreas" "0" "id" "4"

    And json collection result contains "industrySectors" "0" "id" "1"
    And json collection result contains "industrySectors" "1" "id" "3"
    And json collection result contains "industrySubSectors" "0" "id" "1"
    And json collection result contains "industrySubSectors" "1" "id" "5"

    And json collection result contains "languages" "0" "id" "1"
    And json collection result contains "languages" "1" "id" "4"
    And json collection result contains "languages" "2" "id" "5"

    And json collection result contains "offices" "0" "id" "1"
    And json collection result contains "offices" "1" "id" "2"

    And json collection result contains "secondmentLocations" "0" "placeId" "ChIJgf0RD69C1moR4OeMIXVWBAU"
    And json collection result contains "secondmentLocations" "1" "placeId" "ChIJP3Sa8ziYEmsRUKgyFmh9AQM"
    And json collection result contains "admittedToPracticeLocations" "0" "placeId" "ChIJgf0RD69C1moR4OeMIXVWBAU"
    And json collection result contains "admittedToPracticeLocations" "1" "placeId" "ChIJP3Sa8ziYEmsRUKgyFmh9AQM"

    And json collection result contains "profileExtensions" "0" "versionName" "frontend dev"
    And json collection result contains "profileExtensions" "0" "professionalHeadline" "Frontend Developer"
    And json collection result contains "profileExtensions" "0" "professionalDetails" "Benjamin is super frontend dev, blaa blaa blaa..."
    And json collection result contains "profileExtensions" "0" "default" "true"

    And json collection result contains "profileExtensions" "1" "versionName" "backend dev"
    And json collection result contains "profileExtensions" "1" "professionalHeadline" "Backend Developer"
    And json collection result contains "profileExtensions" "1" "professionalDetails" "Benjamin is super backend dev, blaa blaa blaa..."
    And json collection result contains "profileExtensions" "1" "default" "false"


  Scenario: Update a Profile with full info
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "write1.ashursts@sink.sendgrid.net"
    When I send a PUT request to "profile/1" with body:
     """
      {
        "profession": {
          "id": 2,
          "name": "Accounting"
        },
        "firstName": "Frankie",
        "initial": "T",
        "lastName": "Smith",
        "availableForSecondmentFrom": "2017-02-01T00:00:00+1100",
        "availableForSecondmentTo": "2017-11-01T00:00:00+1100",
        "rateCurrency": {
          "id": 4,
          "name": "Euro"
        },
        "indicativeMonthlyRate": 3000.00,
        "preferredWorkDays": 3,
        "currentJobTitle": "My Bland Title",
        "seniority": {
          "id": 14,
          "name": "Audit Manager"
        },
        "seniorityYearsOfExperience": "57",
        "biography": "Blaa blaa blaa...",
        "education": "Blaa blaa blaa...",
        "practiceAreas": [
          {
          "id": 6,
          "name": "Non Tax"
          }
        ],
        "practiceSubAreas": [
          {
          "id": 7,
          "name": "Taxi Waxi"
          }
        ],
        "industrySectors": [
          {
          "id": 3,
          "name": "Banks"
          }
        ],
        "industrySubSectors": [
          {
          "id": 5,
          "name": "banks insurance"
          }
        ],
        "admittedToPracticeCourts": "Blaa blaa blaa...",
        "admittedToPracticeLocations": "Blaa blaa blaa...",
        "languages": [
        {
        "id": 4,
        "name": "French"
        }
        ],
        "offices": [
          {
          "id": 2,
          "name": "DLA Melb"
          }
        ],
        "secondmentLocations": [
        ],
        "admittedToPracticeLocations": [
          {
          "googleId": "044785c67d3ee62545861361f8173af6c02f4fae",
          "placeId": "ChIJP3Sa8ziYEmsRUKgyFmh9AQM",
          "latitude": -33.8674869,
          "longitude": 151.20699020000006,
          "formattedAddress": "Sydney NSW, Australia",
          "city": "Sydney",
          "state": "New South Wales",
          "country": "Australia"
          }
        ],
        "profileExtensions": [
          {
          "versionName": "backend dev",
          "professionalHeadline": "Backend Developer",
          "professionalDetails": "This guy is super backend dev, blaa blaa blaa...",
          "default": false
          },
          {
          "versionName": "middleware dev",
          "professionalHeadline": "Middleware Developer",
          "professionalDetails": "This guy is super middleware dev, blaa blaa blaa...",
          "default": true
          }
        ]
      }
    """

    Then the response code should be 200
    Then the response should contain json:
    """
      {
        "firstName": "Frankie",
        "initial": "T",
        "lastName": "Smith",
        "availableForSecondmentFrom": "2017-02-01T00:00:00+1100",
        "availableForSecondmentTo": "2017-11-01T00:00:00+1100",
        "indicativeMonthlyRate": 3000.00,
        "preferredWorkDays": 3,
        "currentJobTitle": "My Bland Title",
        "seniorityYearsOfExperience": "57",
        "biography": "Blaa blaa blaa...",
        "education": "Blaa blaa blaa...",
        "secondmentLocations" : []
      }
    """

    And json result contains "company" "id" "3"
    And json result contains "seniority" "id" "14"
    And json result contains "rateCurrency" "id" "4"

    And json collection result contains "practiceAreas" "0" "id" "6"
    And json collection result contains "practiceSubAreas" "0" "id" "7"

    And json collection result contains "industrySectors" "0" "id" "3"
    And json collection result contains "industrySubSectors" "0" "id" "5"

    And json collection result contains "languages" "0" "id" "4"

    And json collection result contains "offices" "0" "id" "2"

    And json collection result contains "admittedToPracticeLocations" "0" "placeId" "ChIJP3Sa8ziYEmsRUKgyFmh9AQM"

    And json collection result contains "profileExtensions" "0" "versionName" "backend dev"
    And json collection result contains "profileExtensions" "0" "professionalHeadline" "Backend Developer"
    And json collection result contains "profileExtensions" "0" "professionalDetails" "This guy is super backend dev, blaa blaa blaa..."
    And json collection result contains "profileExtensions" "0" "default" "false"

    And json collection result contains "profileExtensions" "1" "versionName" "middleware dev"
    And json collection result contains "profileExtensions" "1" "professionalHeadline" "Middleware Developer"
    And json collection result contains "profileExtensions" "1" "professionalDetails" "This guy is super middleware dev, blaa blaa blaa..."
    And json collection result contains "profileExtensions" "1" "default" "true"


  Scenario: Delete Profiles partial and full info
    Given I set header "content-type" with value "application/json"
    And I am authenticating as "write1.ashursts@sink.sendgrid.net"
    When I send a DELETE request to "profile/1" with body:
    """
    {}
    """
    Then the response code should be 204

    Given I set header "content-type" with value "application/json"
    And I am authenticating as "write.deloitte@sink.sendgrid.net"
    When I send a DELETE request to "profile/18" with body:
    """
    {}
    """
    Then the response code should be 204

