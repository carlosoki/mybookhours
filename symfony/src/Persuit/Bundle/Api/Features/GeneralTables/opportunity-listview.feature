@opportunity @list-view
Feature: Opportunity List view
  As a corporate user
  I need to view  opportunity as Supplier and/or Requester

  Client (Requester) Roles:
  - List opportunity in Draft only for the owner
  - List opportunity unapproved for owner and approver
  - List opportunity published for everyone in the company
  - List opportunity closed/withdrawn for everyone in the company

  Firms (Supplier) Roles:
  - List opportunity collection (Scenario 1)
  - List opportunity by profession (Scenario 2)
  - List empty opportunity by profession (Scenario 3)
  - List opportunity by statuses (Scenario 4,5)
  - List opportunity combining statuses and profession (Scenario 6,7)
  - List opportunity by ID (Scenario 8)
  - Unauthorized to list  opportunity by ID (Scenario 9)
  - Archived List View (Scenario 6,11)

  Background:
    Given I loadDB

    Given the following "opportunity" exist
      | id | type             | status     | owningCompany | profession | owningUser | approver | inviteOnly | seeInvitedFirms | invitedCompanies |
      | 1  | clientSecondment | draft      | 1             | 2          | 2          | 4        | 1          |                 |                  |
      | 2  | clientSecondment | draft      | 1             | 2          | 2          | 4        |            |                 |                  |
      | 3  | clientSecondment | draft      | 1             | 1          | 3          | 4        |            |                 |                  |
      | 4  | clientSecondment | draft      | 1             | 1          | 4          |          |            |                 |                  |
      | 5  | clientSecondment | unapproved | 1             | 1          | 3          | 4        |            |                 |                  |
      | 6  | clientSecondment | unapproved | 1             | 2          | 3          | 4        |            |                 |                  |
      | 7  | clientSecondment | closed     | 1             | 1          | 4          |          |            |                 |                  |
      | 8  | clientSecondment | closed     | 2             | 1          | 5          |          |            |                 |                  |
      | 9  | clientSecondment | closed     | 2             | 1          | 5          |          | 1          |                 | 21               |
      | 10 | clientSecondment | closed     | 2             | 1          | 5          |          |            |                 |                  |
      | 11 | clientSecondment | dealtime   | 1             | 1          | 4          |          |            |                 |                  |
      | 12 | clientSecondment | dealtime   | 2             | 1          | 5          |          | 1          |                 | 3                |
      | 13 | clientSecondment | dealtime   | 2             | 1          | 5          |          |            |                 |                  |
      | 14 | clientSecondment | published  | 2             | 1          | 5          |          |            |                 |                  |
      | 15 | clientSecondment | published  | 2             | 1          | 5          |          |            |                 | 3,6              |
      | 16 | clientSecondment | published  | 2             | 1          | 5          |          | 1          |                 | 21,3             |
      | 17 | clientSecondment | published  | 2             | 1          | 5          |          | 1          |                 | 3,6              |
      | 18 | clientSecondment | published  | 2             | 1          | 5          |          |            | 0               | 21,3             |
      | 19 | clientSecondment | published  | 2             | 1          | 5          |          |            | 1               | 21,3             |

    And the following "OpportunityAssign" exist
      | opportunity | User |
      | 8           | 24   |
      | 9           | 24   |
      | 14          | 23   |
      | 15          | 20   |
      | 15          | 23   |
      | 15          | 24   |
      | 16          | 25   |
      | 17          | 23   |

    And the following "OfferClientSecondment" exist
      | id | opportunity | type             | company | createdBy | status    | total |
      | 1  | 8           | clientSecondment | 21      | 24        | draft     | 1000  |
      | 2  | 9           | clientSecondment | 21      | 24        | draft     | 1000  |
      | 3  | 14          | clientSecondment | 6       | 23        | published | 1000  |
      | 4  | 15          | clientSecondment | 3       | 20        | published | 1000  |
      | 5  | 15          | clientSecondment | 6       | 23        | draft     | 1000  |
      | 6  | 15          | clientSecondment | 21      | 24        | published | 1000  |

    #Counter Offer
    And the following "CounterOfferSecondment" exist
      | id | status    | type             | opportunity | company | createdBy | offer |
      | 7  | draft     | clientSecondment | 14          | 2       | 5         | 3     |
      | 8  | draft     | clientSecondment | 15          | 2       | 5         | 6     |
      | 9  | published | clientSecondment | 15          | 2       | 5         | 4     |

    And I am authenticating as "publish.dlapiper@sink.sendgrid.net"

