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
     * @Serializer\Groups({"client", "clientLog", "client_list" })
     */
    private $id;

    /**
     * @ORM\Column(name="name", type="string")
     * @Serializer\Groups({"client", "clientLog", "client_list" })
     */
    private $name;

    /**
     * @ORM\Column(name="address", type="string")
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
