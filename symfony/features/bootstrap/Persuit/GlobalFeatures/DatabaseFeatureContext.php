<?php

namespace Persuit\GlobalFeatures;

use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Symfony2Extension\Context\KernelAwareContext;
use Behat\Gherkin\Node\TableNode;
use Persuit\Bundle\Api\Entity\OpportunityGroup;
use Persuit\Bundle\Api\Entity\Company;
use Persuit\Bundle\Api\Entity\CronTask;
use Persuit\Bundle\Api\Entity\Opportunity;
use Persuit\Bundle\Api\Entity\OpportunitySelectedProfile;
use Persuit\Bundle\Api\Entity\Profile;
use Persuit\Bundle\Api\Entity\ProfileExtension;
use Persuit\Bundle\Api\Entity\QuestionAnswer;
use Persuit\Bundle\Api\Entity\Offer;
use Symfony\Component\HttpKernel\KernelInterface;
use Doctrine\ORM\Tools\SchemaTool;
use Doctrine\Common\Inflector\Inflector;
use PHPUnit_Framework_Assert as Assertions;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;
use Symfony\Component\Validator\Constraints\DateTime;


/**
 * Defines application features from the specific context.
 */
class DatabaseFeatureContext implements Context, SnippetAcceptingContext, KernelAwareContext
{
    const GENERAL_TABLES_COMMAND = 'php bin/behat src/Persuit/Bundle/Api/Features/Fixtures/general-tables-populate.feature';
    const CONSTANTS_TABLES_COMMAND = 'php bin/behat src/Persuit/Bundle/Api/Features/Fixtures/constants-populate.feature';

    /**
     * @var \Symfony\Component\HttpKernel\KernelInterface $kernel
     */
    protected $kernel = null;
    protected $locationContext;

    /**
     * @param \Symfony\Component\HttpKernel\KernelInterface $kernel
     *
     * @return null
     */
    public function setKernel(KernelInterface $kernel)
    {
        $this->kernel = $kernel;
    }

    /** @BeforeScenario */
    public function gatherContexts(BeforeScenarioScope $scope)
    {
        $environment = $scope->getEnvironment();

        $this->locationContext = $environment->getContext('Persuit\GlobalFeatures\LocationContext');
    }

    /**
     * @return null
     */
    public function buildSchema()
    {
        $metadata = $this->getMetadata();

        if (!empty($metadata)) {
            $tool = new SchemaTool($this->getEntityManager());
            $tool->dropSchema($metadata);
            $tool->createSchema($metadata);
        }
    }

    /**
     * @Given I truncate table :arg1
     * @var $arg1 table_name
     */
    public function iTruncateTable($arg1)
    {
        $this->cleanTable($arg1);
    }

    public function getTableName($entityName)
    {
        $em = $this->getEntityManager();
        $cmd = $em->getClassMetadata($entityName);
        $tableName = $cmd->getTableName();

        return $tableName;
    }

    public function cleanTable($tableName)
    {
        $em = $this->getEntityManager();

        $connection = $em->getConnection();
        $dbPlatform = $connection->getDatabasePlatform();
        $connection->executeQuery('SET FOREIGN_KEY_CHECKS=0');
        $q = $dbPlatform->getTruncateTableSql($tableName);
        $connection->executeUpdate($q);
        $connection->executeQuery('SET FOREIGN_KEY_CHECKS=1');
    }

    /**
     * @Given the following :arg1 exist(s)
     */
    public function theFollowingExist(TableNode $table, $arg1, $refresh = null)
    {
        $arg1 = Inflector::classify(Inflector::singularize($arg1));

        switch($arg1)
        {
            case "Profile":
                try {
                    $this->createProfile($table);
                } catch (\Exception $e) {
                    throw $e;
                }
                break;

            case "ProfileExtension":
                try {
                    $this->createProfileExtension($table);
                } catch (\Exception $e) {
                    throw $e;
                }
                break;

            case "Opportunity":
                try {
                    if ($refresh) {
                        $this->cleanTable($arg1);
                    }
                    $this->createOpportunity($table);
                } catch(\Exception $e) {
                    throw $e;
                }
                break;

            case "OpportunityGroup":
                try {
                    if ($refresh) {
                        $this->cleanTable($arg1);
                    }
                    $this->createGroups($table);
                } catch(\Exception $e) {
                    throw $e;
                }
                break;

            case "CronTask":
                try {
                    $this->createCronTask($table);
                } catch (\Exception $e){
                    throw $e;
                }
                break;

            case "QuestionAnswer":
                try {
                    $this->createQuestionAnswer($table);
                } catch (\Exception $e){
                    throw $e;
                }
                break;

            case "Company":
                try {
                    $this->createCompany($table);
                } catch (\Exception $e){
                    throw $e;
                }
                break;
            case "OfferClientSecondment":
                try {
                    $this->createOfferClientSecondment($table);
                } catch (\Exception $e){
                    throw $e;
                }
                break;
            case "OfferClientHour":
                try {
                    $this->createOfferClientHour($table);
                } catch (\Exception $e){
                    throw $e;
                }
                break;
            case "CounterOfferSecondment":
                try {
                    if ($refresh) {
                        $this->cleanTable($arg1);
                    }
                    $this->createOfferClientSecondment($table);
                } catch(\Exception $e) {
                    throw $e;
                }
                break;
            case "OpportunitySelectedProfile":
                try{
                    $this->createOpportunitySelectedProfiles($table);
                }catch (\Exception $e){
                    throw $e;
                }
            break;
            default:
                try {
                    $this->createGenericRecords($table, $arg1);
                } catch (\Exception $e) {
                    throw $e;
                }

        }
    }

