@fixture @general-tables
Feature: This feature is to populate the fixed Tables on databases
  The target tables are:
  Company; language; Currency; industry_sector;
  job_title; practice_area; practice_subarea; profession;
  seniority; activity; LegalEntity

  Background:

    Given the following "profession" exist
      | id | name                  |
      | 1  | Legal                 |
      | 2  | Accounting            |
      | 3  | Consulting            |

    And the following "activity" exist
      | id | name      |
      | 1  | Requester |
      | 2  | Supplier  |

    And the following "service" exist
      | id | profession | activity |
      | 1  | 1          | 1        |
      | 2  | 1          | 2        |
      | 3  | 2          | 1        |
      | 4  | 2          | 2        |

    And the following "companies" exist
      | name                    | profession | description      | service  | registered |
      | DLA Piper               | 1          | test description | 1        | 1          |
      | Herbert Smith Freehills | 1          | test description | 1        |            |
      | Ashursts                | 1          | test description | 1,2      | 1          |
      | KWM                     | 1          | test description | 1        |            |
      | K\&L Gates              | 1          | test description | 1        |            |
      | Baker \& McKenzie       | 1          | test description | 1,2      |            |
      | Norton Rose Fulbright   | 1          | test description | 1        |            |
      | Minter Ellison          | 1          | test description | 1        |            |
      | Clayton Utz             | 1          | test description | 1        |            |
      | Corrs                   | 1          | test description | 1        |            |
      | Allens                  | 1          | test description | 1        |            |
      | Holman Fenwick William  | 1          | test description | 1        |            |
      | Jones Day               | 1          | test description | 1        |            |
      | HWL Ebsworth            | 1          | test description | 1        |            |
      | Gibert \& Tobin         | 1          | test description | 1        |            |
      | Clifford Chance         | 1          | test description | 1        |            |
      | Allen \& Overy          | 1          | test description | 1        |            |
      | Piper Alderman          | 1          | test description | 1        |            |
      | KPMG                    | 1          | test description | 4        |            |
      | Deloitte                | 1          | test description | 4        |            |
      | PwC                     | 1          | test description | 4        |            |
      | Ernst \& Young          | 1          | test description | 4        |            |
      | BHP                     | 1          | test description | 1        |            |
      | Rio Tinto               | 1          | test description | 1        |            |
      | Glencore Xstrata        | 1          | test description | 1        |            |
      | a                       | 1          | test description | 2        | 1          |
      | b                       | 1          | test description | 2        |1           |
      | c                       | 1          | test description | 2        |1           |
      | e                       | 1          | test description | 2        |1           |
      | f                       | 1          | test description | 2        |1           |
      | g                       | 1          | test description | 2        |1           |
      | h                       | 1          | test description | 2        |1           |
      | i                       | 1          | test description | 2        |1           |

    And the following "legalEntities" exist
      | company     | name                  | tax | billingStreet1  | billingCity | billingZip | billingCountry  | billingEmail  | billingPhone |
      | 1           | DLA PTY               | 0.1 | 10 Smith St     | Melbourne   | 3000       | Australia       | test@test.com | 092834239824 |
      | 3           | Ashursts PTY LTD INC  | 0.2 | 1234 Bourke St  | Sydney      | 2100       | Australia       | asdf@test.com | 19823471324  |

    And the following "offices" exist
      | company     | legalEntity | name                |
      | 1           | 1           | DLA Sydney          |
      | 1           | 1           | DLA Melbourne       |
      | 3           | 2           | Ashursts Sydney     |
      | 3           | 2           | Ashursts Melbourne  |
      | 26          | 1           | a 1                 |
      | 26          | 1           | a 2                 |
      | 27          | 1           | b                   |
      | 28          | 1           | c                   |

    And the following "users" exist
      | email                                  | roles                               | company | profession | password | activity | offices |
      | read.dlapiper@sink.sendgrid.net        |                                     | 1       | 1,2        | 123      | 1        |         |
      | write.dlapiper@sink.sendgrid.net       | ROLE_OPP_WRITE                      | 1       | 1          | 123      | 1        |         |
      | write1.dlapiper@sink.sendgrid.net      | ROLE_OPP_WRITE,ROLE_PROFILE_WRITE   | 1       | 1,2        | 123      | 1        |         |
      | publish.dlapiper@sink.sendgrid.net     | ROLE_OPP_WRITE,ROLE_OPP_PUBLISH     | 1       | 1,2        | 123      | 1        |         |
      | othercompany.hsf@sink.sendgrid.net     | ROLE_OPP_WRITE,ROLE_OPP_PUBLISH     | 2       | 1          | 123      | 1        |         |
      | write.hsf@sink.sendgrid.net            | ROLE_OPP_WRITE                      | 2       | 1          | 123      | 1        |         |
      | write2.hsf@sink.sendgrid.net           | ROLE_OPP_WRITE,ROLE_PROFILE_WRITE   | 2       | 1          | 123      | 1        |         |
      | admin.persuit@sink.sendgrid.net        | ROLE_ADMIN                          |         | 1,2        | 123      | 1        |         |
      | userwriter.dlapiper@sink.sendgrid.net  | ROLE_USER_WRITE,ROLE_OFFER_WRITE    | 1       | 1          | 123      | 1        | 1       |
      | read.pwc@sink.sendgrid.net             |                                     | 21      | 2          | 123      | 2        |         |
      | write.pwc@sink.sendgrid.net            | ROLE_OPP_WRITE,ROLE_PROFILE_WRITE   | 21      | 2          | 123      | 2        |         |
      | read.bhp@sink.sendgrid.net             |                                     | 23      | 1,2        | 123      | 1        |         |
      | write.bhp@sink.sendgrid.net            | ROLE_OPP_WRITE,ROLE_PROFILE_WRITE   | 23      | 1,2        | 123      | 1        |         |
      | publish.bhp@sink.sendgrid.net          | ROLE_OPP_WRITE,ROLE_OPP_PUBLISH     | 23      | 1,2        | 123      | 1        |         |
      | write1.bhp@sink.sendgrid.net           | ROLE_OPP_WRITE,ROLE_PROFILE_WRITE   | 23      | 1,2        | 123      | 1        |         |
      | read.ashursts@sink.sendgrid.net        |                                     | 3       | 1,2        | 123      | 2        |         |
      | write.ashursts@sink.sendgrid.net       | ROLE_OPP_WRITE                      | 3       | 1          | 123      | 2        |         |
      | write1.ashursts@sink.sendgrid.net      | ROLE_OPP_WRITE,ROLE_PROFILE_WRITE   | 3       | 1          | 123      | 2        |         |
      | write.bakermckenzie@sink.sendgrid.net  | ROLE_OFFER_WRITE,ROLE_PROFILE_WRITE | 6       | 1          | 123      | 2        |         |
      | offer.offer@sink.sendgrid.net          | ROLE_OFFER_WRITE                    | 3       | 1          | 123      | 2        | 3       |
      | offer1.offer@sink.sendgrid.net         | ROLE_OFFER_WRITE                    | 3       | 1          | 123      | 2        |         |
      | offer2.offer@sink.sendgrid.net         | ROLE_OFFER_WRITE,ROLE_USER_WRITE    | 3       | 1          | 123      | 2        |         |
      | write1.bakermckenzie@sink.sendgrid.net | ROLE_OFFER_WRITE                    | 6       | 1          | 123      | 2        |         |
      | offer.pwc@sink.sendgrid.net            | ROLE_OFFER_WRITE                    | 21      | 1,2        | 123      | 2        |         |
      | offer1.pwc@sink.sendgrid.net           | ROLE_OFFER_WRITE                    | 21      | 2          | 123      | 2        |         |
      | read.deloitte@sink.sendgrid.net        |                                     | 20      | 2          | 123      | 2        |         |
      | write.deloitte@sink.sendgrid.net       | ROLE_OPP_WRITE,ROLE_PROFILE_WRITE   | 20      | 2          | 123      | 2        |         |
      | read@sink.sendgrid.net                 |                                     | 26      | 1,2        | 123      | 2        | 5       |
      | offer@sink.sendgrid.net                | ROLE_OFFER_WRITE                    | 26      | 1          | 123      | 2        | 5       |

    And the following "languages" exist
      | id | name      | code |
      | 1  | English   | en   |
      | 2  | Georgian  | ka   |
      | 3  | Russian   | ru   |
      | 4  | French    | fr   |
      | 5  | German    | de   |
      | 6  | Swedish   | sv   |
      | 7  | Icelandic | is   |

    And the following "currencies" exist
      | id | name                             | code | symbol |
      | 1  | Australia Dollars                | AUD  | $      |
      | 2  | Pounds                           | GBP  | £      |
      | 3  | United States of America Dollars | USD  | $      |
      | 4  | Euro                             | EUR  | €      |

    And the following "IndustrySector" exist
      | name                                     |
      | Accounting                               |
      | Energy & Resources                       |
      | banks                                    |

    And the following "IndustrySubSector" exist
      | IndustrySector    | name                   |
      | 1                 | Account for tax return |
      | 2                 | Mining & Metals        |
      | 2                 | Oil & Gas              |
      | 2                 | Power                  |
      | 3                 | banks insurance        |

    And the following "JobTitle" exist
      | name                                           |
      | LBDO Consulting Senior Managing Director  CPA  |
      | Accountant                                     |
      | Commercial Manager (Procurement)               |
      | General Counsel - Legal                        |
      | Administrator, Human Resources Group Functions |
      | Enterprise Assistant                           |
      | Avocat à la Cour                               |
      | Leader Global M&A Consulting service line      |
      | US Nat'l Managing Principal Cyber Risk         |
      | Consultant corporate                           |

    And the following "PracticeArea" exist
      | id | profession  | name                      |
      | 1  | 1           | Abuse of Market Power     |
      | 2  | 1           | Accounting                |
      | 3  | 1           | Advertising and Marketing |
      | 4  | 2           | Tax                       |
      | 5  | 3           | Cyber                     |
      | 6  | 2           | Non Tax                   |

    And the following "PracticeSubArea" exist
      | id | practiceArea |  name                                  |
      | 1  | 1            |  Cartels \& Competition Investigations |
      | 2  | 1            |  Competition Law Compliance            |
      | 3  | 2            |  Account and marketing                 |
      | 4  | 4            |  Corporate Tax                         |
      | 5  | 5            |  Cyber Services                        |
      | 6  | 4            |  Some Other Tax                        |
      | 7  | 6            |  Taxi Waxi                             |

    And the following "Seniority" exist
      | id | name                                 | profession    |
      | 1  | Partner                              | 1             |
      | 2  | Legal Director                       | 1             |
      | 3  | Of Counsel                           | 1             |
      | 4  | Special Counsel                      | 1             |
      | 5  | Senior Associate                     | 1             |
      | 6  | Associate                            | 1             |
      | 7  | Junior Associate                     | 1             |
      | 8  | Trainee Solicitor                    | 1             |
      | 9  | Paralegal                            | 1             |
      | 10 | Staff Auditor                        | 2             |
      | 11 | Management Services/Consulting Staff | 2             |
      | 12 | Senior Auditor                       | 2             |
      | 13 | Tax Senior                           | 2             |
      | 14 | Audit Manager                        | 2             |
      | 15 | Tax Manager                          | 2             |
      | 16 | Partner                              | 2             |
      | 17 | Senior Partner                       | 2             |
      | 18 | Audit Committee Chair                | 2             |
      | 19 | Audit Committee Member               | 2             |

    And the following "LocationNotFromGoogle" exist
      | googleId                                 | placeId                     | city      | state           | country   | latitude    | longitude          | formattedAddress         |
      | b449cd4d6e7b95f0334503027ea90867a79929ab | ChIJgf0RD69C1moR4OeMIXVWBAU | Melbourne | Victoria        | Australia | -37.8142155 | 144.96323069999994 | Melbourne VIC, Australia |
      | 044785c67d3ee62545861361f8173af6c02f4fae | ChIJP3Sa8ziYEmsRUKgyFmh9AQM | Sydney    | New South Wales | Australia | -33.8674869 | 151.20699020000006 | Sydney NSW, Australia    |

    And the following "CronTask" exist
      | name                         | commands                          |
      | Automated published Statuses | php app/console crontasks:run     |

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
        | profile | versionName   | professionalHeadline | professionalDetails           | default |
        | 1       | Tax Law       | Senior Lawyer        | 8 years experience with taxes | 1       |
        | 2       | Corporate Law | Partner              | 25 years experience           | 1       |

    # And the following "SecondmentOpportunity" exist
    #   | status     |profession | headline                                       | description                             | duration_of_work | duration_frequency | invite_only | see_invited_firms | enable_q_a | owningCompany | owningUser | invited_offices |
    #   | published  | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 12               | weeks              | 1           | 0                 | 1          | 1             | 2          | 3               |
    #   | published  | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 12               | weeks              | 1           | 0                 | 1          | 1             | 2          | 3               |
    #   | dealtime   | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 12               | weeks              | 0           | 0                 | 1          | 1             | 2          | 3               |
    #   | dealtime   | 1         | We are looking for 5 Mid-Senior Web Developers | We are looking for 5 Mid-Senior Lawyers | 12               | weeks              | 0           | 0                 | 1          | 1             | 2          | 3               |

    # And the following "GroupSecondee" exist
    #   | secondmentOpportunity | description |
    #   | 1                     | test test   |
    #   | 2                     | test test   |
    #   | 3                     | test test   |

    # And the following "SecondmentOffer" exist
    #   | status     | secondmentOpportunity | company | createdBy  | comments  | amendments  |
    #   | draft      | 1                     | 3       | 20         | test      | testing     |

    # And the following "OfferProfileGroup" exist
    #   | profileExtension  | groupSecondee | offer | amount  |
    #   | 1                 | 1             | 1     | 1000    |

    And I am authenticating as "read.dlapiper@sink.sendgrid.net"
    And I am authenticating as "write.dlapiper@sink.sendgrid.net"
    And I am authenticating as "write1.dlapiper@sink.sendgrid.net"
    And I am authenticating as "publish.dlapiper@sink.sendgrid.net"
    And I am authenticating as "othercompany.hsf@sink.sendgrid.net"
    And I am authenticating as "write.hsf@sink.sendgrid.net"
    And I am authenticating as "write2.hsf@sink.sendgrid.net"
    And I am authenticating as "admin.persuit@sink.sendgrid.net"
    And I am authenticating as "userwriter.dlapiper@sink.sendgrid.net"
    And I am authenticating as "read.pwc@sink.sendgrid.net"
    And I am authenticating as "write.pwc@sink.sendgrid.net"
    And I am authenticating as "read.bhp@sink.sendgrid.net"
    And I am authenticating as "write.bhp@sink.sendgrid.net"
    And I am authenticating as "publish.bhp@sink.sendgrid.net"
    And I am authenticating as "write1.bhp@sink.sendgrid.net"
    And I am authenticating as "read.ashursts@sink.sendgrid.net"
    And I am authenticating as "write.ashursts@sink.sendgrid.net"
    And I am authenticating as "write1.ashursts@sink.sendgrid.net"
    And I am authenticating as "write.bakermckenzie@sink.sendgrid.net"
    And I am authenticating as "offer.offer@sink.sendgrid.net"
    And I am authenticating as "offer1.offer@sink.sendgrid.net"
    And I am authenticating as "offer2.offer@sink.sendgrid.net"
    And I am authenticating as "write1.bakermckenzie@sink.sendgrid.net"
    And I am authenticating as "read.deloitte@sink.sendgrid.net"
    And I am authenticating as "write.deloitte@sink.sendgrid.net"

  Scenario: Successful GET returns response