# --------------------------    START HERE TEST FOR REQUESTER LIST VIEW      ------------------------------------------
  Scenario: 1 - List secondment opportunity collection
    Given I send a GET request to "opportunity"
    Then the response code should be 200
    And I get 5 results
    And result 1 contains "id" "4"
    And result 2 contains "id" "5"
    And result 3 contains "id" "6"
    And result 4 contains "id" "7"
    And result 5 contains "id" "11"

  Scenario: 2 - List secondment opportunity by profession
    Given I send a GET request to "opportunity?profession=2"
    Then the response code should be 200
    And I get 1 result
    And result 1 contains "id" "6"

  Scenario: 3 - List empty secondment opportunity by profession
    Given I send a GET request to "opportunity?profession=199"
    Then the response code should be 400
    And response should contain json:
   """
       {
          "code": 400,
          "message": "This user does not have the profession: 199 used as parameter"
       }
   """

  Scenario: 4 - List secondment opportunity by statuses
    Given I send a GET request to "opportunity?status=draft,unapproved"
    Then the response code should be 200
    And I get 3 results
    And result 1 contains "id" "4"
    And result 2 contains "id" "5"
    And result 3 contains "id" "6"

  Scenario: 5 - List secondment opportunity by statuses in deal time
    Given I send a GET request to "opportunity?status=dealtime"
    Then the response code should be 200
    And I get 1 results

  Scenario: 6 - List secondment opportunity combining statuses and profession
    Given I send a GET request to "opportunity?status=closed&profession=1"
    Then the response code should be 200
    And I get 1 result
    And result 1 contains "id" "7"

  Scenario: 7 - Empty result listing secondment opportunity combining statuses and profession
    Given I send a GET request to "opportunity?status=draft&profession=2"
    Then the response code should be 200
    And I get 0 result
    And response should contain json:
   """
     []
   """

  Scenario: 8 - List secondment opportunity by ID
    Given I send a GET request to "opportunity/5"
    Then the response code should be 200

  Scenario: 9 - Unauthorized to list secondment opportunity by ID
    Given I send a GET request to "opportunity/1"
    Then the response code should be 403
    And response should contain json:
   """
     {"code":403,"message":"You do not have the necessary permissions"}
   """

  Scenario: 10 - Not found list secondment opportunity by ID
    Given I send a GET request to "opportunity/199"
    Then the response code should be 404
    And response should contain json:
   """
     {"code":404,"message":"Not Found"}
   """

  Scenario: 11 - List of archived secondment opportunity
    Given I am authenticating as "othercompany.hsf@sink.sendgrid.net" with "123" password
    And I send a GET request to "opportunity?status=closed&profession=1"
    Then the response code should be 200
    And I get 3 result
    And result 1 contains "id" "8"
    And result 2 contains "id" "9"
    And result 3 contains "id" "10"

  Scenario: 12 Requester cannot see offers in draft
    Given I am authenticating as "othercompany.hsf@sink.sendgrid.net"
    And I send a GET request to "opportunity/15"
    Then the response code should be 200
    Then json collection result contains "offers" 0 "id" 4

  Scenario: 13 Only Counter offer creator can see counter offer
    Given I am authenticating as "write.hsf@sink.sendgrid.net"
    And I send a GET request to "opportunity/14"
    Then the response code should be 200
    And the response should contain json:
    """
    {
        "id": 14,
        "type": "clientSecondment",
        "status": "published",
        "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "Cupcake ipsum dolor.",
        "offers": [
          {
            "id": 3,
            "comments": "Test Offer Comments",
            "amendments": "",
            "status": "published",
            "company": {
              "id": 6,
              "name": "Baker \\& McKenzie"
            },
            "createdBy": {
              "id": 23,
              "email": "write1.bakermckenzie@sink.sendgrid.net",
              "company": {
                "id": 6,
                "name": "Baker \\& McKenzie"
              },
              "firstName": "jim",
              "lastName": "jones",
              "phone": "0450000000",
              "roles": [
                "ROLE_OFFER_WRITE",
                "ROLE_USER"
              ]
            },
            "isCounter": false,
            "total": 1000,
            "counterOffers": [],
            "type": "clientSecondment",
            "acl": {
              "read": true,
              "write": false,
              "edit": false,
              "accept": false,
              "counter": false,
              "delete": false,
              "reject": false,
              "withdraw": false
            }
          }
        ]
    }
    """
    Given I am authenticating as "othercompany.hsf@sink.sendgrid.net"
    And I send a GET request to "opportunity/14"
    Then the response code should be 200
    And the response should contain json:
    """
    {
      "id": 14,
      "type": "clientSecondment",
      "status": "published",
      "profession": {
        "id": 1,
        "name": "Legal"
      },
      "headline": "Cupcake ipsum dolor.",
      "offers": [
        {
          "id": 3,
          "comments": "Test Offer Comments",
          "amendments": "",
          "status": "published",
          "company": {
            "id": 6,
            "name": "Baker \\& McKenzie"
          },
          "createdBy": {
            "id": 23,
            "email": "write1.bakermckenzie@sink.sendgrid.net",
            "company": {
              "id": 6,
              "name": "Baker \\& McKenzie"
            },
            "firstName": "jim",
            "lastName": "jones",
            "phone": "0450000000",
            "roles": [
              "ROLE_OFFER_WRITE",
              "ROLE_USER"
            ]
          },
          "isCounter": false,
          "total": 1000,
          "counterOffers": [
            {
              "id": 7,
              "comments": "Test Offer Comments",
              "amendments": "",
              "status": "draft",
              "company": {
                "id": 2,
                "name": "Herbert Smith Freehills"
              },
              "createdBy": {
                "id": 5,
                "email": "othercompany.hsf@sink.sendgrid.net",
                "company": {
                  "id": 2,
                  "name": "Herbert Smith Freehills"
                },
                "firstName": "jim",
                "lastName": "jones",
                "phone": "0450000000",
                "roles": [
                  "ROLE_OPP_WRITE",
                  "ROLE_OPP_PUBLISH",
                  "ROLE_USER"
                ]
              },
              "isCounter": false,
              "total": 0,
              "counterOffers": [],
              "type": "clientSecondment",
              "acl": {
                "read": true,
                "write": false,
                "edit": true,
                "accept": false,
                "counter": false,
                "delete": true,
                "reject": false,
                "withdraw": false
              }
            }
          ],
          "type": "clientSecondment",
          "acl": {
            "read": true,
            "write": false,
            "edit": false,
            "accept": false,
            "counter": false,
            "delete": false,
            "reject": false,
            "withdraw": false
          }
        }
      ]
    }
    """

