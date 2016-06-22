<?php

namespace Project\Bundle\Api\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation AS Serializer;

/**
 * Class Appointment
 * @package Project\Bundle\Api\Entity
 *
 * @ORM\Entity(repositoryClass="Project\Bundle\Api\Entity\Repository\AppointmentRepository")
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
     * @Serializer\Groups({"appointment"})
     */
    private $id;

    /**
     * @ORM\Column(name="start", type="datetime")
     *
     * @Serializer\Groups({"appointment"})
     */
    private $start;

    /**
     * @ORM\Column(name="end", type="datetime")
     * @Serializer\Groups({"appointment"})
     */
    private $end;

    /**
     * @ORM\ManyToOne(targetEntity="Project\Bundle\Api\Entity\Client")
     * @ORM\JoinColumn(name="client_id", referencedColumnName="id", nullable=false)
     *
     * @Assert\NotNull()
     * @Assert\Valid()
     *
     * @Serializer\Groups({"appointment"})
     *
     */
    private $client;

    /**
     * @ORM\ManyToOne(targetEntity="Project\Bundle\Api\Entity\Staff")
     * @ORM\JoinColumn(name="staff_id", referencedColumnName="id", nullable=false)
     *
     * @Assert\NotNull()
     * @Assert\Valid()
     *
     * @Serializer\Groups({"appointment"})
     *
     */
    private $staff;

    /**
     * @ORM\Column(name="service_info", type="text", nullable=true)
     * @Serializer\Groups({"appointment"})
     */
    private $serviceInfo;

    //START TASK INFORMATION
    /**
     * @ORM\Column(name="client_info", type="text", nullable=true)
     *
     * @Serializer\Groups({"appointment"})
     *
     */
    private $clientInfo;

    /**
     * @ORM\Column(name="home_care", type="text", nullable=true)
     *
     * @Serializer\Groups({"appointment"})
     *
     */
    private $homeCare;

    /**
     * @ORM\Column(name="personal_care", type="text", nullable=true)
     *
     * @Serializer\Groups({"appointment"})
     *
     */
    private $personalCare;

    /**
     * @ORM\Column(name="respite", type="text", nullable=true)
     *
     * @Serializer\Groups({"appointment"})
     *
     */
    private $respite;

    /**
     * @ORM\Column(name="others", type="text", nullable=true)
     *
     * @Serializer\Groups({"appointment"})
     *
     */
    private $others;
    //END TASK INFORMATION

    //START EVENT REGISTRATION
    /**
     * @ORM\Column(name="report", type="text", nullable=true)
     * @Serializer\Groups({"appointment"})
     *
     */
    private $report;

    /**
     * @ORM\Column(name="client_signature", type="string", nullable=true)
     *
     * @Serializer\Groups({"appointment"})
     */
    private $clientSignature;

    /**
     * @ORM\OneToMany(targetEntity="Project\Bundle\Api\Entity\TravelInfo",
     *      mappedBy="appointment",
     *      cascade={"remove", "persist"},
     *      orphanRemoval=true
     * )
     *
     * @Assert\Valid()
     * @Serializer\Groups({"appointment"})
     */
    private $travelInfo;
    //END EVENT REGISTRATION

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
    public function getStart()
    {
        return $this->start;
    }

    /**
     * @param mixed $start
     * @return Appointment
     */
    public function setStart($start)
    {
        $this->start = $start;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getEnd()
    {
        return $this->end;
    }

    /**
     * @param mixed $end
     * @return Appointment
     */
    public function setEnd($end)
    {
        $this->end = $end;
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
     * @return Appointment
     */
    public function setClient($client)
    {
        $this->client = $client;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getStaff()
    {
        return $this->staff;
    }

    /**
     * @param mixed $staff
     * @return Appointment
     */
    public function setStaff($staff)
    {
        $this->staff = $staff;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getReport()
    {
        return $this->report;
    }

    /**
     * @param mixed $report
     * @return Appointment
     */
    public function setReport($report)
    {
        $this->report = $report;
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
     * @return Appointment
     */
    public function setClientInfo($clientInfo)
    {
        $this->clientInfo = $clientInfo;
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
     * @return Appointment
     */
    public function setHomeCare($homeCare)
    {
        $this->homeCare = $homeCare;
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
     * @return Appointment
     */
    public function setPersonalCare($personalCare)
    {
        $this->personalCare = $personalCare;
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
     * @return Appointment
     */
    public function setRespite($respite)
    {
        $this->respite = $respite;
        return $this;
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
     * @return Appointment
     */
    public function setOthers($others)
    {
        $this->others = $others;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getClientSignature()
    {
        return $this->clientSignature;
    }

    /**
     * @param mixed $clientSignature
     * @return Appointment
     */
    public function setClientSignature($clientSignature)
    {
        $this->clientSignature = $clientSignature;
        return $this;
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

    /**
     * @return mixed
     */
    public function getTravelInfo()
    {
        return $this->travelInfo;
    }

    /**
     * @param TravelInfo $travelInfo
     * @return $this
     */
    public function addTravelInfo(TravelInfo $travelInfo)
    {
        $this->travelInfo[] = $travelInfo;

        return $this;
    }

}
