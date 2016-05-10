<?php
/**
 * Created by PhpStorm.
 * User: carlosoliveira
 * Date: 6/05/2016
 * Time: 12:07 PM
 */

namespace Project\Bundle\Api\Entity\Repository;

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
}