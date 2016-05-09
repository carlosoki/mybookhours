<?php
/**
 * Created by PhpStorm.
 * User: carlosoliveira
 * Date: 6/05/2016
 * Time: 10:48 AM
 */

namespace Persuit\Bundle\Api\Entity;

use Doctrine\ORM\Mapping as ORM;
use JMS\Serializer\Annotation AS Serializer;

/**
 * Class Client
 * @package Persuit\Bundle\Api\Entity\
 *
 * @ORM\Entity(repositoryClass="Persuit\Bundle\Api\Entity\Repository\ClientRepository")
 * @ORM\Table(name="client")
 * @ORM\HasLifecycleCallbacks()
 *
 */
class Client
{
    const CASUAL = 'casual';
    const PART_TIME = 'part-time';
    const FULL_TIME = 'full-time';

    /**
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     * @ORM\Column(name="id", type="integer")
     * @Serializer\Groups({"client", "client_list" })
     */
    private $id;

    /**
     * @ORM\Column(name="name", type="string")
     * @Serializer\Groups({"client", "client_list" })
     */
    private $name;

    /**
     * @ORM\Column(name="type_contract", type="string", nullable=true)
     * @Serializer\Groups({"client", "client_list" })
     */
    private $typeContract;

    /**
     * @ORM\Column(name="rate", type="decimal", scale=2, nullable=true)
     *  @Serializer\Groups({"client", "client_list" })
     */
    private $rate;

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
    public function getName()
    {
        return $this->name;
    }

    /**
     * @param mixed $name
     * @return Client
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getTypeContract()
    {
        return $this->typeContract;
    }

    /**
     * @param mixed $typeContract
     * @return Client
     */
    public function setTypeContract($typeContract)
    {
        $this->typeContract = $typeContract;

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
     * @return Client
     */
    public function setRate($rate)
    {
        $this->rate = $rate;

        return $this;
    }
}