    /**
     * Takes a relation name and an id and attempts to find a record.
     */
    protected function retrieveRelation($relationName, $id)
    {
        if(! is_numeric($id))
        {
            return null;
        }

        $em = $this->getEntityManager();

        switch($relationName){
            case 'locations':
            case 'preferredSecondmentLocations' :
            case 'workLocations':
            case 'secondmentLocations':
            case 'practiceLocations':
            case 'admittedToPracticeLocations':
                $className = "PersuitLocationBundle:Location";
                break;

            case 'owningCompany':
            case 'invitedCompanies':
                $className = "PersuitApiBundle:Company";
                break;

            case 'invitedOffices':
                $className = "PersuitApiBundle:Office";
                break;

            case 'owningUser':
            case 'questionOwner':
            case 'answerOwner':
            case 'approver':
            case 'createdBy':
                $className = "PersuitApiBundle:User";
                break;

            case 'rateCurrency':
                $className = "PersuitApiBundle:Currency";
                break;

            case 'offer':
                $className = "PersuitApiBundle:Offer";
                break;

            case 'secondment':
                $className = "PersuitApiBundle:OpportunitySecondment";
                break;

            case 'logo':
            case 'tcFile':
                $className = "PersuitApiBundle:FileUpload";
                break;

            default:
                $className = 'PersuitApiBundle:'.Inflector::classify(Inflector::singularize($relationName));

        }

        $repo = $em->getRepository($className);

        if($repo){
            $entity = $em->getRepository($className)->find($id);
            if($entity)
            {
                return $entity;
            }
        }
        throw new \Exception('Entity not found '.$relationName.' '.$id);
    }

