# ************************************************************
# Sequel Pro SQL dump
# Version 4499
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.46-0ubuntu0.14.04.2)
# Database: symfony
# Generation Time: 2016-01-20 03:47:21 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table activity
# ------------------------------------------------------------

/*!40000 ALTER TABLE `activity` DISABLE KEYS */;

INSERT INTO `activity` (`id`, `name`)
VALUES
    (1,'Requester'),
    (2,'Supplier');

/*!40000 ALTER TABLE `activity` ENABLE KEYS */;


# Dump of table currency
# ------------------------------------------------------------

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;

INSERT INTO `currency` (`id`, `name`, `code`, `symbol`)
VALUES
    (1,'Australia Dollars','AUD','$'),
    (2,'Pounds','GBP','£'),
    (3,'United States of America Dollars','USD','$'),
    (4,'Euro','EUR','€');

/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table industry_sector
# ------------------------------------------------------------

LOCK TABLES `industry_sector` WRITE;
/*!40000 ALTER TABLE `industry_sector` DISABLE KEYS */;

INSERT INTO `industry_sector` (`id`, `name`)
VALUES
    (1,'Aerospace and Defence'),
    (2,'Agribusiness'),
    (3,'Automotive'),
    (4,'Climate Change'),
    (5,'Construction & Engineering'),
    (6,'Consumer'),
    (7,'Energy & Resources'),
    (8,'Financial Services'),
    (9,'Gaming'),
    (10,'Government and Public Sector'),
    (11,'Healthcare, Life Sciences & Pharmaceuticals'),
    (12,'Hospitality & Leisure'),
    (13,'Infrastructure'),
    (14,'Insurance & Reinsurance'),
    (15,'Manufacturing and Industrials'),
    (16,'Mining'),
    (17,'Oil & Gas'),
    (18,'Outsourcing'),
    (19,'Power & Renewables'),
    (20,'Private Equity'),
    (21,'Retail'),
    (22,'Sports'),
    (23,'Telecommunications, Media & Technology'),
    (24,'Transport & Logistics'),
    (25,'Water & Waste Management'),
    (26,'Wealth and Asset Management');

/*!40000 ALTER TABLE `industry_sector` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table industry_sub_sector
# ------------------------------------------------------------



# Dump of table practice_area
# ------------------------------------------------------------

LOCK TABLES `practice_area` WRITE;
/*!40000 ALTER TABLE `practice_area` DISABLE KEYS */;

INSERT INTO `practice_area` (`id`, `profession_id`, `name`)
VALUES
    (1,1,'Antitrust and Competition'),
    (2,1,'Banking, Finance and Capital Markets'),
    (3,1,'Construction'),
    (4,1,'Corporate, Commercial and Mergers & Acquisitions'),
    (5,1,'Corporate Crimes & Investigations'),
    (6,1,'Data Protection & Privacy'),
    (7,1,'Employment & Workplace Relations'),
    (8,1,'Litigation, Arbitration & ADR'),
    (9,1,'Environment & Planning'),
    (10,1,'Estate Planning'),
    (11,1,'Government/Public Law'),
    (12,1,'Insolvency, Bankruptcy & Restructuring'),
    (13,1,'Insurance & Reinsurance'),
    (14,1,'Intellectual Property & Technology'),
    (15,1,'International Trade/WTO/Government Relations'),
    (16,1,'Pensions and Superannuation'),
    (17,1,'Projects, Energy & Infrastructure'),
    (18,1,'Real Estate'),
    (19,1,'Tax, Trusts and Charities'),
    (20,2,'Audit and Assurance'),
    (21,2,'Tax'),
    (22,2,'Advisory'),
    (23,2,'Private Enterprise'),
    (24,2,'Transactions'),
    (25,3,'Actuarial'),
    (26,3,'Analytics'),
    (27,3,'Asset Lifecycle Management'),
    (28,3,'Customer'),
    (29,3,'Cyber'),
    (30,3,'Digital Services'),
    (31,3,'Economics and Policy'),
    (32,3,'Finance'),
    (33,3,'Human Capital'),
    (34,3,'M & A Integration'),
    (35,3,'Operations'),
    (36,3,'Performance Alignment'),
    (37,3,'Risk and Controls Solutions'),
    (38,3,'Technology'),
    (39,3,'Strategy');

/*!40000 ALTER TABLE `practice_area` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table practice_sub_area
# ------------------------------------------------------------

LOCK TABLES `practice_sub_area` WRITE;
/*!40000 ALTER TABLE `practice_sub_area` DISABLE KEYS */;

