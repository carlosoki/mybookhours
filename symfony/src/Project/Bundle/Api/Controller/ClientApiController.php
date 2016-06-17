<?php
/**
 * Created by PhpStorm.
 * User: carlosholiveira
 * Date: 9/05/2016
 * Time: 8:14 PM
 */

namespace Project\Bundle\Api\Controller;

use FOS\RestBundle\Controller\Annotations;
use FOS\RestBundle\Request\ParamFetcher;
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
class ClientApiController extends BaseController
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
     * @Annotations\QueryParam(name="name", description="Search clients by names")
     *
     * @param ParamFetcher $paramFetcher
     * @return \FOS\RestBundle\View\View
     */
    public function getApiClientsAction(ParamFetcher $paramFetcher = null)
    {
        $client = $this->getRepo(self::CLIENT_REPO)->searchClients($paramFetcher->all());

        $url = $this->generateUrl('api_client_list');

        return $this->renderSerializedView(['client_list'], $client, null, $url);
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
    public function newApiClientAction(Request $request)
    {
        $client = new Client();
        $form = $this->createForm(ClientType::class, $client);

        return $this->processForm(
            $request, $form, self::CLIENT_REPO, $client,
            'api_client', ['client'], Response::HTTP_CREATED
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
            $request, $form, self::CLIENT_REPO, $client,
            'api_client', ['client'], Response::HTTP_OK
        );
    }

    /**
     * Delete an Client by id.
     *
     * @ApiDoc(
     *   resource = true,
     *   statusCodes={
     *     204 = "Returned when successful deleted",
     *     404 = "Returned when the opportunity is not found",
     *     400 = "Returned when validation fails"
     *   }
     * )
     *
     * @param $id
     *
     * @return string
     */
    public function deleteApiClientAction($id)
    {
        $client = $this->getRepo(self::CLIENT_REPO)->find($id);

        if (!$client) {
            throw new NotFoundHttpException('Client id:'.$id.' does not exist');
        }

        $this->getRepo(self::CLIENT_REPO)->delete($client);

        return $this->renderSerializedView(['client'], null, null, Response::HTTP_NO_CONTENT, null);

    }
}