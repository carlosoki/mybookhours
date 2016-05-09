@user
Feature: Add a new User or update an existing User, Roles test.
  In order to validate users roles and permissions
  As a corporate user Authenticated

  Rules:
  | ROLE            | GET  | POST   | PUT    | DELETE  |
  | ROLE_USER       | yes  | no     | no     | no      |
  | ROLE_ADMIN      | yes  | yes    | yes    | yes     |
  | ROLE_USER_WRITE | yes  | yes    | yes    | yes     |

  Background:
    Given I loadConstants

    And the following "companies" exist
      | name                    | profession| description      | service  | registered |
      | DLA Piper               | 1         | test description | 1        | 1          |
      | Herbert Smith Freehills | 1         | test description | 1        |            |

    And the following "users" exist
      | email                                 | roles                            | company | profession | password | activity | offices |
      | read.dlapiper@sink.sendgrid.net       |                                  | 1       | 1,2        | 123      | 1        |         |
      | userwriter.dlapiper@sink.sendgrid.net | ROLE_USER_WRITE,ROLE_OFFER_WRITE | 1       | 1          | 123      | 1        | 1       |
      | admin.persuit@sink.sendgrid.net       | ROLE_ADMIN                       |         | 1,2        | 123      | 1        |         |
      | othercompany.hsf@sink.sendgrid.net    | ROLE_OPP_WRITE,ROLE_OPP_PUBLISH  | 2       | 1          | 123      | 1        |         |

    Scenario Outline:
      ROLE_USER_WRITE can view/update/create/delete User from same company.
      ROLE_ADMIN can view/update/create/delete any user
      Given I am authenticating as "<user>" with "<password>" password
      When I send a <method> request to "<url>" with body:
      """
        <json>
      """
      Then the response code should be <code>
      #NB ROLE_ADMIN tested in user-add-update-delete.feature
      Examples:
        | user                                   | password | method | url    | json  | code |
        | userwriter.dlapiper@sink.sendgrid.net  | 123      | GET    | user/4 | {}    | 403  |
        | userwriter.dlapiper@sink.sendgrid.net  | 123      | GET    | user/1 | {}    | 200  |
        | userwriter.dlapiper@sink.sendgrid.net  | 123      | DELETE | user/4 | {}    | 403  |
        | userwriter.dlapiper@sink.sendgrid.net  | 123      | PUT    | user/4 | {}    | 403  |
        | admin.persuit@sink.sendgrid.net        | 123      | GET    | user/4 | {}    | 200  |
        | admin.persuit@sink.sendgrid.net        | 123      | GET    | user/1 | {}    | 200  |
        | admin.persuit@sink.sendgrid.net        | 123      | DELETE | user/4 | {}    | 204  |
        | userwriter.dlapiper@sink.sendgrid.net  | 123      | POST   | user   | {"firstName":"John","lastName":"Jones","phone":"04509909887","email":"newbiewerqre.hsf@sink.sendgrid.net","professions":[{"id":1}],"activity":{"id":1},"roles":["ROLE_USER_WRITE"],"company":{"id":1}} | 201  |