INSERT INTO `practice_sub_area` (`id`, `practice_area_id`, `name`)
VALUES
    (1,1,'Abuse of Dominance'),
    (2,1,'Antitrust and Intellectual Property'),
    (3,1,'Antitrust/Competition Litigation'),
    (4,1,'Cartels & Competition Investigations'),
    (5,1,'Compliance'),
    (6,1,'Consumer Protection'),
    (7,1,'Corporate, Private Equity, M\\&A and Commercial'),
    (8,1,'Dawn Raids'),
    (9,1,'EU Law and Regulation'),
    (10,1,'International Trade and WTO'),
    (11,1,'Public Procurement and Competitive Tendering'),
    (12,1,'State Aid'),
    (13,1,'Merger Control'),
    (14,1,'Vertical Agreements'),
    (15,2,'Asset management and investment funds'),
    (16,2,'Acquisition & Leveraged Finance'),
    (17,2,'Aircraft Finance'),
    (18,2,'Asset Finance'),
    (19,2,'Bank Asset Sales'),
    (20,2,'Banking & Financial Markets Regulation'),
    (21,2,'Banking, Finance and Securities Litigation'),
    (22,2,'Capital Markets'),
    (23,2,'CDOs and CLOs'),
    (24,2,'Convertible Bonds'),
    (25,2,'Corporate Finance'),
    (26,2,'Corporate trust & agency'),
    (27,2,'DCM'),
    (28,2,'Debt Capital Markets'),
    (29,2,'Derivatives & Structured Products'),
    (30,2,'Digital Payments'),
    (31,2,'Equity Capital Markets'),
    (32,2,'Equity-linked and hybrid offerings'),
    (33,2,'ECM'),
    (34,2,'Emerging Markets'),
    (35,2,'Funds Finance'),
    (36,2,'Leasing Finance'),
    (37,2,'General Lending'),
    (38,2,'High Yield Bonds'),
    (39,2,'Hybrid Securities'),
    (40,2,'Infrastructure finance and development'),
    (41,2,'Infrastructure funds'),
    (42,2,'Islamic Finance'),
    (43,2,'Microfinance and Social Investment'),
    (44,2,'Non-bank lending'),
    (45,2,'Pension/Superannuation funds'),
    (46,2,'Private Equity & Venture Capital'),
    (47,2,'Project Finance'),
    (48,2,'Public Finance'),
    (49,2,'Real Estate Finance and Workouts'),
    (50,2,'Regulatory Capital'),
    (51,2,'Securitisation'),
    (52,2,'Social Finance'),
    (53,2,'Structured Finance'),
    (54,2,'Structured Product funds'),
    (55,2,'Trade Commodities & Export Finance'),
    (56,2,'US securities'),
    (57,3,'Construction Contracts (Drafting)'),
    (58,3,'Construction & Engineering Disputes'),
    (59,3,'Procurement'),
    (60,4,'Business & Technology Sourcing'),
    (61,4,'Commercial Contracts'),
    (62,4,'Corporate'),
    (63,4,'Corporate Advisory'),
    (64,4,'Corporate Governance'),
    (65,4,'Directors\' Duties'),
    (66,4,'Demergers & Reorganisations'),
    (67,4,'e-commerce'),
    (68,4,'Financial Institutions M\\&A'),
    (69,4,'Foreign investment'),
    (70,4,'Franchise & Distribution'),
    (71,4,'Funds & Investment Management'),
    (72,4,'IPOs'),
    (73,4,'Joint Ventures & Strategic Alliances'),
    (74,4,'Mergers & Acquisitions'),
    (75,4,'Mergers & Acquisition Disputes'),
    (76,4,'Outsourcing'),
    (77,4,'Partnerships and LLPs'),
    (78,4,'Private Equity & Venture Capital'),
    (79,4,'Privatisations'),
    (80,4,'PPP/PFI'),
    (81,4,'Public Policy'),
    (82,4,'Regulatory Compliance'),
    (83,4,'Technology Transactions'),
    (84,5,'Anti-bribery and corruption'),
    (85,5,'Compliance'),
    (86,5,'Corporate Investigations'),
    (87,5,'Cross border investigations and enforcement'),
    (88,5,'FCPA'),
    (89,5,'Financial Regulatory Investigations'),
    (90,5,'Fraud and white collar crime'),
    (91,5,'Money laundering'),
    (92,5,'Sanctions'),
    (93,5,'Tax Investigations'),
    (94,6,'Cyber Security'),
    (95,6,'Data Protection'),
    (96,6,'Information Management'),
    (97,6,'Trade Secrets'),
    (98,6,'Privacy'),
    (99,7,'Discrimination & Equal Opportunity'),
    (100,7,'Employment'),
    (101,7,'Employment Disputes'),
    (102,7,'Employee Share Schemes'),
    (103,7,'Equity & Incentive Plans'),
    (104,7,'Executive Compensation'),
    (105,7,'Global Mobility & Migration'),
    (106,7,'Industrial Relations'),
    (107,7,'Immigration'),
    (108,7,'Work Health & Safety'),
    (109,7,'Workplace training'),
    (110,8,'Administrative and Public Law'),
    (111,8,'Arbitration (Domestic)'),
    (112,8,'Arbitration (International)'),
    (113,8,'Aviation Disputes'),
    (114,8,'Banking litigation and financial services disputes'),
    (115,8,'Class actions'),
    (116,8,'Commercial disputes'),
    (117,8,'Competition/Antitrust disputes'),
    (118,8,'Construction and Engineering disputes'),
    (119,8,'Consumer disputes'),
    (120,8,'Contentious regulatory'),
    (121,8,'Contentious Tax'),
    (122,8,'Corporate and M\\&A disputes'),
    (123,8,'Cross-border disputes'),
    (124,8,'Customs & Trade disputes'),
    (125,8,'Data & Privacy related disputes'),
    (126,8,'Defamation'),
    (127,8,'Derivatives \\& Structured Products disputes'),
    (128,8,'Employment Disputes'),
    (129,8,'Energy, Natural Resources & Infrastructure disputes'),
    (130,8,'Environmental'),
    (131,8,'Franchise & Distribution disputes'),
    (132,8,'Fraud and Asset Tracing'),
    (133,8,'Insolvency disputes'),
    (134,8,'Insurance and Reinsurance disputes'),
    (135,8,'Intellectual Property & Enforcement'),
    (136,8,'Investment Treaty Arbitration'),
    (137,8,'Healthcare'),
    (138,8,'Health and Safety'),
    (139,8,'Misleading and Deceptive Conduct'),
    (140,8,'Product liability & Mass Torts'),
    (141,8,'Professional Negligence'),
    (142,8,'Public international law'),
    (143,8,'Real estate disputes'),
    (144,8,'Shareholder disputes'),
    (145,8,'Sports disputes'),
    (146,8,'Technology, media and telecommunications disputes'),
    (147,8,'Trade Secrets & Non-compete disputes'),
    (148,8,'Trust Litigation'),
    (149,9,'Business Ethics and Human Rights'),
    (150,9,'Chemicals'),
    (151,9,'Climate Change'),
    (152,9,'Contaminated Land'),
    (153,9,'Crisis Management'),
    (154,9,'EHS Regulatory'),
    (155,9,'Emissions and Carbon Trading'),
    (156,9,'Environmental Disclosure and Corporate Environmental Transparency'),
    (157,9,'Environmental Litigation'),
    (158,9,'Export Controls'),
    (159,9,'Nature Protection and Biodiversity'),
    (160,9,'Planning'),
    (161,9,'Product Stewardship'),
    (162,9,'Renewables and Clean Technology'),
    (163,9,'Shale Gas Projects'),
    (164,9,'Sustainable Finance'),
    (165,9,'Water'),
    (166,9,'Waste'),
    (167,11,'Freedom of Information'),
    (168,11,'EU Procurement Law'),
    (169,11,'Procurement and Competitive Tendering'),
    (170,11,'Public Law Litigation'),
    (171,11,'Public-Private Partnerships (PPP)'),
    (172,12,'Corporate Insolvency/Bankruptcy'),
    (173,12,'Individual Bankruptcy'),
    (174,12,'Insolvency Litigation'),
    (175,12,'Restructuring & Workouts'),
    (176,13,'Capital Raising'),
    (177,13,'Insurance Business Transfer Schemes'),
    (178,13,'Insurance Capital Markets and Derivatives'),
    (179,13,'Insurance Disputes'),
    (180,13,'Insurance Regulatory and Compliance'),
    (181,13,'Lloyd\'s of London'),
    (182,13,'Policy Advice'),
    (183,13,'Regulatory and Competition'),
    (184,13,'Reinsurance'),
    (185,13,'Reinsurance disputes'),
    (186,13,'Risk Transfer'),
    (187,14,'Anti-counterfeiting'),
    (188,14,'Copyright'),
    (189,14,'Copyright Disputes'),
    (190,14,'Domain names'),
    (191,14,'Intellectual Property'),
    (192,14,'Intellectual Property Disputes & Enforcement'),
    (193,14,'Licensing'),
    (194,14,'Patents'),
    (195,14,'Patent Litigation'),
    (196,14,'Sports rights'),
    (197,14,'The European Unified Patent Court'),
    (198,14,'Trade Secrets'),
    (199,14,'Trademarks'),
    (200,14,'Trademark Litigation'),
    (201,14,'Trademarks and False Advertising'),
    (202,15,'Foreign Investment'),
    (203,15,'Market Access & Trade Policy'),
    (204,15,'Procurement'),
    (205,15,'Trade Law'),
    (206,15,'WTO'),
    (207,17,'Energy'),
    (208,17,'Infrastructure & Transport'),
    (209,17,'Mining & Minerals'),
    (210,17,'Oil & Gas'),
    (211,17,'Renewables'),
    (212,18,'Acquisitions and disposals'),
    (213,18,'Commercial Leasing'),
    (214,18,'Development and Construction'),
    (215,18,'Hospitality & Leisure'),
    (216,18,'Native title and indigenous heritage'),
    (217,18,'Real Estate Finance'),
    (218,18,'Real Estate Funds'),
    (219,18,'Real Estate Investments, Joint Ventures and Structures'),
    (220,18,'Real Estate Litigation'),
    (221,18,'Real Estate Securitisation'),
    (222,18,'Real Estate Management'),
    (223,18,'Real Estate Workouts'),
    (224,18,'REITs'),
    (225,18,'Retail Leasing'),
    (226,19,'Corporate Tax'),
    (227,19,'Global Compliance'),
    (228,19,'Employment related tax and incentives'),
    (229,19,'Energy Taxation'),
    (230,19,'Funds Structuring'),
    (231,19,'International Executive Taxation'),
    (232,19,'State & Local Tax'),
    (233,19,'Private Client Tax & Wealth Planning'),
    (234,19,'R&D Services'),
    (235,19,'Superannuation & Pension Funds'),
    (236,19,'Tax Disputes, Controversy & Investigations'),
    (237,19,'Tax Management Consulting'),
    (238,19,'Transfer Pricing'),
    (239,19,'Trusts'),
    (240,20,'Financial Statement Audit'),
    (241,20,'Accounting Advisory Services'),
    (242,20,'Regulatory Audit'),
    (243,20,'Audit Related Services'),
    (244,20,'Audit Data & Analytics'),
    (245,20,'Accounting Compliance and Reporting'),
    (246,20,'Climate Change and Sustainability Services'),
    (247,20,'Financial Accounting Advisory Services'),
    (248,20,'Financial Statement Audit'),
    (249,20,'Fraud Investigation & Dispute Services'),
    (250,20,'Accoutning Change'),
    (251,20,'Fraud'),
    (252,20,'Corporate Governance'),
    (253,20,'Sustainability Reporting'),
    (254,21,'Corporate Tax'),
    (255,21,'Global Compliance Management Services'),
    (256,21,'Global Transfer Pricing Services'),
    (257,21,'Indirect Tax'),
    (258,21,'International Executive Services'),
    (259,21,'R&D Incentives'),
    (260,21,'Superannuation & Pension Funds'),
    (261,21,'Tax Dispute Resolution & Controversy Services'),
    (262,21,'Tax Management Consulting'),
    (263,22,'Management Consulting'),
    (264,22,'Risk Consulting'),
    (265,22,'Deal Advisory'),
    (266,23,'Private Companies'),
    (267,23,'Family Business'),
    (268,23,'Individuals'),
    (269,24,'Preserving Capital'),
    (270,24,'Optmising Capital'),
    (271,24,'Investing Capital'),
    (272,24,'Raising Capital'),
    (273,25,'Accident Compensation'),
    (274,25,'General Insurance'),
    (275,25,'Financial Services'),
    (276,25,'Health Actuarial'),
    (277,25,'Superannuation, Investments & Wealth Management'),
    (278,26,'Data Analytics Delivery'),
    (279,26,'Data services'),
    (280,26,'GEM'),
    (281,26,'Mining Intelligence and Benchmarking'),
    (282,26,'Value Discovery'),
    (283,27,'Asset Management Systems'),
    (284,27,'Reliability and Maintenance'),
    (285,27,'Reliability-centred Maintenance'),
    (286,27,'Project Management'),
    (287,27,'Operations'),
    (288,27,'Supply Chain Management'),
    (289,27,'Training'),
    (290,27,'ISO 55000 Training'),
    (291,28,'Focus Areas'),
    (292,28,'Profitable Pricing'),
    (293,29,'Lifecycle'),
    (294,29,'Cyber Services'),
    (295,29,'Cyber Savvy'),
    (296,30,'Videos'),
    (297,30,'Aquisitions'),
    (298,31,'Benchmarking'),
    (299,31,'Business case development'),
    (300,31,'Cost effectiveness analyses'),
    (301,31,'Cost modelling and pricing reviews'),
    (302,31,'Economic impact analyses'),
    (303,31,'Feasibility studies'),
    (304,31,'National Competition Policy and legislative reviews'),
    (305,31,'Post-implementation reviews'),
    (306,31,'Program reviews'),
    (307,31,'Regulatory impact statements'),
    (308,31,'Triple bottom line-based benefit-cost analyses.'),
    (309,32,'Compliance'),
    (310,32,'Effectiveness'),
    (311,32,'Enterprise Performance Management'),
    (312,32,'Governance'),
    (313,33,'Actuaries'),
    (314,34,'Deal Inception'),
    (315,35,'Corporate Structure Simplification'),
    (316,35,'Performance Improvement through Benefits Management'),
    (317,35,'Shared Services'),
    (318,35,'Supply Chain Performance Improvement'),
    (319,35,'Sustainable Cost Management'),
    (320,35,'Telecommunications Asset Management'),
    (321,37,'Forensic Services'),
    (322,37,'Governance, Compliance and Regulatory Risk'),
    (323,37,'Risk & Capital Management'),
    (324,37,'Sustainability & Climate Change'),
    (325,37,'Technology Risk'),
    (326,37,'Security, Privacy and Resiliency'),
    (327,38,'Specialists'),
    (328,38,'Data Management'),
    (329,38,'IT Effectiveness'),
    (330,38,'Project Services'),
    (331,38,'Enterprise Information Management'),
    (332,38,'Technology Advisory'),
    (333,39,'Customer and Channel Strategy');

