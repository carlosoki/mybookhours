<?php

namespace Project\Bundle\Api\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation AS Serializer;

/**
 * Class TravelInfo
 * @package Project\Bundle\Api\Entity
 *
 * @ORM\Entity()
 * @ORM\Table(name="travel_info")
 * @ORM\HasLifecycleCallbacks()
 *
 */
class TravelInfo
{

    /**
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity="Project\Bundle\Api\Entity\Appointment", inversedBy="travelInfo")
     * @ORM\JoinColumn(name="appointment_id", referencedColumnName="id", nullable=false)
     *
     * @Assert\NotNull()
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
     * @ORM\Column(name="travel_type", type="string")
     * @Serializer\Groups({"appointment"})
     *
     */
    private $travelType;

    /**
     * @ORM\Column(name="km_start", type="float", nullable=true)
     * @Serializer\Groups({"appointment"})
     */
    private $kmStart;

    /**
     * @ORM\Column(name="km_end", type="float", nullable=true)
     * @Serializer\Groups({"appointment"})
     */
    private $kmEnd;

    /**
     * @ORM\Column(name="total_travelled", type="float", nullable=true)
     */
    private $totalTravelled;

    /**
     * @ORM\Column(name="departure", type="string", nullable=true)
     */
    private $departure;

    /**
     * @ORM\Column(name="destination", type="string", nullable=true)
     */
    private $destination;

    /**
     * @ORM\Column(name="purpose", type="text", nullable=true)
     */
    private $purpose;

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
     * @param mixed $appointment
     * @return $this
     */
    public function setAppointment(Appointment $appointment)
    {
        $this->appointment = $appointment;
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
     * @return TravelInfo
     */
    public function setClient(Client $client)
    {
        $this->client = $client;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getTravelType()
    {
        return $this->travelType;
    }

    /**
     * @param mixed $travelType
     * @return TravelInfo
     */
    public function setTravelType($travelType)
    {
        $this->travelType = $travelType;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getKmStart()
    {
        return $this->kmStart;
    }

    /**
     * @param mixed $kmStart
     * @return TravelInfo
     */
    public function setKmStart($kmStart)
    {
        $this->kmStart = $kmStart;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getKmEnd()
    {
        return $this->kmEnd;
    }

    /**
     * @param mixed $kmEnd
     * @return TravelInfo
     */
    public function setKmEnd($kmEnd)
    {
        $this->kmEnd = $kmEnd;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getTotalTravelled()
    {
        return $this->totalTravelled;
    }

    /**
     * @param mixed $totalTravelled
     * @return TravelInfo
     */
    public function setTotalTravelled($totalTravelled)
    {
        $this->totalTravelled = $totalTravelled;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getDeparture()
    {
        return $this->departure;
    }

    /**
     * @param mixed $departure
     * @return TravelInfo
     */
    public function setDeparture($departure)
    {
        $this->departure = $departure;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getDestination()
    {
        return $this->destination;
    }

    /**
     * @param mixed $destination
     * @return TravelInfo
     */
    public function setDestination($destination)
    {
        $this->destination = $destination;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getPurpose()
    {
        return $this->purpose;
    }

    /**
     * @param mixed $purpose
     * @return TravelInfo
     */
    public function setPurpose($purpose)
    {
        $this->purpose = $purpose;
        return $this;
    }

}