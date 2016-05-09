@industry
Feature: Industry search
	In order to find secondees
	As a corporate user
	I need to search for a company

	Rules:
		- match any occurence of the search string in the field (doesn't have to be at the start)
		- results are ordered by name alphabetically (case insensitive)
		- search is case insensitive
		- need 3 characters minimum for the search to execute
		- special characters are not replaced (searching for 'and' will not search for '&')

	Background:
      Given I loadDB
      And I am authenticating as "publish.dlapiper@sink.sendgrid.net"

    Scenario: Basic match
      When I send a GET request to "/industries?name=Accounting"
      Then I get 1 result
      And result 1 contains "name" "Accounting"

	Scenario: No match
      When I send a GET request to "/industries?name=Zaz"
      Then I get 0 result

	Scenario: Special characters
      When I send a GET request to "/industries?name=Energy & Resources"
      Then I get 1 result
      And result 1 contains "name" "Energy & Resources"

    Scenario: Test JSON Listing the collection
      When I send a GET request to "/industries"
      Then the response code should be 200
      And response should contain json:
      """
        [
          {
            "id": 1,
            "name": "Accounting",
            "industrySubSector": [
              {
                "id": 1,
                "name": "Account for tax return"
              }
            ]
          },
          {
            "id": 2,
            "name": "Energy & Resources",
            "industrySubSector": [
              {
                "id": 2,
                "name": "Mining & Metals"
              },
              {
                "id": 3,
                "name": "Oil & Gas"
              },
              {
                "id": 4,
                "name": "Power"
              }
            ]
          },
          {
            "id": 3,
            "name": "banks",
            "industrySubSector": [
              {
                "id": 5,
                "name": "banks insurance"
              }
            ]
          }
        ]
      """

    Scenario: Test JSON Listing by id
      When I send a GET request to "/industry/1"
      Then the response code should be 200
      And response should contain json:
      """
        {
          "id": 1,
          "name": "Accounting",
          "industrySubSector": [
            {
              "id": 1,
              "name": "Account for tax return"
            }
          ]
        }
      """

    Scenario: Test JSON id not found
      When I send a GET request to "/industry/111"
      Then the response code should be 404
      And response should contain json:
      """
        []
      """