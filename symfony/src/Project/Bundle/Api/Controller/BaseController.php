<?php
/**
 * Created by PhpStorm.
 * User: carlosholiveira
 * Date: 9/05/2016
 * Time: 10:48 PM
 */

namespace Project\Bundle\Api\Controller;

use FOS\RestBundle\Controller\FOSRestController;
use JMS\Serializer\SerializationContext;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Class BaseController
 * @package Project\Bundle\Api\Controller
 */
class BaseController extends FOSRestController
{
    public function getRepo($repoName)
    {
        return $this->get($repoName);
    }
    public function wrapRequest(Request $request, $formName)
    {
        $parameters = $request->request->all();
        $wrapperParams = [$formName => $parameters];
        $request->request->replace($wrapperParams);
    }

    public function renderSerializedView(array $groupSerializer, $object = null, $statusCode = null, $url = null)
    {
        if (!$statusCode) {
            $statusCode = Response::HTTP_OK;
        }

        $view = $this->view($object, $statusCode)->setHeader('Location', $url);
        $context = SerializationContext::create()->setGroups($groupSerializer);
        $view->setSerializationContext($context);

        return $view;
    }
}

