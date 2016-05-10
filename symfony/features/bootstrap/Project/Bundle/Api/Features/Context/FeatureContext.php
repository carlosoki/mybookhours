<?php

namespace Project\Bundle\Api\Features\Context;

use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;
use Behat\Behat\Hook\Scope\AfterScenarioScope;
use Behat\Behat\Hook\Scope\BeforeFeatureScope;
use Behat\Behat\Hook\Scope\AfterFeatureScope;
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
    */
    public static function setup(BeforeSuiteScope $scope)
    {
        self::$refreshDb = false;
    }

    /**
     * @BeforeScenario
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
     */
    public function truncateOpportunityTables(AfterScenarioScope $scope)
    {
        $truncateTables = [
            'opportunity',
            'opportunity_assignment',
            'opportunity_company',
            'opportunity_office',
            'opportunity_industry_sector',
            'opportunity_industry_sub_sector',
            'opportunity_practice_area',
            'opportunity_practice_sub_area',
            'opportunity_location',
            'opportunity_group',
            'opportunity_group_language',
            'opportunity_group_practice_location',
            'opportunity_selected_profile',
            'unlisted_company',
            'offer',
            'offer_client_secondment_group',
            'question_answer'
        ];

        $this->truncate($truncateTables);
    }

    /**
     * @AfterScenario @offer,@counteroffer
     */
    public function truncateOfferTables(AfterScenarioScope $scope)
    {
        $truncateTables = [
            'opportunity',
            'opportunity_assignment',
            'opportunity_group',
            'opportunity_office',
            'offer',
            'opportunity_office',
            'offer_client_secondment_group',
            'invoice'
        ];

        $this->truncate($truncateTables);
    }

    /**
     * @AfterScenario @profile
     */
    public function truncateProfileTables(AfterScenarioScope $scope)
    {
        $truncateTables = [
            'profile',
            'profile_extension',
            'profile_language',
            'profile_practice_area',
            'profile_practice_location',
            'profile_practice_subarea',
            'profile_secondment_location',
            'profile_industry_sector',
            'profile_industry_subsector'
        ];

        $this->truncate($truncateTables);
    }

    /**
     * @AfterScenario @company&&~@search
     */
    public function truncateCompanyTables(AfterScenarioScope $scope)
    {
        $truncateTables = [
            'user',
            'user_profession',
            'user_office',
            'company',
            'company_profession',
            'company_service'
        ];

        $this->truncate($truncateTables);
    }

    /**
     * @AfterScenario @legal_entity&&~@search
     */
    public function truncateLegalEntityTables(AfterScenarioScope $scope)
    {
        $truncateTables = [
            'user',
            'user_profession',
            'company',
            'company_profession',
            'company_service',
            'legal_entity'
        ];

        $this->truncate($truncateTables);
    }

    /**
     * @AfterScenario @office&&~@search
     */
    public function truncateOfficeTables(AfterScenarioScope $scope)
    {
        $truncateTables = [
            'user',
            'user_profession',
            'company',
            'company_profession',
            'company_service',
            'legal_entity',
            'office',
            'user_office'
        ];

        $this->truncate($truncateTables);
    }

    /**
     * @AfterScenario @question-answer
     */
    public function truncateQuestionAnswerTables(AfterScenarioScope $scope)
    {
        $truncateTables = [
            'question_answer',
            'opportunity',
            'opportunity_company'
        ];

        $this->truncate($truncateTables);
    }

    /**
     * @AfterScenario @user&&~@search&&~@validate
     */
    public function truncateUserTables(AfterScenarioScope $scope)
    {
        $truncateTables = [
            'user',
            'user_profession',
            'company',
            'company_profession',
            'company_service'
        ];

        $this->truncate($truncateTables);
    }

    public function truncate(array $truncateTables)
    {
        foreach ($truncateTables as $table) {
            $this->dbContext->cleanTable($table);
        }
    }
}