/*!40000 ALTER TABLE `practice_sub_area` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table profession
# ------------------------------------------------------------

LOCK TABLES `profession` WRITE;
/*!40000 ALTER TABLE `profession` DISABLE KEYS */;

INSERT INTO `profession` (`id`, `name`)
VALUES
    (1,'Legal'),
    (2,'Accounting'),
    (3,'Consulting');

/*!40000 ALTER TABLE `profession` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table seniority
# ------------------------------------------------------------

LOCK TABLES `seniority` WRITE;
/*!40000 ALTER TABLE `seniority` DISABLE KEYS */;

INSERT INTO `seniority` (`id`, `profession_id`, `name`)
VALUES
    (1,1,'Partner'),
    (2,1,'Legal Director'),
    (3,1,'Of Counsel'),
    (4,1,'Special Counsel'),
    (5,1,'Senior Associate'),
    (6,1,'Associate'),
    (7,1,'Junior Associate'),
    (8,1,'Trainee Solicitor'),
    (9,1,'Paralegal'),
    (10,2,'Staff Auditor'),
    (11,2,'Management Services/Consulting Staff'),
    (12,2,'Senior Auditor'),
    (13,2,'Tax Senior'),
    (14,2,'Audit Manager'),
    (15,2,'Tax Manager'),
    (16,2,'Partner'),
    (17,2,'Senior Partner'),
    (18,2,'Audit Committee Chair'),
    (19,2,'Audit Committee Member');

