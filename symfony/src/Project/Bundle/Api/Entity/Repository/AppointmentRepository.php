<?php

namespace Project\Bundle\Api\Entity\Repository;

use Doctrine\ORM\EntityRepository;
use Project\Bundle\Api\Entity\Appointment;

/**
 * Class AppointmentRepository
 * @package Project\Bundle\Api\Entity\Repository
 */
class AppointmentRepository extends EntityRepository
{
    public function save(Appointment $client)
    {
        $this->_em->persist($client);
        $this->_em->flush();
    }
    public function delete(Appointment $client)
    {
        $this->_em->remove($client);
        $this->_em->flush();
    }
}
