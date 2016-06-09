<?php
/**
 * Created by PhpStorm.
 * User: carlosholiveira
 * Date: 9/05/2016
 * Time: 8:14 PM
 */

namespace Project\Bundle\Api\Controller;

use FOS\RestBundle\Controller\Annotations;
use Nelmio\ApiDocBundle\Annotation\ApiDoc;
use Project\Bundle\Api\Entity\Client;
use Project\Bundle\Api\Form\Type\ClientType;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

/**
 * Class ClientController
 * @package Project\Bundle\Api\Controller
 */
class ClientController extends BaseController
{
    const CLIENT_REPO = 'api.repository.client';
    const FORM_NAME = 'client_type';

    /**
     * @ApiDoc(
     *   resource=true,
     *   output = "Project\Api\Entity\Client",
     *   description="Finds and displays the collection of clients",
     *   statusCodes = {
     *     200 = "Returned"
     *   }
     * )
     *
     * @return \FOS\RestBundle\View\View
     */
    public function getApiClientsAction(bool $fromApp = null)
    {
        $client = $this->getRepo(self::CLIENT_REPO)->findAll();

        if ($fromApp) {
            return $client;
        }

        $url = $this->generateUrl('api_client_list');

        return $this->renderSerializedView(['client_list'], $fromApp, $client, null, $url);
    }

    /**
     * @ApiDoc(
     *   resource=true,
     *   output = "Project\Api\Entity\Client",
     *   description="Finds and displays client by id",
     *   statusCodes = {
     *     200 = "Returned when successful",
     *     404 = "Returned when the Client is not found"
     *   }
     * )
     *
     * @param $id
     * @return \FOS\RestBundle\View\View
     */
    public function getApiClientAction($id, bool $fromApp = null)
    {
        $client = $this->getRepo(self::CLIENT_REPO)->find($id);

        if (!$client) {
            throw new NotFoundHttpException('Client id:'.$id.' does not exist');
        }
        $url = $this->generateUrl('api_client', ['id' => $client->getId()]);

        return $this->renderSerializedView(['client'], $fromApp, $client, null, $url);
    }

    /**
     * @ApiDoc(
     *   resource=true,
     *   output = "Project\Api\Entity\Client",
     *   description="Create new clients",
     *   statusCodes = {
     *     200 = "Returned when successful",
     *     400 = "Returned when get validations errors"
     *   },
     *  input="client_type"
     * )
     *
     * @param Request $request
     * @return \FOS\RestBundle\View\View
     */
    public function newApiClientAction(Request $request, bool $fromApp = null, $form = null, Client $client = null)
    {
        if(!$form){
            $client = new Client();
            $form = $this->createForm(ClientType::class, $client);
        }

        if ($fromApp) {
            $router = 'app_client_new';
        } else {
            $router = 'api_client';
        }

        return $this->processForm(
            $request, self::FORM_NAME, $form, self::CLIENT_REPO,
            $client, $router, ['client'], $fromApp, Response::HTTP_CREATED
        );
    }

    /**
     * @ApiDoc(
     *   resource=true,
     *   output = "Project\Api\Entity\Client",
     *   description="Finds a client by id and update the given fields",
     *   statusCodes = {
     *     200 = "Returned when successful",
     *     404 = "Returned when not found",
     *     400 = "Returned when validation fails"
     *   },
     *  input="client_type"
     * )
     * @param Request $request
     * @param $id
     * @return \FOS\RestBundle\View\View
     */
    public function updateApiClientAction(Request $request, $id, bool $fromApp = null)
    {
        $client = $this->getRepo(self::CLIENT_REPO)->find($id);

        if (!$client) {
            throw new NotFoundHttpException('Client id:'.$id.' does not exist');
        }

        if ($fromApp) {
            return $client;
        }

        $form = $this->createForm(ClientType::class, $client, ['method' => $request->getMethod()]);

        return $this->processForm(
            $request, self::FORM_NAME, $form, self::CLIENT_REPO,
            $client, 'api_client', ['client'], $fromApp, Response::HTTP_OK
        );
    }
}