/*!40000 ALTER TABLE `seniority` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table service
# ------------------------------------------------------------

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;

INSERT INTO `service` (`id`, `profession_id`, `activity_id`)
VALUES
    (1,1,1),
    (2,1,2),
    (3,2,1),
    (4,2,2);

/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table language
# ------------------------------------------------------------

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;

INSERT INTO `language` (`id`, `name`, `code`)
VALUES
    (1,'German','de'),
    (2,'English','en'),
    (3,'French','fr'),
    (4,'Russian','ru'),
    (5,'Italian','it'),
    (6,'Spanish','es'),
    (7,'Luxembourgish, Letzeburgesch','lb'),
    (8,'Dutch','nl'),
    (9,'Thai','th'),
    (10,'Portuguese','pt'),
    (11,'Japanese','ja'),
    (12,'Polish','pl'),
    (13,'Indonesian','id'),
    (14,'Afrikaans','af'),
    (15,'Albanian','sq'),
    (16,'Arabic','ar'),
    (17,'Armenian','hy'),
    (18,'Hebrew (modern)','he'),
    (19,'Malay','ms'),
    (20,'Chinese','zh'),
    (21,'Belarusian','be'),
    (22,'Catalan','ca'),
    (23,'Korean','ko'),
    (24,'Czech','cs'),
    (25,'Vietnamese','vi'),
    (26,'Slovak','sk'),
    (27,'Danish','da'),
    (28,'Yiddish','yi'),
    (29,'Tagalog','tl'),
    (30,'Croatian','hr'),
    (31,'Persian (Farsi)','fa'),
    (32,'Georgian','ka'),
    (33,'Greek (modern)','el'),
    (34,'Romanian','ro'),
    (35,'Hungarian','hu'),
    (36,'Serbian','sr'),
    (37,'Swedish','sv'),
    (38,'Turkish','tr'),
    (39,'Hindi','hi'),
    (40,'Marathi','mr'),
    (41,'Tamil','ta'),
    (42,'Ukrainian','uk'),
    (43,'Panjabi, Punjabi','pa'),
    (44,'Uzbek','uz'),
    (45,'Filipino (Pilipino)','fil'),
    (46,'Lingala','ln'),
    (47,'Swahili','sw'),
    (48,'Gujarati','gu'),
    (49,'Latin','la'),
    (50,'Abkhaz','ab'),
    (51,'Afar','aa'),
    (52,'Akan','ak'),
    (53,'Aragonese','an'),
    (54,'Assamese','as'),
    (55,'Avaric','av'),
    (56,'Avestan','ae'),
    (57,'Aymara','ay'),
    (58,'Azerbaijani','az'),
    (59,'Bambara','bm'),
    (60,'Bashkir','ba'),
    (61,'Basque','eu'),
    (62,'Bengali, Bangla','bn'),
    (63,'Bihari','bh'),
    (64,'Bislama','bi'),
    (65,'Bosnian','bs'),
    (66,'Breton','br'),
    (67,'Bulgarian','bg'),
    (68,'Burmese','my'),
    (69,'Catalan','ca'),
    (70,'Chamorro','ch'),
    (71,'Chechen','ce'),
    (72,'Chichewa, Chewa, Nyanja','ny'),
    (73,'Chuvash','cv'),
    (74,'Cornish','kw'),
    (75,'Corsican','co'),
    (76,'Cree','cr'),
    (77,'Divehi, Dhivehi, Maldivian','dv'),
    (78,'Dzongkha','dz'),
    (79,'Esperanto','eo'),
    (80,'Estonian','et'),
    (81,'Ewe','ee'),
    (82,'Faroese','fo'),
    (83,'Fijian','fj'),
    (84,'Finnish','fi'),
    (85,'Fula, Fulah, Pulaar, Pular','ff'),
    (86,'Galician','gl'),
    (87,'Guarani','gn'),
    (88,'Haitian, Haitian Creole','ht'),
    (89,'Hausa','ha'),
    (90,'Herero','hz'),
    (91,'Hiri Motu','ho'),
    (92,'Interlingua','ia'),
    (93,'Interlingue','ie'),
    (94,'Irish','ga'),
    (95,'Igbo','ig'),
    (96,'Inupiaq','ik'),
    (97,'Ido','io'),
    (98,'Icelandic','is'),
    (99,'Inuktitut','iu'),
    (100,'Japanese','ja'),
    (101,'Kalaallisut, Greenlandic','kl'),
    (102,'Kannada','kn'),
    (103,'Kanuri','kr'),
    (104,'Kashmiri','ks'),
    (105,'Kazakh','kk'),
    (106,'Khmer','km'),
    (107,'Kikuyu, Gikuyu','ki'),
    (108,'Kinyarwanda','rw'),
    (109,'Kyrgyz','ky'),
    (110,'Komi','kv'),
    (111,'Kongo','kg'),
    (112,'Korean','ko'),
    (113,'Kurdish','ku'),
    (114,'Kwanyama, Kuanyama','kj'),
    (115,'Ganda','lg'),
    (116,'Limburgish, Limburgan, Limburger','li'),
    (117,'Lao','lo'),
    (118,'Lithuanian','lt'),
    (119,'Luba-Katanga','lu'),
    (120,'Latvian','lv'),
    (121,'Manx','gv'),
    (122,'Macedonian','mk'),
    (123,'Malagasy','mg'),
    (124,'Malayalam','ml'),
    (125,'Maltese','mt'),
    (126,'Ma ori','mi'),
    (127,'Marshallese','mh'),
    (128,'Mongolian','mn'),
    (129,'Nauru','na'),
    (130,'Navajo, Navaho','nv'),
    (131,'Northern Ndebele','nd'),
    (132,'Nepali','ne'),
    (133,'Ndonga','ng'),
    (134,'Norwegian','nb'),
    (135,'Norwegian Nynorsk','nn'),
    (136,'Norwegian','no'),
    (137,'Nuosu','ii'),
    (138,'Southern Ndebele','nr'),
    (139,'Occitan','oc'),
    (140,'Ojibwe, Ojibwa','oj'),
    (141,'Old Church Slavonic, Church Slavonic, Old Bulgarian','cu'),
    (142,'Oromo','om'),
    (143,'Oriya','or'),
    (144,'Ossetian, Ossetic','os'),
    (145,'PA li','pi'),
    (146,'Pashto, Pushto','ps'),
    (147,'Quechua','qu'),
    (148,'Romansh','rm'),
    (149,'Kirundi','rn'),
    (150,'Sanskrit','sa'),
    (151,'Sardinian','sc'),
    (152,'Sindhi','sd'),
    (153,'Northern Sami','se'),
    (154,'Samoan','sm'),
    (155,'Sango','sg'),
    (156,'Scottish Gaelic, Gaelic','gd'),
    (157,'Shona','sn'),
    (158,'Sinhala, Sinhalese','si'),
    (159,'Slovene','sl'),
    (160,'Somali','so'),
    (161,'Southern Sotho','st'),
    (162,'Spanish','es'),
    (163,'Sundanese','su'),
    (164,'Swati','ss'),
    (165,'Telugu','te'),
    (166,'Tajik','tg'),
    (167,'Tigrinya','ti'),
    (168,'Tibetan Standard, Tibetan, Central','bo'),
    (169,'Turkmen','tk'),
    (170,'Tagalog','tl'),
    (171,'Tswana','tn'),
    (172,'Tonga (Tonga Islands)','to'),
    (173,'Tsonga','ts'),
    (174,'Tatar','tt'),
    (175,'Twi','tw'),
    (176,'Tahitian','ty'),
    (177,'Uyghur','ug'),
    (178,'Urdu','ur'),
    (179,'Venda','ve'),
    (180,'Volapuk','vo'),
    (181,'Walloon','wa'),
    (182,'Welsh','cy'),
    (183,'Wolof','wo'),
    (184,'Western Frisian','fy'),
    (185,'Xhosa','xh'),
    (186,'Yoruba','yo'),
    (187,'Zhuang, Chuang','za'),
    (188,'Zulu','zu');

/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `user_profession` WRITE;
/*!40000 ALTER TABLE `user_profession` DISABLE KEYS */;

INSERT INTO `user_profession` (`user_id`, `profession_id`)
VALUES
    (1,1),
    (1,2);

/*!40000 ALTER TABLE `user_profession` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `company_id`, `username`, `username_canonical`, `email`, `email_canonical`, `enabled`, `salt`, `password`, `last_login`, `locked`, `expired`, `expires_at`, `confirmation_token`, `password_requested_at`, `roles`, `credentials_expired`, `credentials_expire_at`, `first_name`, `middle_name`, `last_name`, `phone`, `activity_id`)
VALUES
    (1,NULL,'admin@persuit.com','admin@persuit.com','admin@persuit.com','admin@persuit.com',1,'1prcxy72uf8go4ksww040gggk4cwwww','$2y$13$1prcxy72uf8go4ksww040embDj81tfBsFLXEbviQHn58Ln2sKG40e',NULL,0,0,NULL,NULL,NULL,'a:1:{i:0;s:10:\"ROLE_ADMIN\";}',0,NULL,'Persuit',NULL,'Admin',NULL,1);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `oauth_client` WRITE;
/*!40000 ALTER TABLE `oauth_client` DISABLE KEYS */;

INSERT INTO `oauth_client` (`id`, `random_id`, `redirect_uris`, `secret`, `allowed_grant_types`)
VALUES
    (1,'3pqytskruwg0o0gwsksgkkso8s0gsoss8swg48g0ksk480cw80','a:0:{}','3ukgsu9n3lgkw4ks0ckwww4s8g00kc884go0k4ogc8kw0gwosk','a:5:{i:0;s:8:\"password\";i:1;s:5:\"token\";i:2;s:13:\"refresh_token\";i:3;s:18:\"authorization_code\";i:4;s:18:\"client_credentials\";}');

