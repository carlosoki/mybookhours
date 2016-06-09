<?php
/**
 * Created by PhpStorm.
 * User: carlosholiveira
 * Date: 9/05/2016
 * Time: 10:48 PM
 */

namespace Project\Bundle\Api\Controller;

use FOS\RestBundle\Controller\FOSRestController;
use JmesPath\Tests\_TestClass;
use JMS\Serializer\SerializationContext;
use Project\Bundle\Api\Service\ExceptionWrapperHandler;
use Symfony\Component\HttpFoundation\JsonResponse;
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

    public function processForm(Request $request, $formName, $form, $repoName, $object, $routeName, array $groupSerializer, $fromApp, $statusCode = null )
    {
        $this->wrapRequest($request, $formName);

        $form->handleRequest($request);

        if ($form->isValid()) {
            $this->getRepo($repoName)->save($object);
            
            $url = $this->generateUrl($routeName, ['id' => $object->getId()]);
            
            return $this->renderSerializedView($groupSerializer, $fromApp, $object, $statusCode, $url);

        } else {
            if ($fromApp) {
                $wrapErrors = new ExceptionWrapperHandler();
                $form = $wrapErrors->getFormErrors($form);

                return new JsonResponse(
                    [
                        'message' => 'error',
                        'data' => $form
                    ],
                    400
                );
            }

            return $form;
        }
    }

    public function renderSerializedView(array $groupSerializer, $fromApp, $object = null, $statusCode = null, $url = null)
    {
        if (!$statusCode) {
            $statusCode = Response::HTTP_OK;
        }

        $data = $this->view($object, $statusCode)->setHeader('Location', $url);
        $context = SerializationContext::create()->setGroups($groupSerializer);
        $data->setSerializationContext($context);

        if ($fromApp) {
            $serializer = $this->get('jms_serializer');
            $data =  $serializer->serialize($object, 'json', $context);

            return new JsonResponse(
                [
                    'message' => 'success',
                    'data' => $data
                ],
                $statusCode
            );
        }
        return $data;
    }
}

