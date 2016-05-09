@fixture @constants
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

  Scenario: Successful GET returns response
