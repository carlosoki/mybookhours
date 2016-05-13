<?php
/**
 * Created by PhpStorm.
 * User: carlosoliveira
 * Date: 13/05/2016
 * Time: 5:56 PM
 */

namespace Project\Bundle\Api\Controller;

use Symfony\Component\HttpFoundation\Request;

/**
 * Class ClientLogController
 * @package Project\Bundle\Api\Controller
 */
class ClientLogController extends BaseController
{
    const  FORM_NAME = 'client_log_type';

    public function newClientLogAction(Request $request)
    {
        return 'here!';
    }

}