<?php

namespace Project\Bundle\Api\Controller;

use Project\Bundle\Api\Entity\Appointment;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Class AppointmentApiController
 * @package Project\Bundle\Api\Controller
 */
class AppointmentApiController extends BaseController
{
    const APPOINTMENT_REPO = 'api.repository.appointment';
    const FORM_NAME = 'appointment_type';

    public function getApiAppointmentsAction()
    {
        
    }

    public function getApiAppointmentAction($id)
    {

    }
    
    public function newApiAppointmentAction(Request $request)
    {
        $appointment = new Appointment();
        $form = $this->createForm($this->get('project.form.type.appointment'), $appointment);

        return $this->processForm(
            $request, $form, self::APPOINTMENT_REPO, $appointment,
            'api_appointment', ['appointment'], Response::HTTP_CREATED
        );

    }

    public function updateApiAppointmentAction(Request $request, $id)
    {

    }

    public function deleteApiAppointmentAction($id)
    {

    }

}