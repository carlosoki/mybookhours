<?php

namespace Project\Bundle\App\Controller;

use GuzzleHttp\Message\Response;
use Project\Bundle\Api\Controller\BaseController;
use Project\Bundle\Api\Entity\Client;
use Project\Bundle\Api\Controller\ClientController as ApiClientController;
use Project\Bundle\Api\Form\Type\ClientType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;

class ClientController extends ApiClientController
{
    const FROM_APP = true;
    /**
     * @Template("ProjectAppBundle:Client:listClients.html.twig")
     */
    public function getAppClientsAction()
    {
        $clients = $this->getApiClientsAction(self::FROM_APP);

        return [
            'clients' => $clients
        ];

    }
    /**
     * @Template("ProjectAppBundle:Client:newClient.html.twig")
     * @param Request $request
     * @return array
     */
    public function newAppClientAction(Request $request)
    {
        $client = new Client();
        $form = $this->createForm(ClientType::class, $client);

        if ($request->isMethod('POST')) {

            $client = $this->newApiClientAction($request, self::FROM_APP, $form, $client);
            return $client;

        }

        return [
            'form' => $form->createView()
        ];
    }
}