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
     * @ORM\Column(name="start", type="datetime")
     */
    private $start;

    /**
     * @ORM\Column(name="end", type="datetime")
     */
    private $end;

    /**
     * @ORM\ManyToOne(targetEntity="Project\Bundle\Api\Entity\Client")
     * @ORM\JoinColumn(name="client_id", referencedColumnName="id", nullable=false)
     *
     * @Assert\NotNull()
     * @Assert\Valid()
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
     */
    private $staff;

    /**
     * @ORM\OneToOne(targetEntity="Project\Bundle\Api\Entity\Task", mappedBy="appointment")
     *
     */
    private $task;

    /**
     * @ORM\Column(name="service_info", type="text", nullable=true)
     * @Serializer\Groups({"appointment"})
     */
    private $serviceInfo;

    /**
     * @ORM\Column(name="report", type="text", nullable=true)
     */
    private $report;

    /**
     * @ORM\Column(name="client_signature", type="string", nullable=true)
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
     */
    private $travelInfo;


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
    public function getTask()
    {
        return $this->task;
    }

    /**
     * @param mixed $task
     * @return Appointment
     */
    public function setTask($task)
    {
        $this->task = $task;
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

}
