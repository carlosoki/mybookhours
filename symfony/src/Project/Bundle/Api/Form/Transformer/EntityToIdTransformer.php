<?php

namespace Project\Bundle\Api\Form\Transformer;

use Symfony\Component\Form\DataTransformerInterface;
use Symfony\Component\Form\Exception\TransformationFailedException;
use Doctrine\Common\Persistence\ObjectManager;

/**
 * Class EntityToIdTransformer
 * @package Project\Bundle\Api\Form\Transformer
 */
class EntityToIdTransformer implements DataTransformerInterface
{
    private $manager;
    private $entityName;

    public function __construct(ObjectManager $manager, $entityName)
    {
        $this->manager = $manager;
        $this->entityName = $entityName;
    }

    /**
     * Transforms an object (issue) to a string (number).
     *
     * @param Profile|null $issue
     *
     * @return string
     */
    public function transform($issue)
    {
        if (null === $issue) {
            return '';
        }

        return $issue->getId();
    }

    /**
     * Transforms a string (number) to an object (issue).
     *
     * @param string $id
     *
     * @return Profile|null
     *
     * @throws TransformationFailedException if object (issue) is not found.
     */
    public function reverseTransform($id)
    {
        // no issue number? It's optional, so that's ok
        if (!$id) {
            return;
        }

        $issue = $this->manager->getRepository($this->entityName)
                               ->find($id);

        if (null === $issue) {
            // causes a validation error
            // this message is not shown to the user
            // see the invalid_message option
            throw new TransformationFailedException(sprintf(
                'An issue with number "%s" does not exist!',
                $id
            ));
        }

        return $issue;
    }
}
