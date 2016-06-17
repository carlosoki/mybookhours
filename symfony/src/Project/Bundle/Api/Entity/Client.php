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
 * @package Project\Bundle\Api\Entity
 *
 * @ORM\Entity(repositoryClass="Project\Bundle\Api\Entity\Repository\ClientRepository")
 * @ORM\Table(name="client")
 * @ORM\HasLifecycleCallbacks()
 *
 */
class Client
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     * @ORM\Column(name="id", type="integer")
     * @Serializer\Groups({"client", "appointment", "client_list" })
     */
    private $id;

    /**
     * @ORM\Column(name="name", type="string")
     *
     * @Assert\NotNull()
     * 
     * @Serializer\Groups({"client", "appointment", "client_list" })
     */
    private $name;

    /**
     * @ORM\Column(name="address", type="string")
     *
     * @Assert\NotNull()
     *
     * @Serializer\Groups({"client", "client_list" })
     */
    private $address;

    /**
     * @ORM\Column(name="about_client", type="text", nullable=true)
     * @Serializer\Groups({"client", "client_list" })
     */
    private $aboutClient;

    /**
     *
     *  @Assert\NotNull()
     *
     * @ORM\Column(name="is_active", type="boolean", options={"default" = 1})
     * @Serializer\Groups({"client", "client_list" })
     */
    private $isActive = true;

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
    public function getAddress()
    {
        return $this->address;
    }

    /**
     * @param mixed $address
     * @return Client
     */
    public function setAddress($address)
    {
        $this->address = $address;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getAboutClient()
    {
        return $this->aboutClient;
    }

    /**
     * @param mixed $aboutClient
     * @return Client
     */
    public function setAboutClient($aboutClient)
    {
        $this->aboutClient = $aboutClient;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getIsActive()
    {
        return $this->isActive;
    }

    /**
     * @param mixed $isActive
     * @return Client
     */
    public function setIsActive($isActive)
    {
        $this->isActive = $isActive;

        return $this;
    }
}
