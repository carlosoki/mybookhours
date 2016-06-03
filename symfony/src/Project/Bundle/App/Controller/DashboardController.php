<?php

namespace Project\Bundle\App\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DashboardController extends Controller
{
    /**
     * @Template("ProjectAppBundle:Dashboard:view.html.twig")
     */
    public function getDashboardAction()
    {
        return;
    }

}