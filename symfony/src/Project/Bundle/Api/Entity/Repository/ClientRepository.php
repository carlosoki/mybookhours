<?php
/**
 * Created by PhpStorm.
 * User: carlosoliveira
 * Date: 6/05/2016
 * Time: 12:07 PM
 */

namespace Project\Bundle\Api\Entity\Repository;

use Doctrine\Common\Util\Debug;
use Project\Bundle\Api\Entity\Client;
use Doctrine\ORM\EntityRepository;

/**
 * Class ClientRepository
 * @package Project\Bundle\Api\Entity\Repository
 */
class ClientRepository extends EntityRepository
{
    public function save(Client $client)
    {
        $this->_em->persist($client);
        $this->_em->flush();
    }
    public function delete(Client $client)
    {
        $this->_em->remove($client);
        $this->_em->flush();
    }

    public function searchClients($parameters)
    {
        if (!$parameters) {
            $parameters = [];
        }
        $conditions = [];

        if ($parameters['name']) {
            $names = explode(',', $parameters['name']);

            foreach ($names as $name) {
                $conditions[] = "c.name LIKE '%{$name}%'";
            }

        }

        $qb = $this->_em->createQueryBuilder();

        $qb->select('c')
            ->from('ProjectApiBundle:Client','c')
        ;

        if (! empty($conditions)) {
            $orX = $qb->expr()->orX()
                ->addMultiple($conditions);
            $qb = $qb->andwhere($orX);
        }
        $qb->orderBy('c.name');

        return $qb->getQuery()->getResult();
    }
}