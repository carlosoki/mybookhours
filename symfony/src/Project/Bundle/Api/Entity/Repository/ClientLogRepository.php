<?php
/**
 * Created by PhpStorm.
 * User: carlosoliveira
 * Date: 13/05/2016
 * Time: 6:09 PM
 */

namespace Project\Bundle\Api\Entity\Repository;

use Doctrine\ORM\EntityRepository;
use Project\Bundle\Api\Entity\ClientLog;

/**
 * Class ClientLogRepository
 * @package Project\Bundle\Api\Entity\Repository
 */
class ClientLogRepository extends EntityRepository
{
    public function save(ClientLog $client)
    {
        $this->_em->persist($client);
        $this->_em->flush();
    }
    public function delete(ClientLog $client)
    {
        $this->_em->remove($client);
        $this->_em->flush();
    }
}