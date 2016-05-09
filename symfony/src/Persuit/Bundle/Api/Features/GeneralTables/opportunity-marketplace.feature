@opportunity @marketplace
Feature: Opportunity Marketplace List view

  Suppliers Roles:
  - List Opportunity in marketplace
  - Search in marketplace with some filters

  Background:
    Given I loadDB

## ---------------------- USED AS PROOF CONCEPT FOR SEARCH BY LOCATION -----------------------------------
    And the following "LocationNotFromGoogle" exist
      | googleId                                 | placeId                     | city        | state              | country   | latitude    | longitude          | formattedAddress                |
      | b449cd4d6e7b95f0334503027ea90867a79929ab | ChIJgf0RD69C1moR4OeMIXVWBAU | Melbourne   | Victoria           | Australia | -37.8142155 | 144.96323069999994 | Melbourne VIC, Australia        |
      | 044785c67d3ee62545861361f8173af6c02f4fae | ChIJP3Sa8ziYEmsRUKgyFmh9AQM | Sydney      | New South Wales    | Australia | -33.8674869 | 151.20699020000006 | Sydney NSW, Australia           |
      |                                          | ChIJP7Mmxcc1t2oRQMaOYlQ2AwQ | Adelaide    | South Australia    | Australia | -34.9285894 | 138.5999429        |                                 |
      |                                          | ChIJc9U7KdW6MioR4E7fNbXwBAU | Perth       | Western Australia  | Australia | -31.9535959 | 115.8570118        | Perth WA, Australia             |
      |                                          | ChIJPwRZn_ygwCwRIHwkKqgXAgM | Darwin      | Northern Territory | Australia | -12.4628271 | 130.8417772        | Darwin NT, Australia            |
      |                                          | ChIJrUX0neFC1moRoOeMIXVWBAU | Collingwood | Victoria           | Australia | -37.8031231 | 144.9836514        | Collingwood VIC 3066, Australia |
      |                                          | ChIJm4WGJS9o1moRgOiMIXVWBAU | South Yarra | Victoria           | Australia | -37.8400982 | 144.9954424        | South Yarra VIC, Australia      |
# ----------------------------------------------------------------------------------------------------------

    And the following "opportunity" exists
      | id | type             | status    | headline  | owningCompany | profession | owningUser | approver | inviteOnly | industrySector | practiceArea | locations |
      | 1  | clientSecondment | published | sec.opp1  | 1             | 1          | 2          | 4        | 0          | 1,2            | 1            | 1         |
      | 2  | clientSecondment | published | sec.opp2  | 1             | 1          | 2          | 4        | 0          | 1              | 1            | 1         |
      | 3  | clientSecondment | published | sec.opp3  | 1             | 1          | 3          | 4        | 0          | 3              |              | 6         |
      | 4  | clientSecondment | published | sec.opp4  | 1             | 1          | 3          | 4        | 0          | 2              |              | 7         |
      | 5  | clientSecondment | published | sec.opp5  | 1             | 1          | 3          | 4        | 0          | 2              |              | 2         |
      | 6  | clientSecondment | published | sec.opp6  | 1             | 1          | 3          | 4        | 0          |                |              | 3         |
      | 7  | clientSecondment | published | sec.opp7  | 1             | 1          | 3          | 4        | 0          |                | 3            | 3         |
      | 8  | clientSecondment | published | sec.opp8  | 2             | 1          | 3          | 4        | 0          |                |              | 4         |
      | 9  | clientSecondment | published | sec.opp9  | 2             | 1          | 3          | 4        | 0          |                |              | 5         |
      | 10 | clientSecondment | published | sec.opp10 | 2             | 1          | 3          | 4        | 0          |                | 2            | 6         |
      | 11 | clientSecondment | published | sec.opp11 | 2             | 1          | 3          | 4        | 0          |                | 2            | 2         |
      | 12 | clientSecondment | published | sec.opp12 | 2             | 1          | 3          | 4        | 0          |                |              | 2         |

    And the following "opportunityGroup" exists
      | opportunity | seniority | languages |
      | 1           | 1         | 5         |
      | 1           | 2         |           |
      | 2           | 1         |           |
      | 3           | 4         |           |
      | 4           | 2         |           |
      | 5           | 3         | 1         |
      | 6           | 5         | 1         |
      | 7           | 2         | 1         |
      | 7           | 2         | 1         |
      | 8           | 1         | 1         |
      | 9           | 1         | 1         |
      | 9           | 4         | 1         |
      | 10          | 4         | 1         |
      | 10          | 3         |           |
      | 10          | 5         |           |
      | 11          | 3         |           |
      | 11          | 3         |           |

    And I am authenticating as "offer.offer@sink.sendgrid.net"

#  Scenario: - Search secondment opportunity in marketplace (Only proof of concepts)
#    Given I send a GET request to "opportunity/secondment?location={"state":"Victoria","country":"Australia"}"
#  --> it doesn't work because "" break the function on Behat. Test only via Postman or any other rest client.

  Scenario: 1 - List view secondment opportunity in marketplace
    Given I send a GET request to "opportunity?profession=1&inviteOnly=0"
    Then the response code should be 200
    And I get "11" results
    And result 1 contains "id" "1"
    And result 2 contains "id" "2"


  Scenario: 2 - Search market place by different parameters
    When I send a GET request to "opportunity?profession=1&inviteOnly=0&seniorities=5"
    And I get "2" results
    And result 1 contains "id" "6"
    And result 2 contains "id" "10"

    When I send a GET request to "opportunity?profession=1&inviteOnly=0&companies=2"
    And I get "4" results
    And result 1 contains "id" "8"
    And result 2 contains "id" "9"
    And result 3 contains "id" "10"
    And result 4 contains "id" "11"

    When I send a GET request to "opportunity?profession=1&inviteOnly=0&companies=1,2"
    And I get "11" results

    When I send a GET request to "opportunity?profession=1&inviteOnly=0&languages=1"
    And I get "6" results
    And result 1 contains "id" "5"
    And result 2 contains "id" "6"
    And result 3 contains "id" "7"
    And result 4 contains "id" "8"
    And result 5 contains "id" "9"
    And result 6 contains "id" "10"

    When I send a GET request to "opportunity?profession=1&inviteOnly=0&languages=1,5"
    And I get "7" results
    And result 1 contains "id" "1"
    And result 2 contains "id" "5"
    And result 3 contains "id" "6"
    And result 4 contains "id" "7"
    And result 5 contains "id" "8"
    And result 6 contains "id" "9"
    And result 7 contains "id" "10"

    When I send a GET request to "opportunity?profession=1&inviteOnly=0&industrySectors=1"
    And I get "2" results
    And result 1 contains "id" "1"
    And result 2 contains "id" "2"

    When I send a GET request to "opportunity?profession=1&inviteOnly=0&industrySectors=1,2"
    And I get "4" results
    And result 1 contains "id" "1"
    And result 2 contains "id" "2"
    And result 3 contains "id" "4"
    And result 4 contains "id" "5"

    When I send a GET request to "opportunity?profession=1&inviteOnly=0&practiceAreas=1"
    And I get "2" results
    And result 1 contains "id" "1"
    And result 2 contains "id" "2"

    When I send a GET request to "opportunity?profession=1&inviteOnly=0&practiceAreas=1,3"
    And I get "3" results
    And result 1 contains "id" "1"
    And result 2 contains "id" "2"
    And result 3 contains "id" "7"

    When I send a GET request to "opportunity?profession=1&inviteOnly=0&companies=2&languages=1&practiceAreas=2"
    And I get "1" result
    And result 1 contains "id" "10"