    /**
     * Creates a profile record
     */
    protected function createProfile(TableNode $table)
    {
        // default values so behat tests don't need to include every field.
        $defaultValues = [
            'id'                            => null,
            'firstName'                     => 'Rick',
            'lastName'                      => 'Toiano',
            'initial'                       => 'RT',
            'availableForSecondment'        => 1,
            'availableForSecondmentFrom'    => date_create(date('Y-m-d', strtotime('+1 months'))),
            'availableForSecondmentTo'      => date_create(date('Y-m-d', strtotime('+9 months'))),
            'indicativeMonthlyRate'         => null,
            'currentJobTitle'               => null,
            'seniorityYearsOfExperience'    => null,
            'photoUrl'                      => 'http://jacquelinebrocker.net/wp-content/uploads/2013/10/MarkStrong03.jpg',
            'admittedToPracticeCourts'      => 'Muffin cupcake lemon drops cookie. Jelly beans icing dragée topping caramels cake.',
            'biography'                     => 'Cupcake ipsum dolor. Sit amet cake soufflé tootsie roll soufflé. Sweet jelly-o marzipan lemon drops marshmallow. Sugar plum chupa chups gummi bears jelly-o dessert danish ice cream. Tart chocolate jujubes toffee halvah pastry. Cake biscuit dragée. Sweet brownie lollipop. Apple pie jelly-o oat cake jelly beans cake cupcake danish.
Soufflé dragée caramels. Caramels sweet tart fruitcake soufflé candy bear claw. Dessert marzipan gingerbread tootsie roll topping ice cream chupa chups jelly beans. Tiramisu macaroon chocolate bar. Topping lollipop ice cream jujubes. Candy chupa chups halvah cake.
Chupa chups tiramisu lemon drops soufflé cheesecake apple pie gummi bears. Jelly beans biscuit biscuit cake tart tootsie roll sugar plum soufflé. Chupa chups pastry cookie. Bonbon bonbon danish toffee macaroon. Gummies dessert pastry marzipan cake croissant tart soufflé wafer. Carrot cake pastry jelly sesame snaps pie candy canes. Oat cake jelly chocolate cake candy sugar plum. Gingerbread cheesecake chocolate bar. Sugar plum pastry pie jelly toffee gummies croissant marzipan. Powder cotton candy carrot cake croissant.',
            'education'                     => null,

        ];

        // special relation fields that require a related entity to be created. This will be used later in the algorithm.
        $relationFields = [
            'profession'                  => null,
            'company'                     => null,
            'rateCurrency'                => null,
            'seniority'                   => null,
            'practiceArea'                => null,
            'practiceSubArea'             => null,
            'industrySector'              => null,
            'industrySubSector'           => null,
            'language'                    => null,
            'office'                      => null,
            'secondmentLocations'         => null,
            'admittedToPracticeLocations' => null,
            'profileExtension'            => null
        ];

        // create the full list of default values including the relationFields.
        $defaultValues = array_merge($defaultValues, $relationFields);

        $em = $this->getEntityManager();

        foreach($table as $row)
        {
            /*
             * Check for unknown keys.
             * It compares the head of the table on the *.feature against the array $defaultValues
             * if it does not match throw exception
             */

            if(count(array_diff_key($row, $defaultValues)) > 0)
            {
                throw new \Exception('Unknown key in create profile for test');
            }

            // merge the given values with the default ones.
            $fieldValues = array_merge($defaultValues, $row);

            $profile = new Profile();

            $profile->setFirstName($fieldValues['firstName'])
                ->setLastName($fieldValues['lastName'])
                ->setInitial($fieldValues['initial'])
                ->setAvailableForSecondment($fieldValues['availableForSecondment'])
                ->setIndicativeMonthlyRate($fieldValues['indicativeMonthlyRate'])
                ->setCurrentJobTitle($fieldValues['currentJobTitle'])
                ->setSeniorityYearsOfExperience($fieldValues['seniorityYearsOfExperience'])
                ->setAdmittedToPracticeCourts($fieldValues['admittedToPracticeCourts'])
                ->setBiography($fieldValues['biography'])
            ;

            if( is_string($fieldValues['availableForSecondmentFrom']) && trim($fieldValues['availableForSecondmentFrom']) != "" )
            {
                $d = date_create(date('Y-m-d', strtotime($fieldValues['availableForSecondmentFrom'])));
                $profile->setAvailableForSecondmentFrom($d);
            }
            elseif( $fieldValues['availableForSecondmentFrom'] instanceof \DateTimeInterface )
            {
                $profile->setAvailableForSecondmentFrom($fieldValues['availableForSecondmentFrom']);
            }

            if( is_string($fieldValues['availableForSecondmentTo']) && trim($fieldValues['availableForSecondmentTo']) != "" )
            {
                $d = date_create(date('Y-m-d', strtotime($fieldValues['availableForSecondmentTo'])));
                $profile->setAvailableForSecondmentTo($d);
            }
            elseif( $fieldValues['availableForSecondmentTo'] instanceof \DateTimeInterface )
            {
                $profile->setAvailableForSecondmentTo($fieldValues['availableForSecondmentTo']);
            }

            $profile = $this->createAssignEntity($relationFields, $fieldValues, $profile);
            $em->persist($profile);
        }
        $em->flush();
    }

    /**
     * Creates extensions for profiles
     */
    protected function createProfileExtension(TableNode $table)
    {
        $defaultValues = [
            'id' => null,
            'versionName' => null,
            'professionalHeadline' => null,
            'professionalDetails' => null,
            'default' => false,
        ];

        $relationFields = [
            'profile'  => NULL
        ];

        // create the full list of default values including the relationFields.
        $defaultValues = array_merge($defaultValues, $relationFields);

        $em = $this->getEntityManager();


        foreach($table as $row){
            $entity = new ProfileExtension();
            // check for unkonwn keys
            if(count(array_diff_key($row, $defaultValues)) > 0)
            {
                throw new \Exception('Unknown key in create profile extension: '.print_r($row));
            }

            // merge the given values with the default ones.
            $defaultValues = array_merge($defaultValues, $row);
            $entity
                ->setId($defaultValues['id'])
                ->setVersionName($defaultValues['versionName'])
                ->setProfessionalHeadline($defaultValues['professionalHeadline'])
                ->setProfessionalDetails($defaultValues['professionalDetails'])
                ->setDefault($defaultValues['default'])
            ;
            $entity = $this->createAssignEntity($relationFields, $defaultValues, $entity);
            $em->persist($entity);
        }
        $em->flush();
    }

