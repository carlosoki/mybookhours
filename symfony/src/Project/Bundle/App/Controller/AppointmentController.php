<?php

namespace Project\Bundle\App\Controller;

use Project\Bundle\Api\Entity\Appointment;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class AppointmentController extends Controller
{
    const FROM_APP = true;

    /**
     * @Template("ProjectAppBundle:Appointment:listAppointments.html.twig")
     */
    public function getAppAppointmentsAction()
    {
        return ['appointments' => ''];
    }

    /**
     * @Template("ProjectAppBundle:Appointment:newAppointment.html.twig")
     * @param Request $request
     *
     * @return array
     */
    public function newAppAppointmentAction(Request $request)
    {
        return [
            'appointment' => '',
            'form' => ''
        ];

    }

    /**
     * @param Request $request
     */
    public function saveAppNewAppointmentAction(Request $request)
    {

    }

}