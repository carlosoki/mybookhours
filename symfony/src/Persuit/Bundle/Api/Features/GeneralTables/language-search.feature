@language
Feature: Language search
	In order to find profiles
	As a user
	I need to search for a language

	Rules:
		- match any occurrence of the search string in the field (doesn't have to be at the start)
		- results are ordered by name alphabetically (case insensitive)
		- search is case insensitive
		- need 3 characters minimum for the search to execute
		- special characters are not replaced (searching for 'and' will not search for '&')

	Background:
      Given I loadDB
      And I am authenticating as "publish.dlapiper@sink.sendgrid.net"

	Scenario: Basic match
    When I send a GET request to "/languages?name=GER"
		Then I get 1 result
		And result 1 contains "name" "German"

	Scenario: No match
        When I send a GET request to "/languages?name=Zaz"
		Then I get 0 result

    Scenario: Multiple results
      When I send a GET request to "/languages?name=g"
      Then I get 3 results
      And result 1 contains "name" "English"
      And result 2 contains "name" "Georgian"
      And result 3 contains "name" "German"

    Scenario: Test JSON Listing the collection
      When I send a GET request to "/languages"
      Then the response code should be 200
      And response should contain json:
      """
        [
          {
            "id":1,
            "name":"English",
            "code":"en"
          },
          {
            "id":2,
            "name":"Georgian",
            "code":"ka"
          },
          {
            "id":3,
            "name":"Russian",
            "code":"ru"
          },
          {
            "id":4,
            "name":"French",
            "code":"fr"
          },
          {
            "id":5,
            "name":"German",
            "code":"de"
          }
        ]
      """

    Scenario: Test JSON Listing by id
      When I send a GET request to "/language/1"
      Then the response code should be 200
      And response should contain json:
      """
        {
          "id":1,
          "name":"English",
          "code": "en"
        }
      """

    Scenario: Test JSON id not found
      When I send a GET request to "/language/111"
      Then the response code should be 404
      And response should contain json:
      """
        []
      """