    protected function createOpportunity(TableNode $table)
    {
        $defaultValues = [
            'id'                => null,
            'status'            => 'draft',
            'type'              => 'secondment',
            'headline'          => 'Cupcake ipsum dolor.',
            'description'       => ' Sweet chocolate bar marshmallow. Gingerbread cheesecake toffee. Gummi bears pudding bear claw cookie. Donut caramels brownie soufflé apple pie. Cake jelly-o danish lemon drops. Croissant candy canes topping pie. Tart marshmallow cake bonbon marzipan candy. Pie cheesecake candy candy. Lemon drops gummies halvah pudding cake biscuit pastry chupa chups. Jujubes marshmallow powder pastry muffin carrot cake muffin. Wafer gummi bears lollipop ice cream cookie sesame snaps. Gummies jelly dragée croissant pastry fruitcake. Sugar plum gummies apple pie chocolate bar jujubes gummi bears icing powder.',
            'requesterName'     => '',
            'requesterTitle'    => '',
            'startDate'         => date_create(date('Y-m-d', strtotime('+6 months'))),
            'budgetRangeStart'  => null,
            'budgetRangeEnd'    => null,
            'inviteOnly'        => false,
            'seeInvitedFirms'   => false,
            'publishDate'       => null,
            'expiryDate'        => null,
            'publishDuration'   => 5,
            'automatedStatus'   => null
        ];

        $relationFields = [
            'invitedCompanies'  => null,
            'invitedOffices'    => null,
            'owningCompany'     => null,
            'owningUser'        => null,
            'approver'          => null,
            'profession'        => null,
            'tcFile'            => null,
            'industrySector'    => null,
            'industrySubSector' => null,
            'practiceArea'      => null,
            'practiceSubArea'   => null,
            'currency'          => null,
            'locations'         => null,
        ];

        // create the full list of default values including the relationFields.
        $defaultValues = array_merge($defaultValues, $relationFields);

        $em = $this->getEntityManager();

        foreach($table as $row){
            // check for unkonwn keys
            if(count(array_diff_key($row, $defaultValues)) > 0)
            {
                throw new \Exception('Unknown key in create secondment opp for test:'.print_r(array_diff_key($row, $defaultValues)));
            }

            // merge the given values with the default ones.
            $fieldValues = array_merge($defaultValues, $row);

            $entity = new Opportunity();

            $entity->setStatus($fieldValues['status']);
            $entity->setType($fieldValues['type']);
            $entity->setHeadline($fieldValues['headline']);
            $entity->setDescription($fieldValues['description']);
            $entity->setStartDate($fieldValues['startDate']);
            $entity->setRequesterName($fieldValues['requesterName']);
            $entity->setRequesterTitle($fieldValues['requesterTitle']);
            $entity->setBudgetRangeStart($fieldValues['budgetRangeStart']);
            $entity->setBudgetRangeEnd($fieldValues['budgetRangeEnd']);
            $entity->setInviteOnly($fieldValues['inviteOnly']);
            $entity->setSeeInvitedFirms($fieldValues['seeInvitedFirms']);

            if(Opportunity::STATUS_DRAFT == $fieldValues['status'] || Opportunity::STATUS_UNAPPROVED == $fieldValues['status']){
                $entity->setPublishDate(null);
                $entity->setExpiryDate(null);
            } else {
                $this->setPublishedExpiredDates($fieldValues['status'], $fieldValues['publishDuration'], $entity, $fieldValues['automatedStatus']);
            }

            $entity = $this->createAssignEntity($relationFields, $fieldValues, $entity);
            $em->persist($entity);
        }
        $em->flush();
    }

    private function setPublishedExpiredDates($status, $publishDuration, $entity, $automatedStatus)
    {
        $publishDate = new \DateTime();

        if($automatedStatus){
            /** Used only for opportunity-automated-status.feature */
            $publishDate = $publishDate->format('Y-m-d');

            if ((Opportunity::STATUS_PUBLISHED == $status)) {

                $entity->setPublishDate(new \DateTime(date('Y-m-d 23:00:00', strtotime($publishDate." - 2 days"))));

                $entity->setPublishDuration(new \DateTime(date('Y-m-d 23:00:00', strtotime($publishDate." - 1 days"))));
                $entity->setExpiryDate(new \DateTime(date('Y-m-d 23:00:00', strtotime($publishDate." - 1 days"))));

            } else if ((Opportunity::STATUS_DEALTIME == $status)) {

                $entity->setPublishDate(new \DateTime(date('Y-m-d 23:00:00', strtotime($publishDate." - 9 days"))));

                $publishDuration = date('Y-m-d 23:00:00', strtotime($publishDate." - 8 days"));

                $entity->setPublishDuration(new \DateTime($publishDuration));
                $entity->setExpiryDate(new \DateTime(date('Y-m-d 23:00:00', strtotime($publishDuration." + 7 days"))));

            }

        }else {

            if ((Opportunity::STATUS_PUBLISHED == $status)) {

                $entity->setPublishDate(new \DateTime());
                $publishDurationDate = $publishDate->add(new \DateInterval('P'.$publishDuration.'D'));
                $entity->setPublishDuration($publishDurationDate);
                $entity->setExpiryDate($publishDurationDate);

            } else if ((Opportunity::STATUS_DEALTIME == $status)) {
                    $publishDate = $publishDate->format('Y-m-d');

                    $publishDate = date('Y-m-d 23:59:59', strtotime($publishDate." - 1 days"));

                    $publishDate = date('Y-m-d 23:59:59', strtotime($publishDate." - {$publishDuration} days"));
                    $entity->setPublishDate(new \DateTime($publishDate));

                    $publishDuration = date('Y-m-d 23:59:59', strtotime($publishDate." + {$publishDuration} days"));
                    $entity->setPublishDuration(new \DateTime($publishDuration));

                    $expire = date('Y-m-d 23:59:59', strtotime($publishDuration." + 7 days"));
                    $entity->setExpiryDate(new \DateTime($expire));
            }
        }
    }

