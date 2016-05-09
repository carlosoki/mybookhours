@job_title
Feature: Job Title search
	In order to find profiles
	As a user
	I need to search for a job title

	Rules:
		- match any occurence of the search string in the field (doesn't have to be at the start)
		- results are ordered by name alphabetically (case insensitive)
		- search is case insensitive
		- need 3 characters minimum for the search to execute
		- special characters are not replaced (searching for 'and' will not search for '&')

	Background:
      Given I loadDB
      And I am authenticating as "publish.dlapiper@sink.sendgrid.net"

  Scenario: Basic Match
        When I send a GET request to "/job_titles?name=Acc"
		Then I get 1 result
		And result 1 contains "name" "Accountant"

	Scenario: No match
        When I send a GET request to "/job_titles?name=Zaz"
		Then I get 0 result

	Scenario: Multiple results
        When I send a GET request to "/job_titles?name=TaNt"
		Then I get 3 results
		And result 1 contains "name" "Accountant"
		And result 2 contains "name" "Enterprise Assistant"
		And result 3 contains "name" "Consultant corporate"

	Scenario: One result
        When I send a GET request to "/job_titles?name=Leader Global M&A"
		Then I get 1 result
		And result 1 contains "name" "Leader Global M&A Consulting service line"

	Scenario: One result on bracket
        When I send a GET request to "/job_titles?name=(Pr"
		Then I get 1 result
		And result 1 contains "name" "Commercial Manager (Procurement)"

	Scenario: Special characters
        When I send a GET request to "/job_titles?name=Global M&A"
        Then I get 1 result
        And result 1 contains "name" "Leader Global M&A Consulting service line"

    Scenario: Test JSON Listing the collection
      When I send a GET request to "/job_titles"
      Then the response code should be 200
      And response should contain json:
      """
        [
          {
            "id":1,
            "name":"LBDO Consulting Senior Managing Director  CPA"
          },
          {
            "id":2,"name":"Accountant"
          },
          {
            "id":3,
            "name":"Commercial Manager (Procurement)"
          },
          {
            "id":4,
            "name":"General Counsel - Legal"
          },
          {
            "id":5,
            "name":"Administrator, Human Resources Group Functions"
          }
        ]
      """

    Scenario: Test JSON Listing by id
      When I send a GET request to "/job_title/1"
      Then the response code should be 200
      And response should contain json:
      """
        {
          "id":1,
          "name":"LBDO Consulting Senior Managing Director  CPA"
        }
      """

    Scenario: Test JSON id not found
      When I send a GET request to "/job_title/111"
      Then the response code should be 404
      And response should contain json:
      """
        []
      """