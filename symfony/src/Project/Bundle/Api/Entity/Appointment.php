<?php

namespace Project\Bundle\Api\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation AS Serializer;

/**
 * Class Appointment
 * @package Project\Bundle\Api\Entity
 *
 * @ORM\Entity(repositoryClass="Project\Bundle\Api\Entity\Repository\ClientRepository")
 * @ORM\Table(name="appointment")
 * @ORM\HasLifecycleCallbacks()
 *
 */
class Appointment
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     * @ORM\Column(name="id", type="integer")
     * @Serializer\Groups({"client", "clientLog", "client_list" })
     */
    private $id;

    /**
     * @ORM\Column(name="service_info", type="text")
     * @Serializer\Groups({"appointment"})
     */
    private $serviceInfo;


    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @return mixed
     */
    public function getServiceInfo()
    {
        return $this->serviceInfo;
    }

    /**
     * @param mixed $serviceInfo
     * @return Appointment
     */
    public function setServiceInfo($serviceInfo)
    {
        $this->serviceInfo = $serviceInfo;
        return $this;
    }
}
