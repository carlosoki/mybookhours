@profile
Feature: Profile search
  In order to find a profile
  As a corporate user
  I need to search the list of profiles

  Rules
  - searches across fields are treated as an 'and' e.g. works for DLA Piper and has the expertise of Contract Law
  - searches within a field are treated as an 'or' e.g. works for DLA Piper or Baker & McKenzie -
  - all results are sorted by name
  - Search fields:
  | field                                   | search by      | can search multiple | appears in list view |
  | name                                    | text           | no                  | yes                  |
  | preferred secondment location           | woeid          | yes                 | yes                  |
  | industry sector                         | id             | yes                 | no                   |
  | specific languages                      | id             | yes                 | no                   |
  | firm(s) company name                    | id             | yes                 | yes                  |
  | seniority                               | id             | yes                 | no                   |
  | practice area                           | id             | yes                 | no                   |
  | admitted to practice                    | text           | no                  | no                   |
  | available for secondment                | boolean        | N/A                 | yes                  |
  | profile photo                           | not searchable | N/A                 | yes                  |
  | Available for secondment from (date)    | not searchable | N/A                 | yes                  |
  | Available for secondment to (date)      | not searchable | N/A                 | yes                  |
  | professional experience                 | not searchable | N/A                 | yes                  |

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

    And I am authenticating as "write1.dlapiper@sink.sendgrid.net"

  Scenario: Run a whole bunch of profile searches

  #Scenario: Search by name
    When I send a GET request to "/profiles?name=lock"
    Then I get 3 paginated results

    And paginated result 1 contains "firstName" "Jackson"
    And paginated result 1 contains "lastName" "Pollock"
    And paginated result 1 contains nested "company" "id" "21"

    And paginated result 2 contains "firstName" "Matthew"
    And paginated result 2 contains "lastName" "Pollock"
    And paginated result 2 contains nested "company" "id" "1"

    And paginated result 3 contains "firstName" "Rebecca"
    And paginated result 3 contains "lastName" "Lock"
    And paginated result 3 contains nested "company" "id" "1"

  #Scenario: Search by another name
    When I send a GET request to "/profiles?name=inn"
    Then I get 9 paginated results

    And paginated result 1 contains "firstName" "Alinna"
    And paginated result 1 contains "lastName" "Nop"

    And paginated result 2 contains "firstName" "Andreas"
    And paginated result 2 contains "lastName" "Inniesta"

    And paginated result 3 contains "firstName" "Andrew"
    And paginated result 3 contains "lastName" "Innopolus"

    And paginated result 4 contains "firstName" "Frank"
    And paginated result 4 contains "lastName" "Innazy"

    And paginated result 5 contains "firstName" "Innès"
    And paginated result 5 contains "lastName" "Gunnar"

    And paginated result 6 contains "firstName" "Matias"
    And paginated result 6 contains "lastName" "Oinni"

    And paginated result 7 contains "firstName" "Stina"
    And paginated result 7 contains "lastName" "Inngvar"

    And paginated result 8 contains "firstName" "Tuve"
    And paginated result 8 contains "lastName" "Inngen"

    And paginated result 9 contains "firstName" "Yimmy"
    And paginated result 9 contains "lastName" "Inntut"


  #Scenario: Search by name and company
    When I send a GET request to "/profiles?name=inn&companies=21"
    Then I get 3 paginated results

    And paginated result 1 contains "firstName" "Alinna"
    And paginated result 1 contains "lastName" "Nop"
    And paginated result 1 contains nested "company" "id" "21"

    And paginated result 2 contains "firstName" "Andreas"
    And paginated result 2 contains "lastName" "Inniesta"
    And paginated result 2 contains nested "company" "id" "21"

    And paginated result 3 contains "firstName" "Innès"
    And paginated result 3 contains "lastName" "Gunnar"
    And paginated result 3 contains nested "company" "id" "21"


  #Scenario: Search by name and multiple companies
    When I send a GET request to "/profiles?name=inn&companies=21,19"
    Then I get 4 paginated results

    And paginated result 1 contains "firstName" "Alinna"
    And paginated result 1 contains "lastName" "Nop"
    And paginated result 1 contains nested "company" "id" "21"

    And paginated result 2 contains "firstName" "Andreas"
    And paginated result 2 contains "lastName" "Inniesta"
    And paginated result 2 contains nested "company" "id" "21"

    And paginated result 3 contains "firstName" "Innès"
    And paginated result 3 contains "lastName" "Gunnar"
    And paginated result 3 contains nested "company" "id" "21"

    And paginated result 4 contains "firstName" "Matias"
    And paginated result 4 contains "lastName" "Oinni"
    And paginated result 4 contains nested "company" "id" "19"


  #Scenario: Search by name and multiple companies and seniority
    When I send a GET request to "/profiles?name=inn&companies=21,19&seniorities=12"
    Then I get 2 paginated results

    And paginated result 1 contains "firstName" "Andreas"
    And paginated result 1 contains "lastName" "Inniesta"
    And paginated result 1 contains nested "company" "id" "21"
    And paginated result 1 contains nested "seniority" "id" "12"

    And paginated result 2 contains "firstName" "Matias"
    And paginated result 2 contains "lastName" "Oinni"
    And paginated result 2 contains nested "company" "id" "19"
    And paginated result 2 contains nested "seniority" "id" "12"

  #Scenario: Search by name and multiple companies and multiple seniority
    When I send a GET request to "/profiles?name=inn&companies=21,19&seniorities=12,15"
    Then I get 3 paginated results

    And paginated result 1 contains "firstName" "Alinna"
    And paginated result 1 contains "lastName" "Nop"
    And paginated result 1 contains nested "company" "id" "21"
    And paginated result 1 contains nested "seniority" "id" "15"

    And paginated result 2 contains "firstName" "Andreas"
    And paginated result 2 contains "lastName" "Inniesta"
    And paginated result 2 contains nested "company" "id" "21"
    And paginated result 2 contains nested "seniority" "id" "12"

    And paginated result 3 contains "firstName" "Matias"
    And paginated result 3 contains "lastName" "Oinni"
    And paginated result 3 contains nested "company" "id" "19"
    And paginated result 3 contains nested "seniority" "id" "12"


  #Scenario: Search by name and profession
    When I send a GET request to "/profiles?name=inn&professions=1"
    Then I get 2 paginated results

    And paginated result 1 contains "firstName" "Andrew"
    And paginated result 1 contains "lastName" "Innopolus"
    And paginated result 1 contains nested "profession" "id" "1"

    And paginated result 2 contains "firstName" "Frank"
    And paginated result 2 contains "lastName" "Innazy"
    And paginated result 2 contains nested "profession" "id" "1"


  #Scenario: Search by name and another profession
    When I send a GET request to "/profiles?name=inn&professions=2"
    Then I get 7 paginated results

    And paginated result 1 contains "firstName" "Alinna"
    And paginated result 1 contains "lastName" "Nop"
    And paginated result 1 contains nested "profession" "id" "2"

    And paginated result 2 contains "firstName" "Andreas"
    And paginated result 2 contains "lastName" "Inniesta"
    And paginated result 2 contains nested "profession" "id" "2"

    And paginated result 3 contains "firstName" "Innès"
    And paginated result 3 contains "lastName" "Gunnar"
    And paginated result 3 contains nested "profession" "id" "2"

    And paginated result 4 contains "firstName" "Matias"
    And paginated result 4 contains "lastName" "Oinni"
    And paginated result 4 contains nested "profession" "id" "2"

    And paginated result 5 contains "firstName" "Stina"
    And paginated result 5 contains "lastName" "Inngvar"
    And paginated result 5 contains nested "profession" "id" "2"

    And paginated result 6 contains "firstName" "Tuve"
    And paginated result 6 contains "lastName" "Inngen"
    And paginated result 6 contains nested "profession" "id" "2"


  #Scenario: Search by name and profession and multiple seniority
    When I send a GET request to "/profiles?name=inn&professions=2&seniorities=12,17"
    Then I get 2 paginated results

    And paginated result 1 contains "firstName" "Andreas"
    And paginated result 1 contains "lastName" "Inniesta"
    And paginated result 1 contains nested "profession" "id" "2"
    And paginated result 1 contains nested "seniority" "id" "12"

    And paginated result 2 contains "firstName" "Matias"
    And paginated result 2 contains "lastName" "Oinni"
    And paginated result 2 contains nested "profession" "id" "2"
    And paginated result 2 contains nested "seniority" "id" "12"


  #Scenario: Search by profession and multiple seniority
    When I send a GET request to "/profiles?professions=2&seniorities=12,17"
    Then I get 4 paginated results

    And paginated result 1 contains "firstName" "Andreas"
    And paginated result 1 contains "lastName" "Inniesta"
    And paginated result 1 contains nested "profession" "id" "2"
    And paginated result 1 contains nested "seniority" "id" "12"

    And paginated result 2 contains "firstName" "Jackson"
    And paginated result 2 contains "lastName" "Pollock"
    And paginated result 2 contains nested "profession" "id" "2"
    And paginated result 2 contains nested "seniority" "id" "12"

    And paginated result 3 contains "firstName" "Matias"
    And paginated result 3 contains "lastName" "Oinni"
    And paginated result 3 contains nested "profession" "id" "2"
    And paginated result 3 contains nested "seniority" "id" "12"

    And paginated result 4 contains "firstName" "Oskar"
    And paginated result 4 contains "lastName" "Berg"
    And paginated result 4 contains nested "profession" "id" "2"
    And paginated result 4 contains nested "seniority" "id" "17"


  #Scenario: Search by profession and multiple seniority and company
    When I send a GET request to "/profiles?professions=2&seniorities=12,17&companies=19"
    Then I get 2 paginated results

    And paginated result 1 contains "firstName" "Matias"
    And paginated result 1 contains "lastName" "Oinni"
    And paginated result 1 contains nested "profession" "id" "2"
    And paginated result 1 contains nested "seniority" "id" "12"
    And paginated result 1 contains nested "company" "id" "19"

    And paginated result 2 contains "firstName" "Oskar"
    And paginated result 2 contains "lastName" "Berg"
    And paginated result 2 contains nested "profession" "id" "2"
    And paginated result 2 contains nested "seniority" "id" "17"
    And paginated result 2 contains nested "company" "id" "19"


  #Scenario: Search by name and profession and multiple seniority and company
    When I send a GET request to "/profiles?name=erg&professions=2&seniorities=12,17&companies=19"
    Then I get 1 paginated results

    And paginated result 1 contains "firstName" "Oskar"
    And paginated result 1 contains "lastName" "Berg"
    And paginated result 1 contains nested "profession" "id" "2"
    And paginated result 1 contains nested "seniority" "id" "17"
    And paginated result 1 contains nested "company" "id" "19"


  #Scenario: Search by name and language
    When I send a GET request to "/profiles?name=inn&languages=6"
    Then I get 2 paginated results

    And paginated result 1 contains "firstName" "Stina"
    And paginated result 1 contains "lastName" "Inngvar"
    And paginated result 1 contains deep nested "languages" "1" "id" "6"

    And paginated result 2 contains "firstName" "Tuve"
    And paginated result 2 contains "lastName" "Inngen"
    And paginated result 2 contains deep nested "languages" "1" "id" "6"


  #Scenario: Search by name and multiple language
    When I send a GET request to "/profiles?name=inn&languages=6,7"
    Then I get 3 paginated results

    And paginated result 1 contains "firstName" "Frank"
    And paginated result 1 contains "lastName" "Innazy"
    And paginated result 1 contains deep nested "languages" "1" "id" "3"
    And paginated result 1 contains deep nested "languages" "2" "id" "7"

    And paginated result 2 contains "firstName" "Stina"
    And paginated result 2 contains "lastName" "Inngvar"
    And paginated result 2 contains deep nested "languages" "1" "id" "6"

    And paginated result 3 contains "firstName" "Tuve"
    And paginated result 3 contains "lastName" "Inngen"
    And paginated result 3 contains deep nested "languages" "1" "id" "6"


  #Scenario: Search by name and multiple companies and multiple seniority and practice area and industry sector
    When I send a GET request to "/profiles?name=inn&companies=21,19&seniorities=12,15,16&practiceAreas=4&practiceSubAreas=5,6&industrySectors=1&industrySubSectors=1"
    Then I get 2 paginated results

    And paginated result 1 contains "firstName" "Alinna"
    And paginated result 1 contains "lastName" "Nop"
    And paginated result 1 contains nested "company" "id" "21"
    And paginated result 1 contains nested "seniority" "id" "15"
    And paginated result 1 contains deep nested "practiceAreas" "1" "id" "4"
    And paginated result 1 contains deep nested "practiceSubAreas" "1" "id" "6"
    And paginated result 1 contains deep nested "industrySectors" "1" "id" "1"
    And paginated result 1 contains deep nested "industrySubSectors" "1" "id" "1"

    And paginated result 2 contains "firstName" "Andreas"
    And paginated result 2 contains "lastName" "Inniesta"
    And paginated result 2 contains nested "company" "id" "21"
    And paginated result 2 contains nested "seniority" "id" "12"
    And paginated result 2 contains deep nested "practiceAreas" "1" "id" "4"
    And paginated result 2 contains deep nested "practiceSubAreas" "1" "id" "5"
    And paginated result 2 contains deep nested "industrySectors" "1" "id" "1"
    And paginated result 2 contains deep nested "industrySubSectors" "1" "id" "1"


  #Scenario: Search by secondment locations and admitted to practice locations
    When I send a GET request to "/profiles?secondmentLocations=1,2&admittedToPracticeLocations=2"
    Then I get 1 paginated results

    And paginated result 1 contains "firstName" "Yimmy"
    And paginated result 1 contains "lastName" "Noop"
    And paginated result 1 contains deep nested "secondmentLocations" "1" "id" "2"
    And paginated result 1 contains deep nested "admittedToPracticeLocations" "1" "id" "2"


  #Scenario: Search by another name paginated
    When I send a GET request to "/profiles?name=inn&page=1&limit=3"
    Then I get 3 paginated results

    And result has "totalRowCount" "9"
    And result has "totalPageCount" "3"
    And result has "currentPage" "1"

    And paginated result 1 contains "firstName" "Alinna"
    And paginated result 1 contains "lastName" "Nop"

    And paginated result 2 contains "firstName" "Andreas"
    And paginated result 2 contains "lastName" "Inniesta"

    And paginated result 3 contains "firstName" "Andrew"
    And paginated result 3 contains "lastName" "Innopolus"

    When I send a GET request to "/profiles?name=inn&page=2&limit=3"
    Then I get 3 paginated results

    And result has "totalRowCount" "9"
    And result has "totalPageCount" "3"
    And result has "currentPage" "2"

    And paginated result 1 contains "firstName" "Frank"
    And paginated result 1 contains "lastName" "Innazy"

    And paginated result 2 contains "firstName" "Innès"
    And paginated result 2 contains "lastName" "Gunnar"

    And paginated result 3 contains "firstName" "Matias"
    And paginated result 3 contains "lastName" "Oinni"

    When I send a GET request to "/profiles?name=inn&page=3&limit=3"
    Then I get 3 paginated results

    And result has "totalRowCount" "9"
    And result has "totalPageCount" "3"
    And result has "currentPage" "3"

    And paginated result 1 contains "firstName" "Stina"
    And paginated result 1 contains "lastName" "Inngvar"

    And paginated result 2 contains "firstName" "Tuve"
    And paginated result 2 contains "lastName" "Inngen"

    And paginated result 3 contains "firstName" "Yimmy"
    And paginated result 3 contains "lastName" "Inntut"


  #Scenario: Search by another name paginated
    When I send a GET request to "/profiles?name=nn&page=1&limit=5"
    Then I get 5 paginated results

    And result has "totalRowCount" "9"
    And result has "totalPageCount" "2"
    And result has "currentPage" "1"

    And paginated result 1 contains "firstName" "Alinna"
    And paginated result 1 contains "lastName" "Nop"

    And paginated result 2 contains "firstName" "Andreas"
    And paginated result 2 contains "lastName" "Inniesta"

    And paginated result 3 contains "firstName" "Andrew"
    And paginated result 3 contains "lastName" "Innopolus"

    And paginated result 4 contains "firstName" "Frank"
    And paginated result 4 contains "lastName" "Innazy"

    And paginated result 5 contains "firstName" "Innès"
    And paginated result 5 contains "lastName" "Gunnar"

    When I send a GET request to "/profiles?name=nn&page=2&limit=5"
    Then I get 4 paginated results

    And result has "totalRowCount" "9"
    And result has "totalPageCount" "2"
    And result has "currentPage" "2"

    And paginated result 1 contains "firstName" "Matias"
    And paginated result 1 contains "lastName" "Oinni"

    And paginated result 2 contains "firstName" "Stina"
    And paginated result 2 contains "lastName" "Inngvar"

    And paginated result 3 contains "firstName" "Tuve"
    And paginated result 3 contains "lastName" "Inngen"

    And paginated result 4 contains "firstName" "Yimmy"
    And paginated result 4 contains "lastName" "Inntut"


  #Scenario: Explicit Search for profiles in professions I don't belong to only returns those in professions that I do belong to
    Given I am authenticating as "write.dlapiper@sink.sendgrid.net"
    When I send a GET request to "/profiles?name=inn&professions=1,2,3,4,5"
    Then I get 2 paginated results

    And paginated result 1 contains "firstName" "Andrew"
    And paginated result 1 contains "lastName" "Innopolus"
    And paginated result 1 contains nested "profession" "id" "1"
    And paginated result 1 contains nested "seniority" "id" "4"
    And paginated result 1 contains nested "company" "id" "3"

    And paginated result 2 contains "firstName" "Frank"
    And paginated result 2 contains "lastName" "Innazy"
    And paginated result 2 contains nested "profession" "id" "1"
    And paginated result 2 contains nested "seniority" "id" "2"
    And paginated result 2 contains nested "company" "id" "3"


   #Scenario: General Search only returns profiles for the professions that I do belong to (profession 1)
    Given I am authenticating as "write.dlapiper@sink.sendgrid.net"
    When I send a GET request to "/profiles?name=inn"
    Then I get 2 paginated results

    And paginated result 1 contains "firstName" "Andrew"
    And paginated result 1 contains "lastName" "Innopolus"
    And paginated result 1 contains nested "profession" "id" "1"
    And paginated result 1 contains nested "seniority" "id" "4"
    And paginated result 1 contains nested "company" "id" "3"

    And paginated result 2 contains "firstName" "Frank"
    And paginated result 2 contains "lastName" "Innazy"
    And paginated result 2 contains nested "profession" "id" "1"
    And paginated result 2 contains nested "seniority" "id" "2"
    And paginated result 2 contains nested "company" "id" "3"


   #Scenario: General Search only returns profiles for the professions that I do belong to (profession 2)
    Given I am authenticating as "write.pwc@sink.sendgrid.net"
    When I send a GET request to "/profiles?name=inn"
    Then I get 3 paginated results

    And paginated result 1 contains "firstName" "Alinna"
    And paginated result 1 contains "lastName" "Nop"
    And paginated result 1 contains nested "profession" "id" "2"
    And paginated result 1 contains nested "seniority" "id" "15"
    And paginated result 1 contains nested "company" "id" "21"

    And paginated result 2 contains "firstName" "Andreas"
    And paginated result 2 contains "lastName" "Inniesta"
    And paginated result 2 contains nested "profession" "id" "2"
    And paginated result 2 contains nested "seniority" "id" "12"
    And paginated result 2 contains nested "company" "id" "21"

    And paginated result 3 contains "firstName" "Innès"
    And paginated result 3 contains "lastName" "Gunnar"
    And paginated result 3 contains nested "profession" "id" "2"
    And paginated result 3 contains nested "seniority" "id" "16"
    And paginated result 3 contains nested "company" "id" "21"

   #Scenario: Search available for secondment
    When I send a GET request to "/profiles?availableForSecondment=true"
    Then I get 3 paginated results

    And paginated result 1 contains "firstName" "Alinna"
    And paginated result 1 contains "lastName" "Nop"
    And paginated result 1 contains nested "profession" "id" "2"
    And paginated result 1 contains nested "seniority" "id" "15"
    And paginated result 1 contains nested "company" "id" "21"

    And paginated result 2 contains "firstName" "Andreas"
    And paginated result 2 contains "lastName" "Inniesta"
    And paginated result 2 contains nested "profession" "id" "2"
    And paginated result 2 contains nested "seniority" "id" "12"
    And paginated result 2 contains nested "company" "id" "21"

    And paginated result 3 contains "firstName" "Innès"
    And paginated result 3 contains "lastName" "Gunnar"
    And paginated result 3 contains nested "profession" "id" "2"
    And paginated result 3 contains nested "seniority" "id" "16"
    And paginated result 3 contains nested "company" "id" "21"

    #Scenario: Search unavailable for secondment
    When I send a GET request to "/profiles?availableForSecondment=false"
    Then I get 1 paginated result
    And paginated result 1 contains "firstName" "Jackson"
    And paginated result 1 contains "lastName" "Pollock"
    And paginated result 1 contains nested "company" "id" "21"

    #Scenario: Check indicitive rate is returned
    Given I am authenticating as "read.pwc@sink.sendgrid.net"
    When I send a GET request to "/profiles"
    Then I get 4 paginated results
    And paginated result 1 contains "firstName" "Alinna"
    And paginated result 1 contains "lastName" "Nop"
    And paginated result 1 contains "indicativeMonthlyRate" "1000"

    #Scenario: Check indicitive rate is not returned
    Given I am authenticating as "read.bhp@sink.sendgrid.net"
    When I send a GET request to "/profiles"
    Then I get 10 paginated results
    And paginated result 1 contains "firstName" "Alinna"
    And paginated result 1 contains "lastName" "Nop"
    And paginated result 1 not has key "indicativeMonthlyRate"
