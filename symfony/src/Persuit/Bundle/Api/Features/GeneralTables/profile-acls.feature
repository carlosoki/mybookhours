@profile
Feature: ACL for profile
  In order to validate users roles and permissions
  As a corporate user Authenticated

  Rules:
  | ROLE            | GET  | POST   | PUT    | DELETE  |
  | ROLE_ADMIN      | yes  | yes    | yes    | no      |
  | ROLE_USER       | yes  | no     | no     | no      |

  Background:
    Given I loadDB

    And the following "Profile" exist
      | id | firstName | initial | lastName  | availableForSecondment | availableForSecondmentFrom | availableForSecondmentTo | indicativeMonthlyRate | currentJobTitle | profession | company | seniority | language | practiceArea | practiceSubArea | industrySector | industrySubSector | secondmentLocations | admittedToPracticeLocations |
      | 1  | Benjamin  | J       | Mooney    | 1                      | 2015-01-01                 | 2016-01-01               | 21000                 | Janitor         | 1          | 3       | 1         | 3        |              |                 |                |                   |                     |                             |
      | 2  | Frank     |         | Smith     | 1                      | 2015-01-02                 | 2016-01-01               | 15000                 | Vice President  | 1          | 3       | 1         |          |              |                 |                |                   |                     |                             |
      | 3  | Paul      | P       | Jones     | 0                      | 2015-01-03                 | 2016-01-01               | 20000                 | Senior Dev      | 1          | 3       | 1         |          |              |                 |                |                   |                     |                             |
      | 4  | Sven      |         | Ulrick    | 1                      | 2015-01-01                 | 2016-01-01               | 19000                 |                 | 2          | 6       | 10        | 6        |              |                 |                |                   |                     |                             |
      | 5  | Stina     |         | Inngvar   | 1                      |                            |                          | 17000                 | Backend Dev     | 2          | 6       | 10        | 6        |              |                 |                |                   |                     |                             |
      | 6  | Tuve      | J       | Inngen    | 1                      | 2015-01-01                 | 2015-06-01               | 18000                 |                 | 2          | 6       | 10        | 6        |              |                 |                |                   |                     |                             |
      | 7  | Rebecca   |         | Lock      | 0                      | 2015-01-01                 | 2015-06-01               | 25000                 | CEO             | 1          | 1       | 1         |          |              |                 |                |                   |                     |                             |
      | 8  | Matthew   | T       | Pollock   | 0                      | 2015-01-01                 | 2015-06-01               | 2000                  |                 | 1          | 1       | 1         |          |              |                 |                |                   |                     |                             |
      | 9  | Jackson   | I       | Pollock   | 0                      |                            |                          | 21000                 |                 | 2          | 21      | 12        |          |              |                 |                |                   |                     |                             |
      | 10 | Andreas   | P       | Inniesta  | 1                      |                            |                          | 2000                  |                 | 2          | 21      | 12        |          | 4            | 5               | 1              | 1                 | 1                   | 1                           |
      | 11 | Innès     |         | Gunnar    | 1                      |                            |                          | 24000                 |                 | 2          | 21      | 16        |          |              |                 |                |                   |                     |                             |
      | 12 | Matias    |         | Oinni     | 1                      |                            |                          | 60000                 |                 | 2          | 19      | 12        | 5        |              |                 |                |                   |                     |                             |
      | 13 | Ebba      | F       | Larsen    | 1                      |                            |                          | 40000                 |                 | 2          | 19      | 16        |          |              |                 |                |                   |                     |                             |
      | 14 | Oskar     | Z       | Berg      | 0                      |                            |                          | 20000                 |                 | 2          | 19      | 17        | 5        |              |                 |                |                   |                     |                             |
      | 15 | Alinna    | Z       | Nop       | 1                      |                            |                          | 1000                  |                 | 2          | 21      | 15        |          | 4            | 6               | 1              | 1                 | 1                   |                             |
      | 16 | Frank     | Y       | Innazy    | 0                      |                            |                          | 9000                  |                 | 1          | 3       | 2         | 3,7      |              |                 |                |                   |                     |                             |
      | 17 | Andrew    |         | Innopolus | 1                      | 2015-01-01                 | 2017-01-01               | 2100                  |                 | 1          | 3       | 4         |          |              |                 |                |                   |                     |                             |
      | 18 | Yimmy     | X       | Inntut    | 0                      |                            |                          | 22000                 |                 | 2          | 20      | 15        |          | 4            | 6               | 1              | 1                 |                     |                             |
      | 19 | Yimmy     | X       | Noop      | 1                      | 2015-01-01                 | 2017-01-01               | 22000                 | Web Pleb        | 2          | 20      | 15        | 6,7      | 4            | 6               | 1              | 1                 | 2                   | 2                           |

    And the following "ProfileExtension" exist
      | id  | versionName         | professionalHeadline | professionalDetails           | default |
      | 1   | Tax Law             | Senior Lawyer        | 8 years experience with taxes | 1       |
      | 2   | Corporate Law       | Partner              | 25 years experience           | 0       |


    Scenario Outline:
    Example1 Suppliers with ROLE_PROFILE_WRITE can view/create/update/delete any Profile for a Company they belong to
      Given I am authenticating as "<user>" with "<password>" password
      When I send a <method> request to "<url>" with body:
        """
          <json>
        """
      Then the response code should be <code>
      Examples:
        | user                              | password | method | url       | code | json                                                                                                                                                                                                  |
        | write1.ashursts@sink.sendgrid.net | 123      | GET    | profile/1 | 200  | {}                                                                                                                                                                                                    |
        | write1.ashursts@sink.sendgrid.net | 123      | GET    | profile/2 | 200  | {}                                                                                                                                                                                                    |
        | write1.ashursts@sink.sendgrid.net | 123      | GET    | profile/5 | 403  | {}                                                                                                                                                                                                    |
        | write1.ashursts@sink.sendgrid.net | 123      | GET    | profile/6 | 403  | {}                                                                                                                                                                                                    |
        | write1.ashursts@sink.sendgrid.net | 123      | GET    | profiles  | 200  | {}                                                                                                                                                                                                    |
        | write1.ashursts@sink.sendgrid.net | 123      | POST   | profile   | 201  | {"profession": {"id":1}, "firstName": "benjamin", "lastName": "mooney", "seniority": {"id":1}, "profileExtensions":[{"versionName":"x","professionalHeadline":"y","professionalDetails":"z"}] } |
        | write1.ashursts@sink.sendgrid.net | 123      | PUT    | profile/1 | 200  | {"profession": {"id":1}, "firstName": "benjzzzz", "lastName": "moozzz", "seniority": {"id":1}, "profileExtensions":[{"versionName":"x","professionalHeadline":"y","professionalDetails":"z"}] } |
        | write1.ashursts@sink.sendgrid.net | 123      | DELETE | profile/1 | 204  | {}                                                                                                                                                                                                    |
        | write1.ashursts@sink.sendgrid.net | 123      | PUT    | profile/2 | 200  | {"profession": {"id":1}, "firstName": "benjzzzz", "lastName": "moozzz", "seniority": {"id":1}, "profileExtensions":[{"versionName":"x","professionalHeadline":"y","professionalDetails":"z"}] } |
        | write1.ashursts@sink.sendgrid.net | 123      | DELETE | profile/2 | 204  | {}                                                                                                                                                                                                    |
        | write1.ashursts@sink.sendgrid.net | 123      | PUT    | profile/5 | 403  | {"profession": {"id":1}, "firstName": "benjzzzz", "lastName": "moozzz", "seniority": {"id":1} }                                                                                                     |
        | write1.ashursts@sink.sendgrid.net | 123      | DELETE | profile/5 | 403  | {}                                                                                                                                                                                                    |
        | write1.ashursts@sink.sendgrid.net | 123      | PUT    | profile/6 | 403  | {"profession": {"id":1}, "firstName": "benjzzzz", "lastName": "moozzz", "seniority": {"id":1} }                                                                                                     |
        | write1.ashursts@sink.sendgrid.net | 123      | DELETE | profile/6 | 403  | {}                                                                                                                                                                                                    |

    Scenario Outline:
    Example2 Suppliers with ROLE_PROFILE_WRITE can view/create/update/delete any Profile for a Company they belong to
      Given I am authenticating as "<user>" with "<password>" password
      When I send a <method> request to "<url>" with body:
            """
              <json>
            """
      Then the response code should be <code>
      Examples:
        | user                                  | password | method | url       | code | json                                                                                                                                                                                                |
        | write.bakermckenzie@sink.sendgrid.net | 123      | GET    | profile/1 | 403  | {}                                                                                                                                                                                                  |
        | write.bakermckenzie@sink.sendgrid.net | 123      | GET    | profile/2 | 403  | {}                                                                                                                                                                                                  |
        | write.bakermckenzie@sink.sendgrid.net | 123      | GET    | profile/5 | 200  | {}                                                                                                                                                                                                  |
        | write.bakermckenzie@sink.sendgrid.net | 123      | GET    | profile/6 | 200  | {}                                                                                                                                                                                                  |
        | write.bakermckenzie@sink.sendgrid.net | 123      | GET    | profiles  | 200  | {}                                                                                                                                                                                                  |
        | write.bakermckenzie@sink.sendgrid.net | 123      | POST   | profile   | 201  | {"profession": {"id":1}, "firstName": "Frankee", "lastName": "Jones", "seniority": {"id":2}, "profileExtensions":[{"versionName":"x","professionalHeadline":"y","professionalDetails":"z"}] } |
        | write.bakermckenzie@sink.sendgrid.net | 123      | PUT    | profile/1 | 403  | {"profession": {"id":1}, "firstName": "Frankee", "lastName": "Jones", "seniority": {"id":2} }                                                                                                     |
        | write.bakermckenzie@sink.sendgrid.net | 123      | DELETE | profile/1 | 403  | {}                                                                                                                                                                                                  |
        | write.bakermckenzie@sink.sendgrid.net | 123      | PUT    | profile/2 | 403  | {"profession": {"id":1}, "firstName": "Frankee", "lastName": "Jones", "seniority": {"id":2} }                                                                                                     |
        | write.bakermckenzie@sink.sendgrid.net | 123      | DELETE | profile/2 | 403  | {}                                                                                                                                                                                                  |
        | write.bakermckenzie@sink.sendgrid.net | 123      | PUT    | profile/5 | 200  | {"profession": {"id":1}, "firstName": "Frankee", "lastName": "Jones", "seniority": {"id":2}, "profileExtensions":[{"versionName":"x","professionalHeadline":"y","professionalDetails":"z"}] } |
        | write.bakermckenzie@sink.sendgrid.net | 123      | DELETE | profile/5 | 204  | {}                                                                                                                                                                                                  |
        | write.bakermckenzie@sink.sendgrid.net | 123      | PUT    | profile/6 | 200  | {"profession": {"id":1}, "firstName": "Frankee", "lastName": "Jones", "seniority": {"id":2}, "profileExtensions":[{"versionName":"x","professionalHeadline":"y","professionalDetails":"z"}] } |
        | write.bakermckenzie@sink.sendgrid.net | 123      | DELETE | profile/6 | 204  | {}                                                                                                                                                                                                  |

    Scenario Outline:
    Suppliers with ROLE_USER can only view a Profile for a Company they belong to
      Given I am authenticating as "<user>" with "<password>" password
      When I send a <method> request to "<url>" with body:
        """
          <json>
        """
      Then the response code should be <code>
      Examples:
        | user                            | password | method | url       | code | json                                                                                              |
        | read.ashursts@sink.sendgrid.net | 123      | GET    | profile/1 | 200  | {}                                                                                                |
        | read.ashursts@sink.sendgrid.net | 123      | GET    | profile/2 | 200  | {}                                                                                                |
        | read.ashursts@sink.sendgrid.net | 123      | GET    | profile/5 | 403  | {}                                                                                                |
        | read.ashursts@sink.sendgrid.net | 123      | GET    | profile/6 | 403  | {}                                                                                                |
        | read.ashursts@sink.sendgrid.net | 123      | GET    | profiles  | 200  | {}                                                                                                |
        | read.ashursts@sink.sendgrid.net | 123      | POST   | profile   | 403  | {"profession": {"id":1}, "firstName": "benjamin", "lastName": "mooney", "seniority": {"id":1} } |
        | read.ashursts@sink.sendgrid.net | 123      | PUT    | profile/1 | 403  | {"profession": {"id":1}, "firstName": "benjzzzz", "lastName": "moozzz", "seniority": {"id":1} } |
        | read.ashursts@sink.sendgrid.net | 123      | DELETE | profile/1 | 403  | {}                                                                                                |
        | read.ashursts@sink.sendgrid.net | 123      | PUT    | profile/2 | 403  | {"profession": {"id":1}, "firstName": "benjzzzz", "lastName": "moozzz", "seniority": {"id":1} } |
        | read.ashursts@sink.sendgrid.net | 123      | DELETE | profile/2 | 403  | {}                                                                                                |
        | read.ashursts@sink.sendgrid.net | 123      | PUT    | profile/5 | 403  | {"profession": {"id":1}, "firstName": "benjzzzz", "lastName": "moozzz", "seniority": {"id":1} } |
        | read.ashursts@sink.sendgrid.net | 123      | DELETE | profile/5 | 403  | {}                                                                                                |
        | read.ashursts@sink.sendgrid.net | 123      | PUT    | profile/6 | 403  | {"profession": {"id":1}, "firstName": "benjzzzz", "lastName": "moozzz", "seniority": {"id":1} } |
        | read.ashursts@sink.sendgrid.net | 123      | DELETE | profile/6 | 403  | {}                                                                                                |


    Scenario Outline:
    Requesters even with ROLE_PROFILE_WRITE can NOT create/update/delete any Profiles for any Companies
      Given I am authenticating as "<user>" with "<password>" password
      When I send a <method> request to "<url>" with body:
          """
            <json>
          """
      Then the response code should be <code>
      Examples:
        | user                           | password | method | url       | code | json                                                                                            |
        | write.bhp@sink.sendgrid.net    | 123      | GET    | profile/1 | 200  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | GET    | profile/2 | 200  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | GET    | profile/5 | 200  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | GET    | profile/6 | 200  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | GET    | profiles  | 200  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | POST   | profile   | 403  | {"profession": {"id":1}, "firstName": "Frankee", "lastName": "Jones", "seniority": {"id":2} } |
        | write.bhp@sink.sendgrid.net    | 123      | PUT    | profile/1 | 403  | {"profession": {"id":1}, "firstName": "Frankee", "lastName": "Jones", "seniority": {"id":2} } |
        | write.bhp@sink.sendgrid.net    | 123      | DELETE | profile/1 | 403  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | PUT    | profile/2 | 403  | {"profession": {"id":1}, "firstName": "Frankee", "lastName": "Jones", "seniority": {"id":2} } |
        | write.bhp@sink.sendgrid.net    | 123      | DELETE | profile/2 | 403  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | PUT    | profile/5 | 403  | {"profession": {"id":1}, "firstName": "Frankee", "lastName": "Jones", "seniority": {"id":2} } |
        | write.bhp@sink.sendgrid.net    | 123      | DELETE | profile/5 | 403  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | PUT    | profile/6 | 403  | {"profession": {"id":1}, "firstName": "Frankee", "lastName": "Jones", "seniority": {"id":2} } |
        | write.bhp@sink.sendgrid.net    | 123      | DELETE | profile/6 | 403  | {}                                                                                              |

    Scenario Outline:
    Requesters with ROLE_USER can only view any Profile
      Given I am authenticating as "<user>" with "<password>" password
      When I send a <method> request to "<url>" with body:
            """
              <json>
            """
      Then the response code should be <code>
      Examples:
        | user                           | password | method | url       | code | json                                                                                            |
        | write.bhp@sink.sendgrid.net    | 123      | GET    | profile/1 | 200  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | GET    | profile/2 | 200  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | GET    | profile/3 | 200  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | GET    | profile/4 | 200  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | GET    | profile/5 | 200  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | GET    | profile/6 | 200  | {}                                                                                              |
        | write.bhp@sink.sendgrid.net    | 123      | GET    | profiles  | 200  | {}                                                                                              |


    Scenario Outline:
    Supplier and Requester Users should expect different Profiles to be returned on fetching all Profiles
      Given I am authenticating as "<user>" with "<password>" password
      When I send a <method> request to "<url>" with body:
          """
            <json>
          """
      Then the response code should be <code>
      And result has "totalRowCount" <profileCount>
      Examples:
        | user                                    | password | method | url       | code | profileCount |
        | write1.ashursts@sink.sendgrid.net       | 123      | GET    | profiles  | 200  | 5             |
        | write.bakermckenzie@sink.sendgrid.net   | 123      | GET    | profiles  | 200  | 0             |
        | read.ashursts@sink.sendgrid.net         | 123      | GET    | profiles  | 200  | 5             |
        | write.bhp@sink.sendgrid.net             | 123      | GET    | profiles  | 200  | 19            |