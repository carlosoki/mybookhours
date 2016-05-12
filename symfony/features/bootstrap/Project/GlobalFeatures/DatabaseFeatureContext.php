<?php

namespace Project\GlobalFeatures;

use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Symfony2Extension\Context\KernelAwareContext;
use Behat\Gherkin\Node\TableNode;
use Symfony\Component\HttpKernel\KernelInterface;
use Doctrine\ORM\Tools\SchemaTool;
use Doctrine\Common\Inflector\Inflector;

/**
 * Defines application features from the specific context.
 */
class DatabaseFeatureContext implements Context, SnippetAcceptingContext, KernelAwareContext
{
    const GENERAL_TABLES_COMMAND = 'php bin/behat src/Project/Bundle/Api/Features/Fixtures/general-tables-populate.feature';
    const CONSTANTS_TABLES_COMMAND = 'php bin/behat src/Project/Bundle/Api/Features/Fixtures/constants-populate.feature';

    /**
     * @var \Symfony\Component\HttpKernel\KernelInterface $kernel
     */
    private $kernel = null;

    /**
     * @param \Symfony\Component\HttpKernel\KernelInterface $kernel
     *
     * @return null
     */
    public function setKernel(KernelInterface $kernel)
    {
        $this->kernel = $kernel;
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
     *
     * @param TableNode $table
     * @param $arg1
     * @throws \Exception
     */
    public function theFollowingExist(TableNode $table, $arg1)
    {
        $arg1 = Inflector::classify(Inflector::singularize($arg1));

        switch ($arg1) {
            case 'OpportunitySelectedProfile':
                try {
                    $this->createOpportunitySelectedProfiles($table);
                } catch (\Exception $e) {
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
     *
     * @param $relationName
     * @param $id
     * @return null|object
     * @throws \Exception
     */
    private function retrieveRelation($relationName, $id)
    {
        if (! is_numeric($id)) {
            return null;
        }

        $em = $this->getEntityManager();

        switch ($relationName) {
            case 'invitedCompanies':
                $className = 'ProjectApiBundle:Company';
                break;

            default:
                $className = 'ProjectApiBundle:'.Inflector::classify(Inflector::singularize($relationName));
        }

        $repo = $em->getRepository($className);

        if ($repo) {
            $entity = $em->getRepository($className)->find($id);
            if ($entity) {
                return $entity;
            }
        }
        throw new \Exception('Entity not found '.$relationName.' '.$id);
    }

    /**
     * Goes through each relationField and
     * - checks for an id
     * - retrieves the matching entity (assumes it exists, doesn't create it.)
     * - assign the entity.
     *
     * @param $relationFields
     * @param $fieldValues
     * @param $entity
     * @return
     * @throws \Exception
     */
    private function createAssignEntity($relationFields, $fieldValues, $entity)
    {
        foreach ($relationFields as $key => $value) {
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
                        } else {
                            // the setEntity method doesn't exist try the addEntity method. E.g. addPracticeArea.
                            // the add method is always singular
                            $functionName = 'add'.Inflector::classify(Inflector::singularize($key));
                            if (method_exists($entity, $functionName)) {
                                $entity->$functionName($relation);
                            } else {
                                throw new \Exception('Can\'t create entity relationship '.$functionName);
                            }
                        }
                    }
                }
            }
        }

        return $entity;
    }

    public function getDoctrineRepository($class)
    {
        return $this->kernel->getContainer()->get('doctrine')->getRepository($class);
    }

    /**
     * @return array
     */
    private function getMetadata()
    {
        return $this->getEntityManager()->getMetadataFactory()->getAllMetadata();
    }

    /**
     * @return \Doctrine\ORM\EntityManager
     */
    private function getEntityManager()
    {
        return $this->kernel->getContainer()->get('doctrine.orm.entity_manager');
    }

    /**
     * Create records - works for most entities.
     *
     * @param TableNode $table
     * @param $entityClass
     * @throws \Exception
     */
    private function createGenericRecords(TableNode $table, $entityClass)
    {
        $em = $this->getEntityManager();

        $entityNamespace = 'Project\Bundle\Api\Entity\\'.$entityClass;

        if (!class_exists($entityNamespace)) {
            throw new \Exception('Unrecognised entity '.$entityClass);
        }

        foreach ($table as $row) {

            $entity = new $entityNamespace();

            foreach ($row as $key => $value) {

                $setProperty = 'set'.Inflector::classify(Inflector::singularize($key));

                if (method_exists($entity, $setProperty)) {

                    $relationalClass = 'Project\Bundle\Api\Entity\\'.Inflector::classify(Inflector::singularize($key));

                    if (class_exists($relationalClass)) {

                        if ($value) {
                            $relationRetrieved = $this->retrieveRelation($key, $value);
                            $entity->$setProperty($relationRetrieved);
                        }

                    } else {
                        $entity->$setProperty($value);
                    }

                } else {
                    $addProperty = 'add'.Inflector::classify(Inflector::singularize($key));

                    if ($value) {

                        // if there are multiple ids, repeat for each id.
                        $relations = explode(',', $value);

                        foreach ($relations as $relation) {

                            $relationRetrieved = $this->retrieveRelation($key, $relation);

                            if (method_exists($entity, $addProperty)) {
                                $entity->$addProperty($relationRetrieved);
                            } else {
                                throw new \Exception('Can\'t create entity relationship '.$addProperty);
                            }
                        }
                    }
                }
            }
            $em->persist($entity);
        }
        $em->flush();
    }

    /**
     * @Given /^I loadDB$/
     */
    public function iLoadDB()
    {
        $em = $this->getEntityManager();
        $countUsers = count($em->getRepository('ProjectApiBundle:User')->findAll());
        $countActivities = count($em->getRepository('ProjectApiBundle:Activity')->findAll());

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
        $countUsers = count($em->getRepository('ProjectApiBundle:User')->findAll());
        $countActivities = count($em->getRepository('ProjectApiBundle:Activity')->findAll());

        //Check if the fixture data is loaded already by checking a constant like Activity
        if (!$countActivities || $countUsers) {
            $this->output = shell_exec(self::CONSTANTS_TABLES_COMMAND);
        }
    }
}
