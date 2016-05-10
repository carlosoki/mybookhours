<?php
/**
 * Created by PhpStorm.
 * User: carlosholiveira
 * Date: 9/05/2016
 * Time: 8:14 PM
 */

namespace Project\Bundle\Api\Controller;

use FOS\RestBundle\Controller\FOSRestController;
use FOS\RestBundle\Controller\Annotations;
use JMS\Serializer\SerializationContext;
use Symfony\Component\HttpFoundation\Response;

/**
 * Class ClientController
 * @package Project\Bundle\Api\Controller
 */
class ClientController extends FOSRestController
{
    public function getClientsAction()
    {
        $clientRepo = $this->get('api.repository.client');

        $client = $clientRepo->findAll();

        $url = 'client/';
        $view = $this->view($client, Response::HTTP_OK)->setHeader('Location', $url);
        $context = SerializationContext::create()->setGroups(['client_list']);

        $view->setSerializationContext($context);

        return $view;
        //return new JsonResponse(array('client'=>$client), 200);
    }
}