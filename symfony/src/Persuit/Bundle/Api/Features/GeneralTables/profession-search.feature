@profession
Feature: Profession search
	In order to find profiles
	As a user
	I need to search for a profession

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
          When I send a GET request to "/professions?name=leg"
          Then I get 1 result
          And result 1 contains "name" "Legal"

      Scenario: No match
          When I send a GET request to "/professions?name=Zaz"
          Then I get 0 result

      Scenario: Multiple results
          When I send a GET request to "/professions?name=ing"
          Then I get 2 results
          And result 1 contains "name" "Accounting"
          And result 2 contains "name" "Consulting"

    Scenario: Test JSON Listing the collection
      When I send a GET request to "/professions"
      Then the response code should be 200
      And response should contain json:
      """
        [
          {
            "id":1,
            "name":"Legal"
          },
          {
            "id":2,"name":"Accounting"
          },
          {
            "id":3,
            "name":"Consulting"
          }
        ]
      """

    Scenario: Test JSON Listing by id
      When I send a GET request to "/profession/1"
      Then the response code should be 200
      And response should contain json:
      """
        {
          "id":1,
          "name":"Legal"
        }
      """

    Scenario: Test JSON id not found
      When I send a GET request to "/profession/111"
      Then the response code should be 404
      And response should contain json:
      """
        []
      """