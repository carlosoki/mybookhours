@opportunity @automated-status
Feature: Change status of Published/Deal Time Secondment Opportunity
  After 21 days published the secondment opportunity will be closed if there are no Offers
  Or, extended for more 7 days in Deal Time when the secondment opportunity has offers.
  If the secondment oppoutunity is in Deal Time after 7 days it will be closed.

  Rules:
  - OpportunityStatusesCommand running @hourly
  - crontab -e 0 * * * * php /var/www/api/symfony/app/console crontasks:run
  - When the sec. opp is published and there is no offer, the system will close it.
  - Nothing to close (Scenario 2)
  - When the sec. opp is published and there are offers, the system will change the status to Deal Time.
  - When the sec. opp is in Deal Time, the system will close it.

  Background:
    Given I loadDB

    Given the following "opportunity" exists
      | id | type             | status    | headline  | owningCompany | profession | owningUser | approver | publishDuration | automatedStatus  |
      | 1  | clientSecondment | published | Sec.Opp1  | 1             | 1          | 2          | 4        | 5               | 1                |
      | 2  | clientSecondment | published | Sec.Opp2  | 1             | 1          | 2          | 4        | 5               | 1                |
      | 3  | clientSecondment | published | Sec.Opp3  | 1             | 1          | 4          |          | 5               | 1                |
      | 4  | clientSecondment | published | Sec.Opp4  | 1             | 1          | 4          |          | 5               | 1                |
      | 5  | clientSecondment | published | Sec.Opp5  | 1             | 1          | 4          |          | 5               | 1                |
      | 6  | clientSecondment | dealtime  | Sec.Opp6  | 1             | 1          | 4          |          | 5               | 1                |
      | 7  | clientSecondment | dealtime  | Sec.Opp7  | 1             | 1          | 4          |          | 5               | 1                |
      | 8  | clientSecondment | dealtime  | Sec.Opp8  | 1             | 1          | 4          |          | 5               | 1                |
      | 9  | clientSecondment | dealtime  | Sec.Opp9  | 1             | 1          | 4          |          | 5               | 1                |
      | 10 | clientSecondment | dealtime  | Sec.Opp10 | 1             | 1          | 4          |          | 5               | 1                |

    And the following "OfferClientSecondment" exist
      | status         | opportunity | type       | company | createdBy  | total |
      | draft          | 1           | secondment | 3       | 20         | 1000  |
      | published      | 2           | secondment | 3       | 21         | 1000  |
      | published      | 3           | secondment | 3       | 21         | 1000  |
      | published      | 4           | secondment | 3       | 21         | 1000  |
      | published      | 4           | secondment | 21      | 24         | 1000  |

    Given I am authenticating as "publish.dlapiper@sink.sendgrid.net"

  Scenario: 1 - When the opportunity is published and there is no offer, the system will close it
#    Given I run CronJob
#    Then I send a GET request to "opportunity"
#    And I get "10" results
#    And result 1 contains "id" "1"
#    And result 1 contains "status" "closed"
#    And result 2 contains "id" "2"
#    And result 2 contains "status" "dealtime"
#    And result 3 contains "id" "3"
#    And result 3 contains "status" "dealtime"
#    And result 4 contains "id" "4"
#    And result 4 contains "status" "dealtime"
#    And result 5 contains "id" "5"
#    And result 5 contains "status" "closed"
#    And result 6 contains "id" "6"
#    And result 6 contains "status" "closed"
#    And result 7 contains "id" "7"
#    And result 7 contains "status" "closed"
#    And result 8 contains "id" "8"
#    And result 8 contains "status" "closed"
#    And result 9 contains "id" "9"
#    And result 9 contains "status" "closed"
#    And result 10 contains "id" "10"
#    And result 10 contains "status" "closed"