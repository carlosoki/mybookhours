<?php

namespace Project\Bundle\App\Controller;

use Project\Bundle\Api\Entity\Client;
use Project\Bundle\Api\Controller\ClientController as ApiClientController;
use Project\Bundle\Api\Form\Type\ClientType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

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

        if ($request->isMethod('PUT')) {
            return $this->processForm(
                $request, self::FORM_NAME, $form, self::CLIENT_REPO,
                $client, 'api_client_edit', ['client'], Response::HTTP_OK
            );

        }

        return [
            'client' => $client,
            'form' => $form
        ];
        
    }

    private function saveAppClient()
    {

    }
}