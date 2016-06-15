<?php

namespace Project\Bundle\App\Controller;

use Project\Bundle\Api\Entity\Client;
use Project\Bundle\Api\Controller\ClientController as ApiClientController;
use Project\Bundle\Api\Form\Type\ClientType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Component\HttpFoundation\Request;

/**
 * Class APP ClientController only to build the browser forms.
 * @package Project\Bundle\App\Controller
 */
class ClientController extends ApiClientController
{
    const FROM_APP = true;

    /**
     * @Template("ProjectAppBundle:Client:listClients.html.twig")
     */
    public function getAppClientsAction()
    {
        $clients = $this->getApiClientsAction(self::FROM_APP);

        return ['clients' => $clients];

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

        return [
            'form' => $form->createView()
        ];
    }

    /**
     * @Template("ProjectAppBundle:Client:editClient.html.twig")
     * @param Request $request
     * @param $id
     * @return array
     */
    public function updateAppClientAction(Request $request, $id)
    {
        $client = $this->updateApiClientAction($request, $id, self::FROM_APP);
        $form = $this->createForm(ClientType::class, $client, ['method' => $request->getMethod()]);

        return [
            'client' => $client,
            'form' => $form
        ];
    }
}