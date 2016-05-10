<?php

namespace Project\Bundle\Api\Service;

use FOS\RestBundle\View\ExceptionWrapperHandlerInterface;
use Symfony\Component\Form\Form;
use Symfony\Component\HttpFoundation\Response;

/**
 * Class ExceptionWrapperHandler
 * @package Project\Bundle\Api\Service
 */
class ExceptionWrapperHandler implements ExceptionWrapperHandlerInterface
{
    //TODO: what happens with other error types eg 405's? do these need to be handled?
    public function wrap($data)
    {
        $output = '';

        if (isset($data['status_code']) && Response::HTTP_BAD_REQUEST === $data['status_code']) {
            $statusCode = $data['status_code'];
            //Handle form 400 errors;
            if (isset($data['errors']) && $data['errors'] instanceof Form) {
                $errors = $this->getFormErrors($data['errors']);
                $output = [
                    'code' => $statusCode,
                    'message' => 'Validation Failed',
                    'errors' => $errors,
                ];
            }
            //Handle code thrown 400 exceptions
            //eg: throw new HttpException(Response::HTTP_BAD_REQUEST,'Some message.');
            elseif (isset($data['message'])) {
                $output = [
                    'code' => $statusCode,
                    'message' => $data['message'],
                ];
            } else {
                $output = [
                    'code' => $statusCode,
                    'message' => 'Bad Request',
                ];
            }
        } elseif (isset($data['exception'])) {
            //SM: Need to handle 500s and 403s here
            if ($data['exception']->getStatusCode()) {
                $statusCode = $data['exception']->getStatusCode();
            } else {
                $statusCode = Response::HTTP_INTERNAL_SERVER_ERROR;
            }
            // Symfony\Component\Debug\Exception\FlattenException
            $exception = $data['exception'];

            $output = [
                'code' => $statusCode,
                'message' => $exception->getMessage(),
            ];
        }

        return $output;
    }

    private function getFormErrors(Form $form)
    {
        $errors = [];

        if ($form instanceof Form) {
            foreach ($form->getErrors() as $error) {
                $errors[] = $error->getMessage();
            }

            foreach ($form->all() as $key => $child) {
                //child
                if ($err = $this->getFormErrors($child)) {
                    $errors[$key] = $err;
                }
            }
        }

        return $errors;
    }
}
