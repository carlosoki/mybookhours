<?php

namespace Persuit\Bundle\Api\Form\Transformer;

use Symfony\Component\Form\Exception\TransformationFailedException;
use Doctrine\Common\Persistence\ObjectManager;
use FOS\RestBundle\Form\Transformer\EntityToIdObjectTransformer;

class CollectionEntityToIdObjectTransformer extends EntityToIdObjectTransformer
{
    protected $om;
    protected $entityName;

    /**
     * @param ObjectManager $om
     * @param string        $entityName
     */
    public function __construct(ObjectManager $om, $entityName)
    {
        parent::__construct($om, $entityName);
    }

    /**
     * Do nothing.
     *
     * @param null|object $objects
     * @return string
     * @internal param null|object $object
     *
     */
    public function transform($objects)
    {
        if (!is_array($objects) || empty($objects)) {
            return [];
        }

        $objects = [];

        foreach ($objects as $object) {
            $objects[] = parent::transform($object);
        }

        return $objects;
    }

    /**
     * Transforms an array including an identifier to an object.
     *
     * @param array $idObjects
     * @return null|object
     * @internal param array $idObject
     *
     */
    public function reverseTransform($idObjects)
    {
        if (!is_array($idObjects)) {
            return [];
        }

        $objects = [];

        foreach ($idObjects as $idObject) {
            $objects[] = parent::reverseTransform($idObject);
        }

        return $objects;
    }
}
