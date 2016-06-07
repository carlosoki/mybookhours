<?php

namespace Project\Bundle\App\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class EventTravelController extends Controller
{
    public function getAppEventTravelsAction()
    {

    }

    /**
     * @param $id
     * @param Request $request
     *
     * @return array
     *
     * @Template("ProjectAppBundle:Event:eventTravel.html.twig")
     */
    public function newAppEventTravelAction($id, Request $request)
    {
        return ['events' => ''];

    }

}