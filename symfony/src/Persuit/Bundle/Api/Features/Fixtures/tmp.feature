@fixture @tmp
Feature: ACL for secondment opportunity
  In order to validate users roles and permissions
  As a corporate user Authenticated

  Rules:
  | ROLE                            | VIEW | CREATE | UPDATE | PUBLISH |
  | ROLE_USER                       | yes  | no     | no     | no      |
  | ROLE_OPP_WRITE                  | yes  | yes    | yes    | no      |
  | ROLE_OPP_PUBLISH                | yes  | yes    | yes    | yes     |
  | ROLE_ADMIN                      | yes  | yes    | yes    | yes     |

  Background:
    Given I loadDB

    And the following "opportunity" exist
      | id | type       | status    | headline  | owning_company | profession | owning_user | approver |
      | 1  | secondment | draft     | SEC.OPP 1 | 1              | 1          | 3           | 4        |
      | 2  | secondment | draft     | SEC.OPP 2 | 2              | 1          | 5           |          |
      | 3  | secondment | published | SEC.OPP 3 | 1              | 1          | 3           | 4        |
      | 4  | secondment | published | SEC.OPP 4 | 23             | 1          | 13          | 14       |

  Scenario: Successful GET returns response