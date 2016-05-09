@company @acl
Feature: Add a new Company or update an existing Company
  In order to validate users roles and permissions
  As a corporate user Authenticated

  Rules:
  | ROLE            | GET  | POST   | PUT    | DELETE  |
  | ROLE_ADMIN      | yes  | yes    | yes    | no      |
  | ROLE_USER       | yes  | no     | no     | no      |

  Background:
    Given I loadConstants

    And the following "users" exist
      | email                                 | roles                                | company | profession | password | activity | offices |
      | admin.persuit@sink.sendgrid.net       | ROLE_ADMIN                           |         | 1,2        | 123      | 1        |         |
      | userwriter.dlapiper@sink.sendgrid.net | ROLE_USER_WRITE,ROLE_OPP_OFFER_WRITE | 1       | 1          | 123      | 1        | 1       |

    And the following "companies" exist
      | name                    | profession  | description      | service  | registered |
      | K\&L Gates              | 1           | test description | 1        |            |

    Scenario Outline:
      ROLE_ADMIN can view/update/create any company
      Given I am authenticating as "<user>" with "<password>" password
      When I send a <method> request to "<url>" with body:
      """
        <json>
      """
      Then the response code should be <code>
      #NB ROLE_ADMIN tested in user-add-update-delete.feature
      Examples:
        | user                                  | password | method | url       | json | code |
        | userwriter.dlapiper@sink.sendgrid.net | 123      | GET    | company/1 | {}   | 200  |
        | userwriter.dlapiper@sink.sendgrid.net | 123      | GET    | companies | {}   | 200  |
        | userwriter.dlapiper@sink.sendgrid.net | 123      | PUT    | company/1 | {}   | 403  |
        | userwriter.dlapiper@sink.sendgrid.net | 123      | POST   | company   | {}   | 403  |
        | admin.persuit@sink.sendgrid.net       | 123      | GET    | company/1 | {}   | 200  |
        | admin.persuit@sink.sendgrid.net       | 123      | GET    | companies | {}   | 200  |

