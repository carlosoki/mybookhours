<?php

namespace Project\Bundle\App\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class EventController extends Controller
{
    const FROM_APP = true;

    /**
     * @Template("ProjectAppBundle:Event:listEvents.html.twig")
     */
    public function getAppEventsAction()
    {
        return ['events' => ''];
    }

    /**
     * @Template("ProjectAppBundle:Event:newEvent.html.twig")
     * @param Request $request
     *
     * @return array
     */
    public function newAppEventAction(Request $request)
    {
        return [
            'event' => '',
            'form' => ''
        ];

    }

    /**
     * @param Request $request
     */
    public function saveAppNewEventAction(Request $request)
    {

    }

}