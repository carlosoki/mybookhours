<?php
/**
 * Created by PhpStorm.
 * User: carlosoliveira
 * Date: 6/05/2016
 * Time: 10:48 AM
 */

namespace Project\Bundle\Api\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Validator\Constraints as Assert;
use JMS\Serializer\Annotation AS Serializer;

/**
 * Class Client
 * @package Project\Bundle\Api\Entity\
 *
 * @ORM\Entity(repositoryClass="Project\Bundle\Api\Entity\Repository\ClientRepository")
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
     *
     * @Assert\Choice(
     *  choices = {
     *      project\Bundle\Api\Entity\client::CASUAL,
     *      project\Bundle\Api\Entity\client::PART_TIME,
     *      project\Bundle\Api\Entity\client::FULL_TIME,
     *
     *  })
     *
     * @Serializer\Groups({"client", "client_list" })
     */
    private $typeContract;

    /**
     * @ORM\Column(name="rate", type="decimal", scale=2, nullable=true)
     * @Serializer\Groups({"client", "client_list" })
     */
    private $rate;

    /**
     * @ORM\Column(name="is_inactive", type="boolean", nullable=true, options={"default" = 0})
     * @Serializer\Groups({"client", "client_list" })
     */
    private $isInactive = false;

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

    /**
     * @return mixed
     */
    public function getIsInactive()
    {
        return $this->isInactive;
    }

    /**
     * @param mixed $isInactive
     * @return Client
     */
    public function setIsInactive($isInactive)
    {
        $this->isInactive = $isInactive;

        return $this;
    }
}
