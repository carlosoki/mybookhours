<?php
/**
 * Created by PhpStorm.
 * User: carlosoliveira
 * Date: 13/05/2016
 * Time: 4:19 PM
 */

namespace Project\Bundle\Api\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation as Serializer;

/**
 * Class ClientLogType
 * @package Project\Bundle\Api\Entity
 *
 * @ORM\Entity(repositoryClass="Project\Bundle\Api\Entity\Repository\ClientLogRepository")
 * @ORM\Table(name="client_log")
 * @ORM\HasLifecycleCallbacks()
 */
class ClientLog
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     * @ORM\Column(name="id", type="integer")
     *
     * @Serializer\Groups({"clientLog", "clientLog_list" })
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity="Project\Bundle\Api\Entity\Client")
     * @ORM\JoinColumn(name="client_id",nullable=false)
     *
     * @Serializer\Groups({"clientLog", "clientLog_list" })
     */
    private $client;

    /**
     * @ORM\Column(name="duration_period", type="time")
     *
     * @Serializer\Type("DateTime<'H:i'>")
     * @Serializer\Groups({"clientLog", "clientLog_list" })
     */
    private $durationPeriod;

    /**
     * @ORM\Column(name="start_time", type="datetime", nullable=true)
     *
     *
     * @Serializer\Groups({"clientLog", "clientLog_list" })
     */
    private $start;

    /**
     * @ORM\Column(name="end_time", type="datetime", nullable=true)
     *
     * @Serializer\Groups({"clientLog", "clientLog_list" })
     */
    private $end;

    /**
     * @ORM\Column(name="break_period", type="time", nullable=true)
     *
     * @Serializer\Type("DateTime<'H:i'>")
     * @Serializer\Groups({"clientLog", "clientLog_list" })
     */
    private $breakPeriod;

    /**
     * @ORM\Column(type="decimal", scale=2, nullable=true)
     *
     * @Serializer\Groups({"clientLog", "clientLog_list" })
     */
    private $rate;

    /**
     * @ORM\Column(type="float", nullable=true)
     *
     * @Serializer\Groups({"clientLog", "clientLog_list" })
     */
    private $km;

    /**
     * @ORM\Column(name="total_payment", type="decimal", scale=2, nullable=true)
     *
     * @Serializer\Groups({"clientLog", "clientLog_list" })
     */
    private $totalPayment;

    /**
     * @ORM\Column(type="text", nullable=true)
     *
     * @Serializer\Groups({"clientLog"})
     */
    private $description;

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
    public function getClient()
    {
        return $this->client;
    }

    /**
     * @param mixed $client
     * @return ClientLog
     */
    public function setClient($client)
    {
        $this->client = $client;

        return $this;
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
     * @return ClientLog
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
     * @return ClientLog
     */
    public function setEnd($end)
    {
        $this->end = $end;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getBreakPeriod()
    {
        return $this->breakPeriod;
    }

    /**
     * @param mixed $breakPeriod
     * @return ClientLog
     */
    public function setBreakPeriod($breakPeriod)
    {
        $this->breakPeriod = $breakPeriod;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getDurationPeriod()
    {
        return $this->durationPeriod;
    }

    /**
     * @param mixed $durationPeriod
     * @return ClientLog
     */
    public function setDurationPeriod($durationPeriod)
    {
        $this->durationPeriod = $durationPeriod;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getRate()
    {
        return $this->rate;
    }

    /**
     * @param mixed $rate
     * @return ClientLog
     */
    public function setRate($rate)
    {
        $this->rate = $rate;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getKm()
    {
        return $this->km;
    }

    /**
     * @param mixed $km
     * @return ClientLog
     */
    public function setKm($km)
    {
        $this->km = $km;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getTotalPayment()
    {
        return $this->totalPayment;
    }

    /**
     * @param mixed $totalPayment
     * @return ClientLog
     */
    public function setTotalPayment($totalPayment)
    {
        $this->totalPayment = $totalPayment;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * @param mixed $description
     * @return ClientLog
     */
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }
}