# --------------------------    FINISH HERE TEST FOR REQUESTER LIST VIEW      ------------------------------------------

# --------------------------    START HERE TEST FOR SUPPLIERS LIST VIEW       ------------------------------------------

  Scenario: 14 - Suppliers side - List view no parameters
    Given I am authenticating as "offer1.pwc@sink.sendgrid.net"
    And I send a GET request to "opportunity"
    Then the response code should be 200
    And I get 11 result
    And result 1 contains "id" "7"
    And result 2 contains "id" "8"
    And result 3 contains "id" "9"
    And result 4 contains "id" "10"
    And result 5 contains "id" "11"
    And result 6 contains "id" "13"
    And result 7 contains "id" "14"
    And result 8 contains "id" "15"
    And result 9 contains "id" "16"
    And result 10 contains "id" "18"
    And result 11 contains "id" "19"

  Scenario: 16 - Suppliers side - List view of Archived
    Given I am authenticating as "offer.pwc@sink.sendgrid.net"
    And I send a GET request to "opportunity?status=closed&profession=1"
    Then the response code should be 200
    And I get 2 result
    And result 1 contains "id" "8"
    And result 2 contains "id" "9"

  Scenario: 17 - Suppliers side - List view of Invited Assigned
    Given I am authenticating as "offer.pwc@sink.sendgrid.net"
    And I send a GET request to "opportunity?companyAssigned=1"
    Then the response code should be 200
    And I get 1 result
    And result 1 contains "id" "16"

  Scenario: 18 - Suppliers side - List view of Invited Unassigned
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    And I send a GET request to "opportunity?companyAssigned=0"
    Then the response code should be 200
    And I get 4 result
    And result 1 contains "id" "16"
    And result 2 contains "id" "17"
    And result 3 contains "id" "18"
    And result 4 contains "id" "19"

  Scenario: 19 - Suppliers side - List view of Activity (Offers in draft or published)
    Given I am authenticating as "write1.bakermckenzie@sink.sendgrid.net"
    And I send a GET request to "opportunity?offerStatus=draft,published"
    Then the response code should be 200
    And I get 2 result
    And result 1 contains "id" "14"
    And result 2 contains "id" "15"

  Scenario: 20 - Suppliers side - List view of Activity (No offers made)
    Given I am authenticating as "write1.bakermckenzie@sink.sendgrid.net"
    And I send a GET request to "opportunity?offerStatus=none"
    Then the response code should be 200
    And I get 1 result
    And result 1 contains "id" "17"

  Scenario: 21 - Suppliers side - Do not show invited companies, offices, unlisted companies when see_invited_firms = false
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    And I send a GET request to "opportunity/18"
    Then the response code should be 200
    And the response should contain json:
    """
        {
          "invitedCompanies": [],
          "invitedOffices": []
        }
    """

  Scenario: 22 - Suppliers side - Show invited companies, offices, unlisted companies when see_invited_firms = true
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    And I send a GET request to "opportunity/19"
    Then the response code should be 200
    And json collection result contains "invitedCompanies" "0" "id" "3"
    And json collection result contains "invitedCompanies" "1" "id" "21"

  Scenario: 23 - Suppliers only see Counter offers when it is published
    Given I am authenticating as "write1.bakermckenzie@sink.sendgrid.net"
    And I send a GET request to "opportunity/14"
    Then the response code should be 200
    And the response should contain json:
    """
    {
        "id": 14,
        "type": "clientSecondment",
        "status": "published",
         "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "Cupcake ipsum dolor.",
        "offers": [
          {
            "id": 3,
            "comments": "Test Offer Comments",
            "amendments": "",
            "status": "published",
            "company": {
              "id": 6,
              "name": "Baker \\& McKenzie"
            },
            "createdBy": {
              "id": 23,
              "email": "write1.bakermckenzie@sink.sendgrid.net",
              "company": {
                "id": 6,
                "name": "Baker \\& McKenzie"
              },
              "firstName": "jim",
              "lastName": "jones",
              "phone": "0450000000",
              "roles": [
                "ROLE_OFFER_WRITE",
                "ROLE_USER"
              ]
            },
            "isCounter": false,
            "total": 1000,
            "counterOffers": [],
            "type": "clientSecondment",
            "acl": {
              "read": true,
              "write": true,
              "edit": false,
              "accept": false,
              "counter": false,
              "delete": false,
              "reject": false,
              "withdraw": true
            }
          }
        ]
    }
    """
    Given I am authenticating as "offer.offer@sink.sendgrid.net"
    And I send a GET request to "opportunity/15"
    Then the response code should be 200
    And the response should contain json:
    """
    {
        "id": 15,
        "type": "clientSecondment",
        "status": "published",
         "profession": {
          "id": 1,
          "name": "Legal"
        },
        "headline": "Cupcake ipsum dolor.",
        "offers": [
          {
            "id": 4,
            "comments": "Test Offer Comments",
            "amendments": "",
            "status": "published",
            "company": {
              "id": 3,
              "name": "Ashursts"
            },
            "createdBy": {
              "id": 20,
              "email": "offer.offer@sink.sendgrid.net",
              "company": {
                "id": 3,
                "name": "Ashursts"
              },
              "firstName": "jim",
              "lastName": "jones",
              "phone": "0450000000",
              "roles": [
                "ROLE_OFFER_WRITE",
                "ROLE_USER"
              ]
            },
            "isCounter": false,
            "total": 1000,
             "counterOffers": [
                {
                  "id": 9,
                  "comments": "Test Offer Comments",
                  "amendments": "",
                  "status": "published",
                  "company": {
                    "id": 2,
                    "name": "Herbert Smith Freehills"
                  },
                  "createdBy": {
                    "id": 5,
                    "email": "othercompany.hsf@sink.sendgrid.net",
                    "company": {
                      "id": 2,
                      "name": "Herbert Smith Freehills"
                    },
                    "firstName": "jim",
                    "lastName": "jones",
                    "phone": "0450000000",
                    "roles": [
                      "ROLE_OPP_WRITE",
                      "ROLE_OPP_PUBLISH",
                      "ROLE_USER"
                    ]
                  },
                  "isCounter": false,
                  "total": 0,
                  "counterOffers": [],
                  "type": "clientSecondment",
                  "acl": {
                    "read": true,
                    "write": true,
                    "edit": false,
                    "accept": false,
                    "counter": false,
                    "delete": false,
                    "reject": true,
                    "withdraw": false
                  }
                }
             ],
            "type": "clientSecondment",
            "acl": {
              "read": true,
              "write": true,
              "edit": false,
              "accept": false,
              "counter": false,
              "delete": false,
              "reject": false,
              "withdraw": true
            }
          }
        ]
    }
    """

