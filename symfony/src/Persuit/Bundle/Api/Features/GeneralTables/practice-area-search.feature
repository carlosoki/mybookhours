@practice_area
Feature: Practice Area search
	In order to find profiles
	As a user
	I need to search for an expertise

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
        When I send a GET request to "/practice_areas?name=Abu"
		Then I get 1 result
		And result 1 contains "name" "Abuse of Market Power"

	Scenario: No match
        When I send a GET request to "/practice_areas?name=Zaz"
		Then I get 0 result

	Scenario: Multiple results
        When I send a GET request to "/practice_areas?name=Market"
		Then I get 2 results
		And result 1 contains "name" "Abuse of Market Power"
        And result 2 contains "name" "Advertising and Marketing"

  Scenario: Test JSON Listing the collection
    When I send a GET request to "/practice_areas"
    Then the response code should be 200
    Then I get 6 results
    And result 1 contains "name" "Abuse of Market Power"
    And result 2 contains "name" "Accounting"
    And result 3 contains "name" "Advertising and Marketing"
    And result 4 contains "name" "Tax"
    And result 5 contains "name" "Cyber"
    And result 6 contains "name" "Non Tax"

  Scenario: Test JSON Listing by id
    When I send a GET request to "/practice_area/1"
    Then the response code should be 200
    And response should contain json:
    """
        {
          "id": 1,
          "profession": {
            "id": 1,
            "name": "Legal"
          },
          "name": "Abuse of Market Power",
          "practiceSubArea": [
            {
              "id": 1,
              "name": "Cartels \\& Competition Investigations"
            },
            {
              "id": 2,
              "name": "Competition Law Compliance"
            }
          ]
        }
    """

  Scenario: Test JSON id not found
    When I send a GET request to "/practice_area/111"
    Then the response code should be 404
    And response should contain json:
    """
      []
    """

  Scenario: Test JSON Listing the collection
    When I send a GET request to "/practice_areas?profession=1&name=Competition"
    Then the response code should be 200
    And response should contain json:
    """
      [
        {
          "id": 1,
          "name": "Abuse of Market Power",
          "practiceSubArea": [
            {
              "id": 1,
              "name": "Cartels \\& Competition Investigations"
            },
            {
              "id": 2,
              "name": "Competition Law Compliance"
            }
          ]
        }
      ]
    """
