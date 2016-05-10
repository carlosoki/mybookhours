<?php
/**
 * SM: This class is a workaround for the JMS Serializer
 * See: https://github.com/schmittjoh/JMSSerializerBundle/issues/373
 * Using a combo of hacks there. Not a great long term solution.
 */

namespace Project\Bundle\Api\Service;

use JMS\Serializer\JsonSerializationVisitor as JsonSerializationVisitorBase;

/**
 * Class JsonSerializationVisitor
 * @package Project\Bundle\Api\Service
 */
class JsonSerializationVisitor extends JsonSerializationVisitorBase
{
    public function visitArray($data, array $type, \JMS\Serializer\Context $context)
    {
        reset($data);

        if (is_numeric(key($data)) && 0 != key($data)) {
            $data = array_values($data);
        }

        $result = parent::visitArray($data, $type, $context);

        if (null !== $this->getRoot() && isset($type['params'][1]) && 0 === count($result)) {
            // ArrayObject is specially treated by the json_encode function and
            // serialized to { } while a mere array would be serialized to [].
            return new \ArrayObject();
        }

        return $result;
    }
}