# --------------------------    FINISH HERE TEST FOR SUPPLIERS LIST VIEW      ------------------------------------------

#@opportunity @list-view
#Feature: Opportunity List view
#  As a corporate user
#  I need to view  opportunity as Supplier and/or Requester
#
#  Client (Requester) Roles:
#  - List opportunity in Draft only for the owner
#  - List opportunity unapproved for owner and approver
#  - List opportunity published for everyone in the company
#  - List opportunity closed/withdrawn for everyone in the company
#
#  Firms (Supplier) Roles:
#  - List opportunity collection (Scenario 1)
#  - List opportunity by profession (Scenario 2)
#  - List empty opportunity by profession (Scenario 3)
#  - List opportunity by statuses (Scenario 4,5)
#  - List opportunity combining statuses and profession (Scenario 6,7)
#  - List opportunity by ID (Scenario 8)
#  - Unauthorized to list  opportunity by ID (Scenario 9)
#  - Archived List View (Scenario 6,11)
#
#  Background:
#    Given I loadDB
#
#    Given the following "opportunity" exist
#      | id | type             | status     | owningCompany | profession | owningUser | approver | inviteOnly | seeInvitedFirms | invitedCompanies | invitedOffices |
#      | 1  | clientSecondment | draft      | 1             | 2          | 2          | 4        | 1          |                 |                  |                |
#      | 2  | clientSecondment | draft      | 1             | 2          | 2          | 4        |            |                 |                  |                |
#      | 3  | clientSecondment | draft      | 1             | 1          | 3          | 4        |            |                 |                  |                |
#      | 4  | clientSecondment | draft      | 1             | 1          | 4          |          |            |                 |                  |                |
#      | 5  | clientSecondment | unapproved | 1             | 1          | 3          | 4        |            |                 |                  |                |
#      | 6  | clientSecondment | unapproved | 1             | 2          | 3          | 4        |            |                 |                  |                |
#      | 7  | clientSecondment | closed     | 1             | 1          | 4          |          |            |                 |                  |                |
#      | 8  | clientSecondment | closed     | 2             | 1          | 5          |          |            |                 |                  |                |
#      | 9  | clientSecondment | closed     | 2             | 1          | 5          |          | 1          |                 | 21               |                |
#      | 10 | clientSecondment | closed     | 2             | 1          | 5          |          |            |                 |                  |                |
#      | 11 | clientSecondment | dealtime   | 1             | 1          | 4          |          |            |                 |                  |                |
#      | 12 | clientSecondment | dealtime   | 2             | 1          | 5          |          | 1          |                 | 3                |                |
#      | 13 | clientSecondment | dealtime   | 2             | 1          | 5          |          |            |                 |                  |                |
#      | 14 | clientSecondment | published  | 2             | 1          | 5          |          |            |                 |                  |                |
#      | 15 | clientSecondment | published  | 2             | 1          | 5          |          |            |                 | 3,6              |                |
#      | 16 | clientSecondment | published  | 2             | 1          | 5          |          | 1          |                 | 21,3             |                |
#      | 17 | clientSecondment | published  | 2             | 1          | 5          |          | 1          |                 | 3,6              |                |
#      | 18 | clientSecondment | published  | 2             | 1          | 5          |          |            | 0               | 21,3             |                |
#      | 19 | clientSecondment | published  | 2             | 1          | 5          |          |            | 1               | 21,3             |                |
#
#    And the following "OpportunityAssign" exist
#      | opportunity | User |
#      | 8           | 24   |
#      | 9           | 24   |
#      | 14          | 23   |
#      | 15          | 20   |
#      | 15          | 23   |
#      | 15          | 24   |
#      | 16          | 25   |
#      | 17          | 23   |
#
#    And the following "OfferSecondment" exist
#      | id | opportunity | type       | company | createdBy | status    |
#      | 1  | 8           | secondment | 21      | 24        | draft     |
#      | 2  | 9           | secondment | 21      | 24        | draft     |
#      | 3  | 14          | secondment | 6       | 23        | published |
#      | 4  | 15          | secondment | 3       | 20        | published |
#      | 5  | 15          | secondment | 6       | 23        | draft     |
#      | 6  | 15          | secondment | 21      | 24        | published |
#
#    #Counter Offer
#    And the following "CounterOfferSecondment" exist
#      | id | status    | type       | opportunity | company | createdBy | offer |
#      | 7  | draft     | secondment | 14          | 2       | 5         | 3     |
#      | 8  | draft     | secondment | 15          | 2       | 5         | 6     |
#      | 9  | published | secondment | 15          | 2       | 5         | 4     |
#
#    And I am authenticating as "publish.dlapiper@sink.sendgrid.net"
#
## --------------------------    START HERE TEST FOR REQUESTER LIST VIEW      ------------------------------------------
#  Scenario: 1 - List secondment opportunity collection
#    Given I send a GET request to "opportunity"
#    Then the response code should be 200
#    And I get 5 results
#    And result 1 contains "id" "4"
#    And result 2 contains "id" "5"
#    And result 3 contains "id" "6"
#    And result 4 contains "id" "7"
#    And result 5 contains "id" "11"
#
#  Scenario: 2 - List secondment opportunity by profession
#    Given I send a GET request to "opportunity?profession=2"
#    Then the response code should be 200
#    And I get 1 result
#    And result 1 contains "id" "6"
#
#  Scenario: 3 - List empty secondment opportunity by profession
#    Given I send a GET request to "opportunity?profession=199"
#    Then the response code should be 400
#    And response should contain json:
#   """
#       {
#          "code": 400,
#          "message": "This user does not have the profession: 199 used as parameter"
#       }
#   """
#
#  Scenario: 4 - List secondment opportunity by statuses
#    Given I send a GET request to "opportunity?status=draft,unapproved"
#    Then the response code should be 200
#    And I get 3 results
#    And result 1 contains "id" "4"
#    And result 2 contains "id" "5"
#    And result 3 contains "id" "6"
#
#  Scenario: 5 - List secondment opportunity by statuses in deal time
#    Given I send a GET request to "opportunity?status=dealtime"
#    Then the response code should be 200
#    And I get 1 results
#
#  Scenario: 6 - List secondment opportunity combining statuses and profession
#    Given I send a GET request to "opportunity?status=closed&profession=1"
#    Then the response code should be 200
#    And I get 1 result
#    And result 1 contains "id" "7"
#
#  Scenario: 7 - Empty result listing secondment opportunity combining statuses and profession
#    Given I send a GET request to "opportunity?status=draft&profession=2"
#    Then the response code should be 200
#    And I get 0 result
#    And response should contain json:
#   """
#     []
#   """
#
#  Scenario: 8 - List secondment opportunity by ID
#    Given I send a GET request to "opportunity/5"
#    Then the response code should be 200
#
#  Scenario: 9 - Unauthorized to list secondment opportunity by ID
#    Given I send a GET request to "opportunity/1"
#    Then the response code should be 403
#    And response should contain json:
#   """
#     {"code":403,"message":"You do not have the necessary permissions"}
#   """
#
#  Scenario: 10 - Not found list secondment opportunity by ID
#    Given I send a GET request to "opportunity/199"
#    Then the response code should be 404
#    And response should contain json:
#   """
#     {"code":404,"message":"Not Found"}
#   """
#
#  Scenario: 11 - List of archived secondment opportunity
#    Given I am authenticating as "othercompany.hsf@sink.sendgrid.net" with "123" password
#    And I send a GET request to "opportunity?status=closed&profession=1"
#    Then the response code should be 200
#    And I get 3 result
#    And result 1 contains "id" "8"
#    And result 2 contains "id" "9"
#    And result 3 contains "id" "10"
#
#  Scenario: 12 Requester cannot see offers in draft
#    Given I am authenticating as "othercompany.hsf@sink.sendgrid.net"
#    And I send a GET request to "opportunity/15"
#    Then the response code should be 200
#    Then json collection result contains "offers" 0 "id" 4
#
## --------------------------    FINISH HERE TEST FOR REQUESTER LIST VIEW      ------------------------------------------
#
## --------------------------    START HERE TEST FOR SUPPLIERS LIST VIEW       ------------------------------------------
#
#  Scenario: 14 - Suppliers side - List view no parameters
#    Given I am authenticating as "offer1.pwc@sink.sendgrid.net"
#    And I send a GET request to "opportunity"
#    Then the response code should be 200
#    And I get 11 result
#    And result 1 contains "id" "7"
#    And result 2 contains "id" "8"
#    And result 3 contains "id" "9"
#    And result 4 contains "id" "10"
#    And result 5 contains "id" "11"
#    And result 6 contains "id" "13"
#    And result 7 contains "id" "14"
#    And result 8 contains "id" "15"
#    And result 9 contains "id" "16"
#    And result 10 contains "id" "18"
#    And result 11 contains "id" "19"
#
#  Scenario: 16 - Suppliers side - List view of Archived
#    Given I am authenticating as "offer.pwc@sink.sendgrid.net"
#    And I send a GET request to "opportunity?status=closed&profession=1"
#    Then the response code should be 200
#    And I get 2 result
#    And result 1 contains "id" "8"
#    And result 2 contains "id" "9"
#
#  Scenario: 17 - Suppliers side - List view of Invited Assigned
#    Given I am authenticating as "offer.pwc@sink.sendgrid.net"
#    And I send a GET request to "opportunity?company_assigned=1"
#    Then the response code should be 200
#    And I get 1 result
#    And result 1 contains "id" "16"
#
#  Scenario: 18 - Suppliers side - List view of Invited Unassigned
#    Given I am authenticating as "offer.offer@sink.sendgrid.net"
#    And I send a GET request to "opportunity?company_assigned=0"
#    Then the response code should be 200
#    And I get 4 result
#    And result 1 contains "id" "16"
#    And result 2 contains "id" "17"
#    And result 3 contains "id" "18"
#    And result 4 contains "id" "19"
#
#  Scenario: 19 - Suppliers side - List view of Activity (Offers in draft or published)
#    Given I am authenticating as "write1.bakermckenzie@sink.sendgrid.net"
#    And I send a GET request to "opportunity?offer_status=draft,published"
#    Then the response code should be 200
#    And I get 2 result
#    And result 1 contains "id" "14"
#    And result 2 contains "id" "15"
#
#  Scenario: 20 - Suppliers side - List view of Activity (No offers made)
#    Given I am authenticating as "write1.bakermckenzie@sink.sendgrid.net"
#    And I send a GET request to "opportunity?offer_status=none"
#    Then the response code should be 200
#    And I get 1 result
#    And result 1 contains "id" "17"
#
#  Scenario: 21 - Suppliers side - Do not show invited companies, offices, unlisted companies when see_invited_firms = false
#    Given I am authenticating as "offer.offer@sink.sendgrid.net"
#    And I send a GET request to "opportunity/18"
#    Then the response code should be 200
#    And the response should contain json:
#    """
#        {
#          "invited_companies": [
#            {
#              "id": 3,
#              "name": "Ashursts"
#            }
#          ],
#          "invited_offices": []
#        }
#    """
#
#  Scenario: 22 - Suppliers side - Show invited companies, offices, unlisted companies when see_invited_firms = true
#    Given I am authenticating as "offer.offer@sink.sendgrid.net"
#    And I send a GET request to "opportunity/19"
#    Then the response code should be 200
#    And json collection result contains "invited_companies" "0" "id" "3"
#    And json collection result contains "invited_companies" "1" "id" "21"
#
#  Scenario: 23 - Suppliers side - Dont show offers in draft if not the offer creator
#    Given I am authenticating as "write.bakermckenzie@sink.sendgrid.net"
#    And I send a GET request to "opportunity/15"
#    Then the response code should be 200
#    And the response should contain json:
#    """
#        {
#          "offers": []
#        }
#    """
#
#  Scenario: 23 - Suppliers side - Show offers in draft if the offer creator
#    Given I am authenticating as "write1.bakermckenzie@sink.sendgrid.net"
#    And I send a GET request to "opportunity/15"
#    Then the response code should be 200
#    And json collection result contains "offers" "0" "id" "5"
#
## --------------------------    FINISH HERE TEST FOR SUPPLIERS LIST VIEW      ------------------------------------------