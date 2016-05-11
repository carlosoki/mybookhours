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
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

/**
 * Class ClientController
 * @package Project\Bundle\Api\Controller
 */
class ClientController extends BaseController
{
    const CLIENT_REPO = 'api.repository.client';

    /**
     * @ApiDoc(
     *   resource=true,
     *   output = "Persuit\Api\Entity\Client",
     *   description="Finds and displays the collection of clients",
     *   statusCodes = {
     *     200 = "Returned"
     *   }
     * )
     *
     * @return \FOS\RestBundle\View\View
     */
    public function getClientsAction()
    {
        $client = $this->getRepo(self::CLIENT_REPO)->findAll();

        $url = $this->generateUrl('client_list');

        return $this->renderSerializedView(['client_list'], $client, null, $url);
    }

    /**
     * @ApiDoc(
     *   resource=true,
     *   output = "Persuit\Api\Entity\Client",
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
    public function getClientAction($id)
    {
        $client = $this->getRepo(self::CLIENT_REPO)->findOneBy(['id'=> $id]);

        if (!$client) {
            throw new NotFoundHttpException('Client id:'.$id.' does not exist');
        }
        $url = $this->generateUrl('client', ['id' => $client->getId()]);

        return $this->renderSerializedView(['client'], $client, null, $url);
    }
}