/*!40000 ALTER TABLE `oauth_client` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table company
# ------------------------------------------------------------

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;

INSERT INTO `company` (`id`, `name`, `description`, `registered`, `updated_at`, `created_at`, `file_id`)
VALUES
    (1,'DLA Piper','DLA Piper',1,NULL,'2016-01-01 00:00:00',NULL);
    (2,'Addleshaw Goddard','Addleshaw Goddard',0,NULL,'2016-01-01 00:00:00',NULL)
    (3,'Aikin Gump','Aikin Gump',0,NULL,'2016-01-01 00:00:00',NULL)
    (4,'Akin Gump Strauss Hauer & Feld','Akin Gump Strauss Hauer & Feld',0,NULL,'2016-01-01 00:00:00',NULL)
    (5,'Allbright','Allbright',0,NULL,'2016-01-01 00:00:00',NULL)
    (6,'AllBright Law Offices','AllBright Law Offices',0,NULL,'2016-01-01 00:00:00',NULL)
    (7,'Allen & Gledhill,Allen & Gledhill',0,NULL,'2016-01-01 00:00:00',NULL)
    (8,'Allen & Overy','Allen & Overy',0,NULL,'2016-01-01 00:00:00',NULL)
    (9,'Allens','Allens',0,NULL,'2016-01-01 00:00:00',NULL)
    (10,'Alston & Bird','Alston & Bird',0,NULL,'2016-01-01 00:00:00',NULL)
    (11,'Amarchand Mangaldas Suresh A Shroff & Co','Amarchand Mangaldas Suresh A Shroff & Co',0,NULL,'2016-01-01 00:00:00',NULL)
    (12,'Anderson Mori & Tomotsune','Anderson Mori & Tomotsune',0,NULL,'2016-01-01 00:00:00',NULL)
    (13,'Armachand & Mangaldas','Armachand & Mangaldas',0,NULL,'2016-01-01 00:00:00',NULL)
    (14,'Arnold & Porter','Arnold & Porter',0,NULL,'2016-01-01 00:00:00',NULL)
    (15,'Arnold Block Leibler','Arnold Block Leibler',0,NULL,'2016-01-01 00:00:00',NULL)
    (16,'Ashurst,Ashurst',0,NULL,'2016-01-01 00:00:00',NULL)
    (17,'Ashursts,Ashursts',0,NULL,'2016-01-01 00:00:00',NULL)
    (18,'AZb & Partners','AZb & Partners',0,NULL,'2016-01-01 00:00:00',NULL)
    (19,'Baker & Hostetler','Baker & Hostetler',0,NULL,'2016-01-01 00:00:00',NULL)
    (20,'Baker & McKenzie','Baker & McKenzie',0,NULL,'2016-01-01 00:00:00',NULL)
    (21,'Baker Botts','Baker Botts',0,NULL,'2016-01-01 00:00:00',NULL)
    (22,'Berwin Leighton Paisner','Berwin Leighton Paisner',0,NULL,'2016-01-01 00:00:00',NULL)
    (23,'Bingham McCutchen','Bingham McCutchen',0,NULL,'2016-01-01 00:00:00',NULL)
    (24,'Bird & Bird','Bird & Bird',0,NULL,'2016-01-01 00:00:00',NULL)
    (25,'Blake Morgan','Blake Morgan',0,NULL,'2016-01-01 00:00:00',NULL)
    (26,'BLM','BLM',0,NULL,'2016-01-01 00:00:00',NULL)
    (27,'Bond Dickinson','Bond Dickinson',0,NULL,'2016-01-01 00:00:00',NULL)
    (28,'Borden Ladner Gervais','Borden Ladner Gervais',0,NULL,'2016-01-01 00:00:00',NULL)
    (29,'Browne Jacobson','Browne Jacobson',0,NULL,'2016-01-01 00:00:00',NULL)
    (30,'Bryan Cave','Bryan Cave',0,NULL,'2016-01-01 00:00:00',NULL)
    (31,'Burges Salmon','Burges Salmon',0,NULL,'2016-01-01 00:00:00',NULL)
    (32,'"Cadwalader, Wickersham & Taft','Cadwalader, Wickersham & Taft',0,NULL,'2016-01-01 00:00:00',NULL)
    (33,'China 11-25','China 11-26',0,NULL,'2016-01-01 00:00:00',NULL)
    (34,'Clayton Utz','Clayton Utz',0,NULL,'2016-01-01 00:00:00',NULL)
    (35,'Cleary Gottlieb,Cleary Gottlieb,0,NULL,2016-01-01 00:00:00',NULL)
    (36,'Cleary Gottlieb Steen & Hamilton,Cleary Gottlieb Steen & Hamilton,0,NULL,2016-01-01 00:00:00',NULL)
    (37,'Clifford Chance,Clifford Chance,0,NULL,2016-01-01 00:00:00',NULL)
    (38,'Clyde & Co,Clyde & Co,0,NULL,2016-01-01 00:00:00',NULL)
    (39,'CMS,CMS,0,NULL,2016-01-01 00:00:00',NULL)
    (40,'CMS Legal Services,CMS Legal Services,0,NULL,2016-01-01 00:00:00',NULL)
    (41,'Colin Biggers & Paisley (CBP Lawyers),Colin Biggers & Paisley (CBP Lawyers),0,NULL,2016-01-01 00:00:00',NULL)
    (42,'Cooley,Cooley,0,NULL,2016-01-01 00:00:00',NULL)
    (43,'Corrs,Corrs,0,NULL,2016-01-01 00:00:00',NULL)
    (44,'Covington & Burling,Covington & Burling,0,NULL,2016-01-01 00:00:00',NULL)
    (45,'"Cravath, Swaine & Moore","Cravath, Swaine & Moore",0,NULL,2016-01-01 00:00:00',NULL)
    (46,'"Cuatrecasas, Gonçalves Pereira","Cuatrecasas, Gonçalves Pereira",0,NULL,2016-01-01 00:00:00',NULL)
    (47,'DAC Beachcroft,DAC Beachcroft,0,NULL,2016-01-01 00:00:00',NULL)
    (48,'Dacheng,Dacheng,0,NULL,2016-01-01 00:00:00',NULL)
    (49,'Davis Polk,Davis Polk,0,NULL,2016-01-01 00:00:00',NULL)
    (50,'Davis Polk & Wardwell,Davis Polk & Wardwell,0,NULL,2016-01-01 00:00:00',NULL)
    (51,'Debevioise & Plimpton,Debevioise & Plimpton,0,NULL,2016-01-01 00:00:00',NULL)
    (52,'Debevoise & Plimpton,Debevoise & Plimpton,0,NULL,2016-01-01 00:00:00',NULL)
    (53,'Dechert,Dechert,0,NULL,2016-01-01 00:00:00',NULL)
    (54,'Decherts,Decherts,0,NULL,2016-01-01 00:00:00',NULL)
    (55,'DeHeng,DeHeng,0,NULL,2016-01-01 00:00:00',NULL)
    (56,'DeHeng Law Offices,DeHeng Law Offices,0,NULL,2016-01-01 00:00:00',NULL)
    (57,'Dentons,Dentons,0,NULL,2016-01-01 00:00:00',NULL)
    (58,'Duane Morris,Duane Morris,0,NULL,2016-01-01 00:00:00',NULL)
    (59,'DWF,DWF,0,NULL,2016-01-01 00:00:00',NULL)
    (60,'Eversheds,Eversheds,0,NULL,2016-01-01 00:00:00',NULL)
    (61,'Faegre Baker Daniels,Faegre Baker Daniels,0,NULL,2016-01-01 00:00:00',NULL)
    (62,'Fangda Partners,Fangda Partners,0,NULL,2016-01-01 00:00:00',NULL)
    (63,'Fasken Martineau DuMoulin,Fasken Martineau DuMoulin,0,NULL,2016-01-01 00:00:00',NULL)
    (64,'Fidal,Fidal,0,NULL,2016-01-01 00:00:00',NULL)
    (65,'Fieldfisher,Fieldfisher,0,NULL,2016-01-01 00:00:00',NULL)
    (66,'Foley & Lardner,Foley & Lardner,0,NULL,2016-01-01 00:00:00',NULL)
    (67,'"Fragomen, Del Rey, Bernsen & Loewy","Fragomen, Del Rey, Bernsen & Loewy",0,NULL,2016-01-01 00:00:00',NULL)
    (68,'Freshfields,Freshfields,0,NULL,2016-01-01 00:00:00',NULL)
    (69,'Freshfields Bruckhaus Deringer,Freshfields Bruckhaus Deringer,0,NULL,2016-01-01 00:00:00',NULL)
    (70,'"Fried, Frank, Harris, Shriver & Jacobson","Fried, Frank, Harris, Shriver & Jacobson",0,NULL,2016-01-01 00:00:00',NULL)
    (71,'Gadens,Gadens,0,NULL,2016-01-01 00:00:00',NULL)
    (72,'Gibert & Tobin,Gibert & Tobin,0,NULL,2016-01-01 00:00:00',NULL)
    (73,'"Gibson, Dunn & Crutcher","Gibson, Dunn & Crutcher",0,NULL,2016-01-01 00:00:00',NULL)
    (74,'Goodwin Procter,Goodwin Procter,0,NULL,2016-01-01 00:00:00',NULL)
    (75,'Gowling Lafleur Henderson,Gowling Lafleur Henderson,0,NULL,2016-01-01 00:00:00',NULL)
    (76,'Grandall Law Firm,Grandall Law Firm,0,NULL,2016-01-01 00:00:00',NULL)
    (77,'Greenberg Traurig,Greenberg Traurig,0,NULL,2016-01-01 00:00:00',NULL)
    (78,'Hall & Wilcock,Hall & Wilcock,0,NULL,2016-01-01 00:00:00',NULL)
    (79,'Henry Davis York,Henry Davis York,0,NULL,2016-01-01 00:00:00',NULL)
    (80,'Herbert Smith Freehills,Herbert Smith Freehills,0,NULL,2016-01-01 00:00:00',NULL)
    (81,'Hill Dickinson,Hill Dickinson,0,NULL,2016-01-01 00:00:00',NULL)
    (82,'Hills Dickinson,Hills Dickinson,0,NULL,2016-01-01 00:00:00',NULL)
    (83,'Hogan Lovells,Hogan Lovells,0,NULL,2016-01-01 00:00:00',NULL)
    (84,'Holding Redlich,Holding Redlich,0,NULL,2016-01-01 00:00:00',NULL)
    (85,'Holland & Knight,Holland & Knight,0,NULL,2016-01-01 00:00:00',NULL)
    (86,'Holman Fenwick William,Holman Fenwick William,0,NULL,2016-01-01 00:00:00',NULL)
    (87,'HSF,HSF,0,NULL,2016-01-01 00:00:00',NULL)
    (88,'Hughes Hubbard & Reed,Hughes Hubbard & Reed,0,NULL,2016-01-01 00:00:00',NULL)
    (89,'Hunt & Hunt ,Hunt & Hunt ,0,NULL,2016-01-01 00:00:00',NULL)
    (90,'Hunton & Williams,Hunton & Williams,0,NULL,2016-01-01 00:00:00',NULL)
    (91,'HWL Ebsworth,HWL Ebsworth,0,NULL,2016-01-01 00:00:00',NULL)
    (92,'Ince & Co,Ince & Co,0,NULL,2016-01-01 00:00:00',NULL)
    (93,'J&A Garrigues,J&A Garrigues,0,NULL,2016-01-01 00:00:00',NULL)
    (94,'Jackson Lewis,Jackson Lewis,0,NULL,2016-01-01 00:00:00',NULL)
    (95,'Jenner & Block,Jenner & Block,0,NULL,2016-01-01 00:00:00',NULL)
    (96,'Johnson Winter & Slattery,Johnson Winter & Slattery,0,NULL,2016-01-01 00:00:00',NULL)
    (97,'Jones Day,Jones Day,0,NULL,2016-01-01 00:00:00',NULL)
    (98,'Jun He,Jun He,0,NULL,2016-01-01 00:00:00',NULL)
    (99,'K&L Gates,K&L Gates,0,NULL,2016-01-01 00:00:00',NULL)
    (100,'Katten Muchin Rosenman,Katten Muchin Rosenman,0,NULL,2016-01-01 00:00:00',NULL)
    (101,'Kennedys,Kennedys,0,NULL,2016-01-01 00:00:00',NULL)
    (102,'Khai tan & Co,Khai tan & Co,0,NULL,2016-01-01 00:00:00',NULL)
    (103,'Kilpatrick Townsend & Stockton,Kilpatrick Townsend & Stockton,0,NULL,2016-01-01 00:00:00',NULL)
    (104,'Kim & Chang,Kim & Chang,0,NULL,2016-01-01 00:00:00',NULL)
    (105,'Kim &Chang,Kim &Chang,0,NULL,2016-01-01 00:00:00',NULL)
    (106,'King & Spalding,King & Spalding,0,NULL,2016-01-01 00:00:00',NULL)
    (107,'King & Wood Mallesons,King & Wood Mallesons,0,NULL,2016-01-01 00:00:00',NULL)
    (108,'Kirkland & Ellis,Kirkland & Ellis,0,NULL,2016-01-01 00:00:00',NULL)
    (109,'KWM,KWM,0,NULL,2016-01-01 00:00:00',NULL)
    (110,'Landers & Rogers,Landers & Rogers,0,NULL,2016-01-01 00:00:00',NULL)
    (111,'Latham & Watkins,Latham & Watkins,0,NULL,2016-01-01 00:00:00',NULL)
    (112,'Lee & Ko,Lee & Ko,0,NULL,2016-01-01 00:00:00',NULL)
    (113,'Lewis Brisbois Bisgaard & Smith,Lewis Brisbois Bisgaard & Smith,0,NULL,2016-01-01 00:00:00',NULL)
    (114,'Linklaters,Linklaters,0,NULL,2016-01-01 00:00:00',NULL)
    (115,'Littler Mendelson,Littler Mendelson,0,NULL,2016-01-01 00:00:00',NULL)
    (116,'Locke Lord,Locke Lord,0,NULL,2016-01-01 00:00:00',NULL)
    (117,'Loyens & Loeff,Loyens & Loeff,0,NULL,2016-01-01 00:00:00',NULL)
    (118,'Maddocks,Maddocks,0,NULL,2016-01-01 00:00:00',NULL)
    (119,'Mayer Brown,Mayer Brown,0,NULL,2016-01-01 00:00:00',NULL)
    (120,'McDermott Will & Emery,McDermott Will & Emery,0,NULL,2016-01-01 00:00:00',NULL)
    (121,'McGuireWoods,McGuireWoods,0,NULL,2016-01-01 00:00:00',NULL)
    (122,'Milbank Tweed,Milbank Tweed,0,NULL,2016-01-01 00:00:00',NULL)
    (123,'"Milbank, Tweed, Hadley & McCloy","Milbank, Tweed, Hadley & McCloy",0,NULL,2016-01-01 00:00:00',NULL)
    (124,'MIlls & Reeve,MIlls & Reeve,0,NULL,2016-01-01 00:00:00',NULL)
    (125,'Mills Oakley,Mills Oakley,0,NULL,2016-01-01 00:00:00',NULL)
    (126,'Minter Ellison,Minter Ellison,0,NULL,2016-01-01 00:00:00',NULL)
    (127,'Moray & Agnew,Moray & Agnew,0,NULL,2016-01-01 00:00:00',NULL)
    (128,'"Morgan, Lewis & Bockius","Morgan, Lewis & Bockius",0,NULL,2016-01-01 00:00:00',NULL)
    (129,'Mori Hamada & Matsumoto,Mori Hamada & Matsumoto,0,NULL,2016-01-01 00:00:00',NULL)
    (130,'Morrison & Foerster,Morrison & Foerster,0,NULL,2016-01-01 00:00:00',NULL)
    (131,'Nagashima Ohno & Tsunematsu,Nagashima Ohno & Tsunematsu,0,NULL,2016-01-01 00:00:00',NULL)
    (132,'Nishimura &Asahi,Nishimura &Asahi,0,NULL,2016-01-01 00:00:00',NULL)
    (133,'Nixon Peabody,Nixon Peabody,0,NULL,2016-01-01 00:00:00',NULL)
    (134,'Norton Rose Fulbright,Norton Rose Fulbright,0,NULL,2016-01-01 00:00:00',NULL)
    (135,'O\'Melveny & Myers,O\'Melveny & Myers,0,NULL,2016-01-01 00:00:00',NULL)
    (136,'Oatley,Oatley,0,NULL,2016-01-01 00:00:00',NULL)
    (137,'"Ogletree, Deakins, Nash, Smoak & Stewart","Ogletree, Deakins, Nash, Smoak & Stewart",0,NULL,2016-01-01 00:00:00',NULL)
    (138,'Olswang,Olswang,0,NULL,2016-01-01 00:00:00',NULL)
    (139,'"Orrick, Herrington & Sutcliffe","Orrick, Herrington & Sutcliffe",0,NULL,2016-01-01 00:00:00',NULL)
    (140,'Osborne Clarke,Osborne Clarke,0,NULL,2016-01-01 00:00:00',NULL)
    (141,'Paul Hastings,Paul Hastings,0,NULL,2016-01-01 00:00:00',NULL)
    (142,'"Paul, Weiss, Rifkind","Paul, Weiss, Rifkind",0,NULL,2016-01-01 00:00:00',NULL)
    (143,'"Paul, Weiss, Rifkind, Wharton & Garrison","Paul, Weiss, Rifkind, Wharton & Garrison",0,NULL,2016-01-01 00:00:00',NULL)
    (144,'Pepper Hamilton,Pepper Hamilton,0,NULL,2016-01-01 00:00:00',NULL)
    (145,'Perkins Coie,Perkins Coie,0,NULL,2016-01-01 00:00:00',NULL)
    (146,'Pillsbury Winthrop Shaw Pittman,Pillsbury Winthrop Shaw Pittman,0,NULL,2016-01-01 00:00:00',NULL)
    (147,'Pinsent Masons,Pinsent Masons,0,NULL,2016-01-01 00:00:00',NULL)
    (148,'Piper Alderman,Piper Alderman,0,NULL,2016-01-01 00:00:00',NULL)
    (149,'Polsinelli,Polsinelli,0,NULL,2016-01-01 00:00:00',NULL)
    (150,'Proskauer Rose,Proskauer Rose,0,NULL,2016-01-01 00:00:00',NULL)
    (151,'Quinn Emanuel Urquhart & Sullivan,Quinn Emanuel Urquhart & Sullivan,0,NULL,2016-01-01 00:00:00',NULL)
    (152,'Rajah & Tan,Rajah & Tan,0,NULL,2016-01-01 00:00:00',NULL)
    (153,'Reed Smith,Reed Smith,0,NULL,2016-01-01 00:00:00',NULL)
    (154,'Ropes & Gray,Ropes & Gray,0,NULL,2016-01-01 00:00:00',NULL)
    (155,'RPC,RPC,0,NULL,2016-01-01 00:00:00',NULL)
    (156,'Schulte Roth & Zabel,Schulte Roth & Zabel,0,NULL,2016-01-01 00:00:00',NULL)
    (157,'Seyfarth Shaw,Seyfarth Shaw,0,NULL,2016-01-01 00:00:00',NULL)
    (158,'Shearman & Sterling,Shearman & Sterling,0,NULL,2016-01-01 00:00:00',NULL)
    (159,'"Sheppard, Mullin, Richter & Hampton","Sheppard, Mullin, Richter & Hampton",0,NULL,2016-01-01 00:00:00',NULL)
    (160,'Shoosmiths,Shoosmiths,0,NULL,2016-01-01 00:00:00',NULL)
    (161,'Sidley Austin,Sidley Austin,0,NULL,2016-01-01 00:00:00',NULL)
    (162,'Simmons & Simmons,Simmons & Simmons,0,NULL,2016-01-01 00:00:00',NULL)
    (163,'Simpson Thacher & Bartlett,Simpson Thacher & Bartlett,0,NULL,2016-01-01 00:00:00',NULL)
    (164,'Simpson Thatcher,Simpson Thatcher,0,NULL,2016-01-01 00:00:00',NULL)
    (165,'Siqueira Castro,Siqueira Castro,0,NULL,2016-01-01 00:00:00',NULL)
    (166,'Skadden Arps,Skadden Arps,0,NULL,2016-01-01 00:00:00',NULL)
    (167,'"Skadden, Arps, Slate, Meagher & Flom","Skadden, Arps, Slate, Meagher & Flom",0,NULL,2016-01-01 00:00:00',NULL)
    (168,'Slaughter & May,Slaughter & May,0,NULL,2016-01-01 00:00:00',NULL)
    (169,'Slaughter and May,Slaughter and May,0,NULL,2016-01-01 00:00:00',NULL)
    (170,'Sparke Helmore Lawyers,Sparke Helmore Lawyers,0,NULL,2016-01-01 00:00:00',NULL)
    (171,'Squire Patton Boggs,Squire Patton Boggs,0,NULL,2016-01-01 00:00:00',NULL)
    (172,'Stephenson Harwood,Stephenson Harwood,0,NULL,2016-01-01 00:00:00',NULL)
    (173,'Sullivan & Cromwell,Sullivan & Cromwell,0,NULL,2016-01-01 00:00:00',NULL)
    (174,'Sullivan Cromwell,Sullivan Cromwell,0,NULL,2016-01-01 00:00:00',NULL)
    (175,'Taylor Wessing,Taylor Wessing,0,NULL,2016-01-01 00:00:00',NULL)
    (176,'Thomson Geer,Thomson Geer,0,NULL,2016-01-01 00:00:00',NULL)
    (177,'TLT,TLT,0,NULL,2016-01-01 00:00:00',NULL)
    (178,'TMI Associates,TMI Associates,0,NULL,2016-01-01 00:00:00',NULL)
    (179,'Travers Smith,Travers Smith,0,NULL,2016-01-01 00:00:00',NULL)
    (180,'TressCox Lawyers,TressCox Lawyers,0,NULL,2016-01-01 00:00:00',NULL)
    (181,'Troutman Sanders,Troutman Sanders,0,NULL,2016-01-01 00:00:00',NULL)
    (182,'Trowers and Hamlins,Trowers and Hamlins,0,NULL,2016-01-01 00:00:00',NULL)
    (183,'Venable,Venable,0,NULL,2016-01-01 00:00:00',NULL)
    (184,'Vinson & Elkin,Vinson & Elkin,0,NULL,2016-01-01 00:00:00',NULL)
    (185,'Vinson & Elkins,Vinson & Elkins,0,NULL,2016-01-01 00:00:00',NULL)
    (186,'"Wachtell, Lipton, Rosen & Katz","Wachtell, Lipton, Rosen & Katz",0,NULL,2016-01-01 00:00:00',NULL)
    (187,'Watson Farley & Williams,Watson Farley & Williams,0,NULL,2016-01-01 00:00:00',NULL)
    (188,'Weightmans,Weightmans,0,NULL,2016-01-01 00:00:00',NULL)
    (189,'Weil Gotshal & Manges,Weil Gotshal & Manges,0,NULL,2016-01-01 00:00:00',NULL)
    (190,'"Weil, Gotshal & Manges","Weil, Gotshal & Manges",0,NULL,2016-01-01 00:00:00',NULL)
    (191,'White & Case,White & Case,0,NULL,2016-01-01 00:00:00',NULL)
    (192,'Williams & Connolly,Williams & Connolly,0,NULL,2016-01-01 00:00:00',NULL)
    (193,'Willkie Farr & Gallagher,Willkie Farr & Gallagher,0,NULL,2016-01-01 00:00:00',NULL)
    (194,'Wilmer Cutler Pickering Hale and Dorr,Wilmer Cutler Pickering Hale and Dorr,0,NULL,2016-01-01 00:00:00',NULL)
    (195,'Wilson Elser Moskowitz Edelman & Dicker,Wilson Elser Moskowitz Edelman & Dicker,0,NULL,2016-01-01 00:00:00',NULL)
    (196,'Wilson Sonsini Goodrich & Rosati,Wilson Sonsini Goodrich & Rosati,0,NULL,2016-01-01 00:00:00',NULL)
    (197,'Winston & Strawn,Winston & Strawn,0,NULL,2016-01-01 00:00:00',NULL)
    (198,'Withers,Withers,0,NULL,2016-01-01 00:00:00',NULL)
    (199,'Wragge Lawrence Graham & Co,Wragge Lawrence Graham & Co,0,NULL,2016-01-01 00:00:00',NULL)
    (200,'Yingke,Yingke,0,NULL,2016-01-01 00:00:00',NULL)
    (201,'Zhong Lun,Zhong Lun,0,NULL,2016-01-01 00:00:00',NULL)
    (202,'Zhong Yin,Zhong Yin,0,NULL,2016-01-01 00:00:00',NULL)
    (203,'Zhong Yin Law Firm,Zhong Yin Law Firm,0,NULL,2016-01-01 00:00:00',NULL)

/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table company_profession
# ------------------------------------------------------------

LOCK TABLES `company_profession` WRITE;
/*!40000 ALTER TABLE `company_profession` DISABLE KEYS */;

INSERT INTO `company_profession` (`company_id`, `profession_id`)
VALUES
    (1,1);

/*!40000 ALTER TABLE `company_profession` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table company_service
# ------------------------------------------------------------

LOCK TABLES `company_service` WRITE;
/*!40000 ALTER TABLE `company_service` DISABLE KEYS */;

INSERT INTO `company_service` (`company_id`, `service_id`)
VALUES
    (1,2);

/*!40000 ALTER TABLE `company_service` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cron_task
# ------------------------------------------------------------

LOCK TABLES `cron_task` WRITE;
/*!40000 ALTER TABLE `cron_task` DISABLE KEYS */;

INSERT INTO `cron_task` (`id`, `name`, `commands`, `frequency`, `last_run`)
VALUES
    (1,'Automated published Statuses','php app/console crontasks:run','daily',NULL);

/*!40000 ALTER TABLE `cron_task` ENABLE KEYS */;
UNLOCK TABLES;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
