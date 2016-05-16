<?php
/**
 * Created by PhpStorm.
 * User: carlosoliveira
 * Date: 13/05/2016
 * Time: 5:56 PM
 */

namespace Project\Bundle\Api\Controller;

use Project\Bundle\Api\Entity\ClientLog;
use Project\Bundle\Api\Form\Type\ClientLogType;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Class ClientLogController
 * @package Project\Bundle\Api\Controller
 */
class ClientLogController extends BaseController
{
    const  FORM_NAME = 'client_log_type';
    const CLIENT_LOG_REPO = 'api.repository.client.log';

    public function getClientLogAction($id)
    {
        return 'client_log by id';
    }

    public function newClientLogAction(Request $request)
    {
        $clientLog = new ClientLog();
        $form = $this->createForm(ClientLogType::class, $clientLog);

        return $this->processForm(
            $request, self::FORM_NAME, $form, self::CLIENT_LOG_REPO,
            $clientLog, 'client_log', ['clientLog'], Response::HTTP_CREATED
        );
    }

}