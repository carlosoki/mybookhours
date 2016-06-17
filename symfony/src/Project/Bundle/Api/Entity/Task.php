<?php

namespace Project\Bundle\Api\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation AS Serializer;

/**
 * Class Task
 * @package Project\Bundle\Api\Entity
 *
 * @ORM\Entity()
 * @ORM\Table(name="task")
 * @ORM\HasLifecycleCallbacks()
 *
 */
class Task
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     * @ORM\Column(name="id", type="integer")
     */
    private $id;

    /**
     * @ORM\OneToOne(targetEntity="Project\Bundle\Api\Entity\Appointment", inversedBy="task")
     * @ORM\JoinColumn(name="appointment_id", referencedColumnName="id", nullable=false)
     *
     * @Assert\Valid()
     */
    private $appointment;

    /**
     * @ORM\ManyToOne(targetEntity="Project\Bundle\Api\Entity\Client")
     * @ORM\JoinColumn(name="client_id", referencedColumnName="id", nullable=false)
     *
     * @Assert\Valid()
     */
    private $client;

    /**
     * @ORM\Column(name="client_info", type="text", nullable=true)
     */
    private $clientInfo;

    /**
     * @ORM\Column(name="home_care", type="text", nullable=true)
     */
    private $homeCare;

    /**
     * @ORM\Column(name="personal_care", type="text", nullable=true)
     */
    private $personalCare;

    /**
     * @ORM\Column(name="respite", type="text", nullable=true)
     */
    private $respite;

    /**
     * @ORM\Column(name="others", type="text", nullable=true)
     */
    private $others;

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
    public function getAppointment()
    {
        return $this->appointment;
    }

    /**
     * @return mixed
     */
    public function getOthers()
    {
        return $this->others;
    }

    /**
     * @param mixed $others
     * @return Task
     */
    public function setOthers($others)
    {
        $this->others = $others;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getRespite()
    {
        return $this->respite;
    }

    /**
     * @param mixed $respite
     * @return Task
     */
    public function setRespite($respite)
    {
        $this->respite = $respite;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getPersonalCare()
    {
        return $this->personalCare;
    }

    /**
     * @param mixed $personalCare
     * @return Task
     */
    public function setPersonalCare($personalCare)
    {
        $this->personalCare = $personalCare;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getHomeCare()
    {
        return $this->homeCare;
    }

    /**
     * @param mixed $homeCare
     * @return Task
     */
    public function setHomeCare($homeCare)
    {
        $this->homeCare = $homeCare;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getClientInfo()
    {
        return $this->clientInfo;
    }

    /**
     * @param mixed $clientInfo
     * @return Task
     */
    public function setClientInfo($clientInfo)
    {
        $this->clientInfo = $clientInfo;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getClient()
    {
        return $this->client;
    }

    /**
     * @param mixed $client
     * @return Task
     */
    public function setClient($client)
    {
        $this->client = $client;
        return $this;
    }

}