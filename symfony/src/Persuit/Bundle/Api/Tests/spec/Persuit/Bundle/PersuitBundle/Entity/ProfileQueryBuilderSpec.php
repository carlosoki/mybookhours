<?php

namespace spec\Persuit\Bundle\Api\Entity;

use PhpSpec\ObjectBehavior;
use Doctrine\ORM\QueryBuilder;

class ProfileQueryBuilderSpec extends ObjectBehavior
{
    /**
     * @param Doctrine\ORM\QueryBuilder
     */
    public function let(QueryBuilder $qb)
    {
        $this->beConstructedWith($qb);
    }

    public function it_is_initializable()
    {
        $this->shouldHaveType('Persuit\Bundle\Api\Entity\ProfileQueryBuilder');
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_create_a_query($qb)
    {
        $offset = 6;
        $limit = 11;

        $qb->resetDQLParts()->shouldBeCalled();
        $qb->select('p')->shouldBeCalled();
        $qb->from('Persuit\Bundle\Api\Entity\Profile', 'p')->shouldBeCalled();
        $qb->setMaxResults($limit)->shouldBeCalled();
        $qb->setFirstResult($offset)->shouldBeCalled();
        $qb->orderBy('p.name')->shouldBeCalled();

        $this->newQuery($offset, $limit);
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_job_title($qb)
    {
        $this->newQuery();

        $qb->andWhere('p.jobTitle IN (1)')->shouldBeCalled();
        $this->addCondition('job_title', 1);
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_job_title_with_multiple_ids($qb)
    {
        $this->newQuery();

        $qb->andWhere('p.jobTitle IN (1,2,3)')->shouldBeCalled();
        $this->addCondition('job_title', '1,2,3');
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_languages($qb)
    {
        $this->newQuery();

        $qb->join('p.languages', 'j1', 'WITH', 'j1.id IN (1)')->shouldBeCalled();
        $this->addCondition('languages', 1);
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_languages_with_multiple_ids($qb)
    {
        $this->newQuery();

        $qb->join('p.languages', 'j1', 'WITH', 'j1.id IN (1,2,3)')->shouldBeCalled();
        $this->addCondition('languages', '1,2,3');
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_practice_areas($qb)
    {
        $this->newQuery();

        $qb->join('p.practiceAreas', 'j1', 'WITH', 'j1.id IN (1)')->shouldBeCalled();
        $this->addCondition('practice_areas', 1);
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_practice_areas_with_multiple_ids($qb)
    {
        $this->newQuery();

        $qb->join('p.practiceAreas', 'j1', 'WITH', 'j1.id IN (1,2,3)')->shouldBeCalled();
        $this->addCondition('practice_areas', '1,2,3');
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_company($qb)
    {
        $this->newQuery();

        $qb->andWhere('p.company IN (1)')->shouldBeCalled();
        $this->addCondition('company', 1);
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_company_with_multiple_ids($qb)
    {
        $this->newQuery();

        $qb->andWhere('p.company IN (1,2,3)')->shouldBeCalled();
        $this->addCondition('company', '1,2,3');
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_conidtion_on_profession($qb)
    {
        $this->newQuery();

        $qb->andWhere('p.profession IN (1)')->shouldBeCalled();
        $this->addCondition('profession', 1);
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_profession_with_multiple_ids($qb)
    {
        $this->newQuery();

        $qb->andWhere('p.profession IN (1,2,3)')->shouldBeCalled();
        $this->addCondition('profession', '1,2,3');
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_preferred_secondment_location($qb)
    {
        $this->newQuery();

        $qb->join('p.preferredSecondmentLocations', 'l', 'WITH', 'l.woeid IN (1)')->shouldBeCalled();
        $this->addCondition('preferred_secondment_locations', 1);
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_preferred_secondment_location_with_multiple_ids($qb)
    {
        $this->newQuery();

        $qb->join('p.preferredSecondmentLocations', 'l', 'WITH', 'l.woeid IN (1,2,3)')->shouldBeCalled();
        $this->addCondition('preferred_secondment_locations', '1,2,3');
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_name($qb)
    {
        $this->newQuery();

        $qb->andWhere('p.name LIKE \'%testing%\'')->shouldBeCalled();

        $this->addCondition('name', 'testing');
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_admitted_to_practice($qb)
    {
        $this->newQuery();

        $qb->andWhere('p.admittedToPractice LIKE \'%testing%\'')->shouldBeCalled();

        $this->addCondition('admitted_to_practice', 'testing');
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_offset($qb)
    {
        $this->newQuery();

        $qb->setFirstResult(10)->shouldBeCalled();

        $this->addCondition('offset', 10);
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_add_a_condition_on_limit($qb)
    {
        $this->newQuery();

        $qb->setMaxResults(10)->shouldBeCalled();

        $this->addCondition('limit', 10);
    }

    /**
     * @param Doctrine\ORM\QueryBuilder $qb
     */
    public function it_can_not_return_more_results_than_than_max($qb)
    {
        $realObj = $this->getWrappedObject();
        $max = $realObj::MAX_LIMIT + 1;

        $qb->setMaxResults($max)->shouldNotBeCalled();

        $this->shouldThrow('\Exception')->duringAddCondition('limit', $max);
    }

    /**
     * @param Doctrine\ORM\QueryBuilder  $qb
     * @param Doctrine\ORM\AbstractQuery $query
     */
    public function it_can_return_a_query($qb, $query)
    {
        $qb->getQuery()->willReturn($query);
        $this->getQuery()->shouldReturn($query);
    }
}
