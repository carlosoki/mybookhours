@office @acl
Feature: Add a new LegalEntity or update an existing LegalEntity
  In order to validate users roles and permissions
  As a corporate user Authenticated

  Rules:
  | ROLE            | GET  | POST   | PUT    | DELETE  |
  | ROLE_ADMIN      | yes  | yes    | yes    | no      |
  | ROLE_USER       | yes  | no     | no     | no      |

  Background:
    Given I loadConstants

    And the following "companies" exist
      | name                    | profession  | description      | service  | registered |
      | DLA Piper               | 1           | test description | 1        | 1          |

    And the following "legalEntities" exist
      | company     | name                  | tax | billingStreet1  | billingCity | billingZip | billingCountry  | billingEmail  | billingPhone |
      | 1           | DLA PTY               | 0.1 | 10 Smith St     | Melbourne   | 3000       | Australia       | test@test.com | 092834239824 |

    And the following "offices" exist
      | company     | legalEntity | name                |
      | 1           | 1           | DLA Sydney          |

    And the following "users" exist
      | email                                 | roles                            | company | profession | password | activity | offices |
      | admin.persuit@sink.sendgrid.net       | ROLE_ADMIN                       |         | 1,2        | 123      | 1        |         |
      | userwriter.dlapiper@sink.sendgrid.net | ROLE_USER_WRITE,ROLE_OFFER_WRITE | 1       | 1          | 123      | 1        | 1       |


    Scenario Outline:
      ROLE_ADMIN can view/update/create any Office
      Given I am authenticating as "<user>" with "<password>" password
      When I send a <method> request to "<url>" with body:
      """
        <json>
      """
      Then the response code should be <code>
      #NB ROLE_ADMIN tested in user-add-update-delete.feature
      Examples:
        | user                                  | password | method | url      | json | code |
        | userwriter.dlapiper@sink.sendgrid.net | 123      | GET    | office/1 | {}   | 200  |
        | userwriter.dlapiper@sink.sendgrid.net | 123      | GET    | offices  | {}   | 200  |
        | userwriter.dlapiper@sink.sendgrid.net | 123      | PUT    | office/1 | {}   | 403  |
        | userwriter.dlapiper@sink.sendgrid.net | 123      | POST   | office   | {}   | 403  |
        | admin.persuit@sink.sendgrid.net       | 123      | GET    | office/1 | {}   | 200  |
        | admin.persuit@sink.sendgrid.net       | 123      | GET    | offices  | {}   | 200  |

