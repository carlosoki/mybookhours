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

        if ( $request->isMethod( 'POST' ) ) {

            $baseController = new BaseController();
            $baseController->wrapRequest($request, 'client_type');

            $form->handleRequest($request);

            if ($form->isValid()) {
                $this->get('api.repository.client')->save($client);

                $response = new JsonResponse(
                    [
                        'message' => 'Success',
                        'form' => $this->renderView(
                            'ProjectAppBundle:Client:newClient.html.twig',
                            [
                                'form' => $form->createView(),
                            ]
                        )
                    ],
                    200
                );
            } else {
                $response = new JsonResponse(
                    [
                        'message' => 'Error',
                        'form' => $this->renderView(
                            'ProjectAppBundle:Client:newClient.html.twig',
                            [
                                'client' => $client,
                                'form' => $form->createView(),
                            ]
                        )
                    ],
                    400
                );
            }

            return $response;
        }

        return [
            'form' => $form->createView()
        ];
    }
}