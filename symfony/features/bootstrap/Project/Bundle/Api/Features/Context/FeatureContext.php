<?php

namespace Project\Bundle\Api\Features\Context;

use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;
use Behat\Behat\Hook\Scope\AfterScenarioScope;
use Behat\Testwork\Hook\Scope\BeforeSuiteScope;

/**
 * Defines application features from the specific context.
 */
class FeatureContext implements Context, SnippetAcceptingContext
{
    public static $refreshDb;
    public static $companyRefreshDb;

    /**
     * @BeforeSuite
     *
     * @param BeforeSuiteScope $scope
     */
    public static function setup(BeforeSuiteScope $scope)
    {
        self::$refreshDb = false;
    }

    /**
     * @BeforeScenario
     *
     * @param BeforeScenarioScope $scope
     */
    public function refreshDb(BeforeScenarioScope $scope)
    {
        $environment = $scope->getEnvironment();
        $this->dbContext = $environment->getContext('Project\GlobalFeatures\DatabaseFeatureContext');

        if (false === self::$refreshDb) {
            $this->dbContext->buildSchema();
            self::$refreshDb = true;
        }
    }

    /**
     * @AfterScenario @opportunity
     *
     * @param AfterScenarioScope $scope
     */
    public function truncateOpportunityTables(AfterScenarioScope $scope)
    {
        $truncateTables = [];

        $this->truncate($truncateTables);
    }

    /**
     * @param array $truncateTables
     */
    public function truncate(array $truncateTables)
    {
        foreach ($truncateTables as $table) {
            $this->dbContext->cleanTable($table);
        }
    }
}
