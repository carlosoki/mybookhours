<?php

namespace Project\GlobalFeatures;

use Behat\Behat\Context\Context;
use Behat\Behat\Tester\Exception\PendingException;
use Behat\WebApiExtension\Context\WebApiContext as BaseApiContext;
use PHPUnit_Framework_Assert as Assertions;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;


class WebApiContext extends BaseApiContext implements Context
{
    protected $authorization;

    /** @BeforeScenario */
    public function gatherContexts(BeforeScenarioScope $scope)
    {
    }

    /**
     * @Then I get :count result(s)
     */
    public function iGetResults($count)
    {
        $data = $this->response->json();
        Assertions::assertEquals($count, count($data));
    }

    /**
     * @Then I get :count paginated result(s)
     */
    public function iGetPaginatedResults($count)
    {
        $data = $this->response->json();
        Assertions::assertArrayHasKey('results', $data);
        Assertions::assertEquals($count, count($data['results']));
    }

    /**
     * @Then result has :key :value
     */
    public function resultHas($key, $value)
    {
        $data = $this->response->json();
        Assertions::assertArrayHasKey($key, $data);
        Assertions::assertEquals($data[$key], $value);
    }

    /**
     * @Then result :index contains :key :value
     */
    public function resultContains($index, $key, $value)
    {
        $index = $index - 1;
        $data = $this->response->json();
        Assertions::assertArrayHasKey($index, $data);
        Assertions::assertArrayHasKey($key, $data[$index]);
        Assertions::assertEquals($data[$index][$key], $value);
    }

    /**
     * @Then paginated result :index contains nested :key1 :key2 :value
     */
    public function resultContainsNested($index, $key1, $key2, $value)
    {
        $index = $index - 1;
        $data = $this->response->json();
        $data = $data['results'];
        Assertions::assertArrayHasKey($index, $data);
        Assertions::assertArrayHasKey($key1, $data[$index]);
        Assertions::assertArrayHasKey($key2, $data[$index][$key1]);
        Assertions::assertEquals($data[$index][$key1][$key2], $value);
    }

    /**
     * @Then paginated result :index1 contains deep nested :key1 :index2 :key2 :value
     */
    public function resultContainsDeepNested($index1, $key1, $index2, $key2, $value)
    {
        $index1 = $index1 - 1;
        $index2 = $index2 - 1;
        $data = $this->response->json();
        $data = $data['results'];
        Assertions::assertArrayHasKey($index1, $data);
        Assertions::assertArrayHasKey($key1, $data[$index1]);
        Assertions::assertArrayHasKey($index2, $data[$index1][$key1]);
        Assertions::assertArrayHasKey($key2, $data[$index1][$key1][$index2]);
        Assertions::assertEquals($data[$index1][$key1][$index2][$key2], $value);
    }

    /**
     * @Then json result contains 1level nested :object :index :object1 :key :value
     *
     * sample: json result contains deep nested "groups" "0" "seniority" "id" "1"
     */
    public function JsonContains1LevelNested($object, $index, $object1, $key, $value)
    {
        $data = $this->response->json();

        Assertions::assertArrayHasKey($object, $data);
        Assertions::assertArrayHasKey($object1, $data[$object][$index]);
        Assertions::assertEquals($data[$object][$index][$object1][$key], $value);

    }

    /**
     * @Then json result :object :index contains 2level nested :object1 :index1 :object2 :index2 :key :value
     * samples:
     *      json result "groups" "0" contains 2level nested "selectedProfiles" "0" "null" "null" "hours" "100"
     *      json result "groups" "0" contains 2level nested "selectedProfiles" "0" "profileExtension" "null" "id" "1"
     */
    public function JsonContains2LevelNested($object, $index, $object1, $index1, $object2, $index2, $key, $value)
    {
        $data = $this->response->json();

        Assertions::assertArrayHasKey($object1, $data[$object][$index]);

        if("null" == $object2 && "null" == $index2){
            Assertions::assertEquals($data[$object][$index][$object1][$index1][$key], $value);
        }else if("null" == $index2){
            Assertions::assertEquals($data[$object][$index][$object1][$index1][$object2][$key], $value);
        }else{
            Assertions::assertArrayHasKey($object2, $data[$object][$index][$object1][$index1]);
            Assertions::assertEquals($data[$object][$index][$object1][$index1][$object2][$index2][$key], $value);
        }
    }

    /**
     * @Then json result contains :object :key :value
     */
    public function jsonResultContains($object, $key, $value)
    {
        $data = $this->response->json();
        Assertions::assertArrayHasKey($object, $data);
        Assertions::assertArrayHasKey($key, $data[$object]);
        Assertions::assertEquals($data[$object][$key], $value);
    }

    /**
     * @Then json collection result contains :object :index :key :value
     */
    public function jsonCollectionResultContains($object, $index, $key, $value)
    {
        $data = $this->response->json();

        if($value === 'true' || $value === 'false')
        {
            $value = filter_var($value, FILTER_VALIDATE_BOOLEAN);
        }

        Assertions::assertArrayHasKey($object, $data);
        Assertions::assertArrayHasKey($key, $data[$object][$index]);
        Assertions::assertEquals($data[$object][$index][$key], $value);
    }

    /**
     * @Then paginated result :index contains :key :value
     */
    public function paginatedResultContains($index, $key, $value)
    {
        $index = $index - 1;
        $data = $this->response->json();
        Assertions::assertArrayHasKey('results', $data);
        Assertions::assertArrayHasKey($index, $data['results']);
        Assertions::assertArrayHasKey($key, $data['results'][$index]);
        Assertions::assertEquals($data['results'][$index][$key], $value);
    }

    /**
     * @Given I am authenticating as :username
     */
    public function iAmAuthenticatingAs($username, $password = null)
    {
        /*
        $user = $this->userContext->findUser($username);
        if(! $user)
        {
            throw new \Exception('Could not find user');
        }

        $this->removeHeader('Authorization');
        $this->authorization = $this->oauthContext->generateTokenForUser($username);
        $this->addHeader('Authorization', 'Bearer ' . $this->authorization);
         */
    }

    /**
     * @Then paginated result :index not has key :key
     */
    public function paginatedResultNotHasKey($index, $key)
    {
        $index = $index - 1;
        $data = $this->response->json();
        Assertions::assertArrayHasKey('results', $data);
        Assertions::assertArrayHasKey($index, $data['results']);
        Assertions::assertArrayNotHasKey($key, $data['results'][$index]);
        // Assertions::assertEquals($data['results'][$index][$key], $value);
    }
}