    protected function createOpportunitySelectedProfiles(TableNode $table)
    {
        $defaultValues = [
            'id'    => null,
            'hours' => 50
        ];
        $relationFields = [
            'opportunityGroup'   => null,
            'profileExtension'   => null
        ];

        // create the full list of default values includeing the relationFields.
        $defaultValues = array_merge($defaultValues, $relationFields);

        $em = $this->getEntityManager();

        foreach($table as $row){
            // check for unkonwn keys
            if(count(array_diff_key($row, $defaultValues)) > 0)
            {
                throw new \Exception('Unknown key in create opportunity selected profiles for test:'.print_r(array_diff_key($row, $defaultValues)));
            }

            // merge the given values with the default ones.
            $fieldValues = array_merge($defaultValues, $row);

            $entity = new OpportunitySelectedProfile();

            $entity->setHours($fieldValues['hours']);

            $entity = $this->createAssignEntity($relationFields, $fieldValues, $entity);
            $em->persist($entity);

        }
        $em->flush();
    }

    protected function createGroups(TableNode $table)
    {
        $defaultValues = [
            'id'                    => NULL,
            'yearsSeniority'        => NULL,
            'quantity'              => NULL,
            'daysPerWeek'           => 5,
            'admittedPracticeCourt' => NULL,

        ];
        $relationFields = [
            'opportunity'       => NULL,
            'seniority'         => NULL,
            'practiceLocations' => NULL,
            'languages'         => NULL
        ];

        // create the full list of default values including the relationFields.
        $defaultValues = array_merge($defaultValues, $relationFields);

        $em = $this->getEntityManager();

        foreach($table as $row){
            // check for unkonwn keys
            if(count(array_diff_key($row, $defaultValues)) > 0)
            {
                throw new \Exception("Unknown key in create Group of secondees for test");
            }

            // merge the given values with the default ones.
            $fieldValues = array_merge($defaultValues, $row);

            $entity = new OpportunityGroup();

            $entity->setYearsSeniority($fieldValues['yearsSeniority']);
            $entity->setQuantity($fieldValues['quantity']);
            $entity->setDaysPerWeek($fieldValues['daysPerWeek']);
            $entity->setAdmittedPracticeCourt($fieldValues['admittedPracticeCourt']);

            $entity = $this->createAssignEntity($relationFields, $fieldValues, $entity);
            $em->persist($entity);
        }
        $em->flush();
    }

    protected function createCompany(TableNode $table)
    {
        $defaultValues = [
            'id'            => null,
            'name'          => 'ABC PTY',
            'registered'    => false,
            'description'   => 'test description'
        ];
        $relationFields = [
            'profession'    => null,
            'service'       => null,
            'logo'  => null
        ];

        // create the full list of default values including the relationFields.
        $defaultValues = array_merge($defaultValues, $relationFields);

        $em = $this->getEntityManager();
        foreach($table as $row){
            // check for unkonwn keys
            if(count(array_diff_key($row, $defaultValues)) > 0)
            {
                throw new \Exception("Unknown key in create Group of secondees for test");
            }

            // merge the given values with the default ones.
            $fieldValues = array_merge($defaultValues, $row);

            $entity = new Company();

            $entity->setName($fieldValues['name'])
                ->setRegistered($fieldValues['registered'])
                ->setDescription($fieldValues['description'])
            ;

            $entity = $this->createAssignEntity($relationFields, $fieldValues, $entity);
            $em->persist($entity);
        }
        $em->flush();

    }

    /**
     * Creates a secondment offer record
     */
    protected function createOfferClientSecondment(TableNode $table)
    {
        // default values so behat tests don't need to include every field.
        $defaultValues = [
            'id' => null,
            'comments' => 'Test Offer Comments',
            'amendments' => '',
            'status' => 'draft',
            'total' => '',
            'type' => 'clientSecondment'
        ];

        // special relation fields that require a related entity to be created. This will be used later in the algorithm.
        $relationFields = [
            'opportunity' => null,
            'company' => null,
            'createdBy' => null,
            'offer' => null,
            'tcFile' => null,
        ];

        // create the full list of default values including the relationFields.
        $defaultValues = array_merge($defaultValues, $relationFields);

        $em = $this->getEntityManager();

        foreach($table as $row)
        {
            /*
             * Check for unknown keys.
             * It compares the head of the table on the *.feature against the array $defaultValues
             * if it does not match throw exception
             */
            if(count(array_diff_key($row, $defaultValues)) > 0)
            {
                throw new \Exception('Unknown key in create offer secondment');
            }

            // merge the given values with the default ones.
            $fieldValues = array_merge($defaultValues, $row);

            $entity = new Offer();

            $entity->setStatus($fieldValues['status'])
                ->setComments($fieldValues['comments'])
                ->setAmendments($fieldValues['amendments'])
                ->setTotal($fieldValues['total'])
                ->setType($fieldValues['type']);

            $entity = $this->createAssignEntity($relationFields, $fieldValues, $entity);
            $em->persist($entity);
        }

        $em->flush();
    }

    /**
     * Creates a secondment offer record
     */
    protected function createOfferClientHour(TableNode $table)
    {
        // default values so behat tests don't need to include every field.
        $defaultValues = [
            'id' => null,
            'comments' => 'Test Offer Comments',
            'amendments' => '',
            'status' => 'draft',
            'total' => '',
            'type' => 'clientHours'
        ];

        // special relation fields that require a related entity to be created. This will be used later in the algorithm.
        $relationFields = [
            'opportunity' => null,
            'company' => null,
            'createdBy' => null,
            'offer' => null,
            'tcFile' => null,
        ];

        // create the full list of default values including the relationFields.
        $defaultValues = array_merge($defaultValues, $relationFields);

        $em = $this->getEntityManager();

        foreach($table as $row)
        {
            if(count(array_diff_key($row, $defaultValues)) > 0)
            {
                throw new \Exception('Unknown key in create offer client hours');
            }

            // merge the given values with the default ones.
            $fieldValues = array_merge($defaultValues, $row);

            $entity = new Offer();

            $entity->setStatus($fieldValues['status'])
                ->setComments($fieldValues['comments'])
                ->setAmendments($fieldValues['amendments'])
                ->setTotal($fieldValues['total'])
                ->setType($fieldValues['type']);

            $entity = $this->createAssignEntity($relationFields, $fieldValues, $entity);
            $em->persist($entity);
        }

        $em->flush();
    }

    /**
     * Goes through each relationField and
     * - checks for an id
     * - retrieves the matching entity (assumes it exists, doesn't create it.)
     * - assign the entity.
     */
    private function createAssignEntity($relationFields, $fieldValues, $entity)
    {
        foreach($relationFields as $key => $value) {
            if ($fieldValues[$key] != null) {
                // if there are multiple ids, repeat for each id.
                $values = explode(',', $fieldValues[$key]);
                foreach ($values as $value) {
                    // look up the entity.
                    $relation = $this->retrieveRelation($key, $value);
                    if ($relation != null) {
                        // try the setEntity method on Profile. E.g. setCompany.
                        $functionName = 'set'.ucwords($key);
                        if (method_exists($entity, $functionName)) {
                            $entity->$functionName($relation);
                        }
                        // the setEntity method doesn't exist try the addEntity method. E.g. addPracticeArea.
                        else {
                            // the add method is always singular
                            $functionName = 'add'.Inflector::classify(Inflector::singularize($key));
                            if (method_exists($entity, $functionName)) {
                                $entity->$functionName($relation);
                            }
                            else {
                                throw new \Exception('Can\'t create entity relationship '.$functionName);
                            }
                        }
                    }
                }
            }
        }

        return $entity;
    }

    protected function createCronTask(TableNode $table)
    {
        $defaultValues = [
            'name'      => "Task one",
            'commands'   => "ls",
            'frequency'  => "daily"
        ];

        $em = $this->getEntityManager();

        foreach($table as $row)
        {
            // check for unkonwn keys
            if(count(array_diff_key($row, $defaultValues)) > 0)
            {
                throw new \Exception('Unknown key in create CronJobTasks for test');
            }

            // merge the given values with the default ones.
            $fieldValues = array_merge($defaultValues, $row);

            $entity = new CronTask();

            $entity->setName($fieldValues['name'])
                ->setCommands($fieldValues['commands'])
                ->setFrequency($fieldValues['frequency']);

            $em->persist($entity);
        }

        $em->flush();
    }

    public function getDoctrineRepository($class)
    {
        return $this->kernel->getContainer()->get('doctrine')->getRepository($class);
    }

    /**
     * @return array
     */
    protected function getMetadata()
    {
        return $this->getEntityManager()->getMetadataFactory()->getAllMetadata();
    }

    /**
     * @return \Doctrine\ORM\EntityManager
     */
    protected function getEntityManager()
    {
        return $this->kernel->getContainer()->get('doctrine.orm.entity_manager');
    }

    protected function createQuestionAnswer(TableNode $table)
    {
        $defaultValues = [
            'id' => null,
            'question' => 'This is a question?',
            'answer' => null
        ];

        $relationFields = [
            'opportunity'   => null,
            'questionOwner' => null,
            'answerOwner'   => null
        ];

        // create the full list of default values including the relationFields.
        $defaultValues = array_merge($defaultValues, $relationFields);

        $em = $this->getEntityManager();

        foreach($table as $row){
            // check for unkonwn keys
            if(count(array_diff_key($row, $defaultValues)) > 0)
            {
                throw new \Exception("Unknown key in create Group of secondees for test");
            }

            // merge the given values with the default ones.
            $fieldValues = array_merge($defaultValues, $row);

            $entity = new QuestionAnswer();

            $entity
                ->setQuestion($fieldValues['question'])
                ->setAnswer($fieldValues['answer'])
            ;

            $entity = $this->createAssignEntity($relationFields, $fieldValues, $entity);
            $em->persist($entity);
        }
        $em->flush();

    }

    /**
     * Create records - works for most entities.
     */
    protected function createGenericRecords(TableNode $table, $entityClass)
    {
        $em = $this->getEntityManager();

        $entityNamespace = 'Persuit\Bundle\Api\Entity\\'.$entityClass;

        if(! class_exists($entityNamespace))
            throw new \Exception("Unrecognised entity {$entityClass}");

        foreach($table as $row){

            $entity = new $entityNamespace();

            foreach ($row as $key => $value){

                $setProperty = 'set'.Inflector::classify(Inflector::singularize($key));

                if (method_exists($entity, $setProperty)){

                    $relationalClass = 'Persuit\Bundle\Api\Entity\\'.Inflector::classify(Inflector::singularize($key));

                    if (class_exists($relationalClass)) {

                        if ($value) {
                            $relationRetrieved = $this->retrieveRelation($key,$value);
                            $entity->$setProperty($relationRetrieved);
                        }

                    } else {
                        $entity->$setProperty($value);
                    }

                } else {
                    $addProperty = 'add'.Inflector::classify(Inflector::singularize($key));

                    if ($value){

                        // if there are multiple ids, repeat for each id.
                        $relations = explode(',', $value);

                        foreach ($relations as $relation){

                            $relationRetrieved = $this->retrieveRelation($key,$relation);

                            if(method_exists($entity, $addProperty))
                                $entity->$addProperty($relationRetrieved);

                            else
                                throw new \Exception('Can\'t create entity relationship '.$addProperty);
                        }
                    }
                }
            }
            $em->persist($entity);
        }
        $em->flush();
    }

    /**
     * @Then opportunity :arg1 has companies :arg2
     */
    public function opportunityHasCompanies($arg1, $arg2)
    {
        $em = $this->getEntityManager();
        $em->clear(); // clear the em cache
        $repo = $em->getRepository("PersuitApiBundle:Opportunity");
        $opportunity = $repo->find($arg1);

        if(! $opportunity)
        {
            throw new \Exception('Opportunity not found');
        }

        if($arg2 == 'null')
        {
            Assertions::assertEquals(count($opportunity->getInvitedCompanies()), 0);
        }
        else
        {
            $companies = explode(',', $arg2);

            Assertions::assertEquals(count($companies), count($opportunity->getInvitedCompanies()));

            foreach($opportunity->getInvitedCompanies() as $company)
            {
                if(! in_array($company->getId(), $companies))
                {
                    throw new \Exception('Unexpected company in opportunity');

                }
            }
        }
    }
    /**
     * @Then opportunity :arg1 has offices :arg2
     */
    public function opportunityHasOffices($arg1, $arg2)
    {
        $em = $this->getEntityManager();
        $em->clear(); // clear the em cache
        $repo = $em->getRepository("PersuitApiBundle:Opportunity");
        $opportunity = $repo->find($arg1);

        if(! $opportunity)
        {
            throw new \Exception('Opportunity not found');
        }

        if($arg2 == 'null')
        {
            Assertions::assertEquals(count($opportunity->getInvitedOffices()), 0);
        }
        else
        {
            $companies = explode(',', $arg2);

            Assertions::assertEquals(count($companies), count($opportunity->getInvitedOffices()));

            foreach($opportunity->getInvitedOffices() as $company)
            {
                if(! in_array($company->getId(), $companies))
                {
                    throw new \Exception('Unexpected company in opportunity');

                }
            }
        }
    }

    /**
     * @Given /^from bundle "([^"]*)" check if "([^"]*)" id (.*) was (.*) found$/
     */
    public function fromBundleCheckIfIdWasFound($arg1, $arg2, $id, $count)
    {
        $em = $this->getEntityManager();
        $em->clear();
        $entityNamespace = 'Persuit\Bundle\\'.$arg1.'\Entity\\'.$arg2;

        $repo = $em->getRepository($entityNamespace);
        $entity = $repo->findBy(array('id'=>$id));

        Assertions::assertEquals(count($entity), $count);
    }

    /**
     * @Given /^check opportunity (.*) and field (.*) was changed (.*) (\d+)$/
     */
    public function checkOpportunityAndFieldWasChanged($id, $field, $search, $count)
    {
        //die('field:'.$field);

        $em = $this->getEntityManager();
        $em->clear();
        $entityNamespace = 'Persuit\Bundle\Api\Entity\Opportunity';

        $repo = $em->getRepository($entityNamespace);

        if("" == $field){
            $entity = $repo->findBy(array('id'=>$id));
        }
        elseif("" == $id){
            $entity = $repo->findBy( array($field => $search) );

        }else{
            $entity = $repo->findOneBy(
                array(
                    'id'=>$id,
                    $field => $search
                )
            );
        }
        Assertions::assertEquals(count($entity), $count);

    }

    /**
     * @Given /^check opportunity "([^"]*)" was not saved "(.*)" (\d+)$/
     */
    public function checkOpportunityWasNotSaved($field, $search, $count)
    {
        $em = $this->getEntityManager();
        $em->clear();
        $entityNamespace = 'Persuit\Bundle\Api\Entity\Opportunity';

        $repo = $em->getRepository($entityNamespace);

        $entity = $repo->findOneBy(
            array(
                $field => $search
            )
        );

        Assertions::assertEquals(count($entity), $count);

    }

    /**
     * @Given /^opportunity (\d+) has Unlisted companies "([^"]*)"$/
     */
    public function opportunityHasUnlistedCompanies($arg1, $arg2)
    {
        $em = $this->getEntityManager();
        $em->clear(); // clear the em cache
        $repo = $em->getRepository("PersuitApiBundle:Opportunity");
        $so = $repo->find($arg1);

        if(! $so)
        {
            throw new \Exception('Opportunity not found');
        }

        if($arg2 == 'null')
        {
            Assertions::assertEquals(count($so->getUnlistedCompanies()), 0);
        }
        else
        {
            $unlistedCompanies = explode(',', $arg2);

            Assertions::assertEquals(count($unlistedCompanies), count($so->getUnlistedCompanies()));

            foreach($so->getUnlistedCompanies() as $unlisted)
            { $savedUnlisted[] = $unlisted->getId();
                if(! in_array($unlisted->getId(), $unlistedCompanies))
                {
                    throw new \Exception('Unexpected unlisted company in opportunity');

                }
            }
        }
    }

    /**
     * @Given /^I loadDB$/
     */
    public function iLoadDB()
    {
        $em = $this->getEntityManager();
        $countUsers = count($em->getRepository('PersuitApiBundle:User')->findAll());
        $countActivities = count($em->getRepository('PersuitApiBundle:Activity')->findAll());

        //Check if the fixture data is loaded already by checking a constant like Activity
        if (!$countUsers || !$countActivities) {
            $this->output = shell_exec(self::GENERAL_TABLES_COMMAND);
        }
    }

    /**
     * @Given /^I loadConstants$/
     */
    public function iLoadConstants()
    {
        $em = $this->getEntityManager();
        $countUsers = count($em->getRepository('PersuitApiBundle:User')->findAll());
        $countActivities = count($em->getRepository('PersuitApiBundle:Activity')->findAll());

        //Check if the fixture data is loaded already by checking a constant like Activity
        if (!$countActivities || $countUsers) {
            $this->output = shell_exec(self::CONSTANTS_TABLES_COMMAND);
        }
    }

    /**
     * @When /^cronJob run then check status to change$/
     */
    public function cronjobRunThenCheckStatusToChange()
    {
        $this->output = shell_exec("php app/console crontasks:run");
    }

    /**
     * @Given /^user from office should be assigned to opportunity "([^"]*)"$/
     */
    public function userFromOfficeShouldBeAssignedToOpportunity($arg1)
    {
        $em = $this->getEntityManager();
        $em->clear(); // clear the em cache
        $repo = $em->getRepository("PersuitApiBundle:Opportunity");
        $opportunity = $repo->find($arg1);

        if(! $opportunity)
        {
            throw new \Exception("Opportunity: {$arg1} not found");
        }

        foreach($opportunity->getInvitedOffices() as $office){
            $offices[] = $office->getId();
        }

        $userRepo = $em->getRepository("PersuitApiBundle:User");
        $officeUsers = $userRepo->userSupplierToOfferPerOffices($offices, $opportunity->getProfession());

        $assignEntity = $em->getRepository("PersuitApiBundle:OpportunityAssign");
        $assignments = $assignEntity->findBy(array('opportunity' => $opportunity));

        if(true == $opportunity->getInviteOnly()){
            Assertions::assertEquals(count($officeUsers),count($assignments));
        } else {
            $arrAssignments = [];
            foreach ($assignments as $assignedUser){
                $arrAssignments[] = $assignedUser->getUser()->getId();
            }

            foreach($officeUsers as $officeUser){
                Assertions::assertContains($officeUser->getId(),$arrAssignments);
            }

        }

    }

    /**
     * @Given /^I run CronJob$/
     */
    public function iRunCronJob()
    {
        $this->output = shell_exec("/var/www/api/symfony/app/console crontasks:run");
    }